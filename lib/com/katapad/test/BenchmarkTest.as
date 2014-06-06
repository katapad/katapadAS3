/**
* @author katapad
* @version 0.1.1
* @since 2008/06/05
* 
*/

package com.katapad.test 
{
	import flash.utils.getTimer;
	
	/**
	 * 処理速度のベンチマークをとるクラス
	 * 初期値では1,000,000回ループする
	 */
	public class BenchmarkTest 
	{
		//メンバ変数
		/**
		 * ループの回数。初期値は1000000。変更しやすくするため、単なるpublic var。
		 */
		public static var trialFrequency:uint = 1000000;
		
		private static var _hr:String = "----------------------------------";
		private static var _headerText:String = _hr + "\n";
		private static var _headerPrint:String;
		
		private static var _resultList:Array = [];
		private static var _testFuncList:Array = [];
		
		/**
		 * コンストラクタ
		 */
		public function BenchmarkTest() 
		{
			throw new Error("cannot construct");
		}
		
		//--------------------------------------------------------------------------
		//
		//  private
		//
		//--------------------------------------------------------------------------
		private static function benchmark(testName:String, func:Function):void
		{
			var startTime:Number = getTimer();
			func();
			pushResult(testName, getTimer() - startTime);
		}
		
		private static function printSingleResult(testName:String, recordTime:Number):void
		{
			trace(resultTextFormat(testName, recordTime));
		}
		
		private static function pushResult(testName:String, recordTime:Number):void
		{
			_resultList.push(resultTextFormat(testName, recordTime));
		}
		
		private static function resultTextFormat(testName:String, recordTime:Number):String
		{
			var result:String = _headerText + testName + ":\t" + recordTime + "ms";
			return result;
		}
		
		private static function printResult():void
		{
			printHeader();
			for (var i:uint = 0, n:uint = _resultList.length; i < n; i++) 
			{
				trace(_resultList[i]);
			}
		}
		
		/**
		 * 10,000,000(times)などと頭にプリントする。結構重い。
		 */
		private static function printHeader():void
		{
			var timesText:String = trialFrequency.toString();
			var textArray:Array = [];
			while (timesText.length > 0) 
			{
				if (timesText.length > 3)
					textArray.unshift(timesText.slice(timesText.length - 3, timesText.length));
				else
					textArray.unshift(timesText);
				timesText = timesText.slice(0, timesText.length - 3);
			}
			_headerPrint = _hr + _hr + "\nTrial: " + textArray.join(",") + " times";
			_resultList.unshift(_headerPrint);
		}
		
		//--------------------------------------------------------------------------
		//
		//  public
		//
		//--------------------------------------------------------------------------
		
		/**
		 * testするfunctionを登録していく。argumentsみたいなので、ずらずら登録していく。
		 * argObjectでも、配列可したargObject群でも可
		 * argObjectは...argsのパラメータを参照。
		 * @param	...args: {testName:String, func:Function}, ...
		 * @param	...args: argObject
		 */
		public static function push(...args:Array):void
		{
			if (args[0] is Array)
			{
				_testFuncList = _testFuncList.concat(args[0]);
			}
			else
			{
				for (var i:uint = 0, n:uint = args.length; i < n; i++) 
				{
					_testFuncList.push(args[i]);
				}
			}
		}
		
		/**
		 * 一通り登録したら、このメソッドでベンチマークをスタート
		 */
		public static function start():void
		{
			for (var i:uint = 0, n:uint = _testFuncList.length; i < n; i++) 
			{
				benchmark(_testFuncList[i].testName, _testFuncList[i].func);
				if ( i == n - 1)
					printResult();
			}
		}
		
		/**
		 * リセットする
		 */
		public static function reset():void
		{
			_testFuncList = [];
			_resultList = [];
		}
		
		/**
		 * 単体で動くメソッド。pushせずにすぐtraceされる。
		 * @param	testName
		 * @param	func
		 */
		public static function singleBenchmark(testName:String, func:Function):void
		{
			var startTime:Number = getTimer();
			func();
			printSingleResult(testName, getTimer() - startTime);
		}
		
		/**
		 * 単体のテスト。pushせずにすぐtrace。こちらでループ処理をするので、scopeと引数の登録が必要。
		 * @param	testName
		 * @param	func
		 * @param	scope
		 * @param	args
		 */
		public static function singleAutoLoop(testName:String, func:Function, scope:Object, args:Array = null):void
		{
			var startTime:Number = getTimer();
			for (var i:int = 0; i < trialFrequency; i++) 
			{
				func.apply(scope, args);
			}
			printSingleResult(testName, getTimer() - startTime);
		}
		
	}
	
}
