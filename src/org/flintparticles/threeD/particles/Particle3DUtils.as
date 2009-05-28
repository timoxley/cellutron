package org.flintparticles.threeD.particles 
{
	import org.flintparticles.common.particles.ParticleFactory;
	import org.flintparticles.threeD.geom.Vector3D;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;	

	public class Particle3DUtils 
	{
		public static function createPixelParticlesFromBitmapData( bitmapData:BitmapData, factory:ParticleFactory = null, offset:Vector3D = null ):Array
		{
			if( offset == null )
			{
				offset = Vector3D.ZERO;
			}
			var particles:Array = new Array();
			var width:int = bitmapData.width;
			var height:int = bitmapData.height;
			var y:int;
			var x:int;
			var p:Particle3D;
			if( factory )
			{
				for( y = 0; y < height; ++y )
				{
					for( x = 0; x < width; ++x )
					{
						p = Particle3D( factory.createParticle() );
						p.position = new Vector3D( x + offset.x, y + offset.y, offset.z, 1 );
						p.color = bitmapData.getPixel32( x, y );
						particles.push( p );
					}
				}
			}
			else
			{
				for( y = 0; y < height; ++y )
				{
					for( x = 0; x < width; ++x )
					{
						p = new Particle3D();
						p.position = new Vector3D( x + offset.x, y + offset.y, offset.z, 1 );
						p.color = bitmapData.getPixel32( x, y );
						particles.push( p );
					}
				}
			}
			return particles;
		}
		
		public static function createRectangleParticlesFromBitmapData( bitmapData:BitmapData, size:uint, factory:ParticleFactory = null, offset:Vector3D = null ):Array
		{
			if( offset == null )
			{
				offset = Vector3D.ZERO;
			}
			var particles:Array = new Array();
			var width:int = bitmapData.width;
			var height:int = bitmapData.height;
			var y:int;
			var x:int;
			var halfSize:Number = size * 0.5;
			offset.x += halfSize;
			offset.y += halfSize;
			var p:Particle3D;
			var b:BitmapData;
			var m:Bitmap;
			var s:Sprite;
			var zero:Point = new Point( 0, 0 );
			if( factory )
			{
				for( y = 0; y < height; y += size )
				{
					for( x = 0; x < width; x += size )
					{
						p = Particle3D( factory.createParticle() );
						p.position = new Vector3D( x + offset.x, -y + offset.y, offset.z, 1 );
						b = new BitmapData( size, size, true, 0 );
						b.copyPixels( bitmapData, new Rectangle( x, y, size, size ), zero );
						m = new Bitmap( b );
						m.x = -halfSize;
						m.y = halfSize;
						s = new Sprite();
						s.addChild( m );
						p.image = s;
						p.collisionRadius = halfSize;
						particles.push( p );
					}
				}
			}
			else
			{
				for( y = 0; y < height; ++y )
				{
					for( x = 0; x < width; ++x )
					{
						p = new Particle3D();
						p.position = new Vector3D( x + offset.x, y + offset.y, offset.z, 1 );
						b = new BitmapData( size, size, true, 0 );
						b.copyPixels( bitmapData, new Rectangle( x, y, size, size ), zero );
						m = new Bitmap( b );
						m.x = -halfSize;
						m.y = halfSize;
						s = new Sprite();
						s.addChild( m );
						p.image = s;
						p.collisionRadius = halfSize;
						particles.push( p );
					}
				}
			}
			return particles;
		}
	}
}
