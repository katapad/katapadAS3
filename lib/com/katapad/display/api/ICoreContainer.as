package com.katapad.display.api 
{
	
	/**
	 * コアSpriteのインターフェイス
	 * @author katapad
	 * @version 0.1
	 * @since 2009/06/19 15:54
	 */
	public interface ICoreContainer extends ICoreDisplay
	{
//		function removeChildren():void;
		function lock():void;
		function unlock():void;
		function mouseLock():void;
		function mouseUnlock():void;
		
		function get isLock():Boolean;
		function get isMouseLock():Boolean;
	}
	
}