package com.katapad.display.shape 
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	import caurina.transitions.Tweener;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/03/30 16:52
	 */
	public class BmdShape extends Shape 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _bmd:BitmapData;
		private var _bx:Number;
		private var _by:Number;
		private var _mtx:Matrix;
		private var _smooth:Boolean;
		private var _autoRedraw:Boolean;
		
		/**
		 * コンストラクタ
		 */
		public function BmdShape(bmd:BitmapData, width:Number, height:Number, autoRedraw:Boolean = true, bx:Number = 0, by:Number = 0, mtx:Matrix = null, smooth:Boolean = false) 
		{
			_init(bmd, width, height, autoRedraw, bx, by, mtx, smooth );
		}
		
		/**
		 * 初期化
		 */
		private function _init(bmd:BitmapData, width:Number, height:Number, autoRedraw:Boolean = true, bx:Number = 0, by:Number = 0, mtx:Matrix = null, smooth:Boolean = false):void 
		{
			_bmd = bmd;
			_bx = bx;
			_by = by;
			_autoRedraw = autoRedraw;
			_mtx = mtx || new Matrix();
			
			_mtx.tx = _bx;
			_mtx.ty = _by;
			
			_smooth = smooth;
			draw(width, height);
		}
		
		public function draw(width:Number = NaN, height:Number = NaN):void
		{
			var w:Number = width || this.width;
			var h:Number = height || this.height;
			_mtx.tx = _bx;
			_mtx.ty = _by;
			graphics.clear();
			graphics.beginBitmapFill(bmd, _mtx, true, _smooth);
			graphics.drawRect(0, 0, width, height);
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
		public function get bmd():BitmapData { return _bmd; }
		
		public function set bmd(value:BitmapData):void 
		{
			_bmd = value;
			if (_autoRedraw)
				draw();
		}
		
		public function get bx():Number { return _bx; }
		
		public function set bx(value:Number):void 
		{
			_bx = value;
			if (_autoRedraw)
				draw(width, height);
		}
		
		public function get by():Number { return _by; }
		
		public function set by(value:Number):void 
		{
			_by = value;
			if (_autoRedraw)
				draw(width, height);
		}
		
		public function get smooth():Boolean { return _smooth; }
		
		public function set smooth(value:Boolean):void 
		{
			_smooth = value;
			if (_autoRedraw)
				draw(width, height);
		}
	
	}
	
}
