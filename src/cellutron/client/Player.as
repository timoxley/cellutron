package cellutron.client 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Player extends AvatarActor
	{
		
		public var health:Number = 100;
		public var weapon:Weapon;
		
		public function Player(parent:DisplayObjectContainer, position:Point = null, rotation:Number = 0) {
			super(parent, position, rotation);
			this.weapon = new Shotgun(this);
			this.weapon.enable = true;
			Main.stageRef.addEventListener(MouseEvent.CLICK, fire_weapon);
		}
		
		override public function step(evt:Event = null):void {
			super.step(evt);
			if (key.isDown(Keyboard.CONTROL)) {
				if (enableControl) {
					weapon.fire();
				}
			}
		}
		
		
		
		public function fire_weapon(evt:Event = null) {
			weapon.fire();
			
		}
		
	}
	
}