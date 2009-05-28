package cellutron.client 
{
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	import flash.events.Event;
	/**
	 * ...
	 * @author Tim Oxley
	 */
	public class Util 
	{
		
		public function Util() 
		{
			
		}
		
		static function get_class(obj:Object):Class {
			return Class(getDefinitionByName(getQualifiedClassName(obj)));
		}
		
		// Convenience function for sending events
		public static function send(type:String) {
			Main.stageRef.dispatchEvent(new Event(type, true, true));
		}
		
	}
	
}