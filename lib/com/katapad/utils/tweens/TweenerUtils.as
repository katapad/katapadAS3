package com.katapad.utils.tweens 
{
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.*;
	import flash.errors.IllegalOperationError;
	import sketchbook.external.tweener.MatrixShortcuts;
	/**
	 * Tweenerに特殊プロパティを追加したりなんかしたり。
	 * @author katapad
	 * @version 0.1
	 * @since 2008/11/04 2:12
	 */
	public class TweenerUtils 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		//private static var _isInit:Boolean = false;
		private static var _color:Boolean = false;
		private static var _display:Boolean = false;
		private static var _curve:Boolean = false;
		private static var _filter:Boolean = false;
		private static var _sound:Boolean = false;
		private static var _text:Boolean = false;
		private static var _matrix:Boolean = false;
		
		
		private static var _callerProps:Object = { time: 0.0, transition: "linear"};
		//----------------------------------
		//  instance var 
		//----------------------------------
		//private var
		
		/**
		 * コンストラクタ
		 */
		public function TweenerUtils() 
		{
			new IllegalOperationError("TweenerUtilsクラスはインスタンス化できません");
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
		 * ショートカット類を一気に登録します。
		 * @param	color	:ColorShortcuts
		 * @param	display	:DisplayShortcuts
		 * @param	curve	:CurveModifiers
		 * @param	filter	:FilterShortcuts
		 * @param	sound	:SoundShortcuts
		 * @param	text	:TextShortcuts
		 * @param	matrix	:MatrixShortcuts
		 */
		public static function registerSpecialProperties(color:Boolean = true, display:Boolean = true, curve:Boolean = false, filter:Boolean = false, sound:Boolean = false, text:Boolean = false, matrix:Boolean = false):void 
		{
			TweenerUtils.color = color;
			TweenerUtils.display = display;
			TweenerUtils.curve = curve;
			TweenerUtils.filter = filter;
			TweenerUtils.sound = sound;
			TweenerUtils.text = text;
			TweenerUtils.matrix = matrix;
		}
		
		/**
		 * 配列に基づいてTweener.removeTweensします。
		 * @param	tweensList : Array　tweenさせてるobjectの配列
		 */
		public static function removeTweensByArray(tweensList:Array):void
		{
			for (var i:int = 0, n:int = tweensList.length; i < n; i++) 
			{
				Tweener.removeTweens(tweensList[i]);
			}
		}
		
		/**
		 * コールのショートカット
		 * @param	scope
		 * @param	func
		 * @param	params
		 * @param	delayTime
		 */
		public static function caller(scope:*, func:Function, params:Array, delayTime:Number = 0.0):void
		{
			Tweener.addTween(scope, { base: _callerProps, delay: delayTime, onComplete: func, onCompleteScope: scope, onCompleteParams: params});
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
		public static function get color():Boolean { return _color; }
		
		public static function set color(value:Boolean):void 
		{
			if (_color)
				return;
			_color = value;
			if (value)
				ColorShortcuts.init();
		}
		
		public static function get display():Boolean { return _display; }
		
		public static function set display(value:Boolean):void 
		{
			if (_display)
				return;
			_display = value;
			if (value)
				DisplayShortcuts.init();
		}
		
		public static function get curve():Boolean { return _curve; }
		
		public static function set curve(value:Boolean):void 
		{
			if (_curve)
				return;
			_curve = value;
			if (value)
				CurveModifiers.init();
		}
		
		public static function get filter():Boolean { return _filter; }
		
		public static function set filter(value:Boolean):void 
		{
			if (_filter)
				return;
			_filter = value;
			if (value)
				FilterShortcuts.init();
		}
		
		public static function get sound():Boolean { return _sound; }
		
		public static function set sound(value:Boolean):void 
		{
			if (_sound)
				return;
			_sound = value;
			if (value)
				SoundShortcuts.init();
		}
		
		public static function get text():Boolean { return _text; }
		
		public static function set text(value:Boolean):void 
		{
			if (_text)
				return;
			_text = value;
			if (value)
				TextShortcuts.init();
		}
		
		public static function get matrix():Boolean { return _matrix; }
		
		public static function set matrix(value:Boolean):void 
		{
			if (_matrix)
				return;
			_matrix = value;
			if (value)
				MatrixShortcuts.init();
		}
	}
}
