package com.cellutron 
{	
	
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Tim Oxley
	 */
	public class Avatar extends MovieClip {
		
		//public var direction:Number = 0;
		static private var instance = null;
		public var leftDown:Boolean = false;
		public var rightDown:Boolean = false;
		public var upDown:Boolean = false;
		public var downDown:Boolean = false;
		public var velocity:Number = 0;
		
		public function Avatar() {
			super();
		}
		
		public static function getInstance():Avatar {
			if (null == instance) {
				instance = new Avatar()
			}
			return instance;
		}

		public function updateVelocity() {
			
		}
		
		public function updateDirection() {
			if (rightDown) {
				faceEast();
			}
			if (leftDown) {
				faceWest();
			}
			if (leftDown && downDown) {
				faceSouthWest();
			}
			if (downDown) {
				faceSouth();
			}
			if (upDown) {
				faceNorth();
			}
			if (rightDown && downDown) {
				faceSouthEast();
			}
			if (upDown && leftDown) {
				faceNorthEast();
			}
			if (upDown && rightDown) {
				faceNorthWest();
			}
		}
		
		
		
		/*
		public function pressLeft() {
			leftDown = true;
		}
		
		public function pressRight() {
			this.rotation = 90;
		}
		
		public function pressUp() {
			this.rotation = 0;
		}
		
		public function pressDown() {
			this.rotation = 180;
		}
		*/
		public function faceWest() {
			this.rotation = 270;
		}
		
		public function faceEast() {
			this.rotation = 90;
		}
		
		public function faceNorth() {
			this.rotation = 0;
		}
		
		public function faceSouth() {
			this.rotation = 180;
		}
		
		public function faceSouthWest() {
			this.rotation = 225;
		}
		public function faceSouthEast() {
			this.rotation = 135;
		}
		public function faceNorthWest() {
			this.rotation = 45;
		}
		public function faceNorthEast() {
			this.rotation = 315;
		}
	
	}
}