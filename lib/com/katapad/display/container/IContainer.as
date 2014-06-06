package com.katapad.display.container 
{
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2008/11/18 19:59
	 */
	public interface IContainer 
	{
		//function start(delayTime:Number = 0.0):void;
		function open(delayTime:Number = 0.0):void;
		function close(delayTime:Number = 0.0):void;
		function removeChildren():void;
		function lock():void;
		function unlock():void;
		
		function get isLock():Boolean;
	}
	
}