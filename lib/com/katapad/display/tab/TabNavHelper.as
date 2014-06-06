package com.katapad.display.tab 
{
	import com.greensock.TweenMax;
	import com.katapad.display.core.CoreSpriteHelper;
	import com.katapad.utils.DOUtils;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import jp.xmas.common.display.btn.NormalBtnHelper;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/11/12 19:57
	 */
	public class TabNavHelper extends NormalBtnHelper 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		public static const NORMAL_LABEL:String = 'normal';
		public static const SELECTED_LABEL:String = 'selected';
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _mc:MovieClip;
		private var _selected:Boolean;
		
		private var _over_mc:Sprite;
		private var _base_mc:Sprite;
		
		/**
		 * コンストラクタ
		 */
		public function TabNavHelper(mc:Sprite) 
		{
			this._mc = mc as MovieClip;
			super(mc);
		}
		
		//--------------------------------------------------------------------------
		//
		//  OVERRIDE
		//
		//--------------------------------------------------------------------------
		override protected function _initHook():void 
		{
			//_normalView();
			super._initHook();
		}
		
		override protected function _registElements():void 
		{
			_base_mc = _mc.base_mc;
			_over_mc = _mc.over_mc;
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
		
		//--------------------------------------------------------------------------
		//
		//  EVENT HANDLER
		//
		//--------------------------------------------------------------------------
		override protected function _overHandler(event:MouseEvent):void 
		{
			_playOverSound();
			DOUtils.show(_over_mc);
		}
		
		override protected function _outHandler(event:MouseEvent):void 
		{
			DOUtils.hide(_over_mc);
		}
		
		//--------------------------------------------------------------------------
		//
		//  PRIVATE
		//
		//--------------------------------------------------------------------------
		private function _selectedView():void 
		{
			//TweenMax.killTweensOf(_mc);
			DOUtils.show(_over_mc);
			_mc.gotoAndStop(SELECTED_LABEL);
			lock();
		}
		
		private function _normalView():void 
		{
			DOUtils.hide(_over_mc);
			_mc.gotoAndStop(NORMAL_LABEL);
			unlock();
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
		public function get selected():Boolean { return _selected; }
		
		public function set selected(value:Boolean):void 
		{
			_selected = value;
			if (_selected)
				_selectedView();
			else
				_normalView();
		}
		
		
	}
}
