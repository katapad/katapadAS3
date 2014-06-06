package com.katapad.display.container 
{
	import com.katapad.utils.DOUtils;
	import flash.display.Sprite;
	import caurina.transitions.Tweener;
	
	/**
	 * 基本クラス
	 * @author katapad
	 * @version 0.1
	 * @since 2008/11/18 20:00
	 */
	public class ContainerSprite extends Sprite implements IContainer
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _isLock:Boolean;
		
		/**
		 * コンストラクタ
		 */
		public function ContainerSprite() 
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  OVERRIDE
		//
		//--------------------------------------------------------------------------
		public function open(delayTime:Number = 0.0):void
		{
			
		}
		
		public function close(delayTime:Number = 0.0):void
		{
			
		}
		
		public function show():void
		{
			
		}
		
		public function hide():void
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		public function removeChildren():void
		{
			DOUtils.removeChildren(this);
		}
		
		public function lock():void
		{
			_isLock = true;
			DOUtils.lock(this);
		}
		
		public function unlock():void
		{
			_isLock = false;
			DOUtils.unlock(this);
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
		public function get isLock():Boolean { return _isLock; }
	
	}
	
}
