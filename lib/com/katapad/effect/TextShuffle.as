package com.katapad.effect 
{
	import com.katapad.utils.StringUtils;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	/**
	 * Text Shuffle クラス。
	 * @author katapad
	 * @version 0.1
	 * @since 2008/09/28 23:50
	 */
	public class TextShuffle extends EventDispatcher 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		public static const EVENT_UPDATE:String = "update";
		
		public static const CHAR_ALL:uint = 0xf;
		public static const CHAR_ALPHABET_UPPER:uint = 8;
		public static const CHAR_ALPHABET_LOWER:uint = 4;
		public static const CHAR_SIGN:uint = 2;
		public static const CHAR_NUMBER:uint = 1;
		public static const CHAR_ALPHABET_ALL:uint = 12;
		
		private static const TABLE_ALPHABET_UPPER:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		private static const TABLE_ALPHABET_LOWER:String = "abcdefghijklmnopqrstuvwxyz";
		private static const TABLE_HIRAGANA:String = "あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをんがぎぐげござじずぜぞだぢづでどばびぶべぼぱぴぷぺぽぁぃぅぇぉゃゅょっ";
		private static const TABLE_KATAKANA:String = "アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲンガギグゲゴザジズゼゾダヂヅデドバビブベボパピプペポァィゥェォャュョッ";
		private static const TABLE_SIGN:String = "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~";
		private static const TABLE_NUMBER:String = "0123456789";
		
		/**
		 * シャッフルが終わったら送出します。
		 * @eventType flash.events.Event.COMPLETE
		 */
		[Event(name="complete", type="flash.events.Event")]
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _targetTF:TextField;
		private var shuffleTextTable:String;
		/** シャッフルするタイプ*/
		private var _shuffleType:uint;
		/** オリジナルの文字列 */
		private var _displayText:String;
		/** pointerとなる文字列 */
		private var _pointerText:String;
		/** シャッフルさせる文字数 */
		private var _renderNum:uint;
		/** pointerとなる文字数 */
		private var _pointerNum:uint;
		
		private var _manualMode:Boolean;
		
		private var _index:int;
		private var _timer:Timer;
		private var _autoFixWidth:Boolean;
		
		/**
		 * コンストラクタ
		 * @param	targetTF	ターゲットとなるテキストフィールド
		 * @param	shuffleType	シャッフルする文字を何にするかのタイプ
		 * @param	pointerText	ポインターになる文字列
		 * @param	renderNum	シャッフル文字列の数
		 * @param	pointerNum	ポインターの文字列の数
		 * @param	autoFixWidth	文字が溢れたときにtextWidthを自動で伸ばすかどうか
		 * @see	text2ShuffleTypeHex
		 */
		public function TextShuffle(targetTF:TextField, shuffleType:uint = TextShuffle.CHAR_ALL, pointerText:String = "_", renderNum:uint = 3, pointerNum:uint = 2, autoFixWidth:Boolean = true) 
		{
			init(targetTF, shuffleType, pointerText, renderNum, pointerNum, autoFixWidth);
		}
		
		/**
		 * 初期化
		 */
		private function init(targetTF:TextField, shuffleType:uint, pointerText:String, renderNum:uint, pointerNum:uint, autoFixWidth:Boolean):void 
		{
			_targetTF = targetTF;
			this.shuffleType = shuffleType;
			_displayText = _targetTF.text;
			_pointerText = pointerText;
			_renderNum = renderNum;
			_pointerNum = pointerNum;
			_autoFixWidth = autoFixWidth;
			_manualMode = false;
			_timer = new Timer(100);
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
		 * shuffleTypeがよくわからなくなったら使おう。[A, a, 記号, 数字] "1111"を引数に入れると0xfが返ってくる。
		 * new TextShuffle(hogeTF, TextShuffle.text2ShuffleTypeHex("1011"));
		 * @param	value
		 * @return
		 */
		public static function text2ShuffleTypeHex(value:String):uint
		{
			return parseInt(value, 2);
		}
		
		/**
		 * とめるだけ
		 */
		public function stop():void
		{
			reset();
		}
		
		/**
		 * インスタンスを削除するときはこれを使ってから
		 */
		public function destroy():void
		{
			reset();
			_targetTF = null;
			_timer = null;
		}
		
		/**
		 * シャッフルしながら表示します。
		 * @param	replaceText nullだとオリジナルを表示します。
		 * @param	timerDelay ミリ秒。
		 */
		public function shuffleIn(replaceText:String = null, timerDelay:Number = 30):void
		{
			reset();
			initShuffle(replaceText, timerDelay);
			_targetTF.text = "";
			_index = - _pointerNum - _renderNum;
			
			_targetTF.addEventListener(Event.ENTER_FRAME, shuffle);
			_timer.addEventListener(TimerEvent.TIMER, incrementIndex);
			_timer.start();
		}
		
		/**
		 * シャッフルしながら文字を消します
		 * @param	timerDelay ミリ秒。
		 */
		public function shuffleOut(timerDelay:Number = 30):void
		{
			reset();
			_index = _displayText.length;
			_timer.delay = timerDelay;
			
			_targetTF.addEventListener(Event.ENTER_FRAME, shuffleOutProc);
			_timer.addEventListener(TimerEvent.TIMER, decrementIndex);
			_timer.start();
		}
		
		/**
		 * すべてのテキストをシャッフルしますが、イメージどおりにするにはロジックをもうひとつ作る必要がある
		 * @param	replaceText
		 * @param	timerDelay
		 */
		public function fullShuffleIn(replaceText:String = null, timerDelay:Number = 30):void
		{
			reset();
			initShuffle(replaceText, timerDelay);
			_targetTF.text = "";
			_renderNum = _displayText.length;
			_pointerNum = 0;
			_index = 0;
			
			_targetTF.addEventListener(Event.ENTER_FRAME, shuffle);
			_timer.addEventListener(TimerEvent.TIMER, incrementIndex);
			_timer.start();
		}
		/**
		 * マニュアルモードで操作します。TextShuffle.indexを操作することで、任意の位置でシャッフルできます。
		 * 終了するときはmanualShuffleOff()を呼んでください。
		 * @param	replaceText
		 * @param	timerDelay
		 * @see #manualShuffleOff
		 */
		public function manualShuffleOn(replaceText:String = null, timerDelay:Number = 30):void
		{
			reset();
			initShuffle(replaceText, timerDelay);
			_manualMode = true;
			_targetTF.text = "";
			_index = - _pointerNum - _renderNum;
			_targetTF.addEventListener(Event.ENTER_FRAME, shuffle);
		}
		
		public function manualShuffleOff():void
		{
			reset();
		}
		
		private function initShuffle(replaceText:String = null, timerDelay:Number = 30):void
		{
			_displayText = replaceText || _displayText;
			_timer.delay = timerDelay;
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
		private function incrementIndex(event:TimerEvent):void 
		{
			_index++;
		}
		
		private function decrementIndex(event:TimerEvent):void 
		{
			_index--;
		}

		private function shuffle(event:Event):void 
		{
			if (_displayText.length  <= _index - 1)
			{
				_targetTF.text = _displayText;
				if (!_manualMode)
					end();
				return;
			}
			
			var str:String = "";
			str = getRandomCharSet(str);
			str = getPointerText(str);
			
			var result:String;
			if (_index > 0)
				result = _displayText.substr(0, _index) + str;
			else
				result = str.slice((_index + _pointerNum + _renderNum) * -1 - 1, str.length);
			
			if (result.length > _displayText.length)
				result = result.substr(0, _displayText.length);
			_targetTF.text = result;
			if (autoFixWidth && _targetTF.maxScrollH)
				_targetTF.width += _targetTF.maxScrollH;
				
			dispatchEvent(new Event(TextShuffle.EVENT_UPDATE));
		}
		
		private function shuffleOutProc(event:Event):void 
		{
			if (_index <= - _pointerNum - _renderNum - 1)
			{
				_targetTF.text = "";
				end();
				return;
			}
			
			//TODO 自動で縮めたいのだけどわからん @2009/01/20 21:22 - kakehashi
			
			var str:String = "";
			str = getRandomCharSet(str);
			str = getPointerText(str);
			
			var result:String;
			if (_index > 0)
				result = _displayText.substr(0, _index) + str;
			else
			{
				var sliceIndex:int = (_index + _pointerNum + _renderNum) * -1;
				if (sliceIndex == 0)
					result = "";
				else
					result = str.slice(sliceIndex, str.length);
			}
			
			if (result.length > _displayText.length)
				result = result.substr(0, _displayText.length);
			_targetTF.text = result;
			
			dispatchEvent(new Event(TextShuffle.EVENT_UPDATE));
		}

		/**
		 * 自分で作ったテーブルをわたす
		 *
		 * */
		public function setShuffleTextTable(str:String):void
		{
			shuffleTextTable = str;
		}
		
		//--------------------------------------------------------------------------
		//
		//  PRIVATE
		//
		//--------------------------------------------------------------------------
		private function setupShuffleTextTable():void
		{
			var type:String = StringUtils.zeroPaddingStr(_shuffleType.toString(2), 4);
			shuffleTextTable = "";
			if (type.charAt(0) == "1")
				shuffleTextTable += TABLE_ALPHABET_UPPER;
			if (type.charAt(1) == "1")
				shuffleTextTable += TABLE_ALPHABET_LOWER;
			if (type.charAt(2) == "1")
				shuffleTextTable += TABLE_SIGN;
			if (type.charAt(3) == "1")
				shuffleTextTable += TABLE_NUMBER;
		}
		
		private function getRandomCharSet(str:String):String
		{
			if (_renderNum == 0)
				return str;
			for (var i:int = 0; i < _renderNum; i++) 
			{
				str = str + getRandomChar();
			}
			return str;
		}
		
		private function getPointerText(str:String):String
		{
			if (_pointerNum == 0)
				return str;
			for (var i:Number = 0, n:Number = _pointerNum; i < n; i++) 
			{
				str = str + _pointerText;
			}
			return str;
		}
		
		private function getRandomChar():String
		{
			return shuffleTextTable.charAt(Math.round(Math.random() * shuffleTextTable.length));
		}
		
		private function end():void
		{
			reset();
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function removeAllEvents():void
		{
			_targetTF.removeEventListener(Event.ENTER_FRAME, shuffle);
			_targetTF.removeEventListener(Event.ENTER_FRAME, shuffleOutProc);
			_timer.removeEventListener(TimerEvent.TIMER, incrementIndex);
			_timer.removeEventListener(TimerEvent.TIMER, decrementIndex);
		}
		
		private function reset():void
		{
			_manualMode = false;
			_timer.stop();
			removeAllEvents();
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
		public function get pointerNum():uint { return _pointerNum; }
		public function set pointerNum(value:uint):void 
		{
			_pointerNum = value;
		}
		
		public function get renderNum():uint { return _renderNum; }
		public function set renderNum(value:uint):void 
		{
			_renderNum = value;
		}
		
		public function get pointerText():String { return _pointerText; }
		public function set pointerText(value:String):void 
		{
			_pointerText = value;
		}
		
		public function get shuffleType():uint { return _shuffleType; }
		/**
		 * A, a, 記号, 数字　の順番の2進数複数フラグ。
		 * 0x1～0xfまで
		 */
		public function set shuffleType(value:uint):void 
		{
			if (value <= 0 || 0xf < value) 
			{
				throw new Error("shuffleTypeの値が不正です。 CHAR_ALLに変換されます");
				value = CHAR_ALL;
			}
			_shuffleType = value;
			setupShuffleTextTable();
		}
		
		public function get autoFixWidth():Boolean { return _autoFixWidth; }
		
		public function set autoFixWidth(value:Boolean):void 
		{
			_autoFixWidth = value;
		}
		
		public function get index():int { return _index; }
		
		public function set index(value:int):void 
		{
			if (!_manualMode)
				throw new Error("manualでシャッフルしてください");
			_index = value;
		}
	}
}
