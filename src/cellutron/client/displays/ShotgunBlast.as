package cellutron.client.displays 
{
	import cellutron.client.Decal;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ShotgunBlast extends Decal
	{
		
		public function ShotgunBlast(x:Number, y:Number) {
			super(x, y);
			
		}
		
		override public function get lifetime():uint { return 60; }
		
		override public function set lifetime(value:uint):void 
		{
			
		}
	}
	
}