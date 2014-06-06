package com.katapad.display.core 
{
	import com.katapad.display.api.ICoreDisplay;
	import com.katapad.display.api.ICoreSpriteHelper;
	import com.katapad.utils.DOUtils;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	
	/**
	 * CoreSpriteの振る舞いをするHelperクラス
	 * @author katapad
	 * @version 0.2
	 * @since 2010/03/23 19:38
	 */
	public class CoreSpriteHelper extends EventDispatcher implements ICoreSpriteHelper, ICoreDisplay
	{
		/**
		 * openが終わったら送出します
		 * @eventType com.katapad.display.core.CoreDOEventName.OPEN_COMPLETE
		 */
		[Event(name = "openComplete", type = "flash.events.Event")]
		
		/**
		 * closeが終わったら送出します
		 * @eventType com.katapad.display.core.CoreDOEventName.CLOSE_COMPLETE
		 */
		[Event(name = "closeComplete", type = "flash.events.Event")]
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		/**
		 * ボタンロックしているかを返します
		 */
		protected var _isLock:Boolean;
		/**
		 * マウスロックしているかを返します。
		 */
		protected var _isMouseLock:Boolean;
		/**
		 * container
		 */
		protected var _target:Sprite;
		/**
		 * name
		 */
		protected var _name:String;
		
		
		/**
		 * コンストラクタ
		 */
		public function CoreSpriteHelper(target:Sprite, name:String = null)
		{
			_init(target, name);
		}
		
		/**
		 * 初期化
		 */
		private function _init(target:Sprite, name:String):void
		{
			_target = target;
			_name = name;
			_registElements();
			_initHook();
		}
		
		protected function _registElements():void
		{
			
		}
		
		protected function _initHook():void
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  OVERRIDE
		//
		//--------------------------------------------------------------------------
		protected function _dispachOpenComplete():void
		{
			dispatchEvent(new Event(CoreDOEventName.OPEN_COMPLETE));
		}
		
		protected function _dispachCloseComplete():void
		{
			dispatchEvent(new Event(CoreDOEventName.CLOSE_COMPLETE));
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
		protected function _noOverideFunction():void
		{
			throw new Error("このメソッドはオーバーライドされていません");
		}
		
		public function removeChildren():void
		{
			DOUtils.removeChildren(_target);
		}
		
		public function lock():void
		{
			DOUtils.lock(_target);
			_isLock = true;
		}
		
		public function unlock():void
		{
			DOUtils.unlock(_target);
			_isLock = false;
		}
		
		public function mouseLock():void
		{
			DOUtils.mouseLock(_target);
			_isMouseLock = true;
		}
		
		public function mouseUnlock():void
		{
			DOUtils.mouseUnlock(_target);
			_isMouseLock = false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function initOpen():void
		{
			
		}
		
		public function open(delayTime:Number = 0.0):void
		{
			_noOverideFunction();
		}
		
		public function close(delayTime:Number = 0.0):void
		{
			_noOverideFunction();
		}
		
		public function show(delayTime:Number = 0):void
		{
			DOUtils.show(_target);
		}
		
		public function hide(delayTime:Number = 0):void
		{
			DOUtils.hide(_target);
		}
		
		public function destroy():void
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
		public function get isLock():Boolean
		{
			return _isLock;
		}
		
		public function get isMouseLock():Boolean
		{
			return _isMouseLock;
		}
		
		
		
		public function get target():Sprite { return _target; }
		
		public function set target(value:Sprite):void
		{
			_target = value;
			_isLock = _target.mouseChildren;
		}
		
		public function get name():String { return _name; }
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		
		/* INTERFACE com.katapad.display.api.ICoreSpriteHelper */
		
		public function get x():Number
		{
			return _target.x;
		}
		
		public function set x(value:Number):void
		{
			_target.x = value;
		}
		
		public function get y():Number
		{
			return _target.y;
		}
		
		public function set y(value:Number):void
		{
			_target.y = value;
		}
		
		public function get rotation():Number
		{
			return _target.rotation;
		}
		
		public function set rotation(value:Number):void
		{
			_target.rotation = value;
		}
		
		public function get alpha():Number
		{
			return _target.alpha;
		}
		
		public function set alpha(value:Number):void
		{
			_target.alpha = value;
		}
		
		public function get scaleX():Number
		{
			return _target.scaleX;
		}
		
		public function set scaleX(value:Number):void
		{
			_target.scaleX = value;
		}
		
		public function get scaleY():Number
		{
			return _target.scaleY;
		}
		
		public function set scaleY(value:Number):void
		{
			_target.scaleY = value;
		}
		
		public function get visible():Boolean
		{
			return _target.visible;
		}
		
		public function set visible(value:Boolean):void
		{
			_target.visible = value;
		}
	
	}
	
}
