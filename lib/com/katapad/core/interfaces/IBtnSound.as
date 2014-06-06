package com.katapad.core.interfaces 
{
	/**
	 * btnのサウンドインターフェイス
	 * @author katapad
	 * @version 0.1
	 * @since 2008/07/30 16:18
	 */
	public interface IBtnSound 
	{
		/**
		 * 初期化
		 */
		function init():void;
		
		/**
		 * over時の音を鳴らす
		 */
		function over():void;
		
		/**
		 * out時の音を鳴らす
		 */
		function out():void;
		
		/**
		 * click時の音を鳴らす
		 */
		function click():void;
		
	}
	
}
