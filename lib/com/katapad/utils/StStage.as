package com.katapad.utils 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
import flash.events.MouseEvent;

/**
	 * [static]Stageを保持したり、よく使うstage系utilをまとめたstaticクラス
	 * @author katapad
	 * @version 0.51
	 * @since 2008/09/09 
	 */
	public class StStage 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		private static var _stage:Stage;
		/** ロックされているかどうか（mouseChildren) */
		private static var _isLock:Boolean;
		
		private static var _centerX:Number;
		private static var _centerY:Number;
		
		private static var _lockKey:*;
		private static var _url:String;
		private static var _isLocal:Boolean;
		
		/**
		 * コンストラクタの呼び出しは禁止です。
		 * stageクラスの参照を持つグローバルっぽいクラスです。
		 * 最初にinitするとあとはStStage.stageでいつでもどこでも参照を受け取れます。
		 */
		public function StStage() 
		{
			throw new IllegalOperationError("cannot construct StStage Class");
		}
		
		/**
		 * stageを登録します。
		 * @param	stage
		 */
		public static function init(stage:Stage):void 
		{
			//trace( "stage : " + stage );
			if (_stage)
			{
				//throw new Error("2度目のinitです。StStage");
				trace("2度目のinitです。StStage");
				return
			}
			_stage = stage;
			if (_stage.mouseChildren)
				_isLock = false;
			else
				_isLock = true;
			_stage.addEventListener(Event.RESIZE, StStage.resizeHandler, false, int.MAX_VALUE);
			_url = stage.loaderInfo.url;
			trace( "_url : " + _url );
			_isLocal = !(/^http/.test(_url));
			
			resizeHandler();
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		/**
		 * SWF全体のマウス操作をロックします。
		 */
		public static function lock():void
		{
			//trace("=;;;;;;===stage======lock ");
			_stage.mouseChildren = false;
			_isLock = true;
		}
		
		/**
		 * SWF全体のマウスロックを解除
		 */
		public static function unlock():void
		{
			if (_lockKey != null)
			{
				//throw new Error("StStage.strongLock()されています");
				trace("StStage.strongLock()されています");
				return;
			}
			//trace("=;;;;;;===stage======unlock ");
			_stage.mouseChildren = true;
			_isLock = false;
		}
		
		public static function toggleLock():void
		{
			if (_isLock)
				unlock();
			else
				lock();
		}
		
		/**
		 * StStage.lock()やunlock()だとどこからでもロック/解除ができてしまうので、それを防止したいときに使います。
		 * @param	lockKey	null以外なら何でも可
		 */
		public static function strongLock(lockKey:*):void
		{
			if (lockKey == null)
			{
				//throw new Error("null以外を引数にしてください");
				trace("null以外を引数にしてください");
				return;
			}
			_lockKey = lockKey;
			lock();
		}
		
		/**
		 * strongLockの解除
		 * @param	lockKey
		 */
		public static function strongUnlock(lockKey:*):void
		{
			//trace("strongUnlock : " );
			if (lockKey == null)
			{
				//throw new Error("null以外を引数にしてください");
				trace("null以外を引数にしてください");
				return;
			}
			if (lockKey !== _lockKey)
			{
				//throw new Error("StStage.strongLock()で渡された引数と異なるのでunlockできません");
				trace("StStage.strongLock()で渡された引数と異なるのでunlockできません");
				return;
			}
			_lockKey = null;
			unlock();
		}
		
		public static function fullScreen():void
		{
			_stage.displayState = StageDisplayState.FULL_SCREEN;
		}
		
		public static function normalScreen():void
		{
			_stage.displayState = StageDisplayState.NORMAL;
		}
		
		public static function toggleFullScreen():void
		{
			if (_stage.displayState == StageDisplayState.FULL_SCREEN)
				_stage.displayState = StageDisplayState.NORMAL;
			else if (_stage.displayState == StageDisplayState.NORMAL)
				_stage.displayState = StageDisplayState.FULL_SCREEN;
		}
		
		/**
		 * EnterFrameイベントに登録する
		 * @param	listener
		 * @param	useCapture
		 * @param	priority
		 * @param	useWeakReference
		 */
		public static function addEnterFrameListener(listener:Function = null, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_stage.stage.addEventListener(Event.ENTER_FRAME, listener, useCapture, priority, useWeakReference);
		}
		
		/**
		 * EnterFrameイベントから外す
		 * @param	listener
		 * @param	useCapture
		 */
		public static function removeEnterFrameListener(listener:Function = null, useCapture:Boolean = false):void
		{
			_stage.stage.removeEventListener(Event.ENTER_FRAME, listener, useCapture);
		}
		
		/**
		 * ターゲットの幅・高さを元に最適なスケールを返す。画像をステージいっぱいいっぱいに引き伸ばすときとかに使います。
		 * @param	targetW
		 * @param	targetH
		 * @param	isMax	最大値を元にスケールさせるかどうか。余白がない状態で引き伸ばされます
		 * @return
		 */
		public static function getScaleByStageScale(targetW:Number, targetH:Number, isMax:Boolean = true):Number
		{
			return isMax ? Math.max(_stage.stageWidth / targetW, _stage.stageHeight / targetH): Math.min(_stage.stageWidth / targetW, _stage.stageHeight / targetH);
		}

		public static function addClick(listener:Function = null, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_stage.stage.addEventListener(MouseEvent.MOUSE_DOWN, listener);
		}
		
		//----------------------------------
		//  quality
		//----------------------------------
		public static function qualityLow():void
		{
			_stage.quality = StageQuality.LOW;
		}
		
		public static function qualityMedium():void
		{
			_stage.quality = StageQuality.MEDIUM;
		}
		
		public static function qualityHigh():void
		{
			_stage.quality = StageQuality.HIGH;
		}
		
		public static function qualityBest():void
		{
			_stage.quality = StageQuality.BEST;
		}
		
		public static function noScale():void
		{
			_stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		public static function TopLeft():void
		{
			stage.align = StageAlign.TOP_LEFT;
		}
		
		/**
		 * いつものセッティング
		 * Quality: HIGH, NO_SCALE, TOP_LEFT
		 */
		public static function ordinarySetting(qualityHigh:Boolean = true, topLeft:Boolean = true, noScale:Boolean = true):void
		{
			if (qualityHigh)
				StStage.qualityHigh();
			if (topLeft)
				StStage.TopLeft();
			if (noScale)
				StStage.noScale();
		}
		
		/**
		 * これを使うとDocumentRootで
		 */
		public static function hideDefaultContextMenu():void
		{
			_stage.showDefaultContextMenu = false;
		}
		
		public static function centering(mc:DisplayObject, round:Boolean = false):void
		{
			if (round)
			{
				mc.x = int(StStage._centerX);
				mc.y = int(StStage._centerY);
			}
			else
			{
				mc.x = StStage._centerX;
				mc.y = StStage._centerY;
			}
		}
		//--------------------------------------------------------------------------
		//
		//  EVENT HANDLER
		//
		//--------------------------------------------------------------------------
		private static function resizeHandler(event:Event = null):void 
		{
			_centerX = _stage.stageWidth * 0.5;
			_centerY = _stage.stageHeight * 0.5;
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
		public static function get stage():Stage 
		{ 
			if (_stage == null)
				throw new Error("StStage.init()で登録してください");
			return _stage; 
		}
		
		public static function get stageWidth():uint 
		{
			return _stage.stageWidth;
		}
		
		public static function get stageHeight():uint
		{
			return _stage.stageHeight;
		}
		
		public static function get centerX():Number 
		{
			return _centerX;
		}
		
		public static function get centerY():Number 
		{
			return _centerY;
		}
		
		public static function get mouseX():Number
		{
			return _stage.mouseX;
		}
		
		public static function get mouseY():Number
		{
			return _stage.mouseY;
		}
		
		public static function get isLock():Boolean { return _isLock; }
		
		public static function get isFullScreen():Boolean { return _stage.displayState == StageDisplayState.FULL_SCREEN }
		
		public static function get isNormalScreen():Boolean { return _stage.displayState == StageDisplayState.NORMAL }
		
		/**
		 * stageの参照を保持しているかどうか
		 */
		public static function get isInit():Boolean
		{
			return _stage != null;
		}
		
		/**
		 * stage.loaderInfo.urlのショートカット
		 */
		public static function get url():String { return _url; }
		
		/**
		 * ローカルでの再生かどうか
		 */
		public static function get isLocal():Boolean { return _isLocal; }

		
		
	}
	
}
