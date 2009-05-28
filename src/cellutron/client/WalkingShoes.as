package cellutron.client
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class WalkingShoes extends MovieClip
	{
		private var playForward:Boolean = false;
		private var minFrame = 30;
		private var maxFrame = 60;
		private var midFrame = 30;
		//private var maxSpeed;
		private var count:uint = 0;
		
		public function WalkingShoes() {
			super();
			SimulationClient.get_instance().addEventListener(SimulationClient.TICK, step);
			//stop();
			maxFrame = this.totalFrames;
		}
		
		public function step(evt:Event) {
			//stop();
			var velocity = SimulationClient.get_instance().avatar.body.GetLinearVelocity().Length();
			if (velocity > 0.2) {
				play();
				
			} else {
				count = 0;
				this.gotoAndStop(0);
			}
			count++;
			
		}

	}
}