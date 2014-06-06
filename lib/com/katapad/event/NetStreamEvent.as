package com.katapad.event 
{
	//import com.katapad.net.NetStreamInfo;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2008/08/04 21:17
	 */
	public class NetStreamEvent extends Event 
	{
		//メンバ変数
		public static const PLAY_STATUS:String = "play_status";
		public static const METADATA_RECEIVED:String = "metadata_received";
		public static const CUE_POINT:String = "cue_point";
		
		//インスタンス変数
		private var _info:Object
		
		/**
		 * コンストラクタ
		 */
		public function NetStreamEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, info:Object = null) 
		{ 
			super(type, bubbles, cancelable);
			_info = info;
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		/**
		 * Duplicates an instance of an Event subclass.
		 *
		 * @return                  <Event> A new Event object that is identical to the original.
		 */
		override public function clone():Event 
		{ 
			return new NetStreamEvent(type, bubbles, cancelable, info);
		}
		
		override public function toString():String 
		{ 
			return formatToString("NetStreamEvent", "type", "bubbles", "cancelable", "eventPhase"); 
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
		public function get info():Object { return info; }
	}
	
}