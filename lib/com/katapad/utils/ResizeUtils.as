package com.katapad.utils 
{
	import com.katapad.core.DOAlign;
	import com.katapad.utils.StStage;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import caurina.transitions.Tweener;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/02/18 17:46
	 */
	public class ResizeUtils 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		private static var _instance:ResizeUtils;
		/**
		 * getInstance
		 */
		public static function getInstance(stage:Stage = null):ResizeUtils
		{
			
			if (_instance == null) 
				_instance = new ResizeUtils(stage, new SingletonEnforcer());
			return _instance;
		}
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _dict:Dictionary;
		private var _stage:Stage;
		
		/**
		 * コンストラクタ
		 */
		public function ResizeUtils(stage:Stage, enforcer:SingletonEnforcer) 
		{
			init(stage);
		}
		
		/**
		 * 初期化
		 */
		private function init(stage:Stage):void 
		{
			if (!stage)
				_stage = StStage.stage;
			else
				_stage = stage;
			stage.addEventListener(Event.RESIZE, resizeHandler);
			_dict = new Dictionary();
		}
		
		public function add(target:DisplayObject, basePoint:uint = DOAlign.MC):void
		{
			var basePt:Point = getPoint(basePoint);
			_dict[target] = new ObjData(target, basePoint, target.x - basePt.x, target.y - basePt.y);
		}
		
		public function remove(target:DisplayObject):void
		{
			if (_dict[target])
			{
				delete _dict[target];
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
		private function resizeHandler(event:Event):void 
		{
			for each(var data:ObjData in _dict) 
			{
				var mc:DisplayObject = data.target;
				var pt:Point = getPoint(data.basePoint);
				mc.x = pt.x + data.x;
				mc.y = pt.y + data.y;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  PRIVATE
		//
		//--------------------------------------------------------------------------
		private function getPoint(basePoint:uint):Point
		{
			var result:Point = new Point();
			//x
			if (basePoint == DOAlign.TL || basePoint == DOAlign.ML || basePoint == DOAlign.BL)
				result.x = 0;
			else if (basePoint == DOAlign.TC || basePoint == DOAlign.MC || basePoint == DOAlign.BC)
				result.x = _stage.stageWidth * 0.5;
			else
				result.x = _stage.stageWidth;
				
			//y
			if (basePoint == DOAlign.TL || basePoint == DOAlign.TC || basePoint == DOAlign.TR)
				result.y = 0;
			else if (basePoint == DOAlign.ML || basePoint == DOAlign.MC || basePoint == DOAlign.MR)
				result.y = _stage.stageHeight * 0.5;
			else
				result.y = _stage.stageHeight;
			return result;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
	
	}
}
import flash.display.DisplayObject;
class ObjData
{
	private var _target:DisplayObject;
	private var _basePoint:uint;
	private var _x:Number;
	private var _y:Number;
	function ObjData(target:DisplayObject, basePoint:uint, x:Number, y:Number)
	{
		_target = target;
		_basePoint = basePoint;
		_x = x;
		_y = y;
	}
	
	public function get target():DisplayObject { return _target; }
	
	public function set target(value:DisplayObject):void 
	{
		_target = value;
	}
	
	public function get basePoint():uint { return _basePoint; }
	
	public function set basePoint(value:uint):void 
	{
		_basePoint = value;
	}
	
	public function get x():Number { return _x; }
	
	public function set x(value:Number):void 
	{
		_x = value;
	}
	
	public function get y():Number { return _y; }
	
	public function set y(value:Number):void 
	{
		_y = value;
	}
	
}


class SingletonEnforcer 
{
	function SingletonEnforcer() 
	{
		
	}
}
