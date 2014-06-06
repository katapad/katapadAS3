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
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ProgressModelの抽象クラスです。インスタンス化は禁止されています。
	 * //TODO エラー処理を作ってない @2009/04/18 2:59 - katapad
	 * @author katapad
	 * @version 0.1
	 * @since 2009/02/06 18:59
	 */
	public class AbstractProgressModel extends EventDispatcher 
	{
		/**
		 * Completeイベント
		 * @eventType flash.events.Event.COMPLETE
		 */
		[Event(name = "complete", type = "flash.events.Event")]
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		/**
		 * モデル自身が監視している対象のパーセント
		 */
		protected var _percent:Number;
		/**
		 * _pecentRangeと_percentを掛け合わせた値
		 */
		protected var _revisedPercent:Number;
		/**
		 * パーセントの幅 （MultiProgressManagerに突っ込むときに何パーセント割り当てるかの値。0-1まで）
		 */
		protected var _pecentRange:Number;
		
		
		public function AbstractProgressModel(percentRange:Number) 
		{
			init(percentRange);
		}
		
		protected function init(percentRange:Number):void 
		{
			_pecentRange = percentRange;
			_revisedPercent = _percent = 0;
			initHook();
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
		 * キャンセルします
		 */
		public function cancel():void
		{
			
		}
		
		/**
		 * 破棄します
		 */
		public function destroy():void
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  PROTECTED
		//
		//--------------------------------------------------------------------------
		/**
		 * オーバーライド用の初期化メソッド
		 */
		protected function initHook():void
		{
			
		}
		/**
		 * オーバーライド用の終了処理メソッド
		 */
		protected function completeHook():void
		{
			
		}
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
		private function complete():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
			completeHook();
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
		/**
		 * @private ほんとはinternalにしたいのだけど、NullProgressModelで使用するため,　publicにしている
		 */
		public function get percent():Number { return _percent; }
		
		/**
		 * @private 
		 */
		public function set percent(value:Number):void 
		{
			_percent = value;
			_revisedPercent = value * _pecentRange;
			if (value >= 1)
				complete();
		}
		
		
		internal function get revisedPercent():Number { return _revisedPercent; }
		
		internal function get pecentRange():Number { return _pecentRange; }
	}
	
}
