package cellutron.client 
{
	import cellutron.client.displays.ShotgunBlast;
	import cellutron.client.effects.physics.Explosion;
	import flash.geom.Point;
	import cellutron.client.effects.physics.Recoil;
	/**
	 * ...
	 * @author ...
	 */
	public class PhysicsWeapon extends Weapon
	{
		
		public var explosionPower:Number = 10;
		public var explosionRadius:Number = 50
		public var directional:Number = 1;
		public var recoil:Number = 10;
		public var atMouse:Boolean = true;

		public function PhysicsWeapon(parent:Actor) 
		{
			super(parent);
		}
		
		override protected function fire_weapon():void {
			super.fire_weapon();
			var shooterLocation:Point = Physics.v_to_p(parent.body.GetPosition());
			var mouseLocation:Point = ControllableActor(parent).mousePosition.clone();
			var shootPoint = mouseLocation.clone();
			if (!atMouse) {
				shootPoint = Physics.get_point_in_direction(shooterLocation, mouseLocation, 15);
				Explosion.explode(shootPoint, explosionPower, explosionRadius, directional, mouseLocation);
			} else {
				Explosion.explode(mouseLocation, explosionPower, explosionRadius);
				
			}
			var spotAt:ShotgunBlast = new ShotgunBlast(shootPoint.x, shootPoint.y);
			spotAt.x = shootPoint.x;
			spotAt.y = shootPoint.y;
			Main.stageRef.addChild(spotAt);
			spotAt.rotation = Physics.rotation_from_points(shooterLocation, shootPoint);
			spotAt.appear();

			particleEffect.blast(shooterLocation, shootPoint);
			Recoil.recoil(explosionPower, recoil, parent, shootPoint);
			
		}
		
	}
	
}