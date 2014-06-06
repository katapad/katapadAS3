package com.katapad.proxy 
{
	import com.katapad.utils.props.DisplayPropsPool;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;	
	import caurina.transitions.Tweener;
	
	/**
	 * AfterEffectsの親子構造に似せたクラスです。
	 * @author katapad
	 * @version 0.1
	 * @since 2010/02/03 13:31
	 */
	dynamic public class MCGroup extends Proxy 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _mcList:Array;
		private var _props:DisplayPropsPool;
		private var _parent:DisplayObject;
		
		/**
		 * グループ化したいmcの配列を入れます。list[0]が親になります。
		 * @param	mcList
		 */
		public function MCGroup(mcList:Array) 
		{
			super();
			init(mcList);
		}
		
		/**
		 * 初期化
		 */
		private function init(mcList:Array):void 
		{
			_props = new DisplayPropsPool();
			_mcList = mcList;
			_props.add(mcList);
			_parent = mcList[0];
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
		/**
		 * 一度破棄してから、別のmcの配列で初期化します
		 * @param	mcList
		 */
		public function reset(mcList:Array):void
		{
			if (_props)
				destroy();
			init(mcList);
		}
		/**
		 * 破棄します
		 */
		public function destroy():void
		{
			_props.destroy();
			_parent = null;
			_mcList = null;
		}
		
		override flash_proxy function setProperty(name:*, value:*):void
		{
			if (String(typeof _parent[name]).toLowerCase() == "number")
			{
				var d:Number = value - _parent[name];
				for (var i:int = 1, n:int = _mcList.length; i < n; ++i) 
				{
					var mc:DisplayObject = _mcList[i];
					mc[name] += d;
				}
			}
			_parent[name] = value;
		}
		
		override flash_proxy function getProperty(name:*):*
		{
			return _parent[name];
	    }
		
		/*override flash_proxy function set x(value:Number):void
		{
			_set("x", value);
		}
		
		
		override flash_proxy function get x():Number
		{
			return _parent.x;
		}*/
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
		private function _set(name:String, value:Number):void
		{
			var d:Number = value - _parent[name];
			for (var i:int = 1, n:int = _mcList.length; i < n; ++i) 
			{
				var mc:DisplayObject = _mcList[i];
				mc[name] += d;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
	
	}
	
}
