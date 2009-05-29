package cellutron.client
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	
	 
	public class SimulationClient extends EventDispatcher {
		public var deltaTimeForTick:uint = 0;
		
		//public static const LOAD:String = 'clientLoadStart';
		//public static const LOAD_DONE:String = 'clientLoadDone';
		public static const CREATE:String = 'clientCreateStart';
		public static const NOT_READY:String = 'clientNotReady';
		public static const READY:String = 'clientReady';
		public static const RUNNING:String = 'clientRunning';
		public static const STOP:String = 'clientStop';
		public static const PAUSE:String = 'clientPaused';
		public static const UNPAUSE:String = 'clientUnpaused';
		public static const TICK:String = 'Tick';
		public static var instance:SimulationClient;
		
		public var mode:String = NOT_READY;
		public var environment:Environment;
		public var player:Player;
		
		public var timer:DeltaTimer;
		public var timestep:Number;
		
		private var timeElapsedSinceTick:uint = 0;
		
		private var counter:int = 0;
		
		
		private var main:Main;
		/* Singleton */
		public function SimulationClient() {
			timer = new DeltaTimer();
			
			timestep = 1 / Main.stageRef.frameRate * 1000;
			
			//addEventListener(LOAD_START, this.startLoad);
			//addEventListener(LOAD_DONE, this.finishLoad);
			
			main = Main.get_instance();
			addEventListener(STOP, this.halt);
			//addEventListener(READY, this.ready);
			//addEventListener(RUNNING, this.running);
			addEventListener(PAUSE, this.toggle_pause);
			addEventListener(UNPAUSE, this.toggle_pause);
			//addEventListener(DESTROY_START, this.destroy);
			
			//addEventListener(DESTROY_DONE, this.exit);
			//trace("Simulation Client: Created New.");
			//Main.stageRef.addEventListener(MouseEvent.MOUSE_DOWN, this.toggle_pause);
			
			
			this.environment = new Environment();
			
			
			//send(LOAD_START);
		}
		
		
		
		public static function get_instance():SimulationClient {
			if (SimulationClient.instance == null) {
				SimulationClient.instance = new SimulationClient();
			}
			return SimulationClient.instance;
		}
		
		public function init(evt:Event = null) {
			if (!environment.isVisible) {
				var init_player:Function = function() {

					environment.removeEventListener(CellutronClip.APPEAR, init_player);
					environment.init();
					var position = new Point(Main.stageRef.stageWidth /2, Main.stageRef.stageHeight /2);
					player = new Player(Main.stageRef, position);
					player.display.addEventListener(CellutronClip.APPEAR, unpause);
					GameObject(player.display).appear();
					
					start();
					
				};
				environment.addEventListener(CellutronClip.APPEAR, init_player);
				environment.appear();
			}
			
		}
		
		public function stepCalc(evt:Event) {
			if (mode == RUNNING) {
				
				timeElapsedSinceTick += timer.calculateDeltaTime();
				
				if (timeElapsedSinceTick > timestep) {
					
					for (var i:uint = uint(timeElapsedSinceTick/timestep); i > 0; i--) {
						this.dispatchEvent(new Event(TICK));
					}
					timeElapsedSinceTick = timeElapsedSinceTick%timestep;
				}
			}			
		}
		
		
		
		
		public function start() {
			
			timer.reset();
			unpause();
		}
		
		public function pause(evt:Event = null) {
			mode = PAUSE;
			this.main.menu.appear();
			main.menu.addEventListener(CellutronClip.DISAPPEAR, this.unpause);
			main.removeEventListener(Event.ENTER_FRAME, stepCalc);
			player.enableControl = false;
		}
		
		public function unpause(evt:Event = null) {
			//trace("Unpause");
			main.menu.removeEventListener(CellutronClip.DISAPPEAR, this.unpause);
			main.addEventListener(Event.ENTER_FRAME, stepCalc);
			player.enableControl = true;
			mode = RUNNING;	
		}
		
		
		public function toggle_pause(evt:Event):Boolean {
			if (this.mode == PAUSE) {
				unpause();
				return false;
			} else if (this.mode == RUNNING) {
				pause();
				return true;
			} else {
				throw new Error("Pausing non running game? mode: " + mode);		
			}
		}
		
		public function halt(evt:Event) {
			//trace("Simulation Client: Stopping...");
			this.mode = STOP;
		}
		
		public function exit(evt:Event) {
			//trace("Exiting");
			// INSERT EXIT THING HERE
		}
	}
	
	
	
}