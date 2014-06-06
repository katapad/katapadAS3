package com.katapad.bitmap 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.IBitmapDrawable;
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	/**
	 * 鏡面反射クラス
	 * @author katapad
	 * @version 0.1
	 * @since 2009/01/07 21:12
	 */
	public class ReflectionDraw 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		public static const GRADIENT_COLORS:Array = [0, 0];
		private static const GRADIENT_ALPHAS:Array = [0.8, 0];
		private static const GRADIENT_RATIOS:Array = [0, 122];
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _reflectSource:IBitmapDrawable;
		private var _destBitmap:Bitmap;
		private var _destBitmapData:BitmapData;
		private var _drawMatrix:Matrix;
		//private var _gradientBitmap:BitmapData;
		
		private var _gradientShape:Shape;
		private var _gradientColors:Array;
		private var _gradientAlphas:Array;
		private var _gradientRatios:Array;
		
		/**
		 * 鏡面反射を作ってdrawするヘルパークラスです。DisplayObjectではありません。
		 * 
		 * @param	reflectSource	鏡面反射したいIBitmapDrawable
		 * @param	destBitmap		鏡面反射を配置するbitmap。destBitmap.bitmapdataがなくても作れますが、bitmapdataのサイズがいい加減になる可能性が高いです。
		 * @param	alphas			グラデーション設定用。defaultは2値	ReflectionDraw.GRADIENT_ALPHAS
		 * @param	ratios			グラデーション設定用。defaultは2値	ReflectionDraw.GRADIENT_RATIOS
		 * @param	colors			グラデーション設定用。defaultは2値 ReflectionDraw.GRADIENT_COLORS
		 * @param	drawMatrix		bitmapdata.drawするときのmatrix。指定がなければ左上基準でbitmapdata.drawする
		 * @see	#draw()
		 */
		public function ReflectionDraw(reflectSource:IBitmapDrawable, destBitmapData:BitmapData, alphas:Array = null, ratios:Array = null, colors:Array= null, drawMatrix:Matrix = null) 
		{
			init(reflectSource, destBitmapData, alphas, ratios, colors, drawMatrix);
		}
		
		/**
		 * 初期化
		 */
		private function init(reflectSource:IBitmapDrawable, destBitmapData:BitmapData, alphas:Array, ratios:Array, colors:Array, drawMatrix:Matrix):void 
		{
			_reflectSource = reflectSource;
			//_destBitmap = destBitmap;
			//if (!destBitmap.bitmapData)
				//_destBitmapData = destBitmap.bitmapData = new BitmapData(Math.ceil(DisplayObject(_reflectSource).width), Math.ceil(DisplayObject(_reflectSource).height), true, 0xFFFFFF);
			//else
				_destBitmapData = destBitmapData;
			
			_gradientColors = colors || ReflectionDraw.GRADIENT_COLORS;
			_gradientAlphas = alphas || ReflectionDraw.GRADIENT_ALPHAS;
			_gradientRatios = ratios || ReflectionDraw.GRADIENT_RATIOS;
			
			_drawMatrix = drawMatrix || new Matrix();
			if (drawMatrix == null)
			{
				_drawMatrix.translate(0, -_destBitmapData.height);
				_drawMatrix.scale(1.0, -1.0);
			}
			//_gradientBitmap = new BitmapData(_destBitmapData.width, _destBitmapData.height, true, 0xFFFFFF);
			
			createGradient();
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
		 * 鏡面反射を描きます。
		 */
		public function draw():void
		{
			_destBitmapData.lock();
			_destBitmapData.fillRect(_destBitmapData.rect, 0);
			_destBitmapData.draw(_reflectSource, _drawMatrix);
			_destBitmapData.draw(_gradientShape, null, null, BlendMode.ALPHA);
			//bitmapをdrawする方が高速だが、alphaをうまくdrawできない
			//_destBitmapData.draw(_gradientBitmap, null, null, BlendMode.ALPHA);
			_destBitmapData.unlock();
		}
		
		/**
		 * 参照をすべて切る。鏡面反射したbitmapdataも消すなら、destroyBitmapdataをtrueにする
		 * @param	destroyBitmapdata
		 */
		public function destroy(destroyBitmapdata:Boolean = false):void
		{
			if (destroyBitmapdata)
				_destBitmapData.dispose();
			_reflectSource = null;
			_destBitmap = null;
			_destBitmapData = null;
			_drawMatrix = null;
			_gradientShape = null;
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
		private function createGradient():void
		{
			_gradientShape = new Shape();
			var mtx:Matrix = new Matrix();
			mtx.createGradientBox(_destBitmapData.width, _destBitmapData.height, Math.PI * 0.5);
			_gradientShape.graphics.beginGradientFill(GradientType.LINEAR, _gradientColors, _gradientAlphas, _gradientRatios, mtx);
			_gradientShape.graphics.drawRect(0, 0, _destBitmapData.width, _destBitmapData.height);
			_gradientShape.graphics.endFill();
			//_gradientBitmap.draw(_gradientShape);
			//_destBitmap.parent.addChild(new Bitmap(_gradientBitmap));
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
		public function get gradientColors():Array { return _gradientColors; }
		
		public function set gradientColors(value:Array):void 
		{
			_gradientColors = value;
		}
		
		public function get gradientAlphas():Array { return _gradientAlphas; }
		
		public function set gradientAlphas(value:Array):void 
		{
			_gradientAlphas = value;
		}
		
		public function get gradientRatios():Array { return _gradientRatios; }
		
		public function set gradientRatios(value:Array):void 
		{
			_gradientRatios = value;
		}
		
	
	}
	
}
