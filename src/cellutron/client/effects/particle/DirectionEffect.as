package cellutron.client.effects.particle 
{
	import cellutron.client.effects.particle.ParticleEffect;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DirectionEffect extends ParticleEffect
	{

		
		public function DirectionEffect() {
			super();
		}
		
		override public function blast(position:Point, direction:Point = null) {
			// Override me
		}
		
	}
	
}