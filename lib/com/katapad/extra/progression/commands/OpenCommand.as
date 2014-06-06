package com.katapad.extra.progression.commands 
{
	import com.katapad.display.api.ICoreDisplay;
	import com.katapad.display.api.ICoreSpriteHelper;
	import com.katapad.display.core.CoreDOEventName;
	import flash.events.Event;
	import jp.progression.casts.*;
	import jp.progression.commands.display.*;
	import jp.progression.commands.lists.*;
	import jp.progression.commands.net.*;
	import jp.progression.commands.tweens.*;
	import jp.progression.commands.*;
	import jp.progression.data.*;
	import jp.progression.events.*;
	import jp.progression.scenes.*;
	
	/**
	 * ...
	 * @author katapad
	 */
	public class OpenCommand extends Command 
	{
		
		private var _coreDisplay:ICoreDisplay;
		
		/**
		 * 新しい OpenCommand インスタンスを作成します。
		 */
		public function OpenCommand( coreDisplay:ICoreDisplay, initObject:Object = null ) 
		{
			// 親クラスを初期化します。
			super( _execute, _interrupt, initObject );
			_coreDisplay = coreDisplay;
		}
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void 
		{
			// 
			_coreDisplay.open();
			_coreDisplay.addEventListener(CoreDOEventName.OPEN_COMPLETE, _onOpenComplete);
		}
		
		private function _onOpenComplete(event:Event):void 
		{
			_removeEvent();
			executeComplete();
		}
		
		/**
		 * 中断されるコマンドの実装です。
		 */
		private function _interrupt():void 
		{
			_removeEvent();
		}
		
		private function _removeEvent():void
		{
			_coreDisplay.removeEventListener(CoreDOEventName.OPEN_COMPLETE, _onOpenComplete);
		}
		
		/**
		 * インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。
		 */
		public override function clone():Command 
		{
			return new OpenCommand( _coreDisplay, this );
		}
		
		public function get coreDisplay():ICoreDisplay { return _coreDisplay; }
	}
}
