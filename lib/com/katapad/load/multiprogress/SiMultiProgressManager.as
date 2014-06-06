/*
 * Licensed under the MIT License
 * 
 * Copyright (c) 2009 katapad.com
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package com.katapad.load.multiprogress 
{
	import flash.display.DisplayObject;
	/**
	 * シングルトンのMultiProgressManager
	 * @author katapad
	 * @version 0.2
	 * @since 2009/04/29 22:24
	 */
	public class SiMultiProgressManager extends MultiProgressManager 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		/** どこかで必ずパーセント表示が終了したときのイベントを使うので、ここに名前を書いておきます。
		 * stage.dispatchEvent(SiMultiProgressManager.LOADING_VIEW_EVENT_COMPLETE～～)や
		 * SiMultiProgressManagerのインスタンス自身にこのイベントを発行させてもいいかと思います。
		 * それで、main側がこのイベント名に反応して表示を開始します。
		 */
		public static const LOADING_VIEW_EVENT_COMPLETE:String = "loadingViewEventComplete"
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		
		private static var _instance:SiMultiProgressManager;
		/**
		 * 複数のプログレスをまとめるクラスを作ります
		 * @param	enterframe		EnterFrame用DisplayObject。通常はstageの参照を渡します。
		 * @param	useFriction		パーセントをスムーズにするかどうか
		 * @param	friction		スムーズにするときのfrictionの値。
		 * @param	maxSpeed		useFriction時にパーセントの伸びの1フレームあたりの限界値を設定します。0.1を設定すると 0から1に一気にいくのではなく、0.1、0.2、0.3…とあがっていきます
		 */
		public static function getInstance(enterframe:DisplayObject = null, useFriction:Boolean = true, friction:Number = 0.3, maxSpeed:Number = NaN):SiMultiProgressManager
		{
			if (_instance == null) 
				_instance = new SiMultiProgressManager(new SingletonEnforcer(), enterframe, useFriction, friction, maxSpeed);
			return _instance;
		}
		
		/**
		 * シングルトンのMultiProgressManager
		 */
		public function SiMultiProgressManager(enforcer:SingletonEnforcer, enterframe:DisplayObject, useFriction:Boolean, friction:Number, maxSpeed:Number) 
		{
			super(enterframe, useFriction, friction, maxSpeed);
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
class SingletonEnforcer
{
	function SingletonEnforcer()
	{
		
	}
}
