package com.katapad.net.fms 
{
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	/**
	 * FMSのポートを選ぶときのコレクションアイテム
	 * @author katapad
	 * @version 0.1
	 * @since 2008/09/13 19:02
	 */
	public class PortItem 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _nc:NetConnection;
		private var _serverPath:String;
		
		/**
		 * コンストラクタ
		 */
		//public function PortItem(nc:NetConnection = null, encoding:uint = ObjectEncoding.AMF0) 
		public function PortItem(serverPath:String, nc:NetConnection = null, encoding:uint = 0) 
		{
			init(serverPath, nc, encoding);
		}
		
		/**
		 * 初期化
		 */
		private function init(serverPath:String, nc:NetConnection, encoding:uint):void 
		{
			_serverPath = serverPath;
			_nc = nc;
			if (_nc == null)
				_nc = new NetConnection();
			_nc.objectEncoding = encoding;
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
		public function connect():void
		{
			_nc.connect(_serverPath);
		}
		
		public function destroy():void
		{
			_nc = null;
			_serverPath = null;
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
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
		public function get nc():NetConnection { return _nc; }
		
		public function get serverPath():String { return _serverPath; }
	
	}
	
}
