package cellutron.client 
{
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.events.Event;
	
	import cellutron.client.effects.physics.Explosion;
	
	/**
	 * ...
	 * @author ...
	 */
	public class AvatarActor extends MultipartControllableActor
	{
		public function AvatarActor(parent:DisplayObjectContainer, position:Point = null, rotation:Number = 0) {
			if (position == null) {
				position = new Point()
			}
			
			friction = 0.3;
			restitution = 0.4;
			density = 10;
			acceleration = 5;
			
			var avatarDisplay:MovieClip = new Avatar();
			parent.addChild(avatarDisplay);
			
			super(GenericActor.CIRCLE, parent, avatarDisplay, position, rotation);
			
			//Main.stageRef.addEventListener(, explodeAt);
		}
		
		
		/*public function explodeAt(evt:MouseEvent) {
			if (_enableControl) {
				
				var loc = new Point(evt.stageX, evt.stageY);
				var loc2:Point = Physics.v_to_p(body.GetPosition());
				Explosion.explode(loc, loc2);
				ParticleEffects.emit_particles(loc, loc2);
			}
		}*/
		
		public function fire() {
			
		}
		
		override public function step(evt:Event = null):void {
			super.step(evt);
		}
		
	
	
	}
	
}