package com.katapad.display.tab 
{
	import com.katapad.display.core.CoreSprite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/11/12 19:41
	 */
	public class TabController extends EventDispatcher 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		protected var _tabNav:TabNavContainer;
		protected var _contentList:Array;
		protected var _defaultIndex:int;
		protected var _currentContent:CoreSprite;
		
		protected var _index:int;
		//private var
		
		/**
		 * コンストラクタ
		 */
		public function TabController(tabNav:TabNavContainer, contentList:Array, defaultIndex:int = 0) 
		{
			this._defaultIndex = defaultIndex;
			this._contentList = contentList;
			this._tabNav = tabNav;
			_init();
		}
		
		/**
		 * 初期化
		 */
		private function _init():void 
		{
			//on();
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
		public function on(index:int = -1):void
		{
			if (index == -1)
				_index = _defaultIndex;
			else
				_index = index;
			_currentContent = _contentList[_index];
			_tabNav.addEventListener(TabEvent.TAB_CLICK, _onNavClickHandler);
			_firstView();
		}
		
		public function off():void
		{
			_tabNav.removeEventListener(TabEvent.TAB_CLICK, _onNavClickHandler);
		}
		
		
		public function change(index:int):void
		{
			_index = index;
			_update();
		}
		
		//--------------------------------------------------------------------------
		//
		//  PROTECTED
		//
		//--------------------------------------------------------------------------
		private function _firstView():void 
		{
			_updateNavView();
			for (var i:int = 0, n:int = _contentList.length; i < n; ++i) 
			{
				if (i == _index)
					CoreSprite(_contentList[i]).show();
				else
					CoreSprite(_contentList[i]).hide();
			}
		}
		
		protected function _update():void 
		{
			_updateNavView();
			_updateContentView();
		}
		
		protected function _updateNavView():void 
		{
			_tabNav.updateView(_index);
		}
		
		protected function _updateContentView():void 
		{
			_currentContent.hide();
			_currentContent = _contentList[_index];
			_currentContent.show();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  EVENT HANDLER
		//
		//--------------------------------------------------------------------------
		protected function _onNavClickHandler(event:TabEvent):void 
		{
			_index = event.index;
			_update();
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
