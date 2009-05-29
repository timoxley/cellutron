package cellutron.client
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import gs.TweenMax;
	import gs.easing.Elastic;
	import gs.events.TweenEvent;
	
	public dynamic class CellutronClip extends MovieClip
	{
		
		public var top = 10;
		public var bottom = 10;
		public var left = 10;
		public var right = 10;
		
		public static var padding = 10;
				
		public static const READY = "clipReady";
		public static const NOT_READY = "clipNotReady";
		public static const PLAYING = "clipPlaying";
		public static const STOPPED = "clipStopped";
		
		public static const APPEAR = "clipAppear";
		public static const DISAPPEAR = "clipDisappear";
		public static const X_CHANGE = "yChange";
		public static const Y_CHANGE = "xChange";
		public static const APPEAR_SPEED = 2;
		
		public var state:String = NOT_READY;
		
		
		public var transition:TweenMax;
		public var isVisible:Boolean = false;
		public var transitionEnable:Boolean = true;
		public var targetClip;
		public var destinationScale:Number = 1;
		
		public function CellutronClip() {
			super();
			this.targetClip = Main.stageRef;
			//trace("this.targetClip = " + this.targetClip);
			if (this is IResizeable || this.hasOwnProperty('position')) {
				this['position']();
				Main.stageRef.addEventListener(Event.RESIZE, this['position']);
			} else {
				////trace("this.hasOwnProperty('position')" +  this.hasOwnProperty('position'));
			}
			this.scaleX = 0;
			this.scaleY = 0;
			this.transition = new TweenMax(this, APPEAR_SPEED, {
				scaleX: destinationScale,
				scaleY: destinationScale,
				ease: Elastic.easeOut
			});
			//this.transition.active = false;
			this.transition.pause();
			
			//trace("transition.paused: " + transition.paused);
			this.transition.addEventListener(TweenEvent.COMPLETE, appear_complete);
			this.transition.addEventListener(TweenEvent.START, appear_start);
			
			//var ease:Elastic = new Elastic();
			//ease.
		}	
		
		
		public function appear_start(evt:TweenEvent = null):void {
			//trace("appear start. " + this + " visible: " + isVisible);
			if (!isVisible) {
				add();
				
			} 
			
		}
		
		public function appear_complete(evt:TweenEvent = null):void {
			
			if (!(this.transition.paused)) {
				if (!isVisible) {
					remove();
					this.dispatchEvent(new Event(DISAPPEAR));
				} else {
					this.dispatchEvent(new Event(APPEAR));
				}
			}
		}
		
		public function add(evt:TweenEvent = null):void {
			//trace("add to " + targetClip);//trace(targetClip);
			targetClip.addChild(this);
			
		}
		
		public function remove(evt:TweenEvent = null):void {
			//trace("remove from " + targetClip);
			targetClip.removeChild(this);
			
		}
		
		public function appear(evt:TweenEvent = null):void {
			
			if (!isVisible) {
				toggleAppear();
			}
			
		}
		
		public function disappear(evt:TweenEvent = null):void {
			
			if (isVisible) {
				toggleAppear();
			}
		}
		
		public function toggleAppear():void  {
			
			if (isVisible) {
				
				this.transition.reverse();	
				if (!transitionEnable) {
					this.transition.progress = 100;
				}
				
				
			} else {
				if (!transitionEnable) {
					this.transition.progress = 100;
				}
				if (transition.paused) {
					this.transition.resume();
				}
				
				//this.transition.activate();
			}
			
			isVisible = !isVisible;
		}
	
		public function align_horizontal_center():void  {
			if (targetClip == Main.stageRef) {
				this.x = Main.stageRef.stageWidth / 2;	
			} else {
				this.x = targetClip.width / 2;
			}
		}
		
		public function align_vertical_center():void  {
			if (targetClip == Main.stageRef) {
				this.y = Main.stageRef.stageHeight / 2;
			} else {
				this.y = targetClip.height / 2;
			}
		}
		
		public function reset_transition():void {
			this.scaleX = 1;
			this.scaleY = 1;
			this.destinationScale = 1;
			
		}
		
		
		/*public function get x():Integer {
			return _x;
			
		}*/
		
		override public function set x(value:Number):void {
			super.x = value;
			this.dispatchEvent(new Event(X_CHANGE));
			
		}
		override public function set y(value:Number):void {
			super.y = value;
			this.dispatchEvent(new Event(Y_CHANGE));
			
		}
		
		
	}
}
		/*public function start(parentTask:Task = null):void {
			if (parentTask != null) {
				//trace(new Error("Start with parentTask: " + parentTask.id).getStack//trace());
				this.parentTask = parentTask;
			}
			if (this.animated) {
				this.state = PLAYING;
				this.play();	
			} else {
				this.state = READY;
			}
			Main.stageRef.addChild(this);
		}
		
		public function step(deltaTime:Number):void {
			if (this.state == PLAYING) {
				//trace("clip step");
				if (this.currentFrame == this.totalFrames) {
					//trace("Clip Stop");
					this.stop();
					this.done()
				} 
			}
		}
		
		public function queue(task:Task) {
			//trace("Subcue id " + this.parentTask.subCue.id);
			//trace("Subcue len before " +this.parentTask.subCue.length);
			this.parentTask.subCue.push(task);
			//trace("Subcue len after " +this.parentTask.subCue.length);
		}
		
		public function start_queue() {
			this.parentTask.subCue.start();
		}
		
		public function finish_queue() {
			this.parentTask.subCue.finish();
		}
		
		public function done() {
			if (this.parentTask != null) {
				this.parentTask.done();
			} else {
				throw new Error("Trying to call done() on function with no parent task!");	
			}
		}
		
		public function finish():void {
			this.finish_queue();
			//trace(new Error("Clip Finish").getStack//trace());
			this.state = NOT_READY;
			this.done();
			
		}
		
		public function cleanup() {
			//trace("Intro Cleanup");
			Main.stageRef.removeChild(this);
		}
		
		public function align_horizontal_center() {
			this.x = Main.stageRef.stageWidth / 2;	
		}
		public function align_vertical_center() {
			this.y = Main.stageRef.stageHeight / 2;
			
		}

	}
} */