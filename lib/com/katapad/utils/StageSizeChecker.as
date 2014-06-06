package com.katapad.utils 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	
	/**
	 * WinIEやMacFFでSWFObjectのdynamicEmbedをしたときにおこる
	 * Stage.stageWidthとstageHeightが0になる問題を
	 * EnterFrameで監視してチェックするクラス<br />
	 * Event.RESIZEが飛んでくるタイミングがEvent.ENTER_FRAMEより遅いので、
	 * EVENT.COMPLETEのついでにstageからEVENT.RESIZEも飛ばします(オプション)。
	 * 
	 * @author katapad.com
	 * @version 0.1
	 * @since 2009/03/17 3:40
	 * @usage
	 * <p>MainクラスやPreloaderクラスの最初に</p>
	 * <pre>
	 * var StageSizeChecker:StageSizeChecker = new StageSizeChecker(stage);
	 * StageSizeChecker.addEventListener(Event.COMPLETE, delayInit);
	 * StageSizeChecker.start();
	 * </pre>
	 * <p>を書いて、あとはEvent.COMPLETEの受取先で</p>
	 * <pre>event.target.removeEventListener(Event.COMPLETE, delayInit);</pre>
	 * <p>すればOK</p>

	 */
	public class StageSizeChecker extends EventDispatcher 
	{
		/**
		 * stage.stageWidthとstage.stageHeightが0以外になったら配信します。
		 * @eventType flash.events.Event.COMPLETE
		 */
		[Event(name = "complete", type = "flash.events.Event")]
		
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _stage:Stage;
		private var _isResizeEvent:Boolean;
		
		/**
		 * ステージサイズを見張り、ゼロ以外ならEvent.COMPLETEを配信します。
		 * @param	stage
		 * @param	isResizeEvent	_stage.dispatchEvent(new Event(Event.RESIZE))も同時に発動させるかどうか
		 */
		public function StageSizeChecker(stage:Stage, isResizeEvent:Boolean = true) 
		{
			init(stage, isResizeEvent);
		}
		
		private function init(stage:Stage, isResizeEvent:Boolean):void
		{
			_stage = stage;
			_isResizeEvent = isResizeEvent;
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
		public function start():void
		{
			if (isValidSize())
			{
				complete();
				return;
			}
			_stage.addEventListener(Event.ENTER_FRAME, check);
		}
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
		private function check(event:Event):void 
		{
			if (isValidSize())
				complete();
		}
		
		//--------------------------------------------------------------------------
		//
		//  PRIVATE
		//
		//--------------------------------------------------------------------------
		private function isValidSize():Boolean
		{
			//trace( getTimer(), "_stage.stageWidth : " + _stage.stageWidth );
			return _stage.stageWidth * _stage.stageHeight != 0;
		}
		
		private function complete():void
		{
			_stage.removeEventListener(Event.ENTER_FRAME, check);
			if (_isResizeEvent)
				_stage.dispatchEvent(new Event(Event.RESIZE));
			dispatchEvent(new Event(Event.COMPLETE));
			_stage = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
	
	}
	
}
