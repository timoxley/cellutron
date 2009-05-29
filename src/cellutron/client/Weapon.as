package cellutron.client 
{
	import flash.events.Event;
	import flash.geom.Point;
	import cellutron.client.effects.particle.ParticleEffect;
	import cellutron.client.effects.particle.DirectionEffect;
	import cellutron.client.effects.physics.PhysicsEffect;
	/**
	 * ...
	 * @author ...
	 */
	public class Weapon 
	{
		
		public static const FIRE_READY:String = "fireReady";
		public static const FIRE_NOT_READY:String = "fireNotReady";
		
		public static var delay:Number = 100;
		private var stepsDelay:uint;
		private var stepsElapsed:uint = 0;
		
		private var doFire:Boolean = false;
		
		private var _enable:Boolean;
		
		protected var particleEffect:ParticleEffect;
		protected var physicsEffect:PhysicsEffect;
		
		protected var parent:Actor;
		
		function Weapon(parent:Actor) {
			stepsDelay = delay / SimulationClient.get_instance().timestep;
			this.parent = parent;
		}
		
		public function step(evt:Event) {
			stepsElapsed++;
			
			if ((stepsElapsed >= stepsDelay) && doFire) {
				fire_weapon();
				stepsElapsed = 0;
				doFire = false;
			}
		}
		
		protected function fire_weapon():void {
			// Override me
		}
		
		public function fire():Boolean {
			trace('try fire');
			if (doFire) {
				return false;
			} else {
				doFire = true;
				return true;
			}
		}
		
		public function get enable():Boolean {
			return _enable; 
		}
		
		public function set enable(value:Boolean):void {
			if (_enable == false && value == true) {
				SimulationClient.get_instance().addEventListener(SimulationClient.TICK, step);
			}
			if (_enable == true && value == false) {
				SimulationClient.get_instance().removeEventListener(SimulationClient.TICK, step);
			}
			_enable = value;
		}
		
		
		
		
		
		
		
	}
	
}