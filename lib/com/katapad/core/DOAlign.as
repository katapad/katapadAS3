package com.katapad.core 
{
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2009/01/19 13:21
	 */
	public class DOAlign 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		public static const TL:uint = 1;
		public static const TC:uint = 2;
		public static const TR:uint = 3;
		public static const ML:uint = 4;
		public static const MC:uint = 5;
		public static const MR:uint = 6;
		public static const BL:uint = 7;
		public static const BC:uint = 8;
		public static const BR:uint = 9;
		
		/**
		 * Don't construct
		 */
		public function DOAlign() 
		{
			throw new IllegalOperationError("cannot construct");
		}
		
		/**
		 * 0-1に正規化した状態のポイントを返します
		 * @param	basePoint
		 * @return
		 */
		public static function getNormalizePoint(basePoint:uint):Point
		{
			//0-8に置き換える
			basePoint--;
			
			var result:Point = new Point();
			result.x = basePoint % 3 * 0.5;
			result.y = int(basePoint / 3) * 0.5;
			return result;
		}
	}
}
