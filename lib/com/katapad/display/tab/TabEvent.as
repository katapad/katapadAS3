package com.katapad.display.tab 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author katapad
	 */
	public class TabEvent extends Event 
	{
		private var _index:int;
		private var _params:*;
		
		public static const TAB_CLICK:String = 'tabClick'
		
		public function TabEvent(type:String, index:int, params:* = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this._params = params;
			this._index = index;
			
		} 
		
		public override function clone():Event 
		{ 
			return new TabEvent(type, _params, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TabEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get params():* { return _params; }
		
		public function get index():int { return _index; }
		
	}
	
}