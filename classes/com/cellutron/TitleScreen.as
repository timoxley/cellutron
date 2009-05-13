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
		public static const MAX_NODES:int = 30;
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
		public var rebalanceMode:Boolean = false;
		
		public static const MODE_INIT:int = -1;
		public static const MODE_WAIT:int = 0;
		public static const MODE_READY:int = 1;
		public static const MODE_RUNNING:int = 2;
		public static const MODE_PAUSED:int = 3;
		public static const MODE_HALTED:int = 4;
		public static const MODE_MAX:int = 4;
		
		public static const START:String = 'clientStarted';
		public static const STOP:String = 'clientStopped';
		public static const PAUSE:String = 'clientPaused';
		public static const DESTROY:String = 'clientDestroyed';
		
		public var mode:int = MODE_INIT;
		
		public static var dropPoint:Point = new Point();
		public static var dropPointToConsume:Boolean = false;
		public function TitleScreen() {
			this.x = 0;
			this.y = 0;
			//////trace("TitleScreen: Creating New");
			
			//addEventListener(MouseEvent.MOUSE_DOWN, this.step);
			//stage.addEventListener(MouseEvent.MOUSE_DOWN, this.step);
			addEventListener(Event.ENTER_FRAME, this.step);
			Main.stageRef.addEventListener(MouseEvent.MOUSE_DOWN, this.doMouseDown);
			Main.stageRef.addEventListener(MouseEvent.MOUSE_UP, changeDirection);
			Main.stageRef.addEventListener(KeyboardEvent.KEY_DOWN, this.keyDown);
			Main.stageRef.addEventListener(KeyboardEvent.KEY_UP, this.keyUp);
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
			var avatar:Avatar = Avatar.getInstance();
			avatar.x = Main.stageRef.stageWidth / 2;
			avatar.y = Main.stageRef.stageHeight / 2;
			avatar.visible = false;
			
			addChild(cellLayer);
			addChild(veil);
			addChild(header);
			addChild(menu);
			addChild(avatar);
			menu.y = 50;// - (menu.height / 2);
			this.setMode(MODE_WAIT);
		}
		
		public function setMode(newMode:int):Boolean {
			//trace("set mode: ");
			if (newMode <= MODE_MAX) {
				//trace("MODE = " + newMode);
				mode = newMode;
				return true;
			} else {
				return false;
			}
		}
		
		public static function changeDirection(evt:MouseEvent) {
		//	if (TitleCell.selected != null) {
				////trace("Y = " + String( (evt.stageY - TitleScreen.dropPoint.y)));
				////trace("X = " + String( (evt.stageX - TitleScreen.dropPoint.x)));
				
				if (evt.stageX < TitleScreen.dropPoint.x && evt.stageY < TitleScreen.dropPoint.y) {
					TitleCell.direction = Math.atan(-(TitleScreen.dropPoint.x - evt.stageX)
				/ -(TitleScreen.dropPoint.y - evt.stageY));
					//TitleCell.direction -= 180;
					////trace(" - - ");
					TitleCell.direction = -(TitleCell.direction * 180) / Math.PI;
				}
				
				if (!(evt.stageX < TitleScreen.dropPoint.x) && !(evt.stageY < TitleScreen.dropPoint.y)) {
					TitleCell.direction = Math.atan((TitleScreen.dropPoint.x - evt.stageX)
				/ (TitleScreen.dropPoint.y - evt.stageY));
					////trace(" + + ");
					TitleCell.direction = -(TitleCell.direction * 180) / Math.PI;
					TitleCell.direction += 180;
				}
				
				if (!(evt.stageX < TitleScreen.dropPoint.x) && evt.stageY < TitleScreen.dropPoint.y) {
					TitleCell.direction = Math.atan((TitleScreen.dropPoint.x - evt.stageX)
				/ (TitleScreen.dropPoint.y - evt.stageY));
					////trace(" + - ");
					TitleCell.direction = -(TitleCell.direction * 180) / Math.PI;
					//TitleCell.direction += 90;
				}
				
				if (evt.stageX < TitleScreen.dropPoint.x && !(evt.stageY < TitleScreen.dropPoint.y)) {
					TitleCell.direction = Math.atan((TitleScreen.dropPoint.x - evt.stageX)
				/ (TitleScreen.dropPoint.y - evt.stageY));
					////trace(" - + ");
					TitleCell.direction = -(TitleCell.direction * 180) / Math.PI;
					TitleCell.direction += 180;
				}
				
				
				TitleCell.direction += 270;
				//TitleCell.direction = Math.atan((TitleScreen.dropPoint.x - evt.stageX)
				/// (TitleScreen.dropPoint.y - evt.stageY));
				//TitleCell.direction = (TitleCell.direction * 180) / Math.PI;
				////trace("direction = " + TitleCell.direction);
				//	TitleCell.selected = null; 
			//}
			////trace("changeDirection");
		}
		
		public function clearCells() {
			if (TitleCell.cellList != null) {
				while (TitleCell.cellList.length > 0) {
					this.cellLayer.removeChild(TitleCell.cellList.pop());
				}
			}
			
			
			//deleteNum = 3;
			//////trace("Cell List: " + TitleCell.cellList);
		}
		
		
		public function deleteCell(cellToDelete:TitleCell) {
			this.cellLayer.removeChild(cellToDelete);
			TitleCell.cellList.splice(TitleCell.cellList.indexOf(cellToDelete), 1);
			
		}
		
		/*public function doMouseUp(evt:MouseEvent) {
			paused = false;
			clearCells();
			//////trace("play clear");
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
			//deltaTimeForTick = 0;
			
			if (MODE_READY == mode) {
				
				//newCell.grow();
								//evt.
								
				setMode(MODE_RUNNING);
				clearCells();
			}
				//////trace("play clear");
			/*	//trace("creating first cell");
				var newCell:TitleCell = new TitleCell();
				/*newCell.randomSize();
				newCell.x = TitleScreen.dropPoint.x;
				newCell.y = TitleScreen.dropPoint.y;
				TitleCell.cellList.push(newCell);
				//TitleCell.selected = newCell;
				this.cellLayer.addChild(newCell);
				newCell = new TitleCell();
				////////trace("TitleCell.cellList" + TitleCell.cellList);
				newCell.randomSize();
				//newCell.x = //(parentCell.width/2 + newCell.width/2) * Math.cos(angle * Math.PI / 180);
			//	newCell.x = Main.stageRef.stageWidth / 2 + (Main.stageRef.stageWidth / 2 * 0.3 * (Math.random() - 0.5));//(parentCell.width/2 + newCell.width/2) * Math.sin(angle* Math.PI / 180);
				//newCell.y = Main.stageRef.stageHeight / 2 + (Main.stageRef.stageHeight / 2 * 0.3 * (Math.random() - 0.5));
				//newCell.x += parentCell.x;
				//newCell.y += parentCell.y;
					newCell.x = TitleScreen.dropPoint.x;
				newCell.y = TitleScreen.dropPoint.y;
				newCell.alpha = 0.8;
				TitleCell.cellList.push(newCell);
				newCell.addEventListener(MouseEvent.MOUSE_DOWN, newCell.select);
			} else {
				
				
			}*/
			if (mode == MODE_WAIT) {
				clearCells();
			}
			TitleScreen.dropPointToConsume = true;
		}
		private function step(evt:Event):void {
				if (MODE_RUNNING == mode) {
					deltaTimeForTick += deltaTimer.calculateDeltaTime();
				}
				
				if (MODE_RUNNING == mode && deltaTimeForTick > 200) { 
					if (TitleCell.cellList == null || TitleCell.cellList.length < MAX_NODES) {// && TitleCell.cellList.length >= 0) {
						//trace("trying to add new cell..." + deltaTimeForTick);
						var newCell:TitleCell = TitleCell.spawnCell();
						//trace("len = " + TitleCell.cellList.length);
						if (newCell != null) {
							if (TitleCell.cellList.length == 1 || TitleScreen.dropPointToConsume) {
								newCell.x = TitleScreen.dropPoint.x;
								newCell.y = TitleScreen.dropPoint.y;
								TitleScreen.dropPointToConsume = false;
							}
							cellLayer.addChild(newCell);
							//trace("added new cell = " + deltaTimeForTick);
							deltaTimeForTick = 0;
						
						}						
					}
					
					for each (var cell:TitleCell in TitleCell.cellList) {
						cell.width -= 0.5;
						cell.height -= 0.5;
						if (cell.width <= 10) {
							deleteCell(cell);
						}
					}
					
					if (rebalanceMode) {
						/*for (var i:uint = 0; i < TitleCell.cellList.length; i++) {	
								var neighbours = TitleCell.getNeighbours(TitleCell.cellList[i]);
								for (var i:uint; i < neighbours.length; i++) {
									neighbours[i].scaleX -= TitleCell.cellList[i].magnitude * 0.01;
									neighbours[i].scaleY = neighbours[i].scaleX;
									TitleCell.cellList[i].scaleX += TitleCell.cellList[i].magnitude * 0.01;
									TitleCell.cellList[i].scaleY = TitleCell.cellList[i].scaleX;
								}
						}*/
					}
					
				}
		}
		public function keyUp(evt:KeyboardEvent) {
			switch (evt.keyCode) {
				case Keyboard.LEFT:
					Avatar.getInstance().leftDown = false;
				break;
				case Keyboard.RIGHT:
					Avatar.getInstance().rightDown = false;
				break;
				case Keyboard.UP:
					Avatar.getInstance().upDown = false;
				break;
				case Keyboard.DOWN:
					Avatar.getInstance().downDown = false;
				break;
				
			}
			Avatar.getInstance().updateDirection();
		}

		public function keyDown(evt:KeyboardEvent) {
			switch (evt.keyCode) {
				
				case Keyboard.ESCAPE: 
					if (MODE_RUNNING == mode) { togglePaused(); };
				break;
				case Keyboard.ENTER:
					balance();
				break;
				case Keyboard.LEFT:
					cellLayer.x++;
					Avatar.getInstance().leftDown = true;
				break;
				case Keyboard.RIGHT:
					cellLayer.x--;
					Avatar.getInstance().rightDown = true;
				break;
				case Keyboard.UP:
					cellLayer.y++;
					Avatar.getInstance().upDown = true;
				break;
				case Keyboard.DOWN:
					cellLayer.y--;
					Avatar.getInstance().downDown = true;
				break;
				
			}
			Avatar.getInstance().updateDirection();
		}
		
		public function hideOverlay() {
			this.overlayVisible = false;
			header.visible = false;
			menu.visible = false;
			veil.visible = false;
			Avatar.getInstance().visible = true;
			////trace("hideOverlay");
		}
		
		public function showOverlay() {
			////trace("showOverlay");
			this.overlayVisible = true;
			header.visible = true;
			menu.visible = true;
			veil.visible = true;
			Avatar.getInstance().visible = false;
		}
		
		public function toggleOverlay() {
			////trace("toggleOverlay. overlayVisible = " + overlayVisible);
			if (overlayVisible) {
				hideOverlay();
				
			} else {
				showOverlay();
				
			}
		}
		
		public function pauseGame() {
			showOverlay();
			setMode(MODE_PAUSED);
			this.stop();
		}
		
		public function togglePaused() {
			if (paused) {
				playGame();
			} else {
				pauseGame();
			}
			
		}
		
		public function playGame() {
			//trace("playGame: " + mode);
			if (mode == MODE_WAIT || mode == MODE_PAUSED) {
				
				deltaTimer.reset();
				clearCells();
				hideOverlay();
				//trace("mode ready?");
				setMode(MODE_READY);
				//menu.buttonList..btnName = "RESET";
				menu.buttonList[0].btnText.text = "RESET";					
			}
		}
		
		
		
		public function balance() {
			this.rebalanceMode = true;
			
		}
	}
}