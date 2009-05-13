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
		public static var stageRef;
		public static var landscape;
		
		public function Main() 
		{			
			stageRef = stage;
			
			trace("Init Frame 1");
			var client = SimulationClient.getInstance();
			landscape = new MovieClip();
			//client.start();		
			var titleScreen = new TitleScreen();
			titleScreen.x = 0; //stage.stageWidth / 2;
			titleScreen.y = 0;//stage.stageHeight / 2;
			titleScreen.play();
			stage.addChild(titleScreen);
			stage.addChild(landscape);
			new MonsterDebugger(this);
			
		}	
	}
	
}