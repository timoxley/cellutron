package cellutron.client
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class CellutronSprite extends Sprite implements IStepable
	{
		
		public state:State;
		
		public function CellutronSprite() {
			super();
		}
		
		public function step(deltaTime:Number):void {
			state.step();
		}
		
		public function change_state(state:State){
			state.enter_state();
			this.state.exit_state();
			this.addEventListener(Event.REMOVED_FROM_STAGE
			this.state = state;
			
			Util.send(Util.get_class(this).toString() + "_OUT");
			Util.send(Util.get_class(this).toString() + "_" + state + "_IN");
		}
		
		
		
	}
}