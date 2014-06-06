package com.katapad.display.api 
{
	import flash.events.IEventDispatcher;
	
	/**
	 * コアDisplayObjectのインターフェイス
	 * @author katapad
	 * @version 0.1
	 * @since 2009/06/19 15:54
	 */
	public interface ICoreDisplay extends IEventDispatcher
	{
		/**
		 * Openする前に初期化します。
		 * @private
		 */
		function initOpen():void;
		
		/**
		 * Openが終わったら呼び出します
		 * @private
		 */
		//function openComplete():void;
		
		/**
		 * closeが終わったら呼び出します
		 */
		//function closeComplete():void;
		
		
		/**
		 * openします
		 * @param	delayTime
		 * @param	useCompleteEvent
		 */
		function open(delayTime:Number = 0.0):void;
		
		/**
		 * closeします
		 * @param	delayTime
		 * @param	useCompleteEvent
		 */
		function close(delayTime:Number = 0.0):void;
		
		/**
		 * 表示します
		 */
		function show(delayTime:Number = 0):void;
		
		/**
		 * 非表示にします
		 */
		function hide(delayTime:Number = 0):void;
	}
	
}