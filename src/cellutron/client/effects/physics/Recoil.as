package cellutron.client.effects.physics 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import cellutron.client.Actor;
	import flash.geom.Point;
	import cellutron.client.Physics;
	/**
	 * ...
	 * @author ...
	 */
	public class Recoil extends PhysicsEffect
	{
		
		public function Recoil() 
		{
			
		}
		
		public static function recoil(explosionPower:Number, recoilPercent:Number,  actor:Actor, shotDirection:Point) {
			var b:b2Body = actor.body;
			var fv:b2Vec2 = b.GetPosition().Copy();
			fv.Subtract(Physics.p_to_v(shotDirection));
			fv.Normalize();
			fv.Multiply(explosionPower * recoilPercent / 100);
			b.ApplyForce(fv, b.GetPosition());
			
		}
		
	}
	
}