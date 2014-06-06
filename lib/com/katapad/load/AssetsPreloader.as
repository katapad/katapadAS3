package com.katapad.load 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * Urlloaderで先読みするだけのクラスです。
	 * @author katapad
	 * @version 0.1
	 * @since 2009/03/17 14:57
	 */
	public class AssetsPreloader extends EventDispatcher 
	{
		/**
		 * Completeイベント.作業が終わったら配信します
		 * @eventType flash.events.Event.COMPLETE
		 */
		[Event(name = "complete", type = "flash.events.Event")]
		//----------------------------------
		//  static var/const
		//----------------------------------
		/**　デフォルトの最大同時接続数 */
		public static const DEFAULT_NUM_CONNECT:int = 4;
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _preloadList:Array;
		private var _loadIndex:int;
		private var _loadCompleteIndex:int;
		private var _connectNum:int;
		
		/**
		 * Urlloaderで先読みするだけのクラスです。
		 * 大量の画像をちょこちょこロードすると、必要になったときのロードがスムーズに動きます。
		 * ロードの同時接続数を変更できるので、
		 * swfの処理速度を遅くしない程度に先読みできます。
		 * いまのところpauseやstopなどの機能は未実装です。
		 * 
		 * @param	preloadList	srcのstringが入ったコレクション
		 * @param	connectNum	最大同時接続数
		 */
		public function AssetsPreloader(preloadList:Array, connectNum:int = AssetsPreloader.DEFAULT_NUM_CONNECT) 
		{
			init(preloadList);
		}
		
		/**
		 * 初期化
		 */
		private function init(preloadList:Array, connectNum:int):void 
		{
			if (preloadList.length == 0)
				return;
			_preloadList = preloadList;
			_connectNum = connectNum;
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
		public function start():void
		{
			_loadIndex = 0;
			_loadCompleteIndex = 0;
			
			startLoad(_connectNum);
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
		private function startLoad(connectNum:int):void
		{
			for (var i:int = 0; i < connectNum; ++i) 
			{
				addLoad(i);
			}
			_loadIndex = i - 1;
		}
		
		
		private function addLoad(index:int):void
		{
			var loader:URLLoader = new URLLoader();
			//TODO バイナリで読んだほうがいいかな？ @2009/04/18 3:23 - kakehashi
			loader.load(new URLRequest(_preloadList[index]));
			loader.addEventListener(Event.COMPLETE, loadCompleteHandler);
		}
		
		private function loadCompleteHandler(event:Event):void 
		{
			//TODO connectNumをprivate変数にすればloadCOmpleteIndexも必要ないけど、こっちの方がわかりやすいかな @2009/03/17 15:42 - kakehashi
			++_loadCompleteIndex;
			var loader:URLLoader = URLLoader(event.target);
			loader.removeEventListener(Event.COMPLETE, loadCompleteHandler);
			if (++_loadIndex < _preloadList.length)
				addLoad(_loadIndex);
				
			if (_loadCompleteIndex >= _preloadList.length)
				complete();
				
		}
		
		private function complete():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
			destroy();
		}
		
		private function destroy():void
		{
			//TODO こんなおおざっぱでちゃんとメモリから消えるかな？ @2009/04/18 3:20 - kakehashi
			_preloadList = null;
			_loadIndex = 0;
			_loadCompleteIndex = 0;
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
	
	}
	
}
