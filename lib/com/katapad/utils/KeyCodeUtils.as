package com.katapad.utils 
{
	import com.katapad.ui.CompleteKeyboard;
	import flash.ui.Keyboard;
	
	/**
	 * keyCodeによるswitch被害を拡大させないための防波堤
	 * @author katapad
	 * @version 0.1
	 * @since 2008/08/23 19:16
	 */
	public class KeyCodeUtils 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		public static const ERROR_CODE_UINT:uint = 999999999;
		public static const ERROR_CODE_STRING:String = "999999999";
		public static const RIGHT:String = "→";
		public static const LEFT:String = "←";
		public static const UP:String = "↑";
		public static const DOWN:String = "↓";
		/**
		 * コンストラクタ禁止
		 */
		public function KeyCodeUtils() 
		{
			
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
		 * 押されたキーの文字を返す
		 * @param	keyCode
		 * @return
		 */
		public static function getStringKeyCodeValue(keyCode:uint):String
		{
			var result:String;
			switch (keyCode) 
			{
				case CompleteKeyboard.A:
					result = "A";
					break;
				case CompleteKeyboard.B:
					result = "B";
					break;
				case CompleteKeyboard.C:
					result = "C";
					break;
				case CompleteKeyboard.D:
					result = "D";
					break;
				case CompleteKeyboard.E:
					result = "E";
					break;
				case CompleteKeyboard.F:
					result = "F";
					break;
				case CompleteKeyboard.G:
					result = "G";
					break;
				case CompleteKeyboard.H:
					result = "H";
					break;
				case CompleteKeyboard.I:
					result = "I";
					break;
				case CompleteKeyboard.J:
					result = "J";
					break;
				case CompleteKeyboard.K:
					result = "K";
					break;
				case CompleteKeyboard.L:
					result = "L";
					break;
				case CompleteKeyboard.M:
					result = "M";
					break;
				case CompleteKeyboard.N:
					result = "N";
					break;
				case CompleteKeyboard.O:
					result = "O";
					break;
				case CompleteKeyboard.P:
					result = "P";
					break;
				case CompleteKeyboard.Q:
					result = "Q";
					break;
				case CompleteKeyboard.R:
					result = "R";
					break;
				case CompleteKeyboard.S:
					result = "S";
					break;
				case CompleteKeyboard.T:
					result = "T";
					break;
				case CompleteKeyboard.U:
					result = "U";
					break;
				case CompleteKeyboard.V:
					result = "V";
					break;
				case CompleteKeyboard.W:
					result = "W";
					break;
				case CompleteKeyboard.X:
					result = "X";
					break;
				case CompleteKeyboard.Y:
					result = "Y";
					break;
				case CompleteKeyboard.Z:
					result = "Z";
					break;
				
				case CompleteKeyboard.NUMPAD_DECIMAL:
				case CompleteKeyboard.PERIOD:
					result = ".";
					break;
				case CompleteKeyboard.MINUS:
				case CompleteKeyboard.NUMPAD_SUBTRACT:
					result = "-";
					break;
				case CompleteKeyboard.NUMPAD_DIVIDE:
				case CompleteKeyboard.SLASH:
					result = "/";
					break;
				case CompleteKeyboard.NUMPAD_MULTIPLY:
					result = "*";
					break;
				case CompleteKeyboard.NUMPAD_ADD:
					result = "+";
					break;
				
				/*case CompleteKeyboard.A:
					result = "A";
					break;
				case CompleteKeyboard.A:
					result = "A";
					break;
				case CompleteKeyboard.A:
					result = "A";
					break;
				case CompleteKeyboard.A:
					result = "A";
					break;*/
				default: 
					result = ERROR_CODE_STRING;
					break;
			}
			
			if (result == ERROR_CODE_STRING)
				result = getArrowStringByKeyCode(keyCode);
				
			if (result == ERROR_CODE_STRING)
				result = String(getNumberKeyByKeyCode(keyCode));
				
			return result;
		}
		
		/**
		 * 矢印キーだったら矢印文字を返す
		 * @param	keyCode
		 * @return
		 */
		public static function getArrowStringByKeyCode(keyCode:uint):String
		{
			var result:String;
			switch (keyCode) 
			{
				case CompleteKeyboard.RIGHT:
					result = RIGHT;
					break;
				case CompleteKeyboard.LEFT:
					result = LEFT;
					break;
				case CompleteKeyboard.UP:
					result = UP;
					break;
				case CompleteKeyboard.DOWN:
					result = DOWN;
					break;
				default:
					result = ERROR_CODE_STRING;
					break;
			}
			return result;
		}
		
		
		/**
		 * 押された数字キーの数字をuintで返す
		 * @param	keyCode
		 * @return
		 */
		public static function getNumberKeyByKeyCode(keyCode:uint):uint
		{
			var result:uint;
			switch (keyCode) 
			{
				case CompleteKeyboard.NUMBER_0:
				case CompleteKeyboard.NUMPAD_0:
					result = 0;
					break;
				case CompleteKeyboard.NUMBER_1:
				case CompleteKeyboard.NUMPAD_1:
					result = 1;
					break;
				case CompleteKeyboard.NUMBER_2:
				case CompleteKeyboard.NUMPAD_2:
					result = 2;
					break;
				case CompleteKeyboard.NUMBER_3:
				case CompleteKeyboard.NUMPAD_3:
					result = 3;
					break;
				case CompleteKeyboard.NUMBER_4:
				case CompleteKeyboard.NUMPAD_4:
					result = 4;
					break;
				case CompleteKeyboard.NUMBER_5:
				case CompleteKeyboard.NUMPAD_5:
					result = 5;
					break;
				case CompleteKeyboard.NUMBER_6:
				case CompleteKeyboard.NUMPAD_6:
					result = 6;
					break;
				case CompleteKeyboard.NUMBER_7:
				case CompleteKeyboard.NUMPAD_7:
					result = 7;
					break;
				case CompleteKeyboard.NUMBER_8:
				case CompleteKeyboard.NUMPAD_8:
					result = 8;
					break;
				case CompleteKeyboard.NUMBER_9:
				case CompleteKeyboard.NUMPAD_9:
					result = 9;
					break;
				default :
					result = KeyCodeUtils.ERROR_CODE_UINT;
					break;
			}
			//if (result == KeyCodeUtils.ERROR_CODE_UINT)
				//throw new Error("入力されたkeyCodeがnumber以外です。")
			return result;
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
	
	}
	
}
