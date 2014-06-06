package com.katapad.net 
{
	import com.google.analytics.GATracker;
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author katapad.com
	 * @version 0.1
	 * @since 2009/06/04 19:16
	 */
	public class SiGATracker 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		public static const GA_MODE_AS3:String = "AS3";
		public static const GA_MODE_BRIDGE:String = "Bridge";
		
		private static var _isInit:Boolean;
		
		private static var _instance:SiGATracker;
		/**
		 * getInstance
		 */
		public static function getInstance():SiGATracker
		{
			if (_instance == null) 
				_instance = new SiGATracker(new Enforcer());
			return _instance;
		}
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _tracker:GATracker;
		
		
		/**
		 * コンストラクタ
		 */
		public function SiGATracker(enforcer:Enforcer) 
		{
			_isInit = false;
		}
		
		/**
		 * 初期化
		 */
		public function init(target:DisplayObject, account:String, mode:String, visualDebug:Boolean):void 
		{
			if (_isInit)
				throw new Error("2度目のinit");
			_tracker = new GATracker(target, account, mode, visualDebug);
			_isInit = true;
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
		/**
		 * トラックします。trackPageview("/hoge/hogehoge");とか入れてください。
		 * @param	path
		 */
		public function trackPageview(path:String):void
		{
			if (path.charAt(0) != "/")
				path = "/" + path;
			_tracker.trackPageview(path);
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
		static public function get isInit():Boolean { return _isInit; }
	}
	
}

class Enforcer {
	
	function Enforcer()
	{
		
	}
}
