package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class SimulationServer
	{
		
		public static SERVER_STARTED:int = 0;
		public static SERVER_STOPPED:int = 1;
		public static SERVER_PAUSED:int = 2;
		
		private mode = SERVER_STOPPED;
		
		private static instance:SimulationServer;
		
		private function SimulationServer() {
			trace("Simulation Server: Created New");
		}
		
		public function getInstance():SimulationServer {
			if (null == SimulationServer.instance) {
				SimulationServer.instance = new SimulationServer();
			}
			return SimulationServer.instance;
		}
		
		public function getMode():int {
			return this.mode();
		}
		
		public function start() {
			trace("Simulation Server: Started");
		}
		
		
	}
	
}