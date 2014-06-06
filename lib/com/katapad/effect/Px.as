package com.katapad.effect 
{
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2009/12/01 21:59
	 */
	public class Px 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		//private var
		public var defaultX:Number;
		public var defaultY:Number;
		public var tx:Number;
		public var ty:Number;
		public var ta:Number;
		public var x:Number;
		public var y:Number;
		public var vx:Number;
		public var vy:Number;
		public var color32:uint;
		private var _color:uint;
		public var alpha:Number;
		public var next:Px;
		
		function Px(defaultX:Number, defaultY:Number, tx:Number, ty:Number, color32:uint = 0)
		{
			this.x = this.defaultX = defaultX;
			this.y = this.defaultY = defaultY;
			this.tx = tx;
			this.ty = ty;
			this.color32 = color32;
			_color = color32 & 0xFFFFFF;
			vx = 0;
			vy = 0;
			this.ta = alpha =  ( color32 >> 24 ) & 0xff;
		}
		
		public function get blendColor():uint 
		{
			return _color + (alpha << 24); 
		}
		
		public function set color(value:uint):void 
		{
			_color = value;
		}
		
		public function defaltPos():void
		{
			x = defaultX;
			y = defaultY;
		}
		
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
