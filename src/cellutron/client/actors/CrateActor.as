package cellutron.client.actors 
{
	import cellutron.client.GenericActor;
	import cellutron.client.Environment;
	/**
	 * ...
	 * @author ...
	 */
	public class CrateActor extends GenericActor
	{
		
		public function CrateActor(type:String, parent:DisplayObjectContainer, display:DisplayObject, position:Point, 
			rotation:Number, boundingWidth = 0, boundingHeight = 0) {
			super(GenericActor.RECTANGLE, Environment);
		}
		
	}
	
}