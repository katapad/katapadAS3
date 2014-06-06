package com.katapad.clock 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ClockModel EnterFrameで時間を監視し、時計を更新します
	 * @usage
	 * <ol>
	 * 	<li>initでenterframeを取れるものを渡します。通常はstageを渡します。</li>
	 * 	<li>init後に時間が取得できるので、clockModel.hなどから取得し、viewの初期表示に当ててください</li>
	 * 	<li>startするとClockEventを配信します</li>
	 * </ol>
	 * <p>ClockEventから取得できる値はゼロパディングされた文字列・int・時計の針の角度が取れます</p>
	 * <pre>
	 * _clockModel  = ClockModel.getInstance();
	 * _clockModel.addEventListener(ClockEvent.HOUR_CHANGE, hourHandler);
	 * _clockModel.addEventListener(ClockEvent.MINUTE_CHANGE, minuteHandler);
	 * _clockModel.addEventListener(ClockEvent.SECOND_CHANGE, secondHandler);
	 * 
	 * if (!_clockModel.isStart)
	 * {
	 * 		_clockModel.init(StStage.stage);
	 * 		_clockModel.start();
	 * }
	 * </pre>
	 * @author katapad
	 * @version 0.1.1
	 * @since 2009/02/13 20:23
	 */
	
	public class ClockModel extends EventDispatcher 
	{
		/**
		 * hourの更新
		 * @eventType com.katapad.clock.ClockEvent.HOUR_CHANGE
		 */
		[Event(name = "hour_change", type = "com.katapad.clock.ClockEvent")]
		/**
		 * minuteの更新
		 * @eventType com.katapad.clock.ClockEvent.MINUTE_CHANGE
		 */
		[Event(name = "minute_change", type = "com.katapad.clock.ClockEvent")]
		/**
		 * secondsの更新
		 * @eventType com.katapad.clock.ClockEvent.SECOND_CHANGE
		 */
		[Event(name = "second_change", type = "com.katapad.clock.ClockEvent")]
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _enterFrame:DisplayObject;
		private var _date:Date;
		private var _isStart:Boolean;
		
		private var _h:String;
		private var _m:String;
		private var _s:String;
		
		private var _isInit:Boolean;
		
		private static var _instance:ClockModel;
		/**
		 * getInstance
		 */
		public static function getInstance():ClockModel
		{
			if (_instance == null) 
				_instance = new ClockModel();
			return _instance;
		}
		
		/**
		 * コンストラクタ
		 */
		public function ClockModel() 
		{
			_isInit = false;
		}
		
		/**
		 * 初期化
		 */
		public function init(enterFrame:DisplayObject):void 
		{
			_enterFrame = enterFrame;
			_date = new Date();
			changeProperty();
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
		public function start():void
		{
			if (!_isInit)
				throw new Error("[CloclModel] initしてください");
			if (_isStart)
				return;
			changeProperty();
			procTimer(null);
			_enterFrame.addEventListener(Event.ENTER_FRAME, procTimer);
			_isStart = true;
		}
		
		public function stop():void
		{
			if (!_isStart)
				return;
			_enterFrame.removeEventListener(Event.ENTER_FRAME, procTimer);
			_isStart = false;
		}
		
		public function destroy():void
		{
			stop();
			_enterFrame = null;
			_date = null;
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
		private function procTimer(event:Event):void 
		{
			_date = new Date();
			compare();
		}
		
		//--------------------------------------------------------------------------
		//
		//  PRIVATE
		//
		//--------------------------------------------------------------------------
		private function compare():void
		{
			if (!isChange(_s, zeroPadding(_date.getSeconds())))
				return;
			
			var oldH:String = _h;
			var oldM:String = _m;

			changeProperty();
			dispatchChange(ClockEvent.SECOND_CHANGE);
			
			if (isChange(oldH, _h))
				dispatchChange(ClockEvent.HOUR_CHANGE);
			if (isChange(oldM, _m))
				dispatchChange(ClockEvent.MINUTE_CHANGE);

		}
		
		private function dispatchChange(eventName:String):void
		{
			dispatchEvent(new ClockEvent(eventName, _h, _m, _s));
		}
		
		private function isChange(oldValue:String, newValue:String):Boolean
		{
			return oldValue != newValue;
		}
		
		private function changeProperty():void
		{
			_h = zeroPadding(_date.getHours());
			_m = zeroPadding(_date.getMinutes());
			_s = zeroPadding(_date.getSeconds());
		}
		
		private function zeroPadding(value:Number):String
		{
			var result:String = String(value);
			if (result.length < 2)
				result = "0" + result;
			return result;
		}
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
		/** ゼロパディングされたStringでの「hour」です*/
		public function get h():String { return _h; }
		
		/** ゼロパディングされたStringでの「minute」です*/
		public function get m():String { return _m; }
		
		/** ゼロパディングされたStringでの「second」です*/
		public function get s():String { return _s; }
		
		public function get isStart():Boolean { return _isStart; }
		
		public function get isInit():Boolean { return _isInit; }
	
	}
	
}
