package com.katapad.browser 
{
	import flash.errors.IllegalOperationError;
	import flash.external.ExternalInterface;
	
	/**
	 * ...
	 * @author colors kakehashi
	 * @version 0.1
	 * @since 2009/03/13 19:32
	 */
	public class IsSafari 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		private static var _isSafari:Boolean = false;
		private static var _isInit:Boolean = false;
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		
		public function IsSafari() 
		{
			throw new IllegalOperationError("IsSafari cannot construct");
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
		public static function isSafari():Boolean 
		{
			if (!_isInit)
				checkUA();
			//MonsterDebugger.trace(IsSafari, _isSafari);
			return _isSafari;
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
		private static function checkUA():void
		{
			if (ExternalInterface.available)
			{
				var ua:String = ExternalInterface.call("function() { return navigator.userAgent }");
				if (ua == null)
					return;
				if (ua.match(/Safari\/([\.\d]+)/) && !ua.match(/Chrome\/([\.\d]+)/))
					_isSafari = true;
				else
					_isSafari = false;
			}
			_isInit = true;
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
	
	}
	
