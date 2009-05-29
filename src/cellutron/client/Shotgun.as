package cellutron.client 
{
	import cellutron.client.effects.particle.Firework;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Shotgun extends PhysicsWeapon {
		public function Shotgun(parent:Actor) {
			super(parent);
			explosionPower = 20;
			explosionRadius = 180
			directional = 80;
			recoil = 30;
			atMouse = true;
			this.particleEffect = new Firework();
		}
		
		
		override protected function fire_weapon():void {
			super.fire_weapon();
		}
	}
	
}