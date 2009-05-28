package cellutron.client 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	
	/**
	 * ...
	 * @author Tim Oxley
	 */
	public class State {
		
		public var type:String;
		
		public function State() {
			
			
		}
		
		public static function change(object:Object, type:State):void {
			object.state = type;			
			Util.send(State.get_state(object, type));
		}
		
		public static function get_state(object:Object, type:State):String {
			return Util.get_class(object) + "__" + type;
		}
		
	}
	
}