package cellutron.client
{
	import gs.easing.Linear;
	public class Veil extends CellutronClip
	{
		public static const VEIL_COLOR:Number = 0x222222;
		public static const VEIL_ALPHA:Number = 0.7;
		
		
		public function Veil()
		{
			super();
			trace("Veil?");
			this.x = 0;
			this.y = 0;
			this.scaleX = 1;
			this.scaleY = 1;
			this.alpha = 0;
			this.graphics.beginFill(Veil.VEIL_COLOR, Veil.VEIL_ALPHA);
			this.graphics.drawRect(0, 0, Main.stageRef.stageWidth, Main.stageRef.stageHeight);
			this.graphics.endFill();
			this.transition.setDestination("alpha", 1);
			//this.transition.ease = Linear.easeOut;
			this.transition.duration = 1;
			
			
		}
	}
}