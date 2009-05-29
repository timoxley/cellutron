package cellutron.client.effects.particle
{
	import flash.events.MouseEvent;
		import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flintparticles.common.emitters.Emitter;
	
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.renderers.BitmapRenderer;
	
	
	import cellutron.client.Main;
	/**
	 * ...
	 * @author ...
	 */
	public class ParticleEffect 
	{
		
		public var emitter:Emitter;
		
		public static var renderer:BitmapRenderer;
		
		public function ParticleEffects() 
		{
			
		}
		
		public static function init_particle_generator() {
			
			ParticleEffect.renderer = new BitmapRenderer( new Rectangle( 0, 0, Main.stageRef.stageWidth, Main.stageRef.stageHeight) );
			//renderer.addFilter( new BlurFilter( 0.5, 0.5, 1 ) );
			ParticleEffect.renderer.addFilter( new ColorMatrixFilter( [ 1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.95,0 ] ) );
			
			
			Main.stageRef.addChild( renderer );
		}
		
		public function blast(position:Point, position2:Point = null) {
			
			// override me
			
			
			
		}
		
	}
	
}