package cellutron.client
{
	public class AutoTask extends Task
	{
		public static function create(taskObject:Object, autoFinish:Boolean) {
			if (taskObject is ITaskable) {
				var finish;
				
				// Set up finish function if available
				if (taskObject.hasOwnProperty('finish')) {
					finish = taskObject['finish'];
				} else {
					finish = null;
				}
				
				// Set up step function if available (& implements IStepable)
				if (taskObject is IStepable) {
					return new AutoTask(taskObject['start'], finish, autoFinish, taskObject['step']);	
				} else {
					return new AutoTask(taskObject['start'], finish, autoFinish, null);
				}
			} else {
				throw new Error("Trying to autotask incompatible object: " + taskObject);	
			}
		}
	}
}