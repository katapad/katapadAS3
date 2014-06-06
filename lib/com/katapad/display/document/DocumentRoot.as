package com.katapad.display.document 
{
	import com.katapad.display.core.CoreSprite;
	import com.katapad.display.shape.AutoFitSquare;
	import com.katapad.utils.ContextMenuUtils;
	import com.katapad.utils.StStage;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	* ドキュメントルートの抽象クラス
	* @author katapad
	* @version 0.1.2
	*/
	public class DocumentRoot extends CoreSprite 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		protected var _opaqueBg:Shape;
		protected var _opaqueBgColor:uint;
		protected var _opaqueBgAlpha:Number;
		protected var _hasOpaqueBg:Boolean;
		
		/**
		 * Event.ADDED_TO_STAGEを待たずに強制的にinitをかけるかどうか。
		 * @param	compulsoryInit 強制的にinitをかけるかどうか
		 */
		public function DocumentRoot(compulsoryInit:Boolean = false) 
		{
			if (compulsoryInit)
				init();
			else
				this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		//--------------------------------------------------------------------------
		//
		//  init
		//
		//--------------------------------------------------------------------------
		/**
		 * 初期化。ステージに置かれたとき（ADDED_TO_STAGE）に初期化を行う
		 */
		protected function init(event:Event = null):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			if (!StStage.isInit)
				StStage.init(stage);
			initContextMenu();
			initStage();
			initTweenEngine();
			initHook();
			_initOpaqueBg();
		}
		
		//--------------------------------------------------------------------------
		//
		//  OVERRIDE
		//
		//--------------------------------------------------------------------------
		/**
		 * onResize用のハンドラ
		 * @param	event
		 */
		protected function onResizeHandler(event:Event):void {}
		
		/**
		 * ステージの初期化を行います。
		 */
		protected function initStage():void
		{
			StStage.ordinarySetting(true, false, false);
		}
		
		/**
		 * override用の　初期化フック
		 */
		protected function initHook():void { }

		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		/**
		 * DocumentClassの状態などを一括で返す。
		 * @return
		 */
		public function getDocumentClassInfo():String
		{
			var result:String = toString();
			result += ",";
			result += "quality: " + StStage.stage.quality;
			result += ",";
			result += "FPS: " + StStage.stage.frameRate;
			return result;
		}
		
		/**
		 * toString
		 * @return
		 */
		override public function toString():String 
		{
			return "[object DocumentRoot]";
		}
		
		/**
		 * FPSやqualityなどの設定をtraceする
		 */
		public function traceStatus():void
		{
			trace(getDocumentClassInfo());
		}
		
		//--------------------------------------------------------------------------
		//
		//  PROTECTED
		//
		//--------------------------------------------------------------------------
		/**
		 * Tweenのエンジンをinitする
		 */
		protected function initTweenEngine():void
		{
			
		}
		protected function initContextMenu():void
		{
			if (ContextMenuUtils.isInit)
				return;
			stage.showDefaultContextMenu = true;
			ContextMenuUtils.init(this, true);
		}
		
		//----------------------------------
		//  init系
		//----------------------------------
		/**
		 * 色付きの背景レイヤーの初期値を設定する。あまり使わないので削除候補
		 * @param	hasOpaque
		 * @param	color
		 * @param	alpha
		 */
		protected function initOpaqueBg(hasOpaque:Boolean = false, color:uint = 0xFFFFFF, alpha:Number = 0.0):void
		{
			_hasOpaqueBg = hasOpaque;
			_opaqueBgColor = color;
			_opaqueBgAlpha = alpha;
		}
		
		//--------------------------------------------------------------------------
		//
		//  PRIVATE
		//
		//--------------------------------------------------------------------------
		/**
		 * 色付きの背景を敷きたいときに使う。わかりにくいので削除候補
		 */
		private function _initOpaqueBg():void
		{
			if (!_hasOpaqueBg)
				return;
			_opaqueBg = addChildAt(new AutoFitSquare(_opaqueBgColor, _opaqueBgAlpha), 0) as Shape;
		}
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
	}
	
}
