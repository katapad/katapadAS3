package com.katapad.model 
{
	import com.katapad.utils.StStage;
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2009/01/09 18:36
	 */
	public class FlashVarsModel 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private static var _isInit:Boolean = false;
		private static var _params:Object;
		
		
		/**
		 * コンストラクタ
		 */
		public function FlashVarsModel() 
		{
			throw new IllegalOperationError("FlashVarsModelはインスタンス化できません");
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
		 * 
		 * @param	stage
		 */
		public static function init(stage:Stage):void
		{
			if (_isInit)
				throw new Error("FlashVarsModel.initが2度以上呼ばれました");
			_isInit = true;
			_params = stage.loaderInfo.parameters;
		}
		
		public static function getValue(key:String):String
		{
			return _params[key];
		}
		
		public static function hasKey(key:String):Boolean
		{
			return _params[key] != undefined;
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
		public static function get isInit():Boolean { return _isInit; }
		
		public static function get params():Object { return _params; }
		
		public static function get hasParams():Boolean
		{
			var i:uint = 0;
			for ( var str:String in _params ) 
			{
				++i;
				break;
			}
			return i == 1;
		}
	}
	
}
