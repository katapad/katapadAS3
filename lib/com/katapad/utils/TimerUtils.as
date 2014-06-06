/**
* @author katapad
* @version 0.1
* @since 2008/07/25 16:39
*/

package com.katapad.utils 
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 * Timerのutils
	 */
	public class TimerUtils 
	{
		
		/**
		 * staticなのでコンストラクト禁止
		 */
		public function TimerUtils() 
		{
			throw new IllegalOperationError("LogoTypoPosition cannot construct");
		}
		
		/**
		 * 一度だけのdelayコマンド。delay（秒）。msじゃないので注意。クロージャ + 弱参照にしといて、ほっといたら消えるようにしとく
		 * @param	delay
		 * @param	scope
		 * @param	func
		 * @param	args
		 */
		public static function oneTimeDelayCommand(delay:Number, scope:*, func:Function, args:Array = null ):void
		{
			var timer:Timer = new Timer(delay * 1000, 1);
			timer.addEventListener(TimerEvent.TIMER, function():void
				{
					func.apply(Object, args);
				}, false, 0, false
			);
			timer.start();
		}
		
	}
	
}
