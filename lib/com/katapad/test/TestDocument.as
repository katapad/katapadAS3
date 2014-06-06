package com.katapad.test 
{
	import caurina.transitions.Tweener;
	import test.TestInit;
	//import com.hexagonstar.util.debug.Debug;
	import com.katapad.utils.StStage;
	import com.katapad.utils.tweens.TweenerUtils;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libspark.thread.EnterFrameThreadExecutor;
	import org.libspark.thread.Thread;
	
	/**
	 * Test用のドキュメントルート
	 * @author katapad
	 * @version 0.1
	 * @since 2008/11/18 18:46
	 */
	public class TestDocument extends Sprite 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		protected var _flag1:Boolean;
		private var _enableToggleFlag:Boolean;
		
		/**
		 * コンストラクタ
		 */
		public function TestDocument(enableToggleMouse:Boolean = false) 
		{
			_enableToggleFlag = enableToggleMouse;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * 初期化
		 */
		private function init(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			TestInit.init(stage);
			
			StStage.init(stage);
			StStage.ordinarySetting();
			//StStage.hideDefaultContextMenu();
			
			_flag1 = false;
			initTween();
			if (!Thread.isReady) 
				Thread.initialize(new EnterFrameThreadExecutor());
			//Debug.monitor(stage);
			
			initHook();
			
			if (_enableToggleFlag)
				_enableToggleMouseDown();
				
		}
		
		protected function initTween():void
		{
			//TweenerUtils.registerSpecialProperties(true, true, true, true);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  OVERRIDE
		//
		//--------------------------------------------------------------------------
		protected function initHook():void
		{
			
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
		protected function _enableToggleMouseDown():void
		{
			StStage.stage.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
		}
		
		private function downHandler(event:MouseEvent):void 
		{
			if (_flag1)
			{
				_flag1TrueHandler();
			}
			else
			{
				_flag1FalseHandler();
			}
			_flag1 = !_flag1;
		}
		
		protected function _flag1TrueHandler():void
		{
			
		}
		
		protected function _flag1FalseHandler():void
		{
			
		}
		//--------------------------------------------------------------------------
		//
		//  EVENT HANDLER
		//
		//--------------------------------------------------------------------------
		
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
	
	}
	
}
