package com.katapad.display.api 
{
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2009/06/09 17:53
	 */
	public interface ILoadingView extends IEventDispatcher
	{
		function progress(percent:Number):void;
		function open(delayTime:Number = 0.0):void;
		function close(delayTime:Number = 0.0):void;
//		function setSize(width:Number, height:Number):void;
	}
	
}