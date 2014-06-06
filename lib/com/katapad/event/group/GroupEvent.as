package com.katapad.event.group 
{
	import flash.events.Event;
	
	/**
	 * グループのイベント
	 * @author katapad
	 * @version 0.1
	 * @since 2008/07/31 18:36
	 */
	public class GroupEvent extends Event 
	{
		
		/**
		 * すべてのイベントを受け取ったときに配信します。
		 */
		public static const GROUP_COMPLETE:String = "GROUP_COMPLETE";
		
		/**
		 * グループに格納したイベントのリスト
		 */
		private var _eventList:Array;
		
		/**
		 * コンストラクタ
		 */
		public function GroupEvent(type:String, eventList:Array = null, bubbles:Boolean = false, cancelable:Boolean = false) 
		{ 
			super(type, bubbles, cancelable);
		}
		
		//--------------------------------------------------------------------------
		//
		//  public
		//
		//--------------------------------------------------------------------------
		override public function clone():Event 
		{ 
			return new GroupEvent(type, _eventList, bubbles, cancelable);
		}
		
		override public function toString():String 
		{ 
			return formatToString("GroupEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		//--------------------------------------------------------------------------
		//
		//  private
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  getter/setter
		//
		//--------------------------------------------------------------------------
		public function get eventList():Array { return _eventList; }
	}
	
}