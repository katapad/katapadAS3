package com.katapad.display.document 
{
	import com.katapad.core.interfaces.IMainContents;
	import com.katapad.display.api.ILoadingView;
	import com.katapad.load.multiprogress.MultiProgressManager;
	import com.katapad.load.multiprogress.ProgressEventModel;
	import com.katapad.load.multiprogress.ProgressPercentEvent;
	import com.katapad.load.multiprogress.SiMultiProgressManager;
	import com.katapad.model.FlashVarsModel;
	import com.katapad.utils.StageSizeChecker;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	/**
	 * Preloaderの基底クラス
	 * @author katapad
	 * @version 0.1
	 * @since 2009/04/28 13:00
	 */
	public class BasePreloader extends DocumentRoot 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		public static const FLASH_VARS_URL_NAME:String = "preloader_url";
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		/** ローディングのview指定*/
		protected var _loadingView:ILoadingView;
		
		protected var _url:String;
		protected var _loader:Loader;
		protected var _mainContents:IMainContents;
		protected var _multiProgressManager:MultiProgressManager;
		
		/** パーセントをプロパティとして持っておく。不要かな*/
		protected var _percent:Number;
		protected var _isCached:Boolean;
		/**
		 * 読み込むswfのパーセント範囲指定.MultiProgressManagerを使用するので
		 */
		protected var _mainPercentRange:Number = 0.5;
		/**
		 * コンストラクタ
		 */
		public function BasePreloader() 
		{
			super(false);
		}
		
		//--------------------------------------------------------------------------
		//
		//  OVERRIDE
		//
		//--------------------------------------------------------------------------
		override protected function initHook():void 
		{
			initURL();
			validateURL();
			createMultiProgress();
			
			//ステージのサイズがゼロじゃないかチェック
			var stageChecker:StageSizeChecker = new StageSizeChecker(stage);
			stageChecker.addEventListener(Event.COMPLETE, delayInit);
			stageChecker.start();
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
		/**
		 * _urlや_mainPercentRangeを設定します
		 */
		protected function initURL():void
		{
			
		}
		
		/**
		 * エレメントを作成したり、なんとかしたりをします。
		 */
		protected function initElements():void
		{
			
		}
		/**
		 * プログレス状態の時のハンドラです。_percentの値をLoadingViewに渡したりします
		 */
		protected function onProgress():void
		{
			
		}
		/**
		 * メインを読み終えたときに発動します。
		 */
		protected function onMainLoaded():void
		{
			
		}
		
		protected function onComplete():void
		{
			
		}
		
		protected function onError(event:Event):void
		{
			
		}
		
//		protected function destroy():void
//		{
//
//		}
		
		/**
		 * MultiProgressManagerを定義します。
		 * 基本はシングルトンのマネージャクラスを定義しています。
		 */
		protected function createMultiProgress():void
		{
			_multiProgressManager = SiMultiProgressManager.getInstance(stage);
		}
		
		//--------------------------------------------------------------------------
		//
		//  EVENT HANDLER
		//
		//--------------------------------------------------------------------------
		/**
		 * MultiProgressManagerのcompleteハンドラ
		 * @param	event
		 */
		private function completeHandler(event:ProgressPercentEvent):void 
		{
			_percent = 1.0;
			onComplete();
			destroyMultiProgress();
		}
		
		private function progressHandler(event:ProgressPercentEvent):void 
		{
			_percent = event.percent;
			onProgress();
		}
		
		private function errorHandler(event:Event):void 
		{
			onError(event);
		}
		
		private function mainLoadedHandler(event:Event):void 
		{
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, mainLoadedHandler);
			_loader.contentLoaderInfo.removeEventListener(Event.OPEN, mainLoaderStart);
			onMainLoaded();
		}
		//--------------------------------------------------------------------------
		//
		//  PRIVATE
		//
		//--------------------------------------------------------------------------
		/**
		 * ステージの縦横がゼロになる問題をクリアしたときに行う初期化
		 * @param	event
		 */
		private function delayInit(event:Event = null):void 
		{
			if (event)
				StageSizeChecker(event.target).removeEventListener(Event.COMPLETE, delayInit);
			createLoader();
			initMultiProgress();
			initElements();
			startLoad();
		}
		
		private function createLoader():void
		{
			//ローダーはaddchildせずに使う
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.OPEN, mainLoaderStart);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, mainLoadedHandler);
		}

		protected function mainLoaderStart(event:Event):void
		{

		}
		
		private function startLoad():void
		{
			_multiProgressManager.start();
			//TODO キャッシュのチェックしてないのと、loaderContextを準備していない @2009/04/28 13:35 - katapad
			_loader.load(new URLRequest(_url));
		}
		
		private function validateURL():void
		{
			FlashVarsModel.init(stage);
			if (FlashVarsModel.hasKey(FLASH_VARS_URL_NAME))
				_url = FlashVarsModel.getValue(FLASH_VARS_URL_NAME);
			if (_url == null)
				throw new Error("[BasePreloader] urlを入力してください.このクラスを継承したクラスに_urlを入力するか、FlashVarsで" + BasePreloader.FLASH_VARS_URL_NAME + "を入力してください");
		}
		
		private function initMultiProgress():void
		{
			//TODO キャッシュのチェックしてたら、ここは分岐せなあかんかも @2009/04/28 13:40 - katapad
			_multiProgressManager.addProgress(new ProgressEventModel(_loader.contentLoaderInfo, _mainPercentRange));
			_multiProgressManager.addEventListener(ProgressPercentEvent.PERCENT_PROGRESS, progressHandler);
			_multiProgressManager.addEventListener(ProgressPercentEvent.PERCENT_COMPLETE, completeHandler);
		}
		
		private function removeMultiProgressEvent():void
		{
			_multiProgressManager.removeEventListener(ProgressPercentEvent.PERCENT_PROGRESS, progressHandler);
			_multiProgressManager.removeEventListener(ProgressPercentEvent.PERCENT_COMPLETE, completeHandler);
		}
		
		protected function destroyMultiProgress():void
		{
			removeMultiProgressEvent();
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
	
	}
	
}
