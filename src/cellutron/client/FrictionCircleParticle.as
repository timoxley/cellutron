package cellutron.client
{
	import org.cove.ape.CircleParticle;

	public class FrictionCircleParticle extends CircleParticle
	{
		public function FrictionCircleParticle(x:Number, y:Number, radius:Number, fixed:Boolean=false, mass:Number=1, elasticity:Number=0.3, friction:Number=0)
		{
			super(x, y, radius, fixed, mass, elasticity, friction);
		}
		
		override function update(dt2:Number):void {
			super(dt2:Number);
		}
		
	}
}