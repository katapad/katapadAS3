package com.katapad.display.core 
{
	import com.katapad.display.api.ICoreContainer;
	import com.katapad.utils.DOUtils;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * CoreとなるSprite
	 * @author katapad
	 * @version 0.1
	 * @since 2009/06/19 15:53
	 */
	public class CoreSprite extends Sprite implements ICoreContainer
	{
		/**
		 * openが終わったら送出します
		 * @eventType com.katapad.display.core.CoreSprite.OPEN_COMPLETE
		 */
		//[Event(name = "openComplete", type = "flash.events.Event")]
		[Event(name = "openComplete", type = "com.katapad.display.core.CoreSprite")]
		
		/**
		 * closeが終わったら送出します
		 * @eventType com.katapad.display.core.CoreSprite.CLOSE_COMPLETE
		 */
		[Event(name = "closeComplete", type = "flash.events.Event")]
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		public static const OPEN_COMPLETE:String = "openComplete";
		public static const CLOSE_COMPLETE:String = "closeComplete";
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		protected var _isLock:Boolean;
		protected var _isMouseLock:Boolean;
		
		/**
		 * 
		 */
		public function CoreSprite() 
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  OVERRIDE
		//
		//--------------------------------------------------------------------------
		public function open(delayTime:Number = 0.0):void
		{
			noOverrideFunction();
		}
		
		public function close(delayTime:Number = 0.0):void
		{
			noOverrideFunction();
		}
		
		public function show(delayTime:Number = 0):void
		{
			noOverrideFunction();
		}
		
		public function hide(delayTime:Number = 0):void
		{
			noOverrideFunction();
		}
		
		public function initOpen():void
		{
			
		}
		
		protected function openComplete():void
		{
			dispachOpenComplete();
		}
		
		protected function closeComplete():void
		{
			dispachCloseComplete();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
//		public function removeChildren():void
//		{
//			DOUtils.removeChildren(this);
//		}
		
		public function lock():void
		{
			DOUtils.lock(this);
			_isLock = true;
		}
		
		public function unlock():void
		{
			DOUtils.unlock(this);
			_isLock = false;
		}
		
		public function mouseLock():void
		{
			DOUtils.mouseLock(this);
			_isMouseLock = true;
		}
		
		public function mouseUnlock():void
		{
			DOUtils.mouseUnlock(this);
			_isMouseLock = false;
		}
		
		public function destroy():void
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  PROTECTED
		//
		//--------------------------------------------------------------------------
		protected function dispachOpenComplete():void
		{
			dispatchEvent(new Event(CoreDOEventName.OPEN_COMPLETE));
		}
		
		protected function dispachCloseComplete():void
		{
			dispatchEvent(new Event(CoreDOEventName.CLOSE_COMPLETE));
		}
		
		private function noOverrideFunction():void
		{
			throw new Error("このメソッドはオーバーライドせずに使用されています");
		}
		
		/* INTERFACE com.katapad.display.api.ICoreContainer */
		
		public function get isMouseLock():Boolean
		{
			return _isMouseLock;
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
		public function get isLock():Boolean
		{
			return _isLock;
		}
		
	}
	
}
