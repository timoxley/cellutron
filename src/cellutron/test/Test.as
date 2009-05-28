package cellutron.client.test
{
	import flash.display.MovieClip;
	import cellutron.client.*;
	
	public class Test extends MovieClip
	{
		public function Test()
		{
			super();
			
			test_task_create();
			
			
		}
		
		public function test_task_create() {
			new TaskCue();
			taskWithSubTasks = new Task(function() {
				trace('Main Task');	
				
			}
			}
			
		}
		
	}
}