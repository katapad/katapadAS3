package com.katapad.display.shape 
{
	import com.katapad.core.DOAlign;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/03/29 15:45
	 */
	public class AutoFitBmdSquare extends BmdSquare 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		//private var
		
		/**
		 * コンストラクタ
		 */
		public function AutoFitBmdSquare(bmd:BitmapData, width:Number, height:Number, basePoint:uint = DOAlign.TL) 
		{
			super(bmd, width, height, basePoint);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * 初期化
		 */
		private function init(event:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Event.RESIZE, resizeHandler);
			resizeHandler(null);
		}
		
		private function resizeHandler(event:Event):void 
		{
			width = stage.stageWidth;
			height = stage.stageHeight;
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
