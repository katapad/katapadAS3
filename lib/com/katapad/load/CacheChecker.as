package com.katapad.load 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	/**
	 * ...
	 * @author katapad.com
	 * @version 0.1
	 * @since 2009/04/30 19:13
	 */
	public class CacheChecker extends EventDispatcher 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _eventSource:IEventDispatcher
		
		/**
		 * コンストラクタ
		 */
		public function CacheChecker(eventSource:IEventDispatcher) 
		{
			init(eventSource);
		}
		
		/**
		 * 初期化
		 */
		private function init(eventSource:IEventDispatcher):void 
		{
			_eventSource = eventSource;
			_eventSource.addEventListener(ProgressEvent.PROGRESS, onProgress);
		}
		
		private function onProgress(event:ProgressEvent):void 
		{
			//trace(event);
			var percent:Number = event.bytesLoaded / event.bytesTotal;
			if (percent == 1)
				complete();
		}
		
		private function complete():void
		{
			_eventSource.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			_eventSource = null;
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
