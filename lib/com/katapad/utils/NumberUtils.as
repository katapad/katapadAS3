package com.katapad.utils 
{
	import flash.errors.IllegalOperationError;
/**
 * jp.nium Classes
 * 
 * @author Copyright (C) taka:nium, All Rights Reserved.
 * @version 3.1.72
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is (C) 2007-2009 taka:nium and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/11/02 18:26
	 */
	public class NumberUtils 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		private static const COMMA_REG:RegExp = /(\d)(?=(\d{3})+(?!\d))/g;
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		//private var
		
		/**
		 * コンストラクタ
		 */
		public function NumberUtils() 
		{
			throw new IllegalOperationError("NumberUtils cannot construct");
		}
		
		
		public static function comma( value:int ):String 
		{
			var str:String = String( value );
			return str.replace(COMMA_REG, "$1,");
		}
	}
	
}
