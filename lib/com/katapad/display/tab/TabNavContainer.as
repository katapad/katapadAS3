package com.katapad.display.tab 
{
	import com.katapad.display.core.CoreSprite;
	import com.katapad.utils.DOUtils;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/11/12 19:42
	 */
	public class TabNavContainer extends CoreSprite 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		protected var _navList:Array;
		protected var _navHelperList:Array;
		
		/**
		 * コンストラクタ
		 */
		public function TabNavContainer() 
		{
			_init();
		}
		
		/**
		 * 初期化
		 */
		private function _init():void 
		{
			_createElements();
			_initNavList();
			_initNavEvent();
			_initHook();
		}
		
		protected function _createElements():void 
		{
			
		}
		
		protected function _initNavList():void 
		{
			_navList = DOUtils.numberingedMC2Array(this, 'nav', '', 0);
		}
		
		protected function _initHook():void 
		{
			
		}
		
		private function _initNavEvent():void 
		{
			for (var i:int = 0, n:int = _navList.length; i < n; ++i) 
			{
				var mc:Sprite = _navList[i];
				mc.addEventListener(MouseEvent.CLICK, _navClickHandler);
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
		public function updateView(index:int):void
		{
			
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
		private function _navClickHandler(event:MouseEvent):void 
		{
			var index:int = _navList.indexOf(event.currentTarget);
			dispatchEvent(new TabEvent(TabEvent.TAB_CLICK, index));
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
		
	}
}
