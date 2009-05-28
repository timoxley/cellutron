package cellutron.client
{
	
	import Box2D.Dynamics.b2World;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;

	public class Environment extends CellutronClip
	{
		public var background:Sprite;		
		protected var _world:b2World;
		
		public function Environment()
		{
			super();
			
			this.transitionEnable = false;
			this.scaleX = 1;
			this.scaleY = 1;
			
		}
		
		
		
		public function init(evt:Event = null) {
				
			background = new Sprite();
			var myBitmap:BitmapData = new BackgroundImg(100, 100);
  
			var matrix:Matrix = new Matrix();

			background.graphics.beginBitmapFill(myBitmap, matrix, true);
			background.graphics.drawRect(0, 0, 50000, 50000);
			background.graphics.endFill();
			
			addChild(background);
			
			Physics.setup_world(this);		
		}

		public function get bgResize():Number {
			return this.background.width;
			
		}
		public function set bgResize(value:Number):void {

			this.background.width = value;
			this.background.height = value;
			
			background.graphics.clear();
			background.graphics.beginFill(0xFFAF55, 1);
			background.graphics.drawRect(0, 0, background.width, background.height);
			background.graphics.endFill();
			
		}	
	}
}