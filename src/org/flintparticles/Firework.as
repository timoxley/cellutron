﻿/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author: Richard Lord
 * Copyright (c) Big Room Ventures Ltd. 2008
 * http://flintparticles.org/
 * 
 * Licence Agreement
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package org.flintparticles
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.flintparticles.common.actions.*;
	import org.flintparticles.common.counters.*;
	import org.flintparticles.common.displayObjects.Dot;
	import org.flintparticles.common.energyEasing.Quadratic;
	import org.flintparticles.common.events.EmitterEvent;
	import org.flintparticles.common.initializers.*;
	import org.flintparticles.twoD.actions.*;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.initializers.*;
	import org.flintparticles.twoD.zones.*;	
	
	import cellutron.client.SimulationClient;
	import cellutron.client.Physics;
	
	public class Firework extends Emitter2D
	{
		
		private var previousAcc:Action = null;
		private var previousVel:Action = null;
		public function Firework()
		{
			counter = new Blast( 25 );
			
			addInitializer( new SharedImage( new Dot( 1 ) ) );
			addInitializer( new ColorInit( 0xFFEFD286, 0xFFFF6600 ) );
			//addInitializer( new Velocity( new DiscSectorZone( new Point( 0, 0 ), 40, 30, -4 * Math.PI / 7, -3 * Math.PI / 7 ); //new DiscZone( new Point( 0, 0 ), 10, 10 ) ) );
			addInitializer( new Velocity(new DiscSectorZone(new Point(), 450, 350, -7 * Math.PI / 7, -3 * Math.PI / 7 )));
			//new DiscSectorZone(
			addInitializer( new Lifetime( 0.1, 0.3) );
			
			addAction( new Age( Quadratic.easeIn ) );
			addAction( new Move() );
			addAction( new Fade() );
			//addAction(new Accelerate(100, 100));
			//addAction( new RandomDrift( 15, 15 ) );
			//addAction( new LinearDrag( 0.5 ) );
			
			//addEventListener( EmitterEvent.EMITTER_EMPTY, restart, false, 0, true );
		}
		
		public function blast(position:Point) {
			if (previousAcc != null) {
				this.removeAction(previousAcc);
				
			}
			if (previousVel != null) {
				this.removeAction(previousVel);
				
			}
			this.x = position.x;
			this.y = position.y;
			//position:Point = new Point(evt.stageX, evt.stageY);
			var avatarDisplay:DisplayObject = SimulationClient.get_instance().avatar.display
			var avatarPoint:Point = new Point(avatarDisplay.x, avatarDisplay.y);
			
			var diff:Point = avatarPoint.subtract(position);
			diff.normalize(200);
			
			
			var newAction = new Accelerate(-diff.x, -diff.y);
			
			
			addAction(newAction);
			previousAcc = newAction;
			//newAction =  new Velocity( new DiscSectorZone(new Point(), diff.x, diff.y, -4 * Math.PI / 7, -3 * Math.PI / 7 ));
			
			//addAction(newAction);
			//previousVel = newAction;
			rotation = Physics.rotation_from_points(diff) + 225;
			trace(rotation);
			start();
			
		}
		
		public function restart( ev:EmitterEvent ):void
		{
			start();
		}
	}
}