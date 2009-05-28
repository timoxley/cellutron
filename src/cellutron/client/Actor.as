package cellutron.client
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class Actor extends EventDispatcher {
		
		protected var _display:DisplayObject;
		protected var _body:b2Body;
		protected var _x:Number;
		protected var _y:Number;
		protected var autoRotate:Boolean = true;
		private var _rotation:Number = 0;
		
		// True if we want to move this actor to a new position after next step call.
		private var positionChange:Boolean;
		
		
		public function Actor(display:DisplayObject, body:b2Body) {
			this._display = display;
			this._body = body;
			SimulationClient.get_instance().addEventListener(SimulationClient.TICK, step);
		}
		
		public function step(evt:Event = null):void {
			update_display();
			update_children();
			update_position();
		}
		
		private function update_children():void {
			// Override
		}
		
		private function update_display():void {
			//trace("display x " + x + " y " + y);
			display.x = x;
			display.y = y;
			if (autoRotate) {
				display.rotation = rotation;
			}
		}
		
		
		public function get display():DisplayObject {
			return _display; 
		}
		
		public function set display(value:DisplayObject):void {
			_display = value;
		}
		
		public function get body():b2Body {
			return _body; 
		}
		
		public function set body(value:b2Body):void {
			_body = value;
		}
		
		public function get x():Number { return Physics.m_to_p(body.GetPosition().x); }
		
		public function set x(value:Number):void {
			_x = value;
			positionChange = true;
		}
		
		public function get y():Number {
			return Physics.m_to_p(body.GetPosition().y);
		}
		
		public function set y(value:Number):void {
			
			_y = value;
			positionChange = true;
		}
		
		public function get rotation():Number {
			if(body == null) {
				return 0;
			}
			return Physics.d_to_r(body.GetAngle());
		}
		
		public function set rotation(degrees:Number):void {
			_rotation = Physics.r_to_d(degrees);
			positionChange = true; 
		}
		
		private function update_position():void {
			/*if (positionChange && body != null) {
				body.SetXForm(new b2Vec2(_x, _y), rotation);
				positionChange = false;
			}*/
		}

	}
}