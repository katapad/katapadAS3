package com.katapad.test.tween 
{
	import com.greensock.TweenMax;
	import com.katapad.utils.KeyCodeUtils;
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import com.katapad.ui.CompleteKeyboard;
	
	
	/**
	 * [static] TweenMaxのスピードをマウスクリックでスローにする。スーパースロー的な。
	 * @author katapad
	 * @version 0.1
	 * @since 2008/07/30 17:01
	 * @usage
	 * <dl>
	 * 	<dt>使用できるキー</dt>
	 * 	<dd>「上下左右のアローキー」</dd>
	 * 	<dt>使用できるマウスイベント（shiftキー同時押しには対応せず）</dt>
	 * 	<dd>
	 * 		<ol>
	 * 			<li>MOUSE_DOWN</li>
	 * 			<li>DOUBLE_CLICK</li>
	 * 		</ol>
	 * 	</dd>
	 * </dl>
	 * <ol>
	 * 	<li>TweenMaxSpeedChanger.init(stage, timeScale)でステージを渡し</li>
	 * 	<li>TweenMaxSpeedChanger.start()で開始</li>
	 * 	<li>TweenMaxSpeedChanger.end()で終了。</li>
	 * </oi>
	 */
	public class TweenMaxSpeedChanger
	{
		//メンバ変数
		
		//インスタンス変数
		private static var _stage:Stage;
		private static var _isPause:Boolean = false;
		
		private static var _keyCodeList:Array = [];
		private static var _useSpaceKey:Boolean;
		
		/** MOUSE_DOWNしたときのスピード*/
		private static var _timeScale:Number;
		private static var _keyRightValue:Number = 1.5;
		private static var _keyLeftValue:Number = 0.3;
		private static var _keyDownValue:Number = 5.0;
		private static var _keyUpValue:Number = 2.5;
		
		/**
		 * コンストラクタ禁止
		 */
		public function TweenMaxSpeedChanger() 
		{
			throw new IllegalOperationError("cannot construct \"com.katapad.test.tween.TweenMaxSpeedChanger\"");
		}
		
		//--------------------------------------------------------------------------
		//
		//  public
		//
		//--------------------------------------------------------------------------
		/**
		 * 初期化. timeScale　0.5 = slow, 1.0 = normal, 2.0 = faster
		 * @param	stage
		 * @param	timeScale
		 */
		public static function init(stage:Stage, timeScale:Number = 0.1):void 
		{
			_stage = stage;
			_timeScale = timeScale;
			if (_stage) _stage.doubleClickEnabled = true;
		}
		
		public static function start(mouseOn:Boolean = true, keyOn:Boolean = true, useSpaceKey:Boolean = true):void
		{
			if (mouseOn)
				addMouseHandler();
			if (keyOn)
				addKeyBoardHandler();
			_useSpaceKey = useSpaceKey;
		}
		
		public static function end():void
		{
			removeSlowHandler();
		}
		
		//--------------------------------------------------------------------------
		//
		//  private
		//
		//--------------------------------------------------------------------------
		private static function traceProperty():void
		{
			
			trace( 
				"====== TweenMaxSpeedChanger is Pause ======\n",
				"timeScale : " + _timeScale,
				" ← :" + _keyLeftValue,
				" ↑ :" + _keyUpValue, 
				" → :" + _keyRightValue, 
				" ↓ :" + _keyDownValue
			);
			trace("can change value of arrow key. Example → 1.5　SHIFT ENTER");
		}
		
		//----------------------------------
		//  keyboard
		//----------------------------------
		private static function addKeyBoardHandler():void
		{
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			_stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}
		
		private static function keyDownHandler(event:KeyboardEvent):void 
		{
			switch (event.keyCode) 
			{
				case Keyboard.UP:
				{
					TweenMax.globalTimeScale(_keyUpValue);
					break;
				}
				case Keyboard.RIGHT:
				{
					TweenMax.globalTimeScale(_keyRightValue);
//					TweenMax.globalTimeScale = _keyRightValue;
					break;
				}
				case Keyboard.LEFT:
				{
					TweenMax.globalTimeScale(_keyLeftValue);
					break;
				}
				case CompleteKeyboard.CONTROL:
				case Keyboard.DOWN:
				{
					TweenMax.globalTimeScale(_keyDownValue);
					break;
				}
				case Keyboard.SPACE:
				{
					if (_useSpaceKey)
						pause();
					break;
				}
			}
		}
		
		private static function keyUpHandler(event:KeyboardEvent):void 
		{
			switch (event.keyCode) 
			{
				case Keyboard.UP:
				case Keyboard.RIGHT:
				case Keyboard.LEFT:
				case Keyboard.DOWN:
				case CompleteKeyboard.CONTROL:
				{
					TweenMax.globalTimeScale(1.0);
					break;
				}
			}
		}
		//----------------------------------
		//  mouse
		//----------------------------------
		private static function addMouseHandler():void
		{
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			_stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			_stage.addEventListener(MouseEvent.DOUBLE_CLICK, pause);
			_stage.doubleClickEnabled = true;
		}
		
		private static function pause(event:Event = null):void 
		{
			if (!_isPause)
			{
				TweenMax.pauseAll(); 
				traceProperty();
				inputProperty();
			}
			else
			{
				TweenMax.resumeAll();
				closeInputProperty()
			}
			
			_isPause = !_isPause;
			
		}
		
		private static function removeSlowHandler():void
		{
			_stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			_stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			TweenMax.globalTimeScale (1.0);
		}
		
		private static function mouseDownHandler(event:MouseEvent):void 
		{
			TweenMax.globalTimeScale(_timeScale);
		}
		
		private static function mouseUpHandler(event:MouseEvent):void 
		{
			TweenMax.globalTimeScale(1);
		}
		
		//----------------------------------
		//  input
		//----------------------------------
		private static function inputProperty():void
		{
			_keyCodeList = [];
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, inputKeyHandler);
		}
		
		private static function inputKeyHandler(event:KeyboardEvent):void 
		{
			trace(KeyCodeUtils.getStringKeyCodeValue(event.keyCode));
			
			if (event.keyCode == CompleteKeyboard.ENTER || event.keyCode == CompleteKeyboard.NUMPAD_ENTER)
			{
				//trace("ENTER");
				evaluateKeyCodeArray();
			}
			else
			{
				_keyCodeList.push(event.keyCode);
			}
		}
		
		private static function evaluateKeyCodeArray():void
		{
			var firstKeyValue:uint;
			var func:Function;
			switch (_keyCodeList[0]) 
			{
				case CompleteKeyboard.RIGHT:
					firstKeyValue = CompleteKeyboard.RIGHT;
					func = setKeyRightValue;
					break;
				case CompleteKeyboard.LEFT:
					firstKeyValue = CompleteKeyboard.LEFT;
					func = setKeyLeftValue;
					break;
				case CompleteKeyboard.UP:
					firstKeyValue = CompleteKeyboard.UP;
					func = setKeyUpValue;
					break;
				case CompleteKeyboard.DOWN:
					firstKeyValue = CompleteKeyboard.DOWN;
					func = setKeyDownValue;
					break;
				default :
					firstKeyValue = 999999;
					break;
			}
			if (firstKeyValue == 999999)
			{
				trace("最初のキーは矢印キーを押してください");
				_keyCodeList = [];
				return;
			}
			
			var valueList:Array = [];
			for (var i:int = 1, n:int = _keyCodeList.length; i < n; i++) 
			{
				var code:String = KeyCodeUtils.getStringKeyCodeValue(_keyCodeList[i]);
				//trace( "code : " + code );
				if (code == KeyCodeUtils.ERROR_CODE_STRING)
					valueList.push("error");
				else
					valueList.push(code);
			}
			
			if (_keyCodeList[n - 1] == CompleteKeyboard.SHIFT)
				valueList.pop();
			var numValue:Number = Number(valueList.join(""));
			//trace( "valueList.join() : " + valueList.join("") );
			//trace( "numValue : " + numValue );
			if (isNaN(numValue))
			{
				trace("惜しい！矢印の後が間違ってるよ");
			}
			else
			{
				func(numValue);
				trace("setValue : " + numValue);
			}
			
			_keyCodeList = [];
		}
		
		private static function closeInputProperty():void
		{
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, inputKeyHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
		//public static function set keyUpValue(value:Number):void 
		public static function setKeyUpValue(value:Number):void 
		{
			_keyUpValue = value;
		}
		
		//public static function set keyDownValue(value:Number):void 
		public static function setKeyDownValue(value:Number):void 
		{
			_keyDownValue = value;
		}
		
		//public static function set keyLeftValue(value:Number):void 
		public static function setKeyLeftValue(value:Number):void 
		{
			_keyLeftValue = value;
		}
		
		//public static function set keyRightValue(value:Number):void 
		public static function setKeyRightValue(value:Number):void 
		{
			_keyRightValue = value;
		}
		
		
	
	}
	
}
