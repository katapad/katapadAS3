package com.katapad.display.document 
{
	import caurina.transitions.Tweener;
	import com.katapad.core.interfaces.IMainContents;
	import com.katapad.display.document.DocumentRoot;
	import com.katapad.test.tween.TweenerSpeedChanger;
	import com.katapad.utils.ContextMenuUtils;
	import com.katapad.utils.StStage;
	import com.katapad.utils.tweens.TweenerUtils;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * メインクラス
	 * @author katapad
	 * @version 0.1
	 */
	public class BaseMain extends DocumentRoot implements IMainContents
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _isUnitTest:Boolean;
		//constはコンストラクタで初期化できるはずなのに、コンパイラに怒られるのでやむなくvarにした
		private static var PROJECT_VERSION:String;
		//private static const PROJECT_VERSION:String;
		
		/**
		 * バージョン情報とEvent.ADDED_TO_STAGEを待たずにinitをかけるかどうか
		 * @param	version versionのString
		 * @param	compulsoryInit 強制的にinitをかけるかどうか。
		 */
		public function BaseMain(version:String = null, compulsoryInit:Boolean = false) 
		{
			if (!BaseMain.PROJECT_VERSION && version)
				PROJECT_VERSION = version;
			super(compulsoryInit);
		}
		
		override protected function initHook():void
		{
			trace("[BaseMain]  initHook");
			_isUnitTest = StStage.stage.getChildAt(0) == this;
			initMain();
			createElements();
			
			//debug時
			debugState()
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		public function start():void
		{
			
		}
		//--------------------------------------------------------------------------
		//
		//  OVERRIDE
		//
		//--------------------------------------------------------------------------
		/**
		 * Mainのinitのフック
		 */
		protected function initMainHook():void
		{
			
		}
		
		/**
		 * 子要素作成
		 */
		protected function createElements():void
		{
		}
		
		/**
		 * デバッグモード時にやること
		 */
		protected function debugState():void
		{
//			if (Config.DEBUG_MODE)
//			{
//				traceStatus();
//				//Tweener.setTimeScale(10);
//				TweenerSpeedChanger.init(StStage.stage);
//				TweenerSpeedChanger.start();
//				//Debug.monitor(this);
//			}
			//preloaderがなければstartする
			if (_isUnitTest)
				unitTestStart();
		}
		
		protected function unitTestStart():void
		{
			start();
		}
		
		override public function toString():String
		{
			return "[object Main]";
		}
		
		//--------------------------------------------------------------------------
		//
		//  EVENT HANDLER
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  PROTECTED
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  settings
		//----------------------------------
		protected function initMain():void
		{
			addContextMenu();
			initMainHook();
		}
		
		private function addContextMenu():void
		{
			ContextMenuUtils.add("Version: " + PROJECT_VERSION, true, true);
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
		public function get isUnitTest():Boolean { return _isUnitTest; }
		
	}
	
}
