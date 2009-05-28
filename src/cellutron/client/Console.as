package cellutron.client
{

	import flash.events.Event;
	
	import gs.TweenMax;
	import gs.easing.Bounce;
	import gs.events.TweenEvent;
	
	public class Console extends CellutronClip
	{
		
		public static const CONSOLE_COLOR = 0xAA7777;
		public static const CONSOLE_ALPHA = 0.6;
		
		public var menu:Menu;
		
		public function Console()
		{
			super();
			
			
			
			this.scaleX = 1;
			this.scaleY = 1;
			this.alpha = 1;
			//this.width = Main.stageRef.stageWidth;
			//this.height = Main.stageRef.stageHeight;
			
			this.graphics.beginFill(Console.CONSOLE_COLOR, Console.CONSOLE_ALPHA);
			this.graphics.drawRect(0, 0, Main.stageRef.stageWidth, Main.stageRef.stageHeight * 2);
			this.graphics.endFill();
			this.x = 0;
			this.y = -(this.height);
			
			this.menu = new Menu();
			//this.menu.targetClip = this;
			//this.menu.visible = false;
			menu.align_horizontal_center();
			
			
			
			
			/*this.transition = new TweenMax(this, 1, {
				x: "200",
				y: "200"//, //this.height,
				//ease: Bounce.easeIn
				//onComplete: ,
				//onCompleteParams: new Array(menu)
			});*/
			
			
			this.transition.setDestination("y", -(this.height/2));
			//this.transition.pause();
			this.transition.duration = 2;
			//this.appear();
			//this.transition.addEventListener(TweenEvent.COMPLETE, showMenu);
		}
		
		public function showMenu(evt:TweenEvent) {
			trace(evt.type);
			menu.appear();
		}
		
		
	}
}