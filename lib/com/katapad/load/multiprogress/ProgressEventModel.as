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
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	/**
	 * flash.events.ProgressEventからパーセントを拾うProgressModel
	 * @author katapad
	 * @version 0.1
	 * @since 2009/02/06 20:00
	 */
	public class ProgressEventModel extends AbstractProgressModel 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _eventSource:IEventDispatcher;
		
		/**
		 * flash.events.ProgressEventからパーセントを拾うProgressModelです。
		 * @param	eventSource	ProgressEventを通知するIEventDispatcher.
		 * @param	percentRange	パーセントの幅
		 */
		public function ProgressEventModel(eventSource:IEventDispatcher, percentRange:Number) 
		{
			super(percentRange);
			_eventSource = eventSource;
			start();
		}
		
		//--------------------------------------------------------------------------
		//
		//  OVERRIDE
		//
		//--------------------------------------------------------------------------
		override protected function completeHook():void 
		{
			destroy();
		}
		
		override public function cancel():void 
		{
			destroy();
		}
		
		override public function destroy():void 
		{
			if (!_eventSource)
				return;
			_eventSource.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			_eventSource = null;
		}
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
		private function progressHandler(event:ProgressEvent):void 
		{
			percent = event.bytesLoaded / event.bytesTotal;
		}
		
		//--------------------------------------------------------------------------
		//
		//  PRIVATE
		//
		//--------------------------------------------------------------------------
		private function start():void 
		{
			_eventSource.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
	
	}
	
}
