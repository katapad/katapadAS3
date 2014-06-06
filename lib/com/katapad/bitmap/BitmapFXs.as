package com.katapad.bitmap 
{
	import flash.errors.IllegalOperationError;
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.ConvolutionFilter;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/05/18 0:52
	 */
	public class BitmapFXs 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		public static const OUTLINE_3:String = "outline_3";
		public static const OUTLINE_5:String = "outline_5";
		public static const NEGA:String = "nega";
		public static const GRAY_SCALE:String = "grayScale";
		public static const SHARPEN_WEAK:String = 'sharpenWeak';
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private static var _pool:Dictionary = new Dictionary(true);
		
		/**
		 * コンストラクタ
		 */
		public function BitmapFXs() 
		{
			throw new IllegalOperationError("BitmapFXs cannot construct");
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
		public static function getFX(key:String):BitmapFilter
		{
			var result:BitmapFilter = _pool[key];
			if (!result)
			{
				result = _pool[key]= _getFX(key);
			}
			return result;
		}
		
		private static function _getFX(key:String):BitmapFilter
		{
			var result:BitmapFilter = _pool[key];
			switch (key) 
			{
				case OUTLINE_5 : 
					result = _getOutline5();
					break;
				case OUTLINE_3 : 
					result = _getOutline3();
					break;
				case NEGA : 
					result = _getNEGA();
					break;
				case GRAY_SCALE : 
					result = _getGrayScale();
					break;
				case SHARPEN_WEAK : 
					result = _getSharpenWeak();
					break;
					
			}
			return result;
		}
		
		public static function getDivisor(matrix:Array):int
		{
			var result:Number = 0;
			for each(var index:Number in matrix) 
			{
				result += index;
			}
			return result;
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
		//----------------------------------
		//  bitmap Fx create
		//----------------------------------
		static private function _getOutline5():ConvolutionFilter
		{
			var matrix:Array = [
				-1, -1, -1, -1, -1,
				-1, -1, -1, -1, -1,
				-1, -1, 24, -1, -1,
				-1, -1, -1, -1, -1,
				-1, -1, -1, -1, -1
			];
			
			return new ConvolutionFilter(
				//5, 5, matrix, getDivisor(matrix), 0
				5, 5, matrix, 0, 0
			);
		}
		
		static private function _getOutline3():ConvolutionFilter
		{
			var matrix:Array = [
				0, -1, 0,
				-1, 4, -1,
				0, -1, 0
			];
			
			return new ConvolutionFilter(3, 3, matrix, 0, 0);
		}
		
		
		static private function _getNEGA():ColorMatrixFilter
		{
			return new ColorMatrixFilter(
				[
					-1, 0, 0, 0, 255,
					0, -1, 0, 0, 255,
					0, 0, -1, 0, 255,
					0, 0, 0, 1, 0
				]
			);
		}
		
		static private function _getGrayScale():ColorMatrixFilter
		{
			return new ColorMatrixFilter(
				[
					0.3,	0.59,	0.11,	0,	0,
					0.3,	0.59,	0.11,	0,	0,
					0.3,	0.59,	0.11,	0,	0,
					0,		0,		0,		1,	0
				]
			);
		}
		
		static private function _getSharpenWeak():ConvolutionFilter 
		{
			var convo:ConvolutionFilter = new ConvolutionFilter(3, 3, [	0, -0.5, 0, -0.5, 3, -0.5, 0, -0.5, 0, ], 1, 0);
			return convo;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
	
	}
	
}
