package com.katapad.net 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * スクリーンセーバーコンテンツでネットワークに接続されているかどうかをチェックするだけのクラス。イベント吐き出します。
	 * @author katapad
	 * @version 0.1
	 * @since 2009/02/14 17:38
	 */
	public class NetworkChecker extends EventDispatcher
	{
		/**
		 * ネットワークがOKだったときのイベント
		 * @eventType com.katapad.net.NetworkChecker.NETWORK_OK
		 */
		[Event(name = "network_ok", type = "flash.events.Event")]
		//----------------------------------
		//  static var/const
		//----------------------------------
		public static const NETWORK_OK:String = "network_ok";
		public static const NETWORK_IO_ERROR:String = "network_io_error";
		public static const NETWORK_SECURITY_ERROR:String = "network_security_error";
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _hasNetConnection:Boolean;
		private var _urlRequest:URLRequest;
		private var _isRun:Boolean;
		private var _trialTimes:int;
		private var _maxTrialTimes:int;
		private var _loader:URLLoader;
		
		/**
		 * 
		 * @param	urlRequest	nullだとこちらで用意したurlに飛んでnetworkにつながるか確認しますが、基本必須です。
		 * @param	trialTimes	エラーが帰ってきたときに何度やりなおすか
		 */
		public function NetworkChecker(urlRequest:URLRequest = null, trialTimes:int = 3) 
		{
			init(urlRequest, trialTimes);
		}
		
		/**
		 * 初期化
		 */
		private function init(urlRequest:URLRequest, trialTimes:int):void 
		{
			_urlRequest = urlRequest || new URLRequest("http://katapad.com/networktest.txt");
			_maxTrialTimes = trialTimes;
			_hasNetConnection = false;
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
		public function check():void
		{
			if (_isRun)
				return;
			_isRun = true;
			_trialTimes = 0;
			initLoader();
			checkStart();
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
		private function initLoader():void
		{
			_loader = new URLLoader();
			//FlaverだとうまくOPENを拾わないどころか、拾ってしまうのでPROGRESSに変更した
			//_loader.addEventListener(Event.OPEN, connectionOK);
			_loader.addEventListener(ProgressEvent.PROGRESS, connectionOK);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, checkStart);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, checkStart);
		}
		
		private function destroyLoader():void
		{
			_loader.close();
			//_loader.removeEventListener(Event.OPEN, connectionOK);
			_loader.removeEventListener(ProgressEvent.PROGRESS, connectionOK);
			_loader.removeEventListener(IOErrorEvent.IO_ERROR, checkStart);
			_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, checkStart);
			_loader = null;
		}
		
		private function checkStart(event:Event = null):void
		{
			if (++_trialTimes > _maxTrialTimes)
			{
				errorDispatch(event.type);
				return;
			}
			_loader.load(_urlRequest);
		}
		
		private function connectionOK(event:Event):void 
		{
			dispatchAndEnd(NetworkChecker.NETWORK_OK);
		}
		
		private function dispatchAndEnd(eventType:String):void
		{
			destroyLoader();
			dispatchEvent(new Event(eventType));
		}
		
		private function errorDispatch(eventType:String):void
		{
			if (eventType == IOErrorEvent.IO_ERROR)
				dispatchAndEnd(NetworkChecker.NETWORK_IO_ERROR);
			else if (eventType == SecurityErrorEvent.SECURITY_ERROR)
				dispatchAndEnd(NetworkChecker.NETWORK_SECURITY_ERROR);
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
	
	}
	
}
