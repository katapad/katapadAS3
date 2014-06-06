package com.katapad.core 
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/02/12 15:44
	 */
	public class ObjectPool 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private static var _dict:Dictionary = new Dictionary();
		
		/**
		 * コンストラクタ
		 */
		public function ObjectPool() 
		{
			throw new IllegalOperationError("ObjectPool cannot construct");
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
		 * reset
		 */
		public static function reset():void 
		{
			_dict = new Dictionary();
		}
		
		/**
		 * 
		 * @param	object
		 * @param	id
		 */
		public static function add(object:*, id:String = null):void
		{
			if (_dict[id])
			{
				throw new ArgumentError("id: " + id + " が重複しています");
				return;
			}
			
			_dict[id] = object;
		}
		
		/**
		 * 
		 * @param	id
		 * @return
		 */
		public static function getObject(id:String):*
		{
			if (!_dict[id])
			{
				throw new ArgumentError("id: " + id + " が存在していません");
				return null;
			}
			return _dict[id];
		}
		
		/**
		 * 
		 * @param	id
		 */
		public static function remove(id:String):void
		{
			if (!_dict[id])
			{
				throw new ArgumentError("id: " + id + " が存在していません");
				return ;
			}
			delete _dict[id];
		}
		
		public static function destroy():void
		{
			_dict = null;
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
	
	}
	
}