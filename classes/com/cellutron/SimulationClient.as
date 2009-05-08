package com.cellutron
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SimulationClient extends MovieClip
	{
		
		public static const MODE_INIT:int = 0;
		public static const MODE_READY:int = 1;
		public static const MODE_RUNNING:int = 2;
		public static const MODE_PAUSED:int = 3;
		public static const MODE_HALTED:int = 4;
		public static const MODE_MAX:int = 4;
		
		public static const START:String = 'clientStarted';
		public static const STOP:String = 'clientStopped';
		public static const PAUSE:String = 'clientPaused';
		public static const DESTROY:String = 'clientDestroyed';
		
		public static var instance:SimulationClient;
		
		private var mode:int = MODE_INIT;
		var counter:int = 0;
		
		/* Singleton */
		public function SimulationClient() {
			trace("Simulation Client: Creating New...");
			addEventListener(START, this.start);
			addEventListener(STOP, this.halt);
			addEventListener(PAUSE, this.pause);
			addEventListener(DESTROY, this.destroy);
			trace("Simulation Client: Created New.");
			//Main.stageRef.addEventListener(MouseEvent.MOUSE_DOWN, this.togglePause);
			addEventListener(Event.ENTER_FRAME, step);
			mouseEnabled = true;
			start();
		}
		
		public static function getInstance():SimulationClient {
			if (SimulationClient.instance == null) {
				SimulationClient.instance = new SimulationClient();
			}
			return SimulationClient.instance;
		}
		
		public function start() {
			if (setMode(MODE_RUNNING)) {
				return true;
			} else {
				return false;
			}
		}
		
		public function setMode(newMode:int):Boolean {
			if (newMode <= MODE_MAX) {
				mode = newMode;
				return true;
			} else {
				return false;
			}
		}
		
		public function step(evt:Event):Boolean {
			//trace("Simulation Client: Step");
			if(mode == MODE_RUNNING) {
				//trace('Simulation Client: Loop: ' + counter++);
				//get input
				//sent input to server
				//get response
				//draw graphics
				
			}
			if(mode == MODE_PAUSED) {
				// do paused loop
			}
			return true;
		}
		
		public function pause(evt:Event = null):Boolean {
			trace("Simulation Client: Pausing...");
			return setMode(MODE_PAUSED);
		}
		
		public function togglePause(evt:Event):Boolean {
			
			trace("Simulation Client: Toggle Pause...");
			if (this.mode == MODE_PAUSED) {
				start();
			} else if (this.mode == MODE_RUNNING) {
				pause();
			} else {
				trace("this.mode = " + this.mode);
				return false;
			}
			return true;
		}
		
		public function halt(evt:Event):Boolean {
			trace("Simulation Client: Stopping...");
			return setMode(MODE_HALTED);
		}
		
		public function destroy(evt:Event):Boolean {
			// clean up and prepare for exit;
			return true;
		}
		
		
		// Convenience function for sending events
		public function send(type:String) {
			trace("Simulation Client: Sending: " + type);
			dispatchEvent(new Event(type));
		}
		
		
		
		
	}
	
}