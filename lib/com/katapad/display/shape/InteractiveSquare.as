package com.katapad.display.shape 
{
	import com.katapad.core.DOAlign;
	import com.katapad.utils.DrawUtils;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2008/09/04 17:12
	 */
	public class InteractiveSquare extends Sprite 
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
		//public function InteractiveSquare(width:Number, height:Number, color:uint = 0, alpha:Number = 1.0, basePoint:uint = DOAlign.TL) 
		public function InteractiveSquare(width:Number, height:Number, color:uint = 0, alpha:Number = 1.0, basePoint:uint = 1) 
		{
			super();
			init(width, height, color, alpha, basePoint);
		}
		
		/**
		 * 初期化
		 */
		private function init(width:Number, height:Number, color:Number, alpha:Number, basePoint:uint):void 
		{
			DrawUtils.drawFillPoint(this.graphics, basePoint, 0, 0, width, height, DrawUtils.RECT, color, alpha);
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
