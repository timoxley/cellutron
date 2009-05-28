package cellutron.client
{
	public interface ITaskable
	{
		function start(parentTask:Task = null):void;
		
		function finish():void;		
	}
}