package com.katapad.utils 
{
	import flash.errors.IllegalOperationError;
	/**
	 * [static]Stringのユーティリティ
	 * @author katapad
	 * @version 0.1
	 * @since 2008/08/11 23:18
	 */
	public class StringUtils  
	{
		//----------------------------------
		//  メンバ変数
		//----------------------------------
		
		//----------------------------------
		//  インスタンス変数
		//----------------------------------
		//private var
		
		/**
		 * コンストラクタ
		 */
		public function StringUtils() 
		{
			new IllegalOperationError("cannot constract StringUtils");
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		/**
		 * jpgかpngのロールオーバーimageのurlを取得する。接尾辞は_over
		 * @param	url	変換したいpngかjpgのurl
		 * @return
		 */
		public static function getOverImageURL(url:String):String
		{
			return url.replace(/(.+)(\.(png)|\.(jpg))$/, "$1_over$2");
		}
		
		/**
		 * jpgかpngのカレント表示imageのurlを取得する。接尾辞は_cr
		 * @param	url	変換したいpngかjpgのurl
		 * @return
		 */
		public static function getCurrentImageURL(url:String):String
		{
			return url.replace(/(.+)(\.(png)|\.(jpg))$/, "$1_cr$2");
		}
		
		/**
		 * uint数値が指定の桁数になるまで数値を頭に0を付与します。
		 * @param	value uint値。zeroを足したい数値。負や浮動小数点は対象としていません。
		 * @param	size 桁数
		 * @return	result String値で返します。
		 */
		public static function zeroPadding(value:uint, size:uint = 2):String
		{
			var result:String = value.toString(10);
			while (result.length < size)
			{
				result = "0" + result;
			}
			return result;
		}
		
		/**
		 * String値が指定の桁数になるまで数値を頭に0を付与します。
		 * @param	value uint値。zeroを足したい数値。負や浮動小数点は対象としていません。
		 * @param	size 桁数
		 * @return	result String値で返します。
		 */
		public static function zeroPaddingStr(value:String, size:uint = 2):String
		{
			while (value.length < size)
			{
				value = "0" + value;
			}
			return value;
		}
		
		/**
		 * yyyymmdd型をyyyy-mm-ddのような区切りをつけて返します。
		 * @param	separater
		 * @return
		 */
		public static function formatYYYYMMDD(yyyymmdd:String, separater:String):String
		{
			var list:Array = [];
			list[0] = yyyymmdd.substr(0, 4);
			list[1] = yyyymmdd.substr(4, 2);
			list[2] = yyyymmdd.substr(6, 2);
			return list.join(separater);
		}
		
		/**
		 * xmlなどにある"true"などを変換します。switchで切り替えているだけなので、default値がオプションであります.
		 * true/1/yes  or false/0/no
		 * @param	value
		 * @param	defaultBool
		 * @return
		 */
		public static function stringToBoolean(value:String, defaultBool:Boolean = false):Boolean
		{
			var result:Boolean;
			switch (value) 
			{
				case true.toString() :
				case "1" :
				case "yes" :
					result = true;
					break;
				case false.toString() :
				case "0" :
				case "no" :
					result = false;
					break;
				default :
					result = defaultBool;
					break;
			}
			return result;
		}
		
		/**
		 * xmlなどのString化されたNumberを変換します。
		 * @param	value xmlなどのString値
		 * @param	defaultValue NaNだったときのデフォルト値
		 * @return
		 */
		public static function string2Number(value:String, defaultValue:Number):Number
		{
			var result:Number = Number(value);
			if (isNaN(result))
				result = defaultValue;
			return result;
		}
		
		/**
		 * 日付を返します。
		 * @param	date
		 * @param	kugiri
		 * @return
		 */
		public static function getDateString(date:Date, kugiri:String = '/'):String
		{
			return date.fullYear.toString() + kugiri + zeroPadding(date.month + 1) + kugiri + zeroPadding(date.date);
		}
		
		public static function digit():void
		{
			
		}

		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
	
	}
	
}
