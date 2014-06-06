package com.katapad.utils 
{
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	/**
	 * ContextMenuのutils。
	 * @author katapad
	 * @version 0.1.2
	 * @since 2009/01/20 12:08
	 */
	public class ContextMenuUtils 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		private static var _target:Sprite;
		private static var _contextMenu:ContextMenu;
		private static var _isInit:Boolean = false;
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		
		/**
		 * コンストラクタ
		 */
		public function ContextMenuUtils() 
		{
			throw new IllegalOperationError("cannot construct");
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
		public static function init(target:Sprite, hideBuiltInItems:Boolean = true):void
		{
			if (_target != null)
			{
				//throw new Error("2度目のinitです @ ContextMenuUtils.as");
				trace("2度目のinitです @ ContextMenuUtils.as");
				//_target.contextMenu = null;
				//_target = target;
				return;
			}
			_target = target;
			initContextMenu(hideBuiltInItems);
			_isInit = true;
		}
		
		/**
		 * 最初に表示される不要なものを消します。
		 */
		private static function initContextMenu(hideBuiltInItems:Boolean):void
		{
			_contextMenu = new ContextMenu();
			if (hideBuiltInItems)
				_contextMenu.hideBuiltInItems();
			_target.contextMenu = _contextMenu;
		}
		
		/**
		 * Itemをaddします
		 * @param	menuText
		 * @param	separatorBefore
		 * @param	enabled
		 * @param	visible
		 * @return
		 */
		public static function add(menuText:String, separatorBefore:Boolean = false, enabled:Boolean = true, visible:Boolean = true):ContextMenuItem
		{
			var contextItem:ContextMenuItem = new ContextMenuItem(menuText, separatorBefore, enabled, visible);
			_contextMenu.customItems.push(contextItem);
			return contextItem;
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
		public static function get contextMenu():ContextMenu { return _contextMenu; }
		
		static public function get isInit():Boolean { return _isInit; }
	
	}
	
}
