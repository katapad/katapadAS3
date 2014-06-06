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
	
	/**
	 * MultiProgressManagerが使うイベント
	 * @author katapad
	 * @version 0.1
	 * @since 2008/11/20 12:33
	 */
	public class ProgressPercentEvent extends Event 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		public static const PERCENT_PROGRESS:String = "percent_progress";
		public static const PERCENT_COMPLETE:String = "percent_complete";
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _percent:Number;
		
		/**
		 * 
		 * @param	type
		 * @param	percent	
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function ProgressPercentEvent(type:String, percent:Number, bubbles:Boolean = false, cancelable:Boolean = false) 
		{ 
			super(type, bubbles, cancelable);
			_percent = percent;
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		override public function clone():Event 
		{ 
			return new ProgressPercentEvent(type, _percent, bubbles, cancelable);
		}
		
		override public function toString():String 
		{ 
			return formatToString("ProgressPercentEvent", "percent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
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
		public function get percent():Number { return _percent; }
	}
	
}