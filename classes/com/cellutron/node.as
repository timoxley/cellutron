package {
	
	
	
	public class Node exte  nds MovieClip {
		/* Minumum node weight */
		public static var MIN_WEIGHT = 1;
		
		/* Current node weight */
		private var weight:Number = 1;
		
		/* Connected nodes */
		private var connections:Array;
		
		/* Create a new node at specified location, attached to parentNode */
		public function Node(x:Number, y:Number, parentNode:Node) {
			this.x = x;
			this.y = y;
			connections = new Array();
			connections[0] = parentNode;
		}
		
		public function getWeight():Number {
			return weight;
		}
		
		public function setWeight(newWeight:Number):Boolean {
			if (newWeight > MINWEIGHT) {
				weight = newWeight
				return true;
			} else {
				return false;
			}
		}
		
		public function getConnections():Array {
			return connections;
		}
		
	}
	
}