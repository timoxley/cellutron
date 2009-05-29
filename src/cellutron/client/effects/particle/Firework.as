package cellutron.client.effects.particle 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Firework extends DirectionEffect
	{
		
		public function Firework() {
			super();
			emitter = new FireworkEmitter();
			ParticleEffect.renderer.addEmitter( emitter );
			
		}
		
		override public function blast(position:Point, direction:Point = null) {
			FireworkEmitter(emitter).blast(position, direction);
		}
		
		
	}
	
}