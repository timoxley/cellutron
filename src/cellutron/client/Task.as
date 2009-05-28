package cellutron.client
{
	import flash.events.Event;
	
	public class Task extends Object {
		public static var FINISHING:String = 'TaskFinishing';
		public static var FINISHED:String = 'TaskFinished';
		public static var IDLE:String = 'TaskIdle';
		public static var RUNNING:String = 'TaskRunning';
		public static var count:Number = 0;
		public var id:Number;
		public var startFunction:Function;
		public var finishFunction:Function;
		public var stepFunction:Function;
		public var mode:String;
		public var autoFinish:Boolean;
		public var parentCue:TaskCue;
		public var done:Function;
		
		public var subCue:TaskCue;
		
		//public function Task(object:Object, autoFinish:Boolean = true, autoStep:Boolean = true) {
		public function Task(startFunction:Function, finishFunction:Function = null, autoFinish = true, stepFunction:Function = null) {
			this.startFunction = startFunction;
			this.finishFunction = finishFunction;
			this.autoFinish = autoFinish;
			this.stepFunction = stepFunction;
			this.init();		
		}
		
		public static function autoTask(taskObject:Object, autoFinish = null) {
			if (taskObject is ITaskable) {
				var finish;
				
				// Set up finish function if available
				if (taskObject.hasOwnProperty('finish')) {
					finish = taskObject['finish'];
				} else {
					finish = null;
				}
				if (autoFinish == null) {
					if (taskObject is CellutronClip) {
					//trace("no autofinish");// + taskObject.id);
						autoFinish = false;	
					} else {
						autoFinish = true;
					}
					
				}
				// Set up step function if available (& implements IStepable)
				if (taskObject is IStepable) {
					return new Task(taskObject['start'], finish, autoFinish, taskObject['step']);	
				} else {
					return new Task(taskObject['start'], finish, autoFinish, null);
				}
			} else {
				throw new Error("Trying to autotask incompatible object: " + taskObject);	
			}
		}
		
		public function init() {
			this.mode = IDLE;
			this.id = Task.count++;
			if (this.stepFunction != null) {
				Main.stepList.push(this.step);
			}
			this.subCue = new TaskCue();
			
		}
		
		public function step(deltaTime:Number):void {
			if (this.mode === RUNNING) {
				if (this.stepFunction != null) {
					this.stepFunction(deltaTime);
				}
			}
		}
		
		public function start(doneFunction:Function = null):void {
			this.done = doneFunction;
			
			if (this.mode === IDLE) {
				this.mode = RUNNING;
				if (startFunction == null) {
					this.done();
					return;
				}
				this.subCue.start();
				
				if (autoFinish) {
					startFunction();
					this.done();
				} else {
					
					startFunction(this);
					
				}
			} else {
				throw new Error("Trying to start non-idle task. " + this.toString());	
			}
		}
		
		public function finish():void {
			if (this.mode === RUNNING) { 
				this.mode = FINISHING;
			}
			if (this.mode === FINISHING) {
				if (this.subCue.mode != TaskCue.FINISHED) {
					this.subCue.finish(this.finish);
					return;
				}
				this.mode = Task.FINISHED;
				if (this.finishFunction != null) {
					finishFunction();
				}
				if (autoFinish) {
					this.done();
				}
				if (this.stepFunction != null) {
					Main.stepList.splice(Main.stepList.indexOf(this.step), 1);
				}
			} else {
				throw new Error("Trying to finish non-running/finishing task. Task currently " + this.mode);	
			}
		}
		
		public function toString():String {
			return "Task: " + this.id + " Mode: " + this.mode + "\n";
			
		}
		
		
		
		
	}
}