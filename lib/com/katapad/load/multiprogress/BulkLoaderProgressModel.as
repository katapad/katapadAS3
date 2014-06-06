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
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	
	/**
	 * BulkLoader用のprogressModel
	 * @author katapad
	 * @version 0.1.2
	 * @since 2009/03/03 13:19
	 */
	public class BulkLoaderProgressModel extends AbstractProgressModel 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		/** completeItem / totalItem */
		public static const PERCENT_ITEM_RATIO:uint = 0;
		/** bytesLoaded / currentBytesTotal  */
		public static const PERCENT_BYTES_TOTAL:uint = 1;
		/** weightPercentを使う */
		public static const PERCENT_WEIGHT_PERCENT:uint = 2;
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _bulkLoader:BulkLoader;
		private var _percentType:uint;
		
		/**
		 * BulkLoader用のModelです。
		 * @param	bulkLoader		BulkLoaderのインスタンス
		 * @param	percentRange	パーセントのレンジ
		 * @param	percentType		パーセントのタイプを指定します。BulkLoaderProgressModel.PERCENT_ITEM_RATIO or BulkLoaderProgressModel.PERCENT_BYTES_TOTAL or PERCENT_WEIGHT_PERCENT
		 */
		public function BulkLoaderProgressModel(bulkLoader:BulkLoader, percentRange:Number, percentType:uint = BulkLoaderProgressModel.PERCENT_WEIGHT_PERCENT) 
		{
			_bulkLoader = bulkLoader;
			super(percentRange);
			_percentType = percentType;
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
			if (!_bulkLoader)
				return;
			_bulkLoader.removeEventListener(BulkLoader.PROGRESS, progressHandler);
			_bulkLoader = null;
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
		private function progressHandler(event:BulkProgressEvent):void 
		{
			switch(_percentType)
			{
				case BulkLoaderProgressModel.PERCENT_ITEM_RATIO:
					percent = event.ratioLoaded;
					break;
				case BulkLoaderProgressModel.PERCENT_BYTES_TOTAL :
					percent = event.percentLoaded;
					break;
				case BulkLoaderProgressModel.PERCENT_WEIGHT_PERCENT :
					percent = event.weightPercent;
					break;
				default :
					throw new Error("_percentTypeの値が不正です");
					break;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  PRIVATE
		//
		//--------------------------------------------------------------------------
		private function start():void 
		{
			_bulkLoader.addEventListener(BulkLoader.PROGRESS, progressHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
	
	}
	
}
