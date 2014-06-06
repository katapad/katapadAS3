package com.katapad.display 
{
	import com.katapad.utils.DrawUtils;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	/**
	 * タイリングパターンクラス
	 * @author katapad
	 * @version 0.1
	 * @since 2009/01/07 12:51
	 */
	public class Pattern extends Shape 
	{
		
		//----------------------------------
		//  static var/const
		//----------------------------------
		//コンパイラバグ対策
		private static var  __FORCOMPILE:uint = DrawUtils.TL;
		private var _texture:BitmapData;
		private var _shape:Shape;
		private var _basePoint:uint;
		
		private var _matrix:Matrix;
		private var _repeat:Boolean;
		private var _smooth:Boolean;
		
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		//private var
		
		/**
		 * パターン画像用のシェイプ（bitmapfillするrectのshape）
		 * @param	texture
		 * @param	w
		 * @param	h
		 * @param	basePoint
		 * @param	matrix
		 * @param	repeat
		 * @param	smooth
		 */
		//public function Pattern(texture:BitmapData, w:Number, h:Number, basePoint:uint = DrawUtils.TL, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false) 
		public function Pattern(texture:BitmapData, w:Number, h:Number, basePoint:uint = 1, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false) 
		{
			_texture = texture;
			_basePoint = basePoint;
			_matrix = matrix;
			_repeat = repeat;
			_smooth = smooth;
			
			draw(w, h, matrix, repeat, smooth);
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
		 * 再描画します。w, hは省略すると現在のShapeのwhになります。Matrixは省略するとコンストラクタまたはsetterで定義したものになります。
		 * @param	w
		 * @param	h
		 * @param	matrix
		 * @param	repeat
		 * @param	smooth
		 */
		public function draw(w:Number = NaN, h:Number = NaN, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false):void
		{
			w = w || this.width;
			h = h || this.height;
			_matrix = matrix || _matrix;
			
			graphics.clear();
			DrawUtils.drawBitmapFillPoint(graphics, _texture, _basePoint, 0, 0, w, h, DrawUtils.RECT, matrix, repeat, smooth);
		}
		
		/**
		 * 幅と高さだけを変更して再描画します
		 */
		public function redraw(w:Number = NaN, h:Number = NaN):void
		{
			w = w || this.width;
			h = h || this.height;
			graphics.clear();
			DrawUtils.drawBitmapFillPoint(graphics, _texture, _basePoint, 0, 0, width, height, DrawUtils.RECT, _matrix, _repeat, _smooth);
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
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
		public function get texture():BitmapData { return _texture; }
		
		public function set texture(value:BitmapData):void 
		{
			_texture = value;
			draw(this.width, this.height);
		}
		
		public function get basePoint():uint { return _basePoint; }
		
		public function set basePoint(value:uint):void 
		{
			_basePoint = value;
		}
		
		public function get matrix():Matrix { return _matrix; }
		
		public function set matrix(value:Matrix):void 
		{
			_matrix = value;
		}
	
	}
	
}
