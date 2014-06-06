package com.katapad.utils.props 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author katapad.com
	 * @version 0.1
	 * @since 2009/09/23 16:26
	 */
	public class DisplayProps implements IDisplayProps
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _x:Number;
		private var _y:Number;
		private var _alpha:Number;
		private var _rotation:Number;
		private var _scaleX:Number;
		private var _scaleY:Number;
		
		
		/**
		 * コンストラクタ
		 */
		public function DisplayProps(mc:DisplayObject) 
		{
			_x = mc.x;
			_y = mc.y;
			_alpha = mc.alpha;
			_rotation = mc.rotation;
			_scaleX = mc.scaleX;
			_scaleY = mc.scaleY;
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
		public function toString():String
		{
			return "[DisplayProps Object, " + 
				"x :" + _x + 
				", y :" + _y + 
				", alpha :" + _alpha + 
				", rotation :" + _rotation + 
				", scaleX :" + _scaleX + 
				", scaleY :" + _scaleY + 
				"]";
		}
		
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
		public function get x():Number { return _x; }
		
		public function set x(value:Number):void 
		{
			_x = value;
		}
		
		public function get y():Number { return _y; }
		
		public function set y(value:Number):void 
		{
			_y = value;
		}
		
		public function get alpha():Number { return _alpha; }
		
		public function set alpha(value:Number):void 
		{
			_alpha = value;
		}
		
		public function get rotation():Number { return _rotation; }
		
		public function set rotation(value:Number):void 
		{
			_rotation = value;
		}
		
		public function get scaleX():Number { return _scaleX; }
		
		public function set scaleX(value:Number):void 
		{
			_scaleX = value;
		}
		
		public function get scaleY():Number { return _scaleY; }
		
		public function set scaleY(value:Number):void 
		{
			_scaleY = value;
		}
	}
	
}
