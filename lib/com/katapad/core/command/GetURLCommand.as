package com.katapad.core.command 
{
	import flash.external.ExternalInterface;
	import flash.net.navigateToURL
	import flash.net.URLRequest;
	/**
	 * GetURLのようなことをしつつFirefoxとMSIEのポップアップブロックを回避するコマンドクラス
	 * @author katapad
	 * @version 0.2
	 * @since 2008/11/04 2:02
	 */
	public class GetURLCommand implements ICommand
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		public static const WINDOW_BLANK:String = "_blank";
		public static const WINDOW_PARENT:String = "_parent";
		public static const WINDOW_SELF:String = "_self";
		public static const WINDOW_TOP:String = "_top";
		
		private static var _isCheckBrowser:Boolean = false;
		private static var _isJSOpenBrowser:Boolean = false;
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _window:String;
		private var _urlRequest:URLRequest;
		private var _useExternalInterface:Boolean;
		
		/**
		 * AS2のGetURL的なことをします。
		 * windowにGetURLCommand.WINDOW_BLANKが選ばれたときはポップアップブロックを自動で回避します（Firefox, MSIE7)
		 * @param	url		String or URLRequest
		 * @param	window	GetURLCommand.WINDOW_BLANKがデフォルトです。windowの名前でも通ります。
		 * @param	useExternalInterface	Firefox や MSIE では ExternalInterface が必須になりますが、強制的に navigateURL で代用させることもできます。
		 * 									そのときはこの値を false にしてください
		 */
		public function GetURLCommand(url:*, window:String = GetURLCommand.WINDOW_BLANK, useExternalInterface:Boolean = true) 
		{
			init(url, window, useExternalInterface);
		}
		
		/**
		 * 初期化
		 */
		private function init(url:*, window:String, useExternalInterface:Boolean):void 
		{
			_urlRequest = url is String ? new URLRequest(url) : url;
			_window = window;
			_useExternalInterface = useExternalInterface;
			
			if (!_isCheckBrowser)
				checkBrowser();
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
		public function execute():void
		{
			if (!_useExternalInterface || !_isJSOpenBrowser || _window != GetURLCommand.WINDOW_BLANK) 
				navigateToURL(_urlRequest, _window);
			else
				ExternalInterface.call('function(url, window){this.open(url, window);}', this.url, this.window);
				//↓ではFirefoxで無限ループに陥る。↑ではthisObject == windowObjectなのでthis.openとしている。
				//ExternalInterface.call("window.open", this.url, _window);
		}
		
		public function toString():String
		{
			return "[GetURLCommand, url = " + this.url + ", window" + this.window + ", isJSOpenBrowser: " + _isJSOpenBrowser + "]";
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
		private function checkBrowser():void
		{
			if (ExternalInterface.available)
			{
				var ua:String = String(ExternalInterface.call("function() {return navigator.userAgent;}"));
				if (ua.indexOf("Firefox") != -1)
					_isJSOpenBrowser = true;
				else if (ua.indexOf("MSIE") != -1 && ua.match("MSIE ?(\\d+\\.\\d+)b?;")[1] >= 7)
					_isJSOpenBrowser = true;
			}
			_isCheckBrowser = true;
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
		/** [read-only] */
		public function get window():String { return _window; }
		/** urlのString　[read-only] */
		public function get url():String { return _urlRequest.url; }
		/** [read-only] */
		public function get urlRequest():URLRequest { return _urlRequest; }
		
	
	}
	
}
