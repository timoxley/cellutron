package cellutron.client
{
	import flash.events.Event;
	
	public class Camera extends Object
	{
		
		protected var _x;
		protected var _y;
		public var locked:Object = null;
		public function Camera() {
			super();
		}
		
		public function lock_to(lock:CellutronClip):void {
			lock.addEventListener(Y_CHANGE, this.y_changed);
			lock.addEventListener(X_CHANGE, this.x_changed);
		}
		
		public function unlock():void {
			locked = null
			lock.removeEventListener(Y_CHANGE, this.y_changed);
			lock.removeEventListener(X_CHANGE, this.x_changed);
		}
		
		public function x_changed(evt:Event) {
			if (locked != null) {
				x = locked.x + (locked.width/2);
			} else {
				throw new Error("Still listening to x changes on, but we're not locked to anything");
			}
		}
		
		public function y_changed(evt:Event) {
			if (locked != null) {
				y = locked.y + (locked.height/2);
			} else {
				throw new Error("Still listening to y changes on, but we're not locked to anything");
			}
		}
	
		//public function center_on() {
			
		//}
		
		public function get x():Integer {
			return _x;
			
		}
		public function set x(value:Integer):void {
			/*if (locked != null) {
				unlock();
			}*/
			_x = value;
			SimulationClient.environment.x = _x;
			
		}
		public function get y():Integer {
			return _y;
			
		}
		public function set y(value:Integer):void {
			/*if (locked != null) {
				unlock();
			}*/
			_y = value;
			SimulationClient.environment.y = _y;
			
		}
		
		
		
	}
}