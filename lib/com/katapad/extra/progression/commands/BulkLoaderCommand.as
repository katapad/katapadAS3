package com.katapad.extra.progression.commands 
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import flash.display.Sprite;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.commands.Command;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/02/22 20:31
	 */
	public class BulkLoaderCommand extends Command 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		private static var _nameIndex:int;
		public static const NAME_PREFIX:String = "bulkLoaderCommand";
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		protected var _loader:BulkLoader;
		protected var _bytesLoaded:Number;
		protected var _bytesTotal:Number;
		protected var _weightPercent:Number;
		
		/**
		 * 
		 * @param	loader
		 * @param	loadList loadList[i][0]: url, loadList[i][1]: props
		 * @param	initObject
		 */
		public function BulkLoaderCommand(loader:BulkLoader = null, loadList:Array = null, initObject:Object = null) 
		{
			_loader = loader || new BulkLoader(NAME_PREFIX + _nameIndex);
			// 親クラスを初期化する
			super( _executeFunction, _interruptFunction, initObject );
			
			if (loadList)
				addFromArray(loadList);
			
			// 初期化する
			ObjectUtil.setProperties( this, initObject );
			++_nameIndex;
		}
		
		/**
		 * loadList[i][0]: url, loadList[i][1]: props
		 * @param	loadList
		 */
		public function addFromArray(loadList:Array):void
		{
			for (var i:int = 0, n:int = loadList.length; i < n; ++i) 
			{
				_loader.add(loadList[i][0], loadList[i][1] );
			}
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
		protected function _interruptFunction():void
		{
			_loader.pauseAll();
			_loader.removeAll();
			
			_loader.clear();
			
			_bytesLoaded = 0;
			_bytesTotal = 0;
			_weightPercent = 0;
			
			_destroy();
		}
		
		protected function _executeFunction():void
		{
			_loader.addEventListener(BulkProgressEvent.COMPLETE, _completeHandler);
			_loader.addEventListener(BulkProgressEvent.PROGRESS, _progressHandler);
			_loader.start();
		}
		
		protected function _progressHandler(event:BulkProgressEvent):void 
		{
			_bytesLoaded = event.bytesLoaded;
			_bytesTotal = event.bytesTotal;
			_weightPercent = event.weightPercent;
		}
		
		protected function _completeHandler(event:BulkProgressEvent):void 
		{
			//super.latestData = 
			_destroy();
			// 処理を終了する
			super.executeComplete();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  PRIVATE
		//
		//--------------------------------------------------------------------------
		protected function _destroy():void 
		{
			if ( _loader ) 
			{
				// イベントリスナーを解除する
				_loader.addEventListener(BulkProgressEvent.COMPLETE, _completeHandler);
				_loader.addEventListener(BulkProgressEvent.PROGRESS, _progressHandler);
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
		public function get bytesTotal():Number { return _bytesTotal; }
		
		public function get bytesLoaded():Number { return _bytesLoaded; }
		
		public function get weightPercent():Number { return _weightPercent; }
		
		public function get loader():BulkLoader { return _loader; }
		
	}
	
}
