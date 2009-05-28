package cellutron.client
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
		
	public class Menu extends CellutronClip implements IResizeable {
		
		public var btnPlay:MovieClip;
		public var btnSettings:MovieClip;
		public var btnHelp:MovieClip;
		public var btnCredits:MovieClip;
		public var btnExit:MovieClip;
		public var buttonList:Array;
		public const PADDING:uint = 10;
		
		public static const TOP = 100;
		public const OPEN:String = "menuOpen";
		public const CLOSE:String = "menuClose";
		public var currentSelection;
		//public var transition:TweenMax;
		
		public function Menu() {
			super();
			
			//transition = new TweenMax(this, 1, {xScale: 0, yScale: 0});
			currentSelection = 0;
			buttonList = new Array();
			
			buttonList.push(new GameButton("PLAY", this.playGame));
			buttonList.push(new GameButton("SETTINGS", this.getSettings));
			buttonList.push(new GameButton("HELP", this.getHelp));
			buttonList.push(new GameButton("CREDITS", this.getCredits));
			buttonList.push(new GameButton("EXIT", this.exit));
			
			Main.stageRef.addEventListener(Event.RESIZE, this.position);
			
			Main.stageRef.addEventListener(KeyboardEvent.KEY_DOWN, this.key_down);
			for (var i:uint = 0; i < buttonList.length; i++) {
				var currentButton = buttonList[i];
				////trace("currentButton: " + currentButton.btnName + " " + i);
				if (null != buttonList[i - 1]) {
					currentButton.y += buttonList[i - 1].y + buttonList[i - 1].height + PADDING;
				}
				addChild(currentButton);
			}
			
			this.transition.duration = 1;
			/*//trace("height = " + height);
			//trace("y = " + y);
			
			//trace("y = " + y);
			*/
			/*this.addChild(btnPlay);
			this.addChild(btnSettings);
			this.addChild(btnHelp);
			this.addChild(btnCredits);
			this.addChild(btnExit);
			*/
		
		}
		
		
		override public function toggleAppear():void {
			super.toggleAppear();
			if (!isVisible) {	
				this.transition.duration = 1; 			
			} else {
				this.transition.duration = 2; 
			}	
		}
		
		private function select_next():void {
			if (this.currentSelection < this.buttonList.length - 1) {
				this.currentSelection++;
			}
			select_current();
			
		}
		
		private function select_previous():void {
			if (this.currentSelection > 0) {
					this.currentSelection--;
			}
			select_current()
		}
		
		private function select_current():void {
			for each (var button:GameButton in this.buttonList) {
				if (button.selected) {
					button.doRollOut();
				}
			}
			this.buttonList[currentSelection].doRollOver();
		}
		
		public function key_down(evt:KeyboardEvent):void {
			if (this.visible) {
				switch (evt.charCode) {
					case Keyboard.DOWN || Keyboard.RIGHT:
							select_next();
					break;
					
					case Keyboard.UP || Keyboard.LEFT:
							select_previous();
					break;
				}
			}
			
		}
		
		/*public function start():void {
			this.transition.reverse();
			
		}
		
		public function finish():void {
			this.transition.activate();	
		}
		
		*/
		//override public function step(deltaTime:Number):void {
			
		//}
		
		
		public function playGame(evt:Event):void {
			this.disappear();
			Main.get_instance().dispatchEvent(new Event(SimulationClient.CREATE));
			evt.stopPropagation();
		}
		
		public function getSettings(evt:Event):void {
			//trace("Settings");
			evt.stopPropagation();
		}
		
		public function getHelp(evt:Event):void {
			//trace("Help");
			evt.stopPropagation();
		}		
		
		public function getCredits(evt:Event):void {
			//trace("Credits");
			evt.stopPropagation();
		}
		
		public function exit(evt:Event):void {
			//trace("Exit");
			evt.stopPropagation();
		}
		
		public function showMenu():void {
			
		}
		
		public function position(evt:Event = null):void {
			this.y = Menu.TOP;
			this.x = Main.stageRef.stageWidth / 2;
		}
	}
 	
}