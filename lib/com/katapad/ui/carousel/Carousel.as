package com.katapad.ui.carousel 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/03/15 11:56
	 */
	public class Carousel extends EventDispatcher
	{
		/**
		 * DISABLE_PREV
		 * @eventType com.katapad.ui.carousel.Carousel.DISABLE_PREV
		 */
		[Event(name = "disablePrev", type = "flash.events.Event")]
		
		/**
		 * DISABLE_NEXT
		 * @eventType com.katapad.ui.carousel.Carousel.DISABLE_NEXT
		 */
		[Event(name = "disableNext", type = "flash.events.Event")]
		
		/**
		 * ENABLE_PREV
		 * @eventType com.katapad.ui.carousel.Carousel.ENABLE_PREV
		 */
		[Event(name = "enablePrev", type = "flash.events.Event")]
		
		/**
		 * ENABLE_NEXT
		 * @eventType com.katapad.ui.carousel.Carousel.ENABLE_NEXT
		 */
		[Event(name = "enableNext", type = "flash.events.Event")]
		
		
		//----------------------------------
		//  static var/const
		//----------------------------------
		public static const DISABLE_PREV:String = "disablePrev";
		public static const DISABLE_NEXT:String = "disableNext";
		public static const ENABLE_PREV:String = "enablePrev";
		public static const ENABLE_NEXT:String = "enableNext";
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		protected var _index:int;
		protected var _list:Array;
		protected var _loop:Boolean;
		protected var _max:uint;
		
		protected var _isFirst:Boolean;
		
		protected var _oldContents:*;
		protected var _oldIndex:int;
		
		protected var _steps:int;
		//private var _麻紀:Boolean;
		
		/**
		 * 
		 * @param	loop
		 * @param	list
		 * @param	startIndex
		 * @return
		 */
		public function Carousel(loop:Boolean, list:Array, startIndex:int = 0) 
		//public function Carousel(麻紀:Boolean, startIndex:int, list:Array) 
		{
			_init(loop, list, startIndex);
			//_init(麻紀, startIndex, list);
		}
		
		/**
		 * 初期化
		 */
		protected function _init(loop:Boolean, list:Array, startIndex:int):void 
		{
			if (list.length <= startIndex)
				throw new ArgumentError("startIndexの値が大きすぎます。 startIndex : " + startIndex + ", list.length : " + list.length);
			
			_isFirst = true;
			_index = startIndex;
			_list = list;
			_loop = loop;
			_max = list.length - 1;
			_initHook();
		}
		//--------------------------------------------------------------------------
		//
		//  OVERRIDE
		//
		//--------------------------------------------------------------------------
		protected function _initHook():void
		{
			
		}
		
		protected function _move():void
		{
			_close();
			_open();
			_isFirst = false;
		}
		
		protected function _close(delayTime:Number = 0.0):void
		{
			
		}
		
		protected function _open(delayTime:Number = 0.0):void
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		public function prev():*
		{
			_setOld();
			
			if (loop)
			{
				if (hasPrev())
				{
					--_index;
				}
				else
				{
					_index = _max;
				}
			}
			else
			{
				if (!hasPrev())
					return _getCurrent();
					
				--_index;
			}
			
			_setStep();
			_dispatchEnableAndDisable();
			_move();
			return _getCurrent();
		}
		
		private function _setStep():void
		{
			_steps = _oldIndex - index;
		}
		
		public function next():*
		{
			_setOld();
			
			if (loop)
			{
				if (hasNext())
				{
					++_index;
				}
				else
				{
					_index = 0;
				}
			}
			else
			{
				if (!hasNext())
					return _getCurrent();
				
				++_index;
			}
			
			_setStep();
			_dispatchEnableAndDisable();
			_move();
			return _getCurrent();
		}
		
		
		public function hasNext():Boolean
		{
			return _index < _max;
		}
		
		public function hasPrev():Boolean
		{
			return _index > 0;
		}
		
		//--------------------------------------------------------------------------
		//
		//  PROTECTED
		//
		//--------------------------------------------------------------------------
		protected function _setOld():void
		{
			_oldContents = _getCurrent();
			_oldIndex = _index;
		}
		
		/**
		 * ループしないときの Next Prevをdispatch
		 */
		protected function _dispatchEnableAndDisable():void
		{
			if (_loop)
				return;
			
			if (_oldIndex == 0)
			{
				_dispachEnablePrev();
			}
			else 
			{
				if (_index == 0)
					_dispachDisablePrev();
			}
			
			if (_oldIndex == _max)
			{
				_dispachEnableNext();
			}
			else
			{
				if (_index == _max)
					_dispachDisableNext();
			}
			//trace( "_index : " + _index, "_max : " + _max);
		}
		
		protected function _getCurrent():*
		{
			return _list[_index];
		}
		
		//----------------------------------
		//  dispatch
		//----------------------------------
		protected function _dispachEnablePrev():void
		{
			dispatchEvent(new Event(Carousel.ENABLE_PREV));
		}
		
		protected function _dispachDisablePrev():void
		{
			dispatchEvent(new Event(Carousel.DISABLE_PREV));
		}
		
		protected function _dispachEnableNext():void
		{
			dispatchEvent(new Event(Carousel.ENABLE_NEXT));
		}
		
		protected function _dispachDisableNext():void
		{
			dispatchEvent(new Event(Carousel.DISABLE_NEXT));
		}
		
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
		public function get loop():Boolean { return _loop; }
		
		public function get index():int { return _index; }
		
		public function set index(value:int):void
		{
			_index = value;
		}
		
		public function get current():* { return _getCurrent(); }
		
		public function get isFirst():Boolean { return _isFirst; }
		
		public function set isFirst(value:Boolean):void 
		{
			_isFirst = value;
		}
		
	
	}
	
}
