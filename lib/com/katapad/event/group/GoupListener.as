package com.katapad.event.group 
{
	import com.katapad.event.group.GroupEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * イベントのグループ化
	 * @author katapad
	 * @version 0.2
	 * @since 2008/07/31
	 * @usage
	 * <h3>使い方の流れ</h3>
	 * <ol>
	 *  	<li>GroupListenerをインスタンス化します。</li>
	 * 		<li>addEventGroup()にグループ化したいをイベント登録します。</li>
	 * 		<li>GroupListenerインスタンスのaddEventListenerにグループイベントをすべて受け取ったときのリスナーを登録します。</li>
	 * 	</ol>
	 * 	<pre>
	 * 	var group:GoupListener = new GoupListener();
	 * 	group.addEventGroup(this._imgLoader, Event.COMPLETE);
	 * 	group.addEventGroup(this._swfLoader, Event.COMPLETE);
	 * 	group.addEventListener(Event.COMPLETE, groupCompleteHandler);
	 * 	</pre>
	 * <p>登録したイベントをグループから解除することもできますが、そのイベントが終了している可能性もあります。そうするとうまくイベントを取れなくなる可能性があるので、注意してください。</p>
	 * <p>キャンセルするにはdestroyするほうが好ましいです。</p>
	 */
	public class GoupListener extends EventDispatcher 
	{
		//メンバ変数
		
		//インスタンス変数
		/**
		 * 登録されたイベントのリスト。
		 */
		private var _eventList:Array;
		private var _completeList:Array;
		private var _count:uint = 0;
		private var _useGroupEvent:Boolean = false;
		/**
		 * 一回聞いたら自動で死ぬようにするか
		 */
		private var _use1Time:Boolean = true;
		
		/**
		 * コンストラクタ
		 * @param	isSoonAddEvent	addと同時にイベントリスンするかどうか
		 * @param	useGroupEvent	GroupEventクラスを使うかどうか。使うと溜め込んだeventインスタンスの配列を受け取れます
		 */
		public function GoupListener(use1Time:Boolean = true, useGroupEvent:Boolean = false) 
		{
			init(use1Time, useGroupEvent);
		}
		
		/**
		 * 初期化
		 * @param	isSoonAddEvent
		 * @param	useGroupEvent
		 */
		private function init(use1Time:Boolean, useGroupEvent:Boolean):void 
		{
			_useGroupEvent = useGroupEvent;
			_use1Time = use1Time;
			_eventList = [];
			_completeList = [];
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		/**
		 * グループ化したいイベントを登録していきます。
		 * @param	target		イベントをリスンしたいターゲット
		 * @param	eventType	Eventのtype
		 * @param	id			[option]個別のidをつけたいときに使用してください。idの多重登録はチェックしません。
		 * @return	count		個別の通し番号が返されます。
		 */
		public function addEventGroup(target:EventDispatcher, eventType:String, id:String = null):String
		{
			//target.addEventListener(eventType, addComplete);
			_eventList.push([target, eventType, id, _count]);
			return String(_count++);
		}
		
		/**
		 * removeすることができるが、addした後にcompleteを受け取るとおかしくなります。
		 * @param	target
		 * @param	eventType
		 */
		public function removeEventGroup(target:EventDispatcher, eventType:String):void
		{
			target.removeEventListener(eventType, addComplete);
			removeByTargetAndType(target, eventType);
		}
		
		/**
		 * グループイベントのリスンを開始します。
		 */
		public function start():void
		{
			for (var i:int = 0, n:int = _eventList.length; i < n; i++) 
			{
				EventDispatcher(_eventList[i][0]).addEventListener(_eventList[i][1], addComplete);
			}
		}
		/**
		 * イベントをすべて
		 */
		public function stop():void
		{
			removeAll();
		}
		
		public function destroy():void
		{
			removeAll();
			_eventList = null;
			_completeList = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  PRIVATE
		//
		//--------------------------------------------------------------------------
		private function addComplete(event:Event):void 
		{
			removeEventByCompleteEventTarget(EventDispatcher(event.currentTarget), event.type);
			_completeList.push(event);
			if (_eventList.length == _completeList.length)
				dispatch();
		}
		
		private function removeEventByCompleteEventTarget(eventTarget:EventDispatcher, eventType:String):void
		{
			var target:EventDispatcher = checkTarget(eventTarget, eventType);
			if (target)
				eventTarget.removeEventListener(eventType, addComplete);
		}
		
		private function dispatch():void
		{
			if (!_useGroupEvent)
				dispatchEvent(new Event(Event.COMPLETE));
			else
				dispatchEvent(new GroupEvent(GroupEvent.GROUP_COMPLETE, _eventList));
			
			if (_use1Time)
				destroy();
		}
		
		private function removeByTargetAndType(target:EventDispatcher, eventType:String):void
		{
			for (var i:int = 0, n:int = _eventList.length; i < n; i++) 
			{
				if (_eventList[i][0] == target && _eventList[i][1] == eventType)
				{
					_eventList.splice(i, 1);
					break;
				}
			}
		}
		
		/**
		 * 受け取ったeventTargetとeventListと照合して、一致すれば返す。
		 * @param	target
		 * @param	eventType
		 * @return
		 */
		private function checkTarget(target:EventDispatcher, eventType:String):EventDispatcher
		{
			for (var i:int = 0, n:int = _eventList.length; i < n; i++) 
			{
				if (_eventList[i][0] == target && _eventList[i][1] == eventType)
				{
					return target;
					break;
				}
			}
			//なければ
			return null;
		}
		
		private function removeAll():void
		{
			for (var i:int = 0, n:int = _eventList.length; i < n; i++) 
			{
				EventDispatcher(_eventList[i][0]).removeEventListener(_eventList[i][1], addComplete);
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
	
	}
	
}
