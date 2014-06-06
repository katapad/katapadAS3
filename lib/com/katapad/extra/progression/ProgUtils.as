package com.katapad.extra.progression 
{
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	import jp.progression.Progression;
	import jp.progression.scenes.getSceneBySceneId;
	import jp.progression.scenes.SceneId;
	import jp.progression.scenes.SceneObject;
	
	/**
	 * Progressionのユーティリティ
	 * @author katapad
	 * @version 0.1
	 * @since 2010/03/09 20:53
	 */
	public class ProgUtils 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private static var _siblingDict:Dictionary;
		private static var _manager:Progression;
		private static var _isInit:Boolean = false;
		
		/**
		 * コンストラクタ
		 */
		public function ProgUtils() 
		{
			throw new IllegalOperationError("ProgUtils cannot construct");
		}
		
		
		public static function init(manager:Progression):void 
		{
			_manager = manager;
			_isInit = true;
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
		 * 兄弟シーンを登録します
		 * @param	groupName
		 * @param	sceneIDList
		 */
		public static function addSibling(groupName:String, sceneIDList:/*SceneId*/Array):void
		{
			if (_sibDict[groupName])
				throw new Error(groupName + "が重複しています");
			
			_siblingDict[groupName] = sceneIDList;
		}
		
		/**
		 * Departed と Destinedが兄弟シーンかどうかを判別します
		 * @param	groupName
		 * @param	manager initしていたら必要ありません。
		 * @return
		 */
		public static function isSibling(groupName:String, manager:Progression = null):Boolean
		{
			if (!_sibDict[groupName])
				throw new Error(groupName + "が存在しません");
			
			manager = manager || _manager;
			
			var sceneIDList:/*SceneId*/Array = _sibDict[groupName];
			
			var departedSceneId:SceneId = manager.departedSceneId;
			var destinedSceneId:SceneId = manager.destinedSceneId;
			var result:int = 0;
			for each(var id:SceneId in sceneIDList) 
			{
				if (departedSceneId == id || destinedSceneId == id)
				{
					++result;
					continue;
				}
			}
			
			return result == 2;
		}
		
		/**
		 * departedSceneId と destinedSceneId のSceneObjectのgroupが同じかどうかを調べます
		 * @param	groupName
		 * @param	manager
		 * @return
		 */
		public static function isSameGroupDepartedAndDestined(groupName:String, manager:Progression = null):Boolean
		{
			manager = manager || _manager;
			if (SceneId.isNaS(manager.departedSceneId))
				return false;
			return getSceneBySceneId(manager.departedSceneId).group == getSceneBySceneId(manager.destinedSceneId).group;
		}
		
		/**
		 * 子どものシーンにgotoします
		 * @param	index
		 */
		public static function gotoChild(parent:SceneObject, index:int = 0, manager:Progression = null):void
		{
			manager = manager || _manager;
			manager.goto(parent.getSceneAt(index).sceneId);
		}
		
		/**
		 * 上階層から飛んできたかどうか
		 * @param	manager
		 */
		public static function isFromHead(manager:Progression = null):Boolean
		{
			manager = manager || _manager;
			return manager.departedSceneId.contains(manager.destinedSceneId);
		}
		
		/**
		 * 下階層から来たかどうか
		 * @param	manager
		 */
		public static function isFromBottom(manager:Progression = null):Boolean
		{
			manager = manager || _manager;
			return manager.destinedSceneId.contains(manager.departedSceneId);
		}
		
		/**
		 * 下階層へいくかどうか
		 * @param	manager
		 * @return
		 */
		public static function isGotoBottom(manager:Progression = null):Boolean
		{
			manager = manager || _manager;
			return manager.departedSceneId.contains(manager.destinedSceneId);
		}
		
		/**
		 * 上階層へ行くかどうか
		 * @param	manager
		 * @return
		 */
		public static function isGotoHead(manager:Progression = null):Boolean
		{
			manager = manager || _manager;
			return manager.departedSceneId.contains(manager.destinedSceneId);
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
		private static function get _sibDict():Dictionary
		{
			if (!_siblingDict)
				_siblingDict = new Dictionary();
			return _siblingDict;
		}
		
		static public function get isInit():Boolean { return _isInit; }
		
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
	
	}
	
}
