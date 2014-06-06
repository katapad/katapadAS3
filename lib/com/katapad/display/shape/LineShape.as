package com.katapad.display.shape 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/04/16 11:37
	 */
	public class LineShape extends Shape 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _points:/*Point*/Array;
		private var _isLoop:Boolean;
		private var _lineStyle:LineStyleData;
		private var _alpha:Number;
		private var _color:uint;
		
		private var _canFill:Boolean;
		
		/**
		 * 
		 * @param	points
		 * @param	isLoop
		 * @param	color
		 * @param	alpha	NaNにするとfillしません
		 * @param	lineStyle
		 */
		public function LineShape(points:/*Point*/Array, isLoop:Boolean = true, color:uint = 0x0, alpha:Number = 1.0, lineStyle:LineStyleData = null) 
		{
			_init(points, isLoop, color, alpha, lineStyle);
		}
		
		/**
		 * 初期化
		 */
		private function _init(points:/*Point*/Array, isLoop:Boolean = true, color:uint = 0x0, alpha:Number = 1.0, lineStyle:LineStyleData = null):void 
		{
			if (points.length <= 1)
				throw new ArgumentError("points配列の長さが1以下です。もっとpointをいれてください。書けません");
			_points = points;
			_isLoop = isLoop;
			_color = color;
			_alpha = alpha;
			_lineStyle = lineStyle
			_canFill = !isNaN(_alpha);
			
			draw();
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
		public function draw():void
		{
			graphics.clear();
			
			if (_lineStyle)
				_lineStyle.apply(graphics);
			
			if (_canFill)
				_drawFill();
				
			var pt:Point = _points[0];
			graphics.moveTo(pt.x, pt.y);
			
			for (var i:int = 1, n:int = _points.length; i < n; ++i) 
			{
				pt = _points[i];
				graphics.lineTo(pt.x, pt.y);
				//var old:Point = _points[i - 1];
				//graphics.curveTo((old.x + pt.x) *0.5, (old.y + pt.y) *0.5, pt.x, pt.y);
				//graphics.curveTo( pt.x, pt.y, (old.x + pt.x) *0.5, (old.y + pt.y) *0.5);
			}
			
			if (_isLoop)
			{
				pt = _points[0];
				graphics.lineTo(pt.x, pt.y);
				//graphics.curveTo(pt.x, pt.y);
			}
			
			if (_canFill)
				_drawEndFill();
		}
		
		private function _drawEndFill():void
		{
			graphics.endFill();
		}
		
		private function _drawFill():void
		{
			graphics.beginFill(_color, _alpha);
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
		public function get points():/*Point*/Array { return _points; }
	
	}
	
}
