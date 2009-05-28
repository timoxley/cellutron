package cellutron.client 
{
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GenericActor extends Actor
	{
		
		public static const CIRCLE = "Circle";
		public static const RECTANGLE = "Rectangle";
		
		private var boundingBoxType:String = CIRCLE;
		
		//Default physical prperties
		protected var friction = 0.3;
		protected var restitution = 0.4;
		protected var density = 1;
		
		public function GenericActor(type:String, parent:DisplayObjectContainer, display:DisplayObject, position:Point, 
			rotation:Number, boundingWidth = 0, boundingHeight = 0) {
			
			
			parent.addChild(display);
			
			x = position.x;
			y = position.y;
			
			var oldScaleX = 1;
			var oldScaleY = 1;
			
			/* Get bounds from display object unless otherwise specified */
			if (boundingHeight == 0 && boundingWidth == 0) {
				/* 
				 * Handle the default behaviour of a cellutron clip 
				 * where the clip starts at scale 0;
				 */
				if ((display.scaleX != 1 || display.scaleY != 1) && display is CellutronClip) {
					oldScaleX = display.scaleX;
					oldScaleY = display.scaleY;
					display.scaleX = CellutronClip(display).destinationScale;
					display.scaleY = CellutronClip(display).destinationScale;
				}
				boundingWidth = display.width;
				boundingHeight = display.height;
			}
		
			/* Reset the scaling */
			display.scaleX = oldScaleX;
			display.scaleY = oldScaleY;
			
			var body:b2Body = setup_body(display, position, rotation, boundingWidth, boundingHeight);
			
			super(display, body);
		}
		
		private function setup_body(display:DisplayObject, position:Point, rotation:Number, boundingWidth:Number, boundingHeight:Number):b2Body
		{
			var actorDef;
			
			if (boundingBoxType == CIRCLE) {
				actorDef = new b2CircleDef();
				actorDef.radius = Physics.p_to_m(Math.max(boundingWidth, boundingHeight)/2);
				
			} else if (boundingBoxType == RECTANGLE) {
				actorDef = new b2PolygonDef();
				actorDef.SetAsBox(Physics.p_to_m(boundingWidth/2), Physics.p_to_m(boundingHeight/2));
			}
			
			actorDef.friction = friction;
			actorDef.restitution = restitution;
			actorDef.density = density;
			
			var actorBodyDef:b2BodyDef = new b2BodyDef();
			actorBodyDef.position.Set(Physics.p_to_m(position.x), Physics.p_to_m(position.y));
			actorBodyDef.angle = Physics.d_to_r(rotation);
			actorBodyDef.angularDamping = Physics.GLOBAL_DAMPENING;
			actorBodyDef.linearDamping = Physics.GLOBAL_DAMPENING;
			var actorBody:b2Body = Physics.world.CreateBody(actorBodyDef);
			actorBody.CreateShape(actorDef);
			actorBody.SetMassFromShapes();
			
			return actorBody;
		}
	
	}
	
}