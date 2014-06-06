package com.katapad.display.core 
{
	import com.katapad.utils.DOUtils;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import jp.progression.commands.CommandList;
	import jp.progression.commands.Func;
	import jp.progression.commands.lists.SerialList;
	
	import caurina.transitions.Tweener;
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/03/23 18:37
	 */
	public class CoreCommandSpriteHelper extends BaseCoreSpriteHelper
	{
	
		//----------------------------------
		//  static var/const
		//----------------------------------
		public static const OPEN_COMPLETE:String = "openComplete";
		public static const CLOSE_COMPLETE:String = "closeComplete";
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		protected var _openCommand:CommandList;
		protected var _closeCommand:CommandList;
		
		/**
		 * コンストラクタ
		 */
		public function CoreCommandSpriteHelper(container:Sprite, name:String = null) 
		{
			super(container, name);
		}
		
		//--------------------------------------------------------------------------
		//
		//  OVERRIDE
		//
		//--------------------------------------------------------------------------
		
		public function open(delayTime:Number = 0.0):CommandList
		{
			var com:SerialList = new SerialList();
			com.addCommand(
				new Func(_open, [delayTime], this, CoreCommandSpriteHelper.OPEN_COMPLETE)
			);
			return com;
		}
		
		public function close(delayTime:Number = 0.0):CommandList
		{
			var com:SerialList = new SerialList();
			com.addCommand(
				new Func(_close, [delayTime], this, CoreCommandSpriteHelper.CLOSE_COMPLETE)
			);
			return com;
		}
		
		public function show():void
		{
			_noOverrideFunction();
		}
		
		public function hide():void
		{
			_noOverrideFunction();
		}
		
		
		public function initOpen():void
		{
			
		}
		
		protected function openComplete():void
		{
			dispachOpenComplete();
		}
		
		protected function closeComplete():void
		{
			dispachCloseComplete();
		}
		
		
		protected function _open(delayTime:Number = 0.0):void
		{
			_noOverrideFunction();
		}
		
		protected function _close(delayTime:Number = 0.0):void
		{
			_noOverrideFunction();
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		public function removeChildren():void
		{
			DOUtils.removeChildren(_container);
		}
		
		public function lock():void
		{
			_isLock = true;
			DOUtils.lock(_container);
		}
		
		public function unlock():void
		{
			_isLock = false;
			DOUtils.unlock(_container);
		}
		
		//--------------------------------------------------------------------------
		//
		//  PROTECTED
		//
		//--------------------------------------------------------------------------
		protected function dispachOpenComplete():void
		{
			dispatchEvent(new Event(CoreCommandSpriteHelper.OPEN_COMPLETE));
		}
		
		protected function dispachCloseComplete():void
		{
			dispatchEvent(new Event(CoreCommandSpriteHelper.CLOSE_COMPLETE));
		}
		
		private function _noOverrideFunction():void
		{
			throw new Error("このメソッドはオーバーライドせずに使用されています");
		}
		
		/**
		 * 
		 * @param	target
		 * @param	delayTime
		 */
		protected function _dispatchDelayOpenComplete(delayTime:Number = 0.0, target:Object = null):void
		{
			_dispatchDelayComplete(delayTime, target);
		}
		
		protected function _dispatchDelayCloseComplete(delayTime:Number = 0.0, target:Object = null):void
		{
			_dispatchDelayComplete(delayTime, target, CoreCommandSpriteHelper.CLOSE_COMPLETE);
		}
		
		protected function _dispatchDelayComplete(delayTime:Number = 0.0, target:Object = null, eventType:String = CoreCommandSpriteHelper.OPEN_COMPLETE):void
		{
			target = target || this;
			//trace( "target : " + target );
			Tweener.addTween(target, { time: 0.0, delay: delayTime, transition: "linear",
				onComplete: dispatchEvent, onCompleteParams: [new Event(eventType)]
			});
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
