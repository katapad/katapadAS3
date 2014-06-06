package com.katapad.display.loading 
{
	import com.katapad.display.core.CoreSprite;
	import com.katapad.utils.DOUtils;
	import com.katapad.utils.DrawUtils;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/02/01 17:42
	 */
	public class Kurukuru extends CoreSprite 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _list:Array;
		private var _numUpdate:uint;
		private var _minAlpha:Number;
		private var _subAlpha:Number;
		private var _timerInterval:Number;
		
		private var _timer:Timer;
		private var _index:uint;
		
		/**
		 * コンストラクタ
		 */
		public function Kurukuru(minAlpha:Number = 0.1, subAlpha:Number = 0.1, timerInterval:Number = 60, numUpdate:uint = 5, color:uint = 0, posRadius:Number = 7, numElems:uint = 12,  elemRadius:Number = 3, elemWidth:Number = 9) 
		{
			init(minAlpha, subAlpha, timerInterval, numUpdate, color, posRadius, numElems,  elemRadius, elemWidth);
		}
		
		/**
		 * 初期化
		 */
		private function init(minAlpha:Number, subAlpha:Number, timerInterval:Number, numUpdate:uint, color:uint, posRadius:Number, numElems:uint,  elemRadius:Number, elemWidth:Number):void 
		{
			_numUpdate = numUpdate;
			_minAlpha = minAlpha;
			_subAlpha = subAlpha;
			_timerInterval = timerInterval;
			if (_numUpdate > numElems)
				_numUpdate = numElems;
			
			
			createElements(color, posRadius, numElems,  elemRadius, elemWidth);
			initAlpha();
			_timer = new Timer(_timerInterval);
		}
		
		private function initAlpha():void
		{
			for (var i:int = 0, n:int = _list.length; i < n; ++i) 
			{
				var mc:DisplayObject = _list[i];
				mc.alpha = i * _subAlpha;
				if (mc.alpha < _minAlpha)
					mc.alpha = _minAlpha;
				
			}
		}
		
		private function createElements(color:uint, posRadius:Number, numElems:uint,  elemRadius:Number, elemWidth:Number):void
		{
			_list = [];
			const radian:Number = (Math.PI * 2) / numElems;
			const fixRad:Number = Math.PI / 2;
			var rad:Number;
			for (var i:int = 0; i < numElems; ++i) 
			{
				var mc:Shape = new Shape();
				DrawUtils.drawFill(mc.graphics, 0, -elemRadius * 0.5, elemWidth, elemRadius, DrawUtils.ROUND_RECT, color, 1.0, elemRadius);
				addChild(mc);
				
				rad = radian * i - fixRad;
				mc.x = posRadius * Math.cos(rad);
				mc.y = posRadius * Math.sin(rad);
				
				mc.rotation = rad * (180 / Math.PI);
				
				_list[i] = mc;
			}
		}
		//--------------------------------------------------------------------------
		//
		//  OVERRIDE
		//
		//--------------------------------------------------------------------------
		override public function open(delayTime:Number = 0.0):void 
		{
			DOUtils.show(this);
			startUpdate();
		}
		
		override public function close(delayTime:Number = 0.0):void 
		{
			DOUtils.hide(this);
			stopUpdate();
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------

		public function start():void
		{
			startUpdate();
		}

		public function stop():void
		{
			stopUpdate();
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
		private function startUpdate():void
		{
			if (_timer.running)
				return;
			_timer.addEventListener(TimerEvent.TIMER, update);
			_timer.start();
		}
		
		
		private function stopUpdate():void
		{
			_timer.removeEventListener(TimerEvent.TIMER, update);
			_timer.stop();
		}
		
		private function update(event:Event = null):void 
		{
			for (var i:int = 0, n:int = _list.length; i < n; ++i) 
			{
				var item:DisplayObject = _list[i];
				if (i == _index)
				{
					item.alpha = 1.0;
				}
				else
				{
					item.alpha -= _subAlpha;
					if (item.alpha < _minAlpha)
						item.alpha = _minAlpha;
				}
			}
			_index++;
			_index %= _list.length;
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
	}
}
