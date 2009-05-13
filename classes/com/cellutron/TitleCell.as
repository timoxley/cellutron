package com.cellutron 
{
	import adobe.utils.CustomActions;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.text.StaticText;
	import flash.text.TextField;
	import gs.plugins.DropShadowFilterPlugin;
	import flash.events.MouseEvent;
	
	import gs.easing.*;
	import gs.*;

	
	/**
	 * ...
	 * @author Tim Oxley
	 */
	public class TitleCell extends MovieClip {
		
		public static var direction:Number = 90;
		public var magnitude:Number = 10;
		
		static public var cellList:Array;
		static public var tween:TweenMax;
		static public var selected:TitleCell;
		public var id:uint;
		public var endHeight:uint;
		public var endWidth:uint;
		
		
		public function select(evt:MouseEvent) {
			//TitleCell.selected = this;
			//trace("selected... w: " + this.width + " h: " + this.height);
			var neighbours:Array = getNeighbours(this);
			for each(var neighbourInfo:Array in neighbours) {
				var distance = neighbourInfo[1];
				var neighbour:TitleCell = neighbourInfo[0];
				
				////trace();
				var neighbourArea = Math.pow(Math.PI * (neighbour.endWidth) / 2, 2);
				////trace("this = ", this);
				////trace("neighbour = ", neighbour);
				////trace("this.endWidth = " + this.endWidth);
				////trace("distance = " + distance);
				var distanceFactor:Number = Math.sqrt(distance) / (4 * this.endWidth);
				////trace("4 * this.endWidth = " + 4 * this.endWidth);
				////trace("Math.sqrt(distance) = " + Math.sqrt(distance));
				////trace("distanceFactor = " + distanceFactor);
				var areaReduction =  neighbourArea * distanceFactor;
				////trace();
				var currentArea = Math.pow(Math.PI * this.endWidth / 2, 2);
				
				//////trace("neighbourArea = " + String(Math.pow(Math.PI * neighbour.width / 2, 2)));
				//////trace("areaReduction = " + areaReduction);
				
				//////trace("currentRadius = " + this.width / 2);
				//////trace("newRadius = " + newRadius);
				//////trace("currentArea = " + currentArea);
				var newArea = currentArea + areaReduction;
				//////trace("newArea = " + newArea);
				
				//var a = (pi * r) ^ 2
				//sqrt(a) = pi * r
				//sqrt a / r = pi
				//1 / r * sqrt a = pi
				//r  = (pi / sqrt a) ^ 2
				
				//////trace("supposed new neighbour area = " + String(Math.pow(Math.PI * neighbour.width / 2, 2) - areaReduction));
				
				var newRadius = Math.sqrt(newArea)/Math.PI;
				
				//var scaleAmount = neighbour.width * 0.01;
				neighbour.endWidth -= neighbour.endWidth * distanceFactor;
				neighbour.endHeight = neighbour.endWidth;
				
				//this.scaleX += scaleAmount;
				//this.scaleY = this.scaleX;
				this.endWidth = newRadius *2;
				this.endHeight = this.endWidth;
				this.width = this.endWidth;
				this.height = this.endHeight;
				//////trace("newNeighbourArea = " + String(Math.pow(Math.PI * neighbour.width / 2, 2)));
				neighbour.width = neighbour.endWidth;
				neighbour.height = neighbour.endHeight;
			}
		}
		
		
		
		public function TitleCell() 
		{
			
			
			if (TitleCell.cellList == null) {
				TitleCell.cellList = new Array();
			}
		
			if (tween == null) {
				//growEase = CustomEase.create("growEase", [{s:0,cp:-0.004,e:0.024},{s:0.024,cp:0.052,e:0.112},{s:0.112,cp:0.172,e:0.704},{s:0.704,cp:1.236,e:0.996},{s:0.996,cp:0.756,e:0.972},{s:0.972,cp:1.188,e:1}]);
				//growEase = gs.easing.Elastic
				//tween = 
			}
			
			this.id = TitleCell.cellList.length;
			////////trace("TitleCell: Creating New. id: " + id);
			
			
		}
		
		public static function spawnCell():TitleCell {
			////////trace("TitleCell.cellList :" + TitleCell.cellList);
			var newCell:TitleCell;
			if (TitleCell.cellList == null || TitleCell.cellList.length == 0) {
				newCell = new TitleCell();
				////////trace("TitleCell.cellList" + TitleCell.cellList);
				newCell.randomSize();
				//newCell.x = //(parentCell.width/2 + newCell.width/2) * Math.cos(angle * Math.PI / 180);
				newCell.x = Main.stageRef.stageWidth / 2 + (Main.stageRef.stageWidth / 2 * 0.3 * (Math.random() - 0.5));//(parentCell.width/2 + newCell.width/2) * Math.sin(angle* Math.PI / 180);
				newCell.y = Main.stageRef.stageHeight / 2 + (Main.stageRef.stageHeight / 2 * 0.3 * (Math.random() - 0.5));
				//newCell.x += parentCell.x;
				//newCell.y += parentCell.y;
				newCell.alpha = 0.8;
				TitleCell.cellList.push(newCell);
				newCell.addEventListener(MouseEvent.MOUSE_DOWN, newCell.select);
				return newCell;
			}/* else {
				////////trace("init cell list");
				newCell = new TitleCell();
				////////trace("TitleCell.cellList" + TitleCell.cellList);
				TitleCell.cellList.push(newCell);
				newCell.x = 75€;
				newCell.y = 75;
				TitleScreen.instance.addChild(newCell);
				////////trace(doesCollide(newCell));
				return newCell;
				
				
			}
	*/
			
			var parentCell:TitleCell = TitleCell.cellList[Math.floor(Math.random() * (TitleCell.cellList.length))];
			var count:int = 0;
			do {
				
				count++;
				if (count == 15) {
					newCell = null;
					////////trace("Loop!");
					break;
				}
				////trace("Add cell");
				////////trace("parentCell: " + parentCell.id);
				newCell = new TitleCell();
				//trace("direction: " + TitleCell.direction);
				//var randVal:Number = Math.random() * 50;
				var angle:Number = TitleCell.direction + (Math.random() * 45) - 22.5;// - 45;// + //; * 1/newCell.magnitude);
				////////trace("angle: " + angle);
				newCell.randomSize();
				
				
				newCell.x = (parentCell.endWidth/2 + newCell.endWidth/2) * Math.cos(angle * Math.PI / 180);
				newCell.y = (parentCell.endWidth/2 + newCell.endWidth/2) * Math.sin(angle* Math.PI / 180);
				newCell.x += parentCell.x;
				newCell.y += parentCell.y;
				newCell.alpha = 0.8;
				//newCell.alpha = 0.2;
				//TitleCell.cellList.push(newCell);
				//TitleScreen.instance.addChild(newCell);

				
				/*
				////////trace("Math.sin(" + angle + "* Math.PI / 180) = " + Math.sin(angle * Math.PI / 180));
				////////trace("("+this.width+" + "+newCell.width+") * Math.cos("+angle+" * Math.PI / 180)" + (this.width + newCell.width) * Math.cos(angle * Math.PI / 180));
				////////trace("width: " + this.width + newCell.width + " angle: " + angle);
				////////trace("TitleCell: newCell.x " + newCell.x + " newCell.y " + newCell.y);
				////////trace("TitleCell: Children of parent: " + this.parent.numChildren);		*/		
			} while (doesCollide(newCell));
			
			if (newCell != null) {
				newCell.addEventListener(MouseEvent.MOUSE_DOWN, newCell.select);
				TitleCell.cellList.push(newCell);
				newCell.grow();
				if (newCell.endWidth == 0) {
					////trace("cell has 0 endWidth : " + newCell);
					
				}
			}
			return newCell;
		}		
		
		
		public static function doesCollide(checkCell:TitleCell):Boolean {
			var checkAgainst:TitleCell;
			
			for (var i:uint = 0; i < TitleCell.cellList.length; i++) {
				checkAgainst = TitleCell.cellList[i];
				////trace("checkCell = " + checkCell + " against = " + checkAgainst);
				if (checkAgainst == checkCell) {
					return false;
				}
				var checkWidth = checkCell.endWidth / 2;
				var checkHeight = checkCell.endHeight / 2;
				var againstWidth = checkAgainst.endWidth / 2;
				var againstHeight = checkAgainst.endHeight / 2;
				
				if ((Math.pow(checkAgainst.x - checkCell.x, 2)
					+ Math.pow(checkAgainst.y - checkCell.y, 2)) <
						(Math.pow(checkWidth + againstWidth, 2) - ((Math.pow(checkWidth * 0.5 + againstWidth * 0.5, 2))))) {
						////trace("collision");
						return true;
				} else {
					// no collision found... yet
				}
			}
			// if we get to here we have no collisions!
			return false;
		}
		
		public function randomSize() {
			this.scaleX = (Math.random() * 0.4 + 0.05);
			this.scaleY = this.scaleX;
			this.endWidth = this.width;
			this.endHeight = this.height;
			this.magnitude = this.endWidth;
		}
		
		public function grow():void {
		//	TweenMax.to(this, 2, { scaleX:this.scaleX, scaleY:this.scaleY} );// , ease:Elastic.easeOut, renderOnStart:true } );
			TweenMax.from(this, 4, { scaleX:0, scaleY: 0, ease:Elastic.easeOut, renderOnStart:true} );//ease:CustomEase.byName("growEase")});
		//	this.filters = new DropShadowFilterPlugin();
			//this.filters = new F
		}
		
		public static function getNeighbours(checkCell:TitleCell):Array {
			var neighboursList:Array = new Array();
			var neighbourArray:Array;
			for (var i:uint = 0; i < TitleCell.cellList.length; i++) {
				var checkAgainst:TitleCell = TitleCell.cellList[i];
				if (checkAgainst == checkCell) {
					continue;
				}
				var checkWidth = checkCell.endWidth / 2;
				var checkHeight = checkCell.endHeight / 2;
				var againstWidth = checkAgainst.endWidth / 2;
				var againstHeight = checkAgainst.endHeight / 2;
				var distance = Math.pow(checkAgainst.x - checkCell.x, 2)
					+ Math.pow(checkAgainst.y - checkCell.y, 2);
				if (distance < 
					(Math.pow(checkWidth * 4 + againstWidth, 2))) {
					neighbourArray = new Array();
					neighbourArray.push(checkAgainst, distance);
					neighboursList.push(neighbourArray);
				}
			}
			return neighboursList;
		}

		override public function toString():String {
			
			return "TitleCell id: | "+ this.id +" |      at x: "+ this.x +" y: "+ this.y +" mag: "+ this.magnitude;
		}
	}
	
	
	
}