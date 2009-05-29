package cellutron.client
{
	
	import Box2D.Dynamics.b2World;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;

	public class Environment extends CellutronClip
	{
		public static var EnvironmentWidth = 50000;
		public static var EnvironmentHeight = 50000;
		
		public var background:Sprite;
		//public var decals:Sprite;
		//public var objects:Sprite;
		
		private static var _instance:Environment;
		
		protected var _world:b2World;
		
		public function Environment()
		{
			super();
			if (instance == null) {
				instance = this;
			}
			this.transitionEnable = false;
			this.scaleX = 1;
			this.scaleY = 1;
		}
		
		public function init(evt:Event = null) {
				
			background = new Sprite();
			var myBitmap:BitmapData = new SandBackground(100, 100);
  
			var matrix:Matrix = new Matrix();

			background.graphics.beginBitmapFill(myBitmap, matrix, true);
			background.graphics.drawRect(0, 0, EnvironmentWidth, EnvironmentHeight);
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
		
		public static function get instance():Environment { return _instance; }
		
		public static function set instance(value:Environment):void 
		{
			_instance = value;
		}
	}
}