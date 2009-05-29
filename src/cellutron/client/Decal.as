package cellutron.client 
{
	import adobe.utils.CustomActions;
	import flash.events.Event;
	import gs.events.TweenEvent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Decal extends CellutronClip
	{
		private var _lifetime:uint = 0;
		private static var _count:uint;
		public static var maxDecals:uint = 10; 
		public static var decalList:Array;
		private var _persistent:Boolean;
		private var stepsDelay:uint;
		public var delay:uint = 60;
		private var stepsElapsed:uint = 0;
		
		public function Decal(x:Number, y:Number) {
			super();
			reset_transition();
			if (decalList == null) {
				decalList = new Array();
			}
			this.transition.setDestination("alpha", 100);
			this.transition.duration = 0.1;
			stepsDelay = delay / SimulationClient.get_instance().timestep;
			this.x = x;
			this.y = y;
			if (lifetime > 0) {
				decalList.push(this);
				SimulationClient.get_instance().addEventListener(SimulationClient.TICK, step);
			}
			if (decalList.length > maxDecals) {
				decalList[decalList.length - 1].erase();
			}
		}
		
		override public function disappear(evt:TweenEvent = null):void 
		{
			this.transition.duration = 1;
			super.disappear(evt);
			
		}
		
		public function erase() {
			decalList.splice(decalList.indexOf(this), 1);
			SimulationClient.get_instance().removeEventListener(SimulationClient.TICK, this.step);
			this.disappear();
		}
		
		public function step(evt:Event){
			
			stepsElapsed++;
			
			if ((stepsElapsed >= stepsDelay)) {
				erase();
			}
		}
		
		static public function get count():uint { 
			return decalList.length; 
		}
		
		public function get persistent():Boolean { 
			return (lifetime == 0); 
		}	
		
		public function get lifetime():uint { return _lifetime; }
		
		public function set lifetime(value:uint):void 
		{
			_lifetime = value;
		}
	}
}