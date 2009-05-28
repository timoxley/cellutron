package cellutron.client 
{
	import flash.events.MouseEvent;
		import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.renderers.BitmapRenderer;
	import org.flintparticles.Firework;
	/**
	 * ...
	 * @author ...
	 */
	public class ParticleEffects 
	{
		
		public static var emitter:Firework;
		
		public static var renderer:BitmapRenderer;
		
		public function ParticleEffects() 
		{
			
		}
		
		public static function init_particle_generator() {
			ParticleEffects.emitter = new Firework();
			ParticleEffects.renderer = new BitmapRenderer( new Rectangle( 0, 0, Main.stageRef.stageWidth, Main.stageRef.stageHeight) );
			//renderer.addFilter( new BlurFilter( 0.5, 0.5, 1 ) );
			ParticleEffects.renderer.addFilter( new ColorMatrixFilter( [ 1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.95,0 ] ) );
			ParticleEffects.renderer.addEmitter( emitter );
			
			Main.stageRef.addChild( renderer );
		}
		
		public static function emit_particles(position:Point) {
			ParticleEffects.emitter.blast(position);
		}
		
	}
	
}