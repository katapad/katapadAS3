package com.katapad.utils 
{
	import flash.errors.IllegalOperationError;
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2009/04/15 21:10
	 */
	public class ColorUtils 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		//private var
		
		/**
		 * cant construct
		 */
		public function ColorUtils() 
		{
			throw new IllegalOperationError("[ColorUtils] cannot construct");
		}
		
		public static function tint(value:uint):ColorTransform
		{
			return new ColorTransform(0, 0, 0, 1.0, ( value & 0xff0000 ) >> 16, ( value & 0xff00 ) >> 8, ( value & 0xff ), 0.0)
		}
		
		public static function overTint(value:uint):ColorTransform
		{
			return new ColorTransform(1.0, 1.0, 1.0, 1.0, ( value & 0xff0000 ) >> 16, ( value & 0xff00 ) >> 8, ( value & 0xff ), 0.0)
		}

//		private static function getColor(color:int, percent:Number = 1):ColorTransform
//		{
//			var k:Number = 1.0 - percent;
//			var red:Number = color >> 16 & 0xFF * percent;
//			var green:Number = color >> 8 & 0xFF * percent;
//			var blue:Number = color & 0xFF * percent;
//			return new ColorTransform(k, k, k, 1, red, green, blue);
//		}
		
		//--------------------------------------------------------------------------
		//
		//  OVERRIDE
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  PROTECTED
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  EVENT HANDLER
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  PRIVATE
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
	
	}
	
}
