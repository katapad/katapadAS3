package com.katapad.utils 
{
	import flash.errors.IllegalOperationError;
	/**
	 * Mathユーティリティ
	 * @author katapad
	 * @version 0.1
	 * @since 2008/07/18 13:13
	 */
	public class MathUtils
	{
		//メンバ変数
		
		//インスタンス変数
		//private var
		
		public function MathUtils() 
		{
			throw new IllegalOperationError( "MathUtils cannot construct" );
		}
		
		/**
		 * 範囲内での乱数を生成します。value 2なら　-2～2を返します。
		 * @param	value 2なら　-2～2を返します。
		 * @return 	範囲内の乱数
		 */
		public static function randomRange(min:Number, max:Number):Number
		{
			return Math.random() * (max - min) + min;
		}
		
		/**
		 * 度→ラジアン の変換
		 * @param	degree
		 * @return
		 */
		public static function degreeToRadian(degree:Number):Number
		{
			return degree * Math.PI / 180;
		}
		
		/**
		 * ラジアン→度 の変換
		 * @param	raidan
		 * @return
		 */
        public static function raidanToDegree(raidan:Number):Number
        {
            return raidan / Math.PI * 180;
		}
		
		/**
		 * 1か-1を返します
		 * @return
		 */
		public static function getCoin():int
		{
			return Math.random() > .5 ? 1 : -1;
		}
	}
	
}
