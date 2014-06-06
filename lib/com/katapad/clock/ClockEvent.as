package com.katapad.clock 
{
	import flash.events.Event;
	
	/**
	 * ClockModelに対応するイベントです。
	 * @author katapad
	 * @version 0.1
	 * @since 2009/02/13 20:44
	 */
	public class ClockEvent extends Event 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		public static const HOUR_CHANGE:String = "hour_change";
		public static const MINUTE_CHANGE:String = "minute_change";
		public static const SECOND_CHANGE:String = "second_change";
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _h:String;
		private var _m:String;
		private var _s:String;
		
		private var _intH:int;
		private var _intM:int;
		private var _intS:int;
		
		/**
		 * コンストラクタ
		 */
		public function ClockEvent(type:String, h:String, m:String, s:String, bubbles:Boolean = false, cancelable:Boolean = false) 
		{ 
			super(type, bubbles, cancelable);
			_h = h;
			_m = m;
			_s = s;
			_intH = int(_h);
			_intM = int(_m);
			_intS = int(_s);
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		override public function clone():Event 
		{ 
			return new ClockEvent(type, _h, _m, _s, bubbles, cancelable);
		}
		
		override public function toString():String 
		{ 
			return formatToString("ClockEvent", "type", "bubbles", "cancelable", "eventPhase"); 
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
		/**
		 * "00"といったゼロパディングされた形のStringを渡します
		 */
		public function get h():String { return _h; }
		
		/**
		 * "00"といったゼロパディングされた形のStringを渡します
		 */
		public function get m():String { return _m; }
		
		/**
		 * "00"といったゼロパディングされた形のStringを渡します
		 */
		public function get s():String { return _s; }
		
		public function get h1():String
		{
			return _h.charAt(0);
		}
		
		public function get h2():String
		{
			return _h.charAt(1);
		}
		
		public function get m1():String
		{
			return _m.charAt(0);
		}
		
		public function get m2():String
		{
			return _m.charAt(1);
		}
		
		public function get s1():String
		{
			return _s.charAt(0);
		}
		
		public function get s2():String
		{
			return _s.charAt(1);
		}
		
		public function get degreeH():Number
		{
			return ((_intH % 12) * 30) + (_intM * 0.5) + (_intS / 120);
		}
		
		public function get degreeM():Number
		{
			return (_intM * 6) + (_intS * 0.1);
		}
		
		public function get degreeS():int
		{
			return _intS * 6;
		}
	}
	
}