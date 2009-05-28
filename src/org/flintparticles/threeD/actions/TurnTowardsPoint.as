/*
 * FLINT PARTICLE SYSTEM
 * .....................
 * 
 * Author: Richard Lord (Big Room)
 * Copyright (c) Big Room Ventures Ltd. 2008
 * http://flintparticles.org
 * 
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

package org.flintparticles.threeD.actions 
{
	import org.flintparticles.common.actions.ActionBase;
	import org.flintparticles.common.emitters.Emitter;
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.threeD.geom.Vector3D;
	import org.flintparticles.threeD.particles.Particle3D;	

	/**
	 * The TurnTowardsPoint action causes the particle to constantly adjust its direction
	 * so that it travels towards a particular point.
	 */

	public class TurnTowardsPoint extends ActionBase
	{
		private var _point:Vector3D;
		private var _power:Number;
		private var _velDirection:Vector3D;
		private var _toTarget:Vector3D;
		private var _targetPerp:Vector3D;
		
		/**
		 * The constructor creates a TurnTowardsPoint action for use by 
		 * an emitter. To add a TurnTowardsPoint to all particles created by an emitter, use the
		 * emitter's addAction method.
		 * 
		 * @see org.flintparticles.common.emitters.Emitter#addAction()
		 * 
		 * @param power The strength of the turn action. Higher values produce a sharper turn.
		 * @param point The point towards which the particle turns.
		 */
		public function TurnTowardsPoint( point:Vector3D, power:Number )
		{
			_power = power;
			_point = point.clone();
			_velDirection = new Vector3D();
			_toTarget = new Vector3D();
			_targetPerp = new Vector3D();
		}
		
		/**
		 * The strength of theturn action. Higher values produce a sharper turn.
		 */
		public function get power():Number
		{
			return _power;
		}
		public function set power( value:Number ):void
		{
			_power = value;
		}
		
		/**
		 * The x coordinate of the point that the particle turns towards.
		 */
		public function get point():Vector3D
		{
			return _point;
		}
		public function set point( value:Vector3D ):void
		{
			_point = value.clone();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function update( emitter:Emitter, particle:Particle, time:Number ):void
		{
			var p:Particle3D = Particle3D( particle );
			p.velocity.unit( _velDirection );
			var velLength:Number = p.velocity.length;
			var acc:Number = power * time;
			_point.subtract( p.position, _toTarget );
			var len:Number = _toTarget.length;
			if( len == 0 )
			{
				return;
			}
			_toTarget.scaleBy( 1 / len );
			_toTarget.subtract( _velDirection.scaleBy( _toTarget.dotProduct( _velDirection ) ), _targetPerp );
			p.velocity.incrementBy( _targetPerp.scaleBy( acc / _targetPerp.length ) );
			p.velocity.scaleBy( velLength / p.velocity.length );
		}
	}
}
