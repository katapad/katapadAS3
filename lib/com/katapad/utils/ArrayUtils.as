/**
* @author katapad
* @version 0.1.2
* @since 2008/07/22 16:53
*/

package com.katapad.utils 
{
	import flash.errors.IllegalOperationError;
	public class ArrayUtils 
	{
		/**
		 * cannt construct
		 */
		public function ArrayUtils() 
		{
			new IllegalOperationError("ArrayUtils class cannot construct");
		}
		
		/**
		 * 配列のシャッフル
		 * @param	arr:Array			シャッフルしたい配列
		 * @return	result:Array		元の配列を壊さないで作ったシャッフル済み配列
		 * @usage
		 */
		public static function shuffle(arr:Array):Array {
            var i:int = arr.length;
			var result:Array = arr.slice(0);
            while (i > 0) {
                var j:int = int(Math.random() * i);
                var t:Object = result[--i];
                result[i] = result[j];
                result[j] = t;
            }
            return result;
		}

	}
	
}
