package com.cellutron 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.text.TextField;
		
	/**
	 * ...
	 * @author Tim Oxley
	 */
	public class TitleScreen extends MovieClip
	{
		public static const MAX_NODES:int = 64;
		private var count:int = 0;
		private var nextCell:TitleCell;
		public static var instance:TitleScreen;
		public var header:MovieClip;
		public var menu:MovieClip;
		public var veil:Sprite;
		public var cellLayer:MovieClip;
		public var deleteNum:uint = 0;
		public var overlayVisible:Boolean = true;
		public var playMode:Boolean = false;
		public var paused:Boolean = false;
		public var userToggle:Boolean = false;
		private var deltaTimer:DeltaTimer;
		public var deltaTimeForTick:uint = 0;
		
		public static var dropPoint:Point = new Point();
		
		public function TitleScreen() {
			this.x = 0;
			this.y = 0;
			//trace("TitleScreen: Creating New");
			
			//addEventListener(MouseEvent.MOUSE_DOWN, this.step);
			//stage.addEventListener(MouseEvent.MOUSE_DOWN, this.step);
			addEventListener(Event.ENTER_FRAME, this.step);
			Main.stageRef.addEventListener(MouseEvent.MOUSE_DOWN, this.doMouseDown);
			Main.stageRef.addEventListener(MouseEvent.MOUSE_UP, changeDirection);
			Main.stageRef.addEventListener(KeyboardEvent.KEY_DOWN, this.keyDown);
			instance = this;
			veil = new Sprite();
			cellLayer = new MovieClip();
			menu = new Menu();
						header = new MovieClip();
			menu.x = Main.stageRef.stageWidth / 2;
			menu.y = Main.stageRef.stageHeight / 2;
			veil.x = 0;
			veil.y = 0;
			
			veil.graphics.beginFill(0x222222, 0.7);
			veil.graphics.drawRect(0, 0, Main.stageRef.stageWidth, Main.stageRef.stageHeight);
			veil.graphics.endFill();
			deltaTimer = new DeltaTimer();
			//veil.opaqueBackground = 0xDD0000;
			//veil.
			//veil.alpha = 0.2;
			///veil.visible = true;
			addChild(cellLayer);
			addChild(veil);
			addChild(header);
			addChild(menu);
			menu.y = 50;// - (menu.height / 2);

		}
		
		public static function changeDirection(evt:MouseEvent) {
		//	if (TitleCell.selected != null) {
				trace("Y = " + String( (evt.stageY - TitleScreen.dropPoint.y)));
				trace("X = " + String( (evt.stageX - TitleScreen.dropPoint.x)));
				
				if (evt.stageX < TitleScreen.dropPoint.x && evt.stageY < TitleScreen.dropPoint.y) {
					TitleCell.direction = Math.atan(-(TitleScreen.dropPoint.x - evt.stageX)
				/ -(TitleScreen.dropPoint.y - evt.stageY));
					//TitleCell.direction -= 180;
					trace(" - - ");
					TitleCell.direction = -(TitleCell.direction * 180) / Math.PI;
				}
				
				if (!(evt.stageX < TitleScreen.dropPoint.x) && !(evt.stageY < TitleScreen.dropPoint.y)) {
					TitleCell.direction = Math.atan((TitleScreen.dropPoint.x - evt.stageX)
				/ (TitleScreen.dropPoint.y - evt.stageY));
					trace(" + + ");
					TitleCell.direction = -(TitleCell.direction * 180) / Math.PI;
					TitleCell.direction += 180;
				}
				
				if (!(evt.stageX < TitleScreen.dropPoint.x) && evt.stageY < TitleScreen.dropPoint.y) {
					TitleCell.direction = Math.atan((TitleScreen.dropPoint.x - evt.stageX)
				/ (TitleScreen.dropPoint.y - evt.stageY));
					trace(" + - ");
					TitleCell.direction = -(TitleCell.direction * 180) / Math.PI;
					//TitleCell.direction += 90;
				}
				
				if (evt.stageX < TitleScreen.dropPoint.x && !(evt.stageY < TitleScreen.dropPoint.y)) {
					TitleCell.direction = Math.atan((TitleScreen.dropPoint.x - evt.stageX)
				/ (TitleScreen.dropPoint.y - evt.stageY));
					trace(" - + ");
					TitleCell.direction = -(TitleCell.direction * 180) / Math.PI;
					TitleCell.direction += 180;
				}
				
				
				TitleCell.direction += 270;
				//TitleCell.direction = Math.atan((TitleScreen.dropPoint.x - evt.stageX)
				/// (TitleScreen.dropPoint.y - evt.stageY));
				//TitleCell.direction = (TitleCell.direction * 180) / Math.PI;
				trace("direction = " + TitleCell.direction);
				//	TitleCell.selected = null; 
			//}
			trace("changeDirection");
		}
		
		public function clearCells() {
			while (TitleCell.cellList.length > 0) {
				this.cellLayer.removeChild(TitleCell.cellList.pop());
			}
			
			
			//deleteNum = 3;
			//trace("Cell List: " + TitleCell.cellList);
		}
		
		
		/*public function doMouseUp(evt:MouseEvent) {
			paused = false;
			clearCells();
			//trace("play clear");
			var newCell:TitleCell = new TitleCell();
			newCell.randomSize();
			newCell.direction = 
			newCell.magnitude = 
			newCell.x = TitleCell.dropPoint.x;
			newCell.y = TitleCell.dropPoint.y;
			TitleCell.cellList.push(newCell);
			this.cellLayer.addChild(newCell);
		}
		*/
		public function doMouseDown(evt:MouseEvent) {
			TitleScreen.dropPoint.x = evt.stageX;
			TitleScreen.dropPoint.y = evt.stageY;
			if (playMode && TitleCell.cellList != null && TitleCell.cellList.length == 0) {
				
				//newCell.grow();
								//evt.*/
								
				paused = false;
				clearCells();
				//trace("play clear");
				var newCell:TitleCell = new TitleCell();
				newCell.randomSize();
				newCell.x = TitleScreen.dropPoint.x;
				newCell.y = TitleScreen.dropPoint.y;
				TitleCell.cellList.push(newCell);
				//TitleCell.selected = newCell;
				this.cellLayer.addChild(newCell);
			} else {
				
				
			}
			if (!playMode) {
				clearCells();
			}
		}
		private function step(evt:Event):void {
			if (!paused) {
				deltaTimeForTick += deltaTimer.calculateDeltaTime();
			}
			
			if (!paused && (TitleCell.cellList == null || TitleCell.cellList.length < MAX_NODES) ) {
				if (deltaTimeForTick > 500) {				
					var newCell:TitleCell = TitleCell.spawnCell();
					
					if (newCell != null) {
						cellLayer.addChild(newCell);
						deltaTimeForTick = 0;
					}
				}
			}
		}
		
		public function keyDown(evt:KeyboardEvent) {
			switch (evt.keyCode) {
				
				case Keyboard.ESCAPE: 
					if (playMode) { togglePaused(); };
				break;
			}
			//trace("keypressed: " + evt.charCode);
			
		}
		
		public function hideOverlay() {
			this.overlayVisible = false;
			header.visible = false;
			menu.visible = false;
			veil.visible = false;
		}
		
		public function showOverlay() {
			this.overlayVisible = true;
			header.visible = true;
			menu.visible = true;
			veil.visible = true;
		}
		
		public function toggleOverlay() {
			if (overlayVisible) {
				hideOverlay();
				
			} else {
				showOverlay();
				
			}
		}
		
		public function pauseGame() {
			toggleOverlay();
			paused = true;
			this.stop();
			paused = false;
			this.play();
		}
		
		public function togglePaused() {
			if (paused) {
				playGame();
			} else {
				pauseGame();
			}
			
		}
		
		public function playGame() {
			deltaTimer.reset();
			clearCells();
			playMode = true;
			hideOverlay();
			paused = true;
			//menu.buttonList..btnName = "RESET";
			menu.buttonList[0].btnText.text = "RESET";
		}
	}
}