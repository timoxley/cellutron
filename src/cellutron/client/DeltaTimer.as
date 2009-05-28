package cellutron.client {
import flash.utils.*;

public class DeltaTimer {
	private var m_timeSinceLastTick:int;
	private var pauseStart:int = 0;
	private var pauseTime:int = 0;
	public function DeltaTimer() {
		reset();
	}
	
	public function reset() : void {
		m_timeSinceLastTick = getTimer();
	}
	
	public function calculateDeltaTime():int {
		var currentTime:int = getTimer();
		var deltaTime:int = currentTime - m_timeSinceLastTick;
		m_timeSinceLastTick = currentTime;
		return deltaTime;
	}
	/*
	public function togglePause():void {	
		if (pauseStart > 0) {
			pauseStart = 0;
			pausedTime = getTimer() - pauseStart;
		} else {
			pauseStart = getTimer();
		}
	}*/
}
	
}