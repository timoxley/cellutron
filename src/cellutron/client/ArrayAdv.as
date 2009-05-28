package cellutron.client
{
	public class ArrayAdv extends Array
	{
		public function ArrayAdv(numElements:int=0)
		{
			super(numElements);
		}
		
		public function remove(object:Object) {
			trace(this);
			var index = this.indexOf(object);
			
			trace("removing: " + index);
			/*if (index != -1) {
				this.splice(index, 1);	
			} else {
				throw new Error("Trying to remove object not contained in this ArrayAdv: " + object);
				
			}*/
			
		}
		
		public function toString():String {
			var values:String;
			
			for each (var entry in this) {
				values += "\n||  " + entry + "  ||\n";
			} 
			
			return values;
		
		}
		
	}
}