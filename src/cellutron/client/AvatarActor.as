package cellutron.client 
{
	import Box2D.Dynamics.b2Body;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.events.Event;
	
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
			Main.stageRef.addEventListener(MouseEvent.CLICK, explodeAt);
			//Main.stageRef.addEventListener(, explodeAt);
		}
		
		
		public function explodeAt(evt:MouseEvent) {
			if (_enableControl) {
				var loc = new Point(evt.stageX, evt.stageY);
				PhysicsEffects.explode(loc, Physics.v_to_p(body.GetPosition()));
				ParticleEffects.emit_particles(loc);
			}
		}
		
		override public function step(evt:Event = null):void {
			super.step(evt);
			if (key.isDown(Keyboard.CONTROL)) {
				
				if (enableControl) {
					trace("CONTROL!");
					var loc:Point = Physics.v_to_p(body.GetPosition());
					var loc2 = mousePosition.clone();
					//loc2.normalize(20);
					trace("MOUSE " + loc2);
					PhysicsEffects.explode(loc2, loc);
					ParticleEffects.emit_particles(loc2);
				}
			}
			
			
		}
		
	
	
	}
	
}