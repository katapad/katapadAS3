package com.katapad.utils 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2009/01/09 13:20
	 */
	public class FrameDelay extends EventDispatcher 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _counter:int;
		private var _delayFrames:uint;
		
		/**
		 * コンストラクタ
		 */
		public function FrameDelay(delayFrames:uint) 
		{
			init(delayFrames);
		}
		
		/**
		 * 初期化
		 */
		private function init(delayFrames:uint):void 
		{
			if (delayFrames <= 0)
				throw new ArgumentError("delayFramesの数値は1以上でお願いします");
			_delayFrames = delayFrames;
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
		
		public function start(delayFrames:uint = undefined):void
		{
			_delayFrames = delayFrames || _delayFrames;
			trace( "_delayFrames : " + _delayFrames );
			_counter = 0;
			loopOn();
		}
		
		private function update(event:Event):void 
		{
			if (++_counter > _delayFrames)
				end();
		}
		
		public function resume():void
		{
			if (_counter == _delayFrames)
				throw new Error("このFrameDealyはすでに終了済みです。再利用するには新たにstart()を読んでください。");
			loopOn();
		}
		
		public function stop():void
		{
			loopOff();
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
		private function loopOn():void
		{
			StStage.stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function loopOff():void
		{
			StStage.stage.removeEventListener(Event.ENTER_FRAME, update);
		}
		private function end():void
		{
			loopOff();
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
	
	}
	
}
