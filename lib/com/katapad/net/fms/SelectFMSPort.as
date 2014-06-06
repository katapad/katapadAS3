package com.katapad.net.fms
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	
	/**
	 * FMSサーバのポートを選んで、そのNetConnectionを返します
	 * @author katapad
	 * @version 0.1
	 * @since 2008/09/13 18:00
	 * @usage
	 * <ol>
	 * 	<li>コンストラクタにPortItemのコレクション（配列）を渡して、イベントをリスンします。
	 * 	</li>
	 * 	<li>PortSelectEvent.SELECT_COMPLETEで受け取ったevent.ncに接続されたNetConnectionが格納されています。
	 * 	</li>
	 * </ol>
	 * 
	 * <pre>
	 * private function init():void 
	 * {
	 * 	var portList:Array =
	 * 	[
	 * 		new PortItem(PROTOCOL + DOMAIN + ":80" + DIRECTORY),
	 * 		new PortItem(PROTOCOL_T + DOMAIN + ":80" + DIRECTORY),
	 * 		new PortItem(PROTOCOL + DOMAIN + ":443" + DIRECTORY),
	 * 		new PortItem(PROTOCOL + DOMAIN + ":1935" + DIRECTORY)
	 * 	];
	 * 	
	 * 	var selector:SelectFMSPort = new SelectFMSPort(portList);
	 * 	selector.addEventListener(PortSelectEvent.SELECT_COMPLETE, selectPortEventHandler);
	 * }
	 * 
	 * private function selectPortEventHandler(event:PortSelectEvent):void 
	 * {
	 * 	trace( "event.nc : " + event.nc );
	 * }
	 * </pre>
	 */
	public class SelectFMSPort extends EventDispatcher 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		//private var _nc:NetConnection;
		private var _isConnected:Boolean;
		private var _portList:Array; 
		
		/**
		 * コンストラクタ
		 */
		public function SelectFMSPort(connectionList:Array) 
		{
			init(connectionList);
		}
		
		/**
		 * 初期化
		 */
		private function init(connectionList:Array):void 
		{
			_portList = connectionList;
			_isConnected = false;
			initConnect();
			tryConnect();
		}
		
		private function initConnect():void
		{
			//NetConnection.defaultObjectEncoding = ObjectEncoding.AMF0;
			for (var i:int = 0, n:int = _portList.length; i < n; i++) 
			{
				var item:PortItem = _portList[i];
				var nc:NetConnection = item.nc;
				nc.addEventListener(NetStatusEvent.NET_STATUS, ncNetStatusHandler);
				nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		public function tryConnect():void 
		{
			for (var i:int = 0, n:int = _portList.length; i < n; i++) 
			{
				var item:PortItem = _portList[i];
				item.connect();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  EVENT HANDLER
		//
		//--------------------------------------------------------------------------
		private function securityErrorHandler(event:SecurityErrorEvent):void 
		{
            trace("securityErrorHandler: " + event);
		}
		
		private function ncNetStatusHandler(event:NetStatusEvent):void 
		{
			selectPort(NetConnection(event.currentTarget), event.info.code);
			//NetConnection(event.currentTarget).removeEventListener(NetStatusEvent.NET_STATUS, ncNetStatusHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  PRIVATE
		//
		//--------------------------------------------------------------------------
		private function selectPort(nc:NetConnection, status:String):void
		{
			if (_isConnected || status != "NetConnection.Connect.Success")
				return;
			//_nc = nc;
			_isConnected = true;
			endTryConnection(nc);
		}
		
		private function endTryConnection(connectedNC:NetConnection):void
		{
			for (var i:int = 0, n:int = _portList.length; i < n; i++) 
			{
				var item:PortItem = _portList[i];
				var nc:NetConnection = item.nc;
				nc.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				nc.removeEventListener(NetStatusEvent.NET_STATUS, ncNetStatusHandler);
				if (nc == connectedNC)
				{
					trace("connection success!! " + item.serverPath);
					continue;
				}
				nc.close();
				item.destroy();
				_portList[i] = null;
			}
			
			dispatchEvent(new PortSelectEvent(PortSelectEvent.SELECT_COMPLETE, connectedNC));
			destroy();
		}
		
		private function destroy():void
		{
			_portList = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
		//public function get nc():NetConnection { return _nc; }
	
	}
	
}
