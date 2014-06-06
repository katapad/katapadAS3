package com.katapad.display.shape 
{
	import com.katapad.core.DOAlign;
	import com.katapad.utils.DrawUtils;
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/03/29 15:43
	 */
	public class BmdSquare extends Shape 
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
		public function BmdSquare(bmd:BitmapData, width:Number, height:Number, basePoint:uint = DOAlign.TL) 
		{
			init(bmd, width, height, basePoint);
		}
		
		/**
		 * 初期化
		 */
		private function init(bmd:BitmapData, width:Number, height:Number, basePoint:uint):void 
		{
			graphics.beginBitmapFill(bmd);
			DrawUtils.drawNoFillPoint(graphics, basePoint, 0, 0, width, height, DrawUtils.RECT);
			graphics.endFill();
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
