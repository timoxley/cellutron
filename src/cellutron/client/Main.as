package cellutron.client {
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import gs.events.TweenEvent;
	
	import nl.demonsters.debugger.MonsterDebugger;
		
	public class Main extends MovieClip {
		public static const INIT:String = 'mainInitialiseStart';
		public static const INIT_COMPLETE:String = 'mainInitialiseComplete';
		public static const RUN:String = 'mainRunStart';
		public static const RUN_COMPLETE:String = 'mainRunComplete';
		
		public static var stageRef:Stage;
		public static var stepList:Array;
		
		public var client:SimulationClient;
		
		public var state:String = null;
		public static var taskCue:TaskCue;
		public var intro:Intro;
		
		public var menu:Menu;
		private var veil:MovieClip;
		private var console:Console;
		public static var instance:Main;
		
		public static function get_instance():Main {
			return instance;
		}
		
		public function Main() {
			
			if (Main.instance == null) {
				Main.instance = this;
			}
			
			stageRef = stage;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//this.console = new Console();
			
			new MonsterDebugger(this);
			this.intro = new Intro();		
			this.intro.align_horizontal_center();
			//this.veil = new Veil();
			this.menu = new Menu();
			
			//var topic;
			//topic = this.intro;
			/*var mainTeener:TweenMax = new TweenMax(topic, 1, {
			scaleX:2, 
			scaleY:2,
			onStart: function(topic) {
				//trace("shiiit" + this);
				var def : XML = describeType(this);
				//trace("def" + def);
				var properties : XMLList = def..variable.@name + def..accessor.@name;
				//trace("properties" + properties);
				//trace("properties.length()" + properties.length());
				for each ( var property : String in properties ) {
					//trace(property + ": " + this[property]);
				}
				//this.align_horizontal_center();
				},
			onStartParams: new Array(this.intro),
			onComplete: function(menu){menu.appear()},
			onCompleteParams: new Array(menu)
			});
			
			*/
			
			////trace("intro.transition.paused = " + intro.transition.paused);
			intro.transition.addEventListener(TweenEvent.COMPLETE, function(evt:TweenEvent) { 
				menu.appear();
				////trace("intro.transition (TweenEvent.COMPLETE)");
			});
			
			
			intro.appear();
			
			
			//this.addEventListener(SimulationClient.
			/*timer = new DeltaTimer();
			timer.reset();		
			stageRef = stage;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stepList = new Array();
			Main.taskCue = new TaskCue();
			
			Main.taskCue.push(new Task(this.init));
			////trace(this.intro);
			this.intro = new Intro();
			this.intro['position'] = function() {
				this.align_horizontal_center();
				//
				this.y = 10;
			}
			this.intro.init();
			this.menu = new Menu();
			menu.animated = false;
			
			////trace(this.intro.finish);
			Main.taskCue.push(Task.autoTask(this.intro));//new Task(this.intro.start, this.intro.finish, false, this.intro.step));
			Main.taskCue.push(Task.autoTask(this.menu));
			this.addEventListener(Event.ENTER_FRAME, this.do_step);
			Main.taskCue.start();*/
			
			this.addEventListener(SimulationClient.CREATE, init);
		}
		
		
		
		public function init(evt:Event) {
			//trace("Init Client");
			
			this.client = SimulationClient.get_instance();
			this.menu.addEventListener(CellutronClip.DISAPPEAR, client.init);
			
			//stageRef.addChild(client);
		}
		
		public function init_complete(evt:Event) {
			//trace("Init Complete");
			//State.change(this, RUN);
		}
		
		
		
		// Convenience function for sending events
		public function send(type:String, modeEvent = false) {
			//trace("Simulation Client: Sending: " + type);
			dispatchEvent(new Event(type));
		}
		
		

		
		
	}
}