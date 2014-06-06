package com.katapad.display.shape 
{
	import flash.display.Graphics;
	import flash.display.LineScaleMode;
	import flash.display.Sprite;
	
	import caurina.transitions.Tweener;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2009/10/09 13:59
	 */
	public class LineStyleData 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		public var thickness:Number;
		public var color:uint = 0;
		public var alpha:Number = 1;
		public var pixelHinting:Boolean = false;
		public var scaleMode:String = "normal";
		public var caps:String = null;
		public var joints:String = null;
		public var miterLimit:Number = 3;
		
		/**
		 * 
		 * @param	thickness
		 * @param	color
		 * @param	alpha
		 * @param	pixelHinting
		 * @param	scaleMode		LineScaleMode.
		 * @param	caps
		 * @param	joints
		 * @param	miterLimit
		 */
		public function LineStyleData(thickness:* = null, color:uint = 0, alpha:Number = 1, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3)  
		{
			this.thickness = thickness;
			this.color = color;
			this.alpha = alpha;
			this.pixelHinting = pixelHinting;
			this.scaleMode = scaleMode;
			this.caps = caps;
			this.joints = joints;
			this.miterLimit = miterLimit;
		}
		
		public function apply(graphics:Graphics):void
		{
			graphics.lineStyle(thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
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
