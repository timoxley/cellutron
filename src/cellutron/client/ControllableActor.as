package cellutron.client 
{
	import Box2D.Common.Math.b2Vec2;
	import com.senocular.utils.KeyObject;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author ...
	 */
	public class ControllableActor extends GenericActor
	{
		protected var key:KeyObject;
		protected var _enableControl:Boolean = false;
		protected var acceleration:Number = 10;
		protected var rotationTarget:DisplayObject;
		
		public function ControllableActor(boundingBoxType:String, parent:DisplayObjectContainer, display:DisplayObject, position:Point,
			rotation:Number, boundingWidth = 0, boundingHeight = 0) {
			
			super(boundingBoxType, parent, display, position, rotation, boundingWidth, boundingHeight);
			key = new KeyObject(Main.stageRef);
			autoRotate = false;
			rotationTarget = display;
			
		}
		
		override public function step(evt:Event = null):void {
			if (enableControl) {
				//Direction is a vector that will be applied as an impulse to our object.
				var direction:b2Vec2 = new b2Vec2();
				var dir = new b2Vec2();
				if (key.isDown(Keyboard.LEFT)) {
					dir = new b2Vec2();
					dir.Set(-acceleration,0);
					direction.Add(dir);
				}
				if (key.isDown(Keyboard.RIGHT)) {
					dir = new b2Vec2();
					dir.Set(acceleration,0);
					direction.Add(dir);
				}
				if (key.isDown(Keyboard.UP)) {
					dir = new b2Vec2();
					dir.Set(0, -acceleration);
					direction.Add(dir);
				}
				if (key.isDown(Keyboard.DOWN)) {
					dir = new b2Vec2();
					dir.Set(0, acceleration);
					direction.Add(dir);
				}
			
				body.WakeUp();
				
				body.ApplyForce(direction, body.GetPosition());
			}
			
			updateRotation(rotationTarget, new Point(body.GetLinearVelocity().x, body.GetLinearVelocity().y));
			
			
			
			super.step(evt);
		}
		
		protected function updateRotation(target:DisplayObject, reference:Point, reference2:Point = null):void {
			target.rotation = Physics.rotation_from_points(reference, reference2);
			/*var refX = reference.x;
			var refY = reference.y;
			if (refX == 0 && refY == 0) {
				return;
			}
			
			if (refX <= 0 && refY <= 0) {
			  target.rotation = Math.atan(-(0 - refX) / -(0 - refY));

			  target.rotation = -(target.rotation * 180) / Math.PI;
			}
			
			if (!(refX <= 0) && !(refY <= 0)) {
			  target.rotation = Math.atan((0 - refX) / (0 - refY));
			  target.rotation = -(target.rotation * 180) / Math.PI;
			  target.rotation += 180;
			}
			
			if (!(refX <= 0) && refY <= 0) {
			  target.rotation = Math.atan((0 - refX) / (0 - refY));
			  target.rotation = -(target.rotation * 180) / Math.PI;

			}
			
			if (refX <= 0 && !(refY <= 0)) {
			  target.rotation = Math.atan((0 - refX) / (0 - refY));
			  target.rotation = -(target.rotation * 180) / Math.PI;
			  target.rotation += 180;
			}*/
		}
		
		public function get enableControl():Boolean { return _enableControl; }
		
		public function set enableControl(value:Boolean):void 
		{
			_enableControl = value;
		}

	}
	
}