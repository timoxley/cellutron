package cellutron.client
{
	dynamic public class TaskCue extends Array implements IStepable {
		public static const NOT_READY = 'TaskCueNotReady';
		public static const READY = 'TaskCueReady';
		public static const BUSY = 'TaskCueBusy';
		public static const FINISHING = 'TaskCueFinishing';
		public static const FINISHED = 'TaskCueFinished';
		public static var count = 0;
		
		public var currentTask:Task;
		public var mode = NOT_READY;
		
		public var id:uint;
		
		public function TaskCue(numElements:int=0) {
			super(numElements);		
			this.id = TaskCue.count++;
			trace(new Error("created new task cue: " + this.id).getStackTrace());
			Main.stepList.push(this);
			
		}
	
		public function start() {
			if (mode == NOT_READY) {
				this.mode = READY;	
			} else {
				throw new Error("Starting a Task already started: " + this.id);
			}
		}
		
		public function reset() {
			mode = NOT_READY;
		}
		
		public function finish(doneFunction:Function = null) {
			if (currentTask != null) {
				this.mode == FINISHING;
				if (this.currentTask.mode != Task.FINISHED) {
					this.currentTask.finish();
				}
			} else {
				this.mode == FINISHED;
				if(doneFunction != null) {
					doneFunction();
				}
			}
		}
	
		AS3 override function push(...args):uint {
			if (mode == FINISHING || mode == FINISHED) {
				return args.length;
			}
			for (var i:uint = 0; i < args.length; i++) {
		        if (args[i] is Task) {
		        	args[i]['parentCue'] = this;
		        	super.push(args[i]);
		        } else {
		        	throw new Error("Trying to push object that is not a Task: " + args[i]); 
		        }
		    }
		    
		    return args.length;
		    
		
		}
	
	/*	public static function get_instance():TaskCue {
			if (TaskCue.instance == null) {
				TaskCue.instance = new TaskCue();
				TaskCue.instance.mode = READY;
				Main.stepList.push(TaskCue.instance);
			}

			return TaskCue.instance;
		}*/
		
		
		
		public function step(deltaTime:Number):void {
			if (this.mode == READY || this.mode == FINISHING) {
				next();
			}
			
		}
		
		public function next() {
			var nextTask:Task = null;
			if (this.length != 0) {
				//trace("next() len:" + this.length);
				nextTask = this.shift();
				//trace("len:" + this.length);
				
			}
			if (nextTask != null) {
				this.mode = BUSY;
				this.currentTask = nextTask;
				currentTask.start(this.done);
			} else {
				this.currentTask = null;
			}
		}
		
		public function doneSubQueue() {
			trace("Sub cue finished, finishing");
			
			this.done();
		}
		
		public function done() {
			trace("done() id:" + this.id + " currentTask.id:" + this.currentTask.id + " this.mode: " + this.mode);
			if (this.currentTask != null) {
				/*if (currentTask.subCue.mode != FINISHED && currentTask.subCue.mode != NOT_READY) {
					//trace("Sub cue not finished, finishing");
					//trace("this.doneSubQueue" + this.doneSubQueue);
					//trace("this.subCue" + this.subCue);
					//var shutDownTask = new Task(function() {this.subCue.mode = FINISHED}, this.doneSubQueue);
					//trace("Created shutDownTask id: " + shutDownTask.id);
					//currentTask.subCue.push(shutDownTask);
					currentTask.subCue.finish(this.done);
					return;
				} */
				if (this.currentTask.mode === Task.FINISHED ) {
					// Task is finished
					this.currentTask = null;
					this.mode = TaskCue.READY;
				} else {
					this.currentTask.finish()
				}
			
			} else {
				throw new Error("done() called, but there's no current task!");	
			}			
		}
	}
}