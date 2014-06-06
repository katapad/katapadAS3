package com.katapad.display.shape 
{
	import com.katapad.core.DOAlign;
	import com.katapad.utils.DrawUtils;
	import flash.display.Shape;
	
	/**
	 * ラインつきの四角形を書きます
	 * @author katapad
	 * @version 0.1
	 * @since 2009/10/09 13:57
	 */
	public class LineSquare extends Shape 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		
		/**
		 * ラインつきの四角形を書きます
		 * @param	lineStyle
		 * @param	width
		 * @param	height
		 * @param	isFill
		 * @param	basePoint
		 * @param	color
		 * @param	alpha
		 */
		public function LineSquare(lineStyle:LineStyleData, width:Number, height:Number, isFill:Boolean = false, basePoint:uint = DOAlign.TL, color:uint = 0, alpha:Number = 1.0) 
		{
			if (lineStyle)
			{
				lineStyle.apply(graphics);
			}
			if (isFill)
				DrawUtils.drawFillPoint(graphics, basePoint, 0, 0, width, height, DrawUtils.RECT, color, alpha);
			else
				DrawUtils.drawNoFillPoint(graphics, basePoint, 0, 0, width, height, DrawUtils.RECT, color);
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
