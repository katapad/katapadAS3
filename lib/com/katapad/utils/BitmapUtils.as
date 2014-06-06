package com.katapad.utils 
{
	import com.katapad.core.DOAlign;
	import com.katapad.core.PointData;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2009/01/15 15:57
	 */
	public class BitmapUtils 
	{
		private static var _identityPoint:PointData;
		private static var _identityMatrix:Matrix = new Matrix();
		
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		//private var
		
		/**
		 * コンストラクタ禁止
		 */
		public function BitmapUtils() 
		{
			throw new Error("BitmapUtils is static class");
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
		/**
		 * DrawしたBitmapdataを返します
		 * @param	source
		 * @param	w
		 * @param	h
		 * @param	basePoint
		 * @return
		 */
		public static function drawBasePoint(source:IBitmapDrawable, w:int, h:int, basePoint:uint = 1):BitmapData
		{
			var result:BitmapData = new BitmapData(w, h, true, 0x0);
			result.draw(source, getMatrixByBasePoint(basePoint, w, h));
			return result;
		}
		
		/**
		 * クリップします
		 * @param	source
		 * @param	w
		 * @param	h
		 * @param	rect
		 * @return
		 */
		public static function clipping(source:IBitmapDrawable, w:int, h:int, rect:Rectangle):BitmapData
		{
			var result:BitmapData = new BitmapData(w, h, true, 0x0);
			//result.draw(source, getMatrixByBasePoint(basePoint, w, h), null, null, rect);
			result.draw(source, null, null, null, rect);
			return result;
		}
		
		/**
		 * DrawしたBitmapDataを返します
		 * @param	source
		 * @param	w
		 * @param	h
		 * @param	matrix
		 * @return
		 */
		public static function draw(source:IBitmapDrawable, w:int, h:int, matrix:Matrix = null):BitmapData
		{
			var result:BitmapData = new BitmapData(w, h, true, 0);
			result.draw(source, matrix);
			return result;
		}
		
		/**
		 * 基準点つきのSpriteでくるみます
		 * @param	bitmap
		 * @param	align	DoAlign.TL
		 * @return
		 */
		public static function wrapSprite(bitmap:Bitmap, align:int = 1):Sprite
		{
			var pt:Point = DOAlign.getNormalizePoint(align);
			var result:Sprite = new Sprite();
			result.addChild(bitmap);
			
			bitmap.x = pt.x * -bitmap.width;
			bitmap.y = pt.y * -bitmap.height;
			
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
		private static function getMatrixByBasePoint(basePoint:uint, w:int, h:int):Matrix
		{
			if (basePoint == DOAlign.TL)
				return null;
			var result:Matrix = _identityMatrix;
			result.identity();
			var x:Number = 0;
			var y:Number = 0;
			
			if (basePoint == DOAlign.TC || basePoint == DOAlign.MC || basePoint == DOAlign.BC)
				x = Math.floor(w * 0.5);
			else if (basePoint == DOAlign.TR || basePoint == DOAlign.MR || basePoint == DOAlign.BR )
				x = w;
			
			if (basePoint == DOAlign.ML || basePoint == DOAlign.MC || basePoint == DOAlign.MR )
				y = Math.floor(w * 0.5);
			else if (basePoint == DOAlign.BL || basePoint == DOAlign.BC || basePoint == DOAlign.BR )
				y = h;
			
			result.translate(x, y);
			return result;
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
		private static function get identityPoint():PointData 
		{ 
			if (!_identityPoint)
				_identityPoint = new PointData();
			return _identityPoint; 
		}
	
	}
	
}
