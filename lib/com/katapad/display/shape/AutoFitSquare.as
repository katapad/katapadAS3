package com.katapad.display.shape 
{
	import com.katapad.core.DOAlign;
	import com.katapad.utils.StStage;
	import flash.events.Event;
	/**
	 * リサイズに対応した全画面用のシェイプ
	 * @author katapad
	 * @version 0.1
	 * @since 2009/01/20 13:51
	 */
	public class AutoFitSquare extends Square 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		//private var
		
		/**
		 * リサイズに対応した全画面用のシェイプ
		 * @param	color
		 * @param	alpha
		 */
		public function AutoFitSquare(color:uint = 0xFFFFFF, alpha:Number = 1.0) 
		{
			super(10, 10, color, alpha, DOAlign.TL);
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * 初期化
		 */
		private function init(event:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			this.stage.addEventListener(Event.RESIZE, resizeHandler);
			resizeHandler(null);
		}
		
		private function resizeHandler(event:Event):void 
		{
			this.width = stage.stageWidth;
			this.height = stage.stageHeight;
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
