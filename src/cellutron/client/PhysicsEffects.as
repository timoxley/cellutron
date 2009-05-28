package cellutron.client 
{
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PhysicsEffects 
	{
		
		public function PhysicsEffects() 
		{
			
		}
		
		
		
		
		//TODO: pass a position, not a body
		public static function explode(pos:Point, explosionPower = 50, explosionRadius = 50, directional:Number = 0, direction:Point = null):void {
		 
		 var explosionPower = 50;
		 var explosionRadius = 50
		 var aabb:b2AABB = new b2AABB()
		 if (direction == null) {
			direction = new Point();
		 }
		 
		 var position:b2Vec2 = Physics.p_to_v(pos); 
		
		 var vMin:b2Vec2 = position.Copy();
		 vMin.Subtract(new b2Vec2(Physics.p_to_m(explosionRadius), Physics.p_to_m(explosionRadius)));
		 var vMax:b2Vec2 = position.Copy();
		 vMax.Add(new b2Vec2(Physics.p_to_m(explosionRadius), Physics.p_to_m(explosionRadius)));
		 aabb.lowerBound = vMin;
		 aabb.upperBound = vMax;
		 var shapes:Array = new Array();
		 Physics.world.Query(aabb, shapes, 100);
		 
		 for (var i = 0; i < shapes.length; i++)
		 {
			var b:b2Body = shapes[i].GetBody();
			var fv:b2Vec2 = b.GetPosition().Copy();
			fv.Subtract(position);
			fv.Normalize();
			
			var fv2:b2Vec2 = new b2Vec2();;
			if (directional > 0) {
				fv2 = b.GetPosition().Copy();
				var dir:b2Vec2 = Physics.p_to_v(direction); //;SimulationClient.get_instance().avatar.body.GetPosition().Copy();
				
				fv2.Subtract(dir);
				fv2.Normalize();

				fv2.Multiply(explosionPower * directional);
				fv.Multiply(explosionPower * 1%directional);
			} else {
				
				fv.Multiply(explosionPower);
			}
			
			b.WakeUp();
			b.ApplyForce(fv, b.GetPosition());
			b.ApplyForce(fv2, b.GetPosition());
		 }
		}
		
	}
	
}