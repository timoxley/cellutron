package cellutron.client
{
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	

	
	
	public class Physics
	{
		
		public static const RATIO:Number = 30;
		public static const GLOBAL_DAMPENING = 2.5;
		private static var _world:b2World;
		public static var crate:b2Body;
		
		
		public function Physics()
		{
			
		}
		
		
		public static function m_to_p(value:Number):Number {
			return value * RATIO;
		}
		
		public static function p_to_m(value:Number):Number {
			return value / RATIO;
		}
		
		public static function setup_world(environment:Environment) {
			
			var universeSize:b2AABB = new b2AABB();
			universeSize.lowerBound.Set(environment.x, environment.y);
			universeSize.upperBound.Set(environment.x + environment.width / Physics.RATIO, 
				environment.y + environment.height / Physics.RATIO);
			
			//Physics.world.
            
		 
		   var gravity:b2Vec2 = new b2Vec2(0, 0);
		   var ignoreSleeping:Boolean = true;
		   
		   Physics.world = new b2World(universeSize, gravity, ignoreSleeping);
		   //Physics.world.m_groundBody.m_linearDamping = 5;
		   Physics.place_default_objects()
		   Physics.useDebugDraw()
		  
		   //Physics.addCrate();
		   
		   
			SimulationClient.get_instance().addEventListener(SimulationClient.TICK, step);
			
			ParticleEffects.init_particle_generator();
			
		   
		}
		
		
		public static function useDebugDraw() {
			// set debug draw
			var debugSprite = new Sprite();
			Main.stageRef.addChild(debugSprite);
			
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			 
			dbgDraw.m_sprite = debugSprite;
			dbgDraw.m_drawScale = RATIO;
			dbgDraw.m_fillAlpha = 0.3;
			dbgDraw.m_lineThickness = 1.0;
			dbgDraw.m_drawFlags = b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit;
			Physics.world.SetDebugDraw(dbgDraw);
			
		}
		
		public static function step(evt:Event = null) {
			//trace('step Main.stageRef.frameRate:' + Main.stageRef.frameRate);
			//if (SimulationClient.get_instance().mode ) {
			
			Physics.world.Step(Main.stageRef.frameRate/1000, 5);
			/*SimulationClient.get_instance().avatar.step();
			SimulationClient.get_instance().avatar.x = crate.GetPosition().x * RATIO;
			SimulationClient.get_instance().avatar.y = crate.GetPosition().y * RATIO;*/
			
			//}
		}
		
		public static function r_to_d(radians:Number):Number {
			return radians * 180 / Math.PI;
		}
		
		public static function d_to_r(degrees:Number):Number {
			return degrees * Math.PI / 180;
		}
		
		public static function place_default_objects():void {
			
			
			/*	
			var groundDef:b2PolygonDef = new b2PolygonDef;
			groundDef.vertexCount = 4;
			b2Vec2(groundDef.vertices[0]).Set(0 / RATIO, 0 / RATIO);
			b2Vec2(groundDef.vertices[1]).Set(environment.width / Physics.RATIO, 0 / RATIO);
			b2Vec2(groundDef.vertices[2]).Set(environment.width / Physics.RATIO, environment.height / Physics.RATIO);
			b2Vec2(groundDef.vertices[3]).Set(0 / RATIO, environment.height / Physics.RATIO);
			*/	
				
			
			// create shape defn
			var shapeDef:b2PolygonDef = new b2PolygonDef;
			shapeDef.vertexCount = 4;
			b2Vec2(shapeDef.vertices[0]).Set(0 / RATIO, 0 / RATIO);
			b2Vec2(shapeDef.vertices[1]).Set(550 / RATIO, 0 / RATIO);
			b2Vec2(shapeDef.vertices[2]).Set(550 / RATIO, 10 / RATIO);
			b2Vec2(shapeDef.vertices[3]).Set(0 / RATIO, 10 / RATIO);
			
			shapeDef.friction = 0.5;
			shapeDef.restitution = 0.3;
			shapeDef.density = 0.0;
			// create body defn
			var floorBodyDef:b2BodyDef = new b2BodyDef();
			floorBodyDef.position.Set(0 / RATIO, 390 / RATIO); 
			
			
			
			
			var floorBody:b2Body = _world.CreateBody(floorBodyDef);
			//create shape
			floorBody.CreateShape(shapeDef);
			floorBody.SetMassFromShapes();
			
			
			// create roof
			floorBodyDef.position.Set(0 / RATIO, 0 / RATIO); 
			
			
			// create roof
			var roofBody:b2Body = _world.CreateBody(floorBodyDef);
			//create shape
			roofBody.CreateShape(shapeDef);
			roofBody.SetMassFromShapes();
			
			//create shape
			floorBody.CreateShape(shapeDef);
			floorBody.SetMassFromShapes();
			
			var wallShapeDef:b2PolygonDef = new b2PolygonDef();
			wallShapeDef.SetAsBox(5 / RATIO, 195 / RATIO);
			wallShapeDef.friction = 0.5;
			wallShapeDef.restitution = 0.8;
			wallShapeDef.density = 0.0;
			
			var wallBodyDef:b2BodyDef = new b2BodyDef();
			wallBodyDef.position.Set(5 / RATIO, 195 / RATIO);
			
			
			var leftWall:b2Body = world.CreateBody(wallBodyDef);
			leftWall.CreateShape(wallShapeDef);
			leftWall.SetMassFromShapes();
			
			wallBodyDef.position.Set(545 / RATIO, 195 / RATIO);
			var rightWall:b2Body = world.CreateBody(wallBodyDef);
			rightWall.CreateShape(wallShapeDef);
			rightWall.SetMassFromShapes();
			add_garbage();
			
			trace("body count:" + world.GetBodyCount());
			
			
		}
		
		
		public static function add_garbage() {
			while (world.GetBodyCount() < 80) {
				var wallShapeDef:b2PolygonDef = new b2PolygonDef();
				wallShapeDef.SetAsBox(Physics.p_to_m((Math.random() * 5) + 5), 
					Physics.p_to_m((Math.random() * 5) + 5));
				wallShapeDef.friction = 0.5;
				wallShapeDef.restitution = 0.4;//Math.random() * 0.7 + (0.7/2);
				wallShapeDef.density = 1;//Math.random() * 5 + 0.2;
				
				var wallBodyDef:b2BodyDef = new b2BodyDef();
				wallBodyDef.position.Set(Physics.p_to_m((Math.random() * Main.stageRef.stageWidth - 20) + 20), 
					Physics.p_to_m((Math.random() * Main.stageRef.stageHeight - 20) + 20));
				wallBodyDef.angularDamping = Physics.GLOBAL_DAMPENING;
				wallBodyDef.linearDamping = Physics.GLOBAL_DAMPENING;
				
				var leftWall:b2Body = world.CreateBody(wallBodyDef);
				leftWall.CreateShape(wallShapeDef);
				leftWall.SetMassFromShapes();
			}
			
		}
		
		public static function addCrate() {
			var crateDef:b2CircleDef = new b2CircleDef();
			//var crateDef:b2PolygonDef = new b2PolygonDef();
			//crateDef.SetAsBox(25 / RATIO, 25 / RATIO);
			crateDef.radius = 20 / RATIO;
			crateDef.friction = 0.3;
			crateDef.restitution = 0.1;
			crateDef.density = 4;
			
			var crateBodyDef:b2BodyDef = new b2BodyDef();
			crateBodyDef.position.Set(250 / RATIO, 100 / RATIO);
			crateBodyDef.angle = 30 * Math.PI/180;
			crateBodyDef.angularDamping = 1.5;
			crateBodyDef.linearDamping = 1.5;
			crate = world.CreateBody(crateBodyDef);
			crate.CreateShape(crateDef);
			crate.SetMassFromShapes();
			
		}
		
		
		
		
		
		
		public static function get world():b2World {
			return _world;
		}
		
		public static function set world(value:b2World):void {
			_world = value;
		}
		
		public static function rotation_from_points(point1:Point, point2:Point = null):Number {
			if (point2 == null) {
				point2 = new Point();
			}
			var rotation:Number = 0;
			var point1X = point1.x;
			var point1Y = point1.y;
			var point2X = point2.x;
			var point2Y = point2.y;
			
			if (point1X == point2X && point1Y == point2X) {
				return null;
			}
			
			if (point1X <= point2X && point1Y <= point2Y) {
			  rotation = -Math.atan((point2X - point1X) / (point2Y - point1Y));
			   rotation = Physics.r_to_d(rotation);
			  //rotation = (rotation * 180) / Math.PI;
			  //rotation += 90;
			  
			}
			
			if (!(point1X <= point2X) && !(point1Y <= point2Y)) {
			  rotation = Math.atan((point2X - point1X) / -(point2Y - point1Y));
			  rotation = Physics.r_to_d(rotation);
			  //rotation = -(rotation * 180) / Math.PI;
			  rotation += 180;
			}
			
			if (!(point1X <= point2X) && point1Y <= point2Y) {
			  rotation = -Math.atan((point2X - point1X) / (point2Y - point1Y));
			  rotation = Physics.r_to_d(rotation);
			  //rotation = -(rotation * 180) / Math.PI;

			}
			
			if (point1X <= point2X && !(point1Y <= point2Y)) {
			  rotation = Math.atan((point2X - point1X) / -(point2Y - point1Y));
			  rotation = Physics.r_to_d(rotation);
			  //rotation = -(rotation * 180) / Math.PI;
			 rotation += 180;
			}
			return rotation;
		}
		
		public static function get_point_in_direction(initialPoint:Point, directionPoint:Point, distance:Number = 1):Point {
			
			var loc2:Point = directionPoint.clone();
			var xNegative:Boolean = (loc2.x < Main.stageRef.stageWidth/2);
			var yNegative:Boolean = (loc2.y < Main.stageRef.stageHeight/2);
			loc2.normalize(20);
			if (xNegative) {
				loc2.x = -loc2.x;
			}
			if (yNegative) {
				loc2.y = -loc2.y;
			}
			loc2 = loc2.add(initialPoint);
			return loc2;
		}
		
		public static function p_to_v(point:Point):b2Vec2 {
			return new b2Vec2(Physics.p_to_m(point.x), Physics.p_to_m(point.y));
		}
		
		public static function v_to_p(vector:b2Vec2):Point {
			return new Point(Physics.m_to_p(vector.x), Physics.m_to_p(vector.y));
		}
		
	}
}