/**
* @author katapad
* @version 0.1.2
* @since 2008/03/27 19:08
*/

package com.katapad.utils 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;

	public class TextFieldUtils 
	{
		
		/**
		 * like as2 method of createTextField
		 * @version 2008/03/27 18:20
		 * @return TextField
		 */
		public static function createTextField(x:Number, y:Number, width:Number, height:Number):TextField 
		{
			var result:TextField = new TextField();
			result.x = x;
			result.y = y;
			result.width = width;
			result.height = height;
			return result;
		}
		
		/**
		 * 最後を任意のテキストに置き換えて、TextFieldにあわせてトリミングします。
		 * via http://blog.nium.jp/2007/04/textfield.php
		 * @param	textField
		 * @param	endText
		 * @param	defaultFontSize
		 */
		public static function trimmingText(textField:TextField, endText:String = "…", defaultFontSize:Number = 12):void
		{
			textField.wordWrap = false;
			if (textField.maxScrollH <= 0) 
				return;
			textField.appendText(endText);
			var text:String = textField.text;
			
			//ループの回数を減らす
			if (textField.maxScrollH > defaultFontSize * 1.5)
				textField.text = text.slice(0, text.length - endText.length - 1 - Math.ceil(textField.maxScrollH / defaultFontSize)) + endText;
			while (textField.maxScrollH > 0) 
			{
				text = textField.text;
				textField.text = text.slice(0, text.length - endText.length - 1) + endText;
			}
		}
		
		/**
		 * テキストを文字数でトリミング. maxlengthを8文字指定すると、8文字プラスendTextになります。
		 * @param	text
		 * @param	maxLength
		 * @param	endText
		 * @return
		 */
		public static function trimmingTextByLength(text:String, maxLength:int = 8, endText:String = "…"):String
		{
			if (text.length > maxLength)
				text = text.slice(0, maxLength) + endText;
			return text;
		}
		
		/**
		 * テキストフィールドをセンタリングするときに使います。(X)
		 * @param	textField
		 * @param	startX
		 * @param	endX
		 * @param	isStrict	テキストフィールドの余分な大きさを考慮して、-2します。
		 */
		public static function centeringTFX(textField:TextField, startX:Number, endX:Number, isStrict:Boolean = true):void
		{
			textField.x =   (endX + startX - textField.textWidth) * 0.5;
			if (isStrict)
				textField.x -= 2;
		}
		
		/**
		 * テキストフィールドをセンタリングするときに使います。(Y)
		 * @param	textField
		 * @param	startY
		 * @param	endY
		 * @param	isStrict	テキストフィールドの余分な大きさを考慮して、-2します。
		 */
		public static function centeringTFY(textField:TextField, startY:Number, endY:Number, isStrict:Boolean = true):void
		{
			textField.y =   (endY + startY - textField.textHeight) * 0.5;
			if (isStrict)
				textField.y -= 2;
		}
		
		/**
		 * 
		 * @param	tagName
		 * @return
		 */
		public static function wrapTag(tagName:String, text:String):String
		{
			return '<' + tagName + '>' + text + '</' + tagName + '>';
		}
		/**
		 * <a>でラップします。これで拾います textField.addEventListener(TextEvent.LINK, _linkHandler);
		 * @param	text
		 * @param	eventName
		 */
		public static function htmlEventWrap(text:String, eventName:String = 'htmlClick'):String
		{
			return '<a href="event:' + eventName + '">' + text + '</a>';
		}
		
		/**
		 * defaultTextFormatでいつものセッティングをおこないます（だいたいいつも一緒なので) 
		 * @param	textField
		 * @param	fontName
		 * @param	size
		 * @param	color
		 * @return
		 */
		public static function normalSetting(textField:TextField, size:Object = null, color:Object = null, autoSize:String = "left", bold:Object = null, fontName:String = "_当幅"):TextFormat
		{
			var tFormat:TextFormat = new TextFormat(fontName, size, color, bold);
			textField.defaultTextFormat = tFormat;
			textField.autoSize = autoSize;
			return tFormat;
		}
		
		/**
		 * ノーマルセッティング2
		 * @param	tf
		 */
		public static function normalSetting2(tf:TextField, autoSize:String = 'left'):void
		{
			tf.mouseEnabled = false;
			tf.mouseWheelEnabled = false;
			tf.autoSize = autoSize;
		}
		
		/*public static function getBounds(tf:TextField):Rectangle
		{
			//var bmd:BitmapData = new BitmapData(tf.textWidth, tf.textHeight);
			
			var result:Rectangle;
			return result;
		}*/
		
		/**
		 * ラップします
		 * @param	color
		 * @param	text
		 * @return
		 */
		public static function wrapFontColor(color:int, text:String):String
		{
			return '<font color="#' + color.toString(16) + '">' + text + '</font>'
		}
		
		/**
		 * 半角何文字以内のやつ(バイト数)かどうかをかえす
		 * @param	text
		 * @param	hannkakuMaxLength
		 * @return
		 */
		public static function isStringWithInCount(text:String, hannkakuMaxLength:int = 60):Boolean
		{
			var byteArray:ByteArray = new ByteArray();
			byteArray.writeMultiByte(text, "shift_jis");  
			return byteArray.length <= hannkakuMaxLength
		}
		
		/**
		 * 太字にするだけ
		 * @param	textField
		 */
		public static function setBold(textField:TextField):void
		{
			var format:TextFormat = textField.getTextFormat();
			format.bold = true;
			textField.defaultTextFormat = format;
		}
		
		/**
		 * スタティッククラスなのでインスタンス化はしない
		 */
		public function TextFieldUtils() {
			throw new Error("TextFieldUtils is cannot instantiation");
		}
	}
	
}
