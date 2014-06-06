/**
* @author katapad
* @version 0.1
*/

package com.katapad.text {
	//import flash.events.Event;
	//import flash.events.MouseEvent;
	
	import flash.text.TextField;

	public class ExTextField extends TextField {
		//メンバ変数
		
		//インスタンス変数
		
		/**
		 * コンストラクタ
		 * @param	x
		 * @param	y
		 * @param	width
		 * @param	height
		 */
		public function ExTextField(x:Number, y:Number, width:Number, height:Number) {
			init(x, y, width, height);
		}
		
		/**
		 * 初期化
		 */
		private function init(x:Number, y:Number, width:Number, height:Number):void {
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
		}
	}
	
}
