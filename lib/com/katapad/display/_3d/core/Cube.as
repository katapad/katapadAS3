package com.katapad.display._3d.core 
{
	import com.katapad.display.shape.LineShape;
	import com.katapad.display.shape.LineStyleData;
	import com.katapad.display.shape.Square;
	import com.katapad.utils.DrawUtils;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import caurina.transitions.Tweener;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/04/19 11:08
	 */
	public class Cube extends Sprite 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _front:DisplayObject;
		private var _back:DisplayObject;
		private var _left:DisplayObject;
		private var _right:DisplayObject;
		private var _top:DisplayObject;
		private var _bottom:DisplayObject;
		
		private var _mcList:Vector.<DisplayObject>;
		
		private var _spWidth:Number;
		private var _spHeight:Number;
		
		/**
		 * コンストラクタ
		 */
		public function Cube(width:Number, height:Number) 
		{
			_init(width, height);
		}
		
		/**
		 * 初期化
		 */
		private function _init(width:Number, height:Number):void 
		{
			_spWidth = width;
			_spHeight = height;
			_createElements();
			_initElements();
		}
		
		private function _initElements():void
		{
			var hw:Number = _spWidth * 0.5;
			//var mc:DisplayObject;
			//mc = _mcList[0];
			//front
			_mcList[0].z = -hw;
			
			//right
			_mcList[1].x = hw;
			_mcList[1].rotationY = 90;
			
			//back
			_mcList[2].z = -hw;
			_mcList[2].rotationY = 180;
			
			//left
			_mcList[3].x = -hw;
			_mcList[3].rotationY = 270;
			
			//top
			_mcList[4].y = hw;
			_mcList[4].rotationX = 90;
			//
			//top
			_mcList[5].y = -hw;
			_mcList[5].rotationX = -90;
			
			
			
			
		}
		
		private function _createElements():void
		{
			_mcList = new Vector.<DisplayObject>(6);
			var hw:Number = _spWidth * 0.5;
			var hh:Number = -_spHeight * 0.5;
			for (var i:int = 0, n:int = 6; i < n; ++i) 
			{
				//var mc:Shape = new Square(_spWidth, _spHeight, 
				
				var mc:Shape = new LineShape([new Point(-hw, -hh), new Point(hw, -hh), new Point(hw, hh), new Point(-hw, hh)], true, 1, NaN, new LineStyleData(1, 0xFF9900, 1, true, "normal" ));
				addChild(mc);
				_mcList[i] = mc;
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
