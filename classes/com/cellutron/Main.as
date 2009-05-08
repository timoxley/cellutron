package com.cellutron 
{
	import com.cellutron.SimulationClient;
	import flash.display.MovieClip;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * ...
	 * @author Tim Oxley
	 */
	public class Main extends MovieClip
	{
		static var stageRef;
		public function Main() 
		{			
			stageRef = stage;
			trace("Init Frame 1");
			var client = SimulationClient.getInstance();
			//client.start();		
			var titleScreen = new TitleScreen();
			titleScreen.x = 0; //stage.stageWidth / 2;
			titleScreen.y = 0;//stage.stageHeight / 2;
			titleScreen.play();
			stage.addChild(titleScreen);
			new MonsterDebugger(this);
			
		}	
	}
	
}