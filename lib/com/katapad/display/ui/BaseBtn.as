package com.katapad.display.ui 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * 抽象ボタンクラス。
	 * @author katapad
	 * @version 0.1
	 * @since 2009/01/23 17:10
	 */
	public class BaseBtn extends Sprite 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _lock:Boolean;
		
		/**
		 * BaseBtnクラスは抽象クラスです。継承して使ってください。
		 * REMOVED_FROM_STAGE時に自動でremoveEventListenerします。
		 * @usage	BaseBtn.lock = true / false　のみでイベントを拾うかどうかの判断をします。
		 */
		public function BaseBtn(lock:Boolean = true) 
		{
			init(lock);
		}
		
		/**
		 * 初期化
		 */
		protected function init(lock:Boolean = true):void 
		{
			this.lock = lock;
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveHandler);
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
		protected function enableBtn():void 
		{
			this.buttonMode = true;
			this.addEventListener(MouseEvent.ROLL_OVER,overHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, outHandler);
			this.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		protected function disableBtn():void
		{
			this.buttonMode = false;
			this.removeEventListener(MouseEvent.ROLL_OVER,overHandler);
			this.removeEventListener(MouseEvent.ROLL_OUT, outHandler);
			this.removeEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		protected function overHandler(event:MouseEvent):void 
		{
			
		}
		
		protected function outHandler(event:MouseEvent):void 
		{
			
		}
		
		protected function clickHandler(event:MouseEvent):void 
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  EVENT HANDLER
		//
		//--------------------------------------------------------------------------
		protected function onRemoveHandler(event:Event):void 
		{
			if (_lock)
				disableBtn();
		}
		
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
		public function get lock():Boolean { return _lock; }
		
		public function set lock(value:Boolean):void 
		{
			_lock = value;
			if (value)
				disableBtn();
			else
				enableBtn();
		}
		
	
	}
	
}
