package com.katapad.display.shape 
{
	import com.katapad.core.DOAlign;
	import flash.display.Shape;
	import com.katapad.utils.DrawUtils;
	
	/**
	 * ちゃちゃっと長方形を作る
	 * @author katapad
	 * @version 0.1
	 * @since 2008/09/04 17:00
	 */
	public class Square extends Shape 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		
		/**
		 * 四角形のシェイプクラス。
		 * @param	width
		 * @param	height
		 * @param	color
		 * @param	alpha
		 * @param	basePoint
		 */
		//public function Square(width:Number, height:Number, color:uint = 0, alpha:Number = 1.0, basePoint:uint = DOAlign.TL) 
		public function Square(width:Number, height:Number, color:uint = 0, alpha:Number = 1.0, basePoint:uint = 1) 
		{
			init(width, height, color, alpha, basePoint);
		}
		
		/**
		 * 初期化
		 */
		private function init(width:Number, height:Number, color:Number, alpha:Number, basePoint:uint):void 
		{
			DrawUtils.drawFillPoint(graphics, basePoint, 0, 0, width, height, DrawUtils.RECT, color, alpha);
		}

		public function setSize(width:Number, height:Number):void
		{
			this.width = width;
			this.height = height;
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
