package com.katapad.utils 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.getQualifiedClassName;
	
	import caurina.transitions.Tweener;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/05/05 19:12
	 */
	public class MoveUtil 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _target:DisplayObject;
		private var _dx:Number;
		private var _dy:Number;
		
		/**
		 * コンストラクタ
		 */
		public function MoveUtil(target:DisplayObject, dx:Number = 1, dy:Number = 1):void
		{
			_init(target, dx, dy);
		}
		
		/**
		 * 初期化
		 */
		private function _init(target:DisplayObject, dx:Number = 1, dy:Number = 1):void 
		{
			_target = target;
			_dx = dx;
			_dy = dy;
			start();
		}
		
		private function _onKeyDown(event:KeyboardEvent):void 
		{
			var dx:Number = _dx;
			var dy:Number = _dy;
			switch (event.keyCode) 
			{
				case Keyboard.LEFT:
					_target.x -= dx;
					break;
					
				case Keyboard.RIGHT:
					_target.x += dx;
					break;
					
				case Keyboard.UP:
					_target.y -= dy;
					break;
					
				case Keyboard.DOWN:
					_target.y += dy;
					break;
			}
			_tracePosition();
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
			trace( "_target : " + _target , "_target is Sprite: " + (_target is Sprite) );
			StStage.stage.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown);
			if (_target is Sprite || _target is MovieClip)
			{
				trace("kitemasu");
				_target.addEventListener(MouseEvent.MOUSE_DOWN, _startDrag);
			}
		}
		
		private function _startDrag(event:MouseEvent = null):void 
		{
			Sprite(_target).startDrag();
			StStage.stage.addEventListener(MouseEvent.MOUSE_UP, _stopDrag);
		}
		
		private function _stopDrag(event:MouseEvent = null):void 
		{
			StStage.stage.removeEventListener(MouseEvent.MOUSE_UP, _stopDrag);
			Sprite(_target).stopDrag();
			_tracePosition();
		}
		
		public function stop():void
		{
			StStage.stage.removeEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown);
			if (_target is Sprite || _target is MovieClip)
				_target.removeEventListener(MouseEvent.MOUSE_DOWN, _startDrag);
			_stopDrag();
		}
		
		public function destroy():void
		{
			stop();
			_target = null;
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
		private function _tracePosition():void
		{
			trace("target: " + _target.name, getQualifiedClassName(_target), "new Point(" + _target.x, ", " + _target.y + ")");
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
	
	}
	
}
