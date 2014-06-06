package com.katapad.net.fms 
{
	import flash.events.Event;
	import flash.net.NetConnection;
	
	/**
	 * FMSのポートが選ばれたときのイベント
	 * @author katapad
	 * @version 0.1
	 * @since 2008/09/13 18:59
	 */
	public class PortSelectEvent extends Event 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		public static const SELECT_COMPLETE = "select_complete";
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _nc:NetConnection;
		
		/**
		 * コンストラクタ
		 */
		public function PortSelectEvent(type:String, nc:NetConnection, bubbles:Boolean  = false, cancelable:Boolean = false) 
		{ 
			super(type, bubbles, cancelable);
			_nc = nc;
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		override public function clone():Event 
		{ 
			return new PortSelectEvent(type, _nc, bubbles, cancelable);
		}
		
		override public function toString():String 
		{ 
			return formatToString("PortSelectEvent", "type", "netConnection", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
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
	}
	
}