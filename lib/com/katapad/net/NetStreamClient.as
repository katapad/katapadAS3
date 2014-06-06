package com.katapad.net 
{
	import com.katapad.event.NetStreamEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	//import flash.events.Event;
	//import flash.events.MouseEvent;
	
	import caurina.transitions.Tweener;
	//import
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2008/08/04 21:22
	 */
	public class NetStreamClient extends EventDispatcher
	{
		//メンバ変数
		
		//インスタンス変数
		private var _duration:Number;
		
		/**
		 * コンストラクタ
		 */
		public function NetStreamClient() 
		{
			init();
		}
		
		/**
		 * 初期化
		 */
		private function init():void 
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		/**
		 * このイベントは、NetStream.play() メソッドの呼び出し後、ただしビデオ再生ヘッドが進むよりは前にトリガされます。
		 * @param	info
		 */
		public function onMetaData(info:Object):void
		{
			trace( "onMetaData : " );
			dispatchEvent(new NetStreamEvent(NetStreamEvent.METADATA_RECEIVED, info));
			_duration = info.duration;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/**
		 * onCuePointイベント。infoObjectのキーはparameters, name, time, type]
		 * @param	info
		 */
		public function onCuePoint(info:Object):void
		{
			trace( "onCuePoint : " );
			dispatchEvent(new NetStreamEvent(NetStreamEvent.CUE_POINT, info));
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
		public function get duration():Number { return _duration; }
		
	}
	
}
