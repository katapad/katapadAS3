package com.katapad.ui.mouse 
{
	import com.katapad.core.PointData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	import caurina.transitions.Tweener;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/04/03 3:32
	 */
	public class MouseMonitor 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _isInit:Boolean = false;
		
		private var _maxCount:int = 10;
		private var _isRunning:Boolean;
		
		private static var _instance:MouseMonitor;
		private var _stage:Stage;
		
		private var _list:Array;
		private var _vx:Number;
		private var _vy:Number;
		
		
		/**
		 * getInstance
		 */
		public static function getInstance():MouseMonitor
		{
			if (_instance == null) 
				_instance = new MouseMonitor(new SingletonEnforcer());
			return _instance;
		}
		
		/**
		 * コンストラクタ
		 */
		public function MouseMonitor(enforcer:SingletonEnforcer) 
		{
			
		}
		
		public function init(stage:Stage, maxCount:Number = 10):void
		{
			_stage = stage;
			_maxCount = maxCount
			_list = [];
			
			_isInit = true;
		}
		
		private function update(event:Event):void 
		{
			_list.push(new PointData(_stage.mouseX, _stage.mouseY));
			if (_list.length > _maxCount)
			{
				_list.shift();
			}
			
				
			var totalX:Number = 0;
			var totalY:Number = 0;
			var oldPt:PointData;
			for (var i:int = 0, n:int = _list.length; i < n; ++i) 
			{
				var pt:PointData = _list[i];
				if (oldPt)
				{
					totalX += pt.x - oldPt.x;
					totalY += oldPt.y - pt.y;
				}
				oldPt = pt;
			}
			
			_vx = totalX;
			_vy = totalY;
		}
		
		public function start():void
		{
			_isRunning = true;
			_startUpdate();
		}
		
		public function stop():void
		{
			_isRunning = false;
			_stopUpdate();
		}
		
		private function _startUpdate():void
		{
			_stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function _stopUpdate():void
		{
			_stage.removeEventListener(Event.ENTER_FRAME, update);
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
		public function get vx():Number { return _vx; }
		
		public function get vy():Number { return _vy; }
		
		public function get isRunning():Boolean { return _isRunning; }
	}
	
}

class SingletonEnforcer 
{
	function SingletonEnforcer(){}
}
