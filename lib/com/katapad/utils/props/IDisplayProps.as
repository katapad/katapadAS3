package com.katapad.utils.props 
{
	/**
	 * DisplayObjectの表示に関する基本プロパティ
	 * @author katapad.com
	 */
	public interface IDisplayProps
	{
		function get x():Number;
		function get y():Number;
		function get rotation():Number;
		function get scaleX():Number;
		function get scaleY():Number;
		function get alpha():Number;
	}
}