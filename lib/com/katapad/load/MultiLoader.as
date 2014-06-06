/**
* @author katapad
* @version 0.1.0
* @since 2008/06/09 19:28
*/

package com.katapad.load 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;

	public class MultiLoader extends EventDispatcher
	{
		//メンバ変数
		public const AS3_SWF:uint = 0;
		public const AS2_SWF:uint = 1;
		public const IMAGE:uint = 2;
		public const XML_FILE:uint = 3;
		
		
		//インスタンス変数
		private var _loader:Loader;
		private var _inputArray:Array;
		private var _result:Array;
		
		private var _loadedBytes:uint = 0;
		private var _totalBytes:uint = 0;
		
		/**
		 * コンストラクタ
		 */
		public function MultiLoader() 
		{
			init();
		}
		
		/**
		 * 初期化
		 */
		private function init():void 
		{
			_loader = new Loader();
			_inputArray = [];
			_result = [];
		}
		
		//--------------------------------------------------------------------------
		//
		//  public
		//
		//--------------------------------------------------------------------------
		/**
		 * push！デフォルトfileTypeはimage
		 * @param	fileName
		 * @param	fileType
		 */
		public function push(fileName:String, fileType:uint = IMAGE):void
		{
			if(fileType != AS2_SWF)
				_inputArray.push([fileName, fileType]);
		}
		
		public function start():void
		{
			calcTotalByte();
			next();
		}
		
		/**
		 * すべてのインスタンス変数を削除
		 */
		public function destroy():void
		{
			_loader = null;
			_inputArray = _result = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  get/set
		//
		//--------------------------------------------------------------------------
		public function getResult():Array
		{
			return _result;
		}
		
		//--------------------------------------------------------------------------
		//
		//  private
		//
		//--------------------------------------------------------------------------
		private function next():void
		{
			_loader.load(new URLRequest(_inputArray[_result.length][0]));
			_loader.contentLoaderInfo.addEventListener (IOErrorEvent.IO_ERROR,ioErrorHandler);
			_loader.contentLoaderInfo.addEventListener(Event.INIT, initHandler);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		}
		//----------------------------------
		//  byte
		//----------------------------------
		private function calcTotalByte():void
		{
			for (var i:uint = 0, n:uint = _inputArray.length; i < n; i++) 
			{
				_loader.load(new URLRequest(_inputArray[_result.length][0]));
				_totalBytes += _loader.contentLoaderInfo.bytesTotal;
				trace( "1フレーム置かないと、見れないのか_loader.contentLoaderInfo.bytesTotal : " + _loader.contentLoaderInfo.bytesTotal );
				_loader.close();
			}
				//trace( "_totalBytes : " + _totalBytes );
		}
		
		private function calcLoadedByte():void
		{
			_loadedBytes += _loader.contentLoaderInfo.bytesTotal;
			trace( "_loadedBytes : " + _loadedBytes );
		}
		
		
		//----------------------------------
		//  eventHandler
		//----------------------------------
		private function ioErrorHandler(event:IOErrorEvent):void {
			dispatchEvent(event);
		}
		
		private function progressHandler(event:ProgressEvent):void
		{
			trace( "_loader.contentLoaderInfo.bytesTotal : " + _loader.contentLoaderInfo.bytesTotal );
			//var ratioSelf:Number = event.bytesLoaded / event.bytesTotal;
			//var ratioAll:Number =  Math.round((_result.length + ratioSelf) / _inputArray.length * 100) / 100;
			//trace( "ratioAll : " + ratioAll );
			//dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, _loadedBytes + _loader.contentLoaderInfo.bytesLoaded, _totalBytes));
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, _result.length, _inputArray.length));
		}
		
		private function initHandler(event:Event):void
		{
			_result.push(_loader.content);
			
			_loader.contentLoaderInfo.removeEventListener (IOErrorEvent.IO_ERROR,ioErrorHandler);
			_loader.contentLoaderInfo.removeEventListener (Event.INIT, initHandler);
			_loader.contentLoaderInfo.removeEventListener (ProgressEvent.PROGRESS, progressHandler);
			calcLoadedByte();
			if (_inputArray.length == _result.length) 
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
			else {
				next();
			}
		}
		
		private function completeHandler(event:Event):void
		{
			
		}
		
	}
	
}
