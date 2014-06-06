package com.katapad.display.shape 
{
	import com.katapad.core.DOAlign;
	import com.katapad.utils.DOUtils;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/02/18 19:30
	 */
	public class TileShape 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _layer:DisplayObjectContainer;
		private var _mcList:/*Shape*/Array;
		
		//private var _alpha:Number;
		//private var _scale:Number;
		//private var _rotation:Number;
		
		/**
		 * コンストラクタ
		 */
		public function TileShape(layer:DisplayObjectContainer, xNum:uint = 5, yNum:uint = 2, width:Number = 50, height:Number = 50, color:uint = 0x0, alpha:Number = 1.0, basePoint:uint = DOAlign.TL) 
		{
			init(layer, xNum, yNum, width, height, color, alpha, basePoint);
		}
		
		/**
		 * 初期化
		 */
		private function init(layer:DisplayObjectContainer, xNum:uint, yNum:uint, width:Number, height:Number, color:uint, alpha:Number, basePoint:uint):void 
		{
			_mcList = [];
			_layer = layer;
			var basePt:Point = DOAlign.getNormalizePoint(basePoint);
			basePt.x *= width;
			basePt.y *= height;
			
			for (var i:int = 0; i < yNum; ++i) 
			{
				var xx:Number = basePt.x;
				var yy:Number = basePt.y + i * height;
				for (var j:int = 0; j < xNum; ++j) 
				{
					//color = Math.random() * 0xFFFFFF;
					var mc:Shape = new Square(width, height, color, alpha, basePoint);
					mc.x = xx;
					mc.y = yy;
					xx += width;
					layer.addChild(mc);
					_mcList.push(mc); 
				}
			}
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
		public function destroy():void
		{
			DOUtils.removeChildren(_layer);
			_mcList = null;
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
		public function get alpha():Number { return _mcList[0].alpha; }
		
		public function set alpha(value:Number):void 
		{
			for each(var mc:Shape in _mcList) 
			{
				mc.alpha = value;
			}
		}
		
		public function get scaleX():Number { return _mcList[0].scaleX; }
		
		public function set scaleX(value:Number):void 
		{
			for each(var mc:Shape in _mcList) 
			{
				mc.scaleX = value;
			}
		}
		
		public function get scaleY():Number { return _mcList[0].scaleY; }
		
		public function set scaleY(value:Number):void 
		{
			for each(var mc:Shape in _mcList) 
			{
				mc.scaleY = value;
			}
		}
		
		public function get scale():Number { return _mcList[0].scaleX; }
		public function set scale(value:Number):void 
		{
			for each(var mc:Shape in _mcList) 
			{
				mc.scaleX = mc.scaleY = value;
			}
		}
		
		public function get rotation():Number { return _mcList[0].rotation; }
		
		public function set rotation(value:Number):void 
		{
			for each(var mc:Shape in _mcList) 
			{
				mc.rotation = value;
			}
		}
		
		public function get mcList():/*Shape*/Array { return _mcList; }
		
		public function get layer():DisplayObjectContainer { return _layer; }
		
	}
}