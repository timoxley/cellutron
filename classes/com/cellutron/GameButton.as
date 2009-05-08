package com.cellutron 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	public class GameButton extends MovieClip {
		var btnName:String;
		public static const BUTTON_WIDTH:uint = 200;
		public static const BUTTON_HEIGHT:uint = 40;
		//public var btnText:TextField;
		private var bounds:Rectangle;
		
		public function GameButton(name:String, clickCallback:Function) {
			this.addEventListener(MouseEvent.ROLL_OVER, this.doRollOver);
			this.addEventListener(MouseEvent.ROLL_OUT, this.doRollOut);
			this.addEventListener(MouseEvent.MOUSE_UP, clickCallback);
			this.buttonMode = true;
			this.enabled = true;
			this.btnName = name;
			this.btnText.text = name;
			this.bounds = this.btnText.getBounds(this);
			
			this.doRollOut();
			/*this.graphics.beginFill(0xaaaaaa, 0.3);
			this.graphics.drawRoundRect(0 - bounds.width/2, 0 - bounds.height/2, bounds.width, bounds.height, 20, 20);
			
			this.graphics.endFill();
			*/
		}

		
		public function doRollOver(evt:Event) {
			this.btnText.textColor = 0xFFFFFF;
			useHandCursor = true;
			this.graphics.clear();
			this.graphics.beginFill(0xaaaaaa, 0.9);
			this.graphics.drawRoundRect(0 - bounds.width/2, 0 - bounds.height/2, bounds.width, bounds.height, 20, 20);
			
			this.graphics.endFill();
		}
		public function doRollOut(evt:Event = null) {
			this.btnText.textColor = 0x333333;
			this.graphics.clear();
			this.graphics.beginFill(0xaaaaaa, 0.7);
			this.graphics.drawRoundRect(0 - bounds.width/2, 0 - bounds.height/2, bounds.width, bounds.height, 20, 20);
			
			this.graphics.endFill();
		}
	}
	
}