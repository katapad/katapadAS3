package com.katapad.ui.comps 
{
	import com.bit101.components.Window;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import caurina.transitions.Tweener;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/05/20 4:11
	 */
	public class DisplaceParamsWindow extends Window 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _mapPoint:Point;
		private var _componentX:int;
		private var _componentY:int;
		private var _scaleX:Number;
		private var _scaleY:Number;
		private var _mode:String = "wrap";
		
		
		/**
		 * コンストラクタ
		 */
		public function DisplaceParamsWindow(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, title:String = "DisplacementParmas") 
		{
			super(parent, xpos, ypos, title);
			_init();
		}
		
		/**
		 * 初期化
		 */
		private function _init():void 
		{
			//null, BitmapDataChannel.BLUE, BitmapDataChannel.BLUE, 30, 30, DisplacementMapFilterMode.CLAMP
			_createElements();
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
