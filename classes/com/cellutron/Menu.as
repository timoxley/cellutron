package com.cellutron 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Menu extends MovieClip {
		
		public var btnPlay:MovieClip;
		public var btnSettings:MovieClip;
		public var btnHelp:MovieClip;
		public var btnCredits:MovieClip;
		public var btnExit:MovieClip;
		public var buttonList:Array;
		public const PADDING:uint = 20;
		
		public function Menu() {
			buttonList = new Array();
			
			buttonList.push(new GameButton("PLAY", this.playGame));
			buttonList.push(new GameButton("SETTINGS", this.getSettings));
			buttonList.push(new GameButton("HELP", this.getHelp));
			buttonList.push(new GameButton("CREDITS", this.getCredits));
			buttonList.push(new GameButton("EXIT", this.exit));
			
			for (var i:uint = 0; i < buttonList.length; i++) {
				var currentButton = buttonList[i];
				//trace("currentButton: " + currentButton.btnName + " " + i);
				if (null != buttonList[i - 1]) {
					currentButton.y += buttonList[i - 1].y + buttonList[i - 1].height + PADDING;
				}
				addChild(currentButton);
			}
			/*trace("height = " + height);
			trace("y = " + y);
			
			trace("y = " + y);
			*/
			/*this.addChild(btnPlay);
			this.addChild(btnSettings);
			this.addChild(btnHelp);
			this.addChild(btnCredits);
			this.addChild(btnExit);
			*/
		}
		
		public function playGame(evt:Event) {
			TitleScreen.instance.playGame();
			evt.stopPropagation();
		}
		
		public function getSettings(evt:Event) {
			trace("Settings");
			evt.stopPropagation();
		}
		
		public function getHelp(evt:Event) {
			trace("Help");
			evt.stopPropagation();
		}		
		
		public function getCredits(evt:Event) {
			trace("Credits");
			evt.stopPropagation();
		}
		
		public function exit(evt:Event) {
			TitleScreen.instance.playMode = false;
			TitleScreen.instance.clearCells();
			trace("Exit");
			evt.stopPropagation();
		}
	}
 	
}