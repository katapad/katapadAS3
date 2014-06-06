package com.katapad.cameras 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.geom.Matrix;
	import flash.events.Event;
	
	import caurina.transitions.Tweener;
	
	/**
	 * papervision3DのFreeCamaeraもどき。2Dで実行する。
	 * @author katapad
	 * @version 0.1.1
	 * @since 2008/08/01 21:30
	 * @usage
	 * <ol>
	 *   <li>cameraをnewして被写体となるDisplayObjectを登録する</li>
	 *   <li>cameraインスタンスをaddChildする</li>
	 *   <li>cameraOnにしてcameraをTweener等で適当に動かすと見れるようになる。</li>
	 * </ol>
	 * <pre>
	 * 	var camera:FreeCamera = new FreeCamera(_mainContainer);
	 *  addChild(camera);
	 *  camera.cameraOn();
	 * //camera.isNoRender = true;
	 * </pre>
	 */
	public class FreeCamera extends Shape 
	{
		private var _stage:Stage;
		private var _stageW:int;
		private var _stageH:int;
		private var _target:DisplayObject;
		private var _isNoRender:Boolean = false;
		private var _scale:Number = 1.0;
		
		private var _targetMatrix:Matrix = new Matrix();
		
		
		/**
		 * コンストラクタ
		 */
		public function FreeCamera(target:DisplayObject) 
		{
			init(target);
		}
		
		/**
		 * 初期化
		 */
		private function init(target:DisplayObject):void 
		{
			_target = target;
			_stage = target.stage;
			_stageW = _stage.stageWidth;
			_stageH = _stage.stageHeight;
			this.visible = false;
			createShape();
		}
		
		//--------------------------------------------------------------------------
		//
		//  public
		//
		//--------------------------------------------------------------------------
		/**
		 * 撮影開始
		 */
		public function cameraOn():void
		{
			addEventListener(Event.ENTER_FRAME, render);
		}
		
		/**
		 * 撮影をやめる。
		 */
		public function cameraOff():void
		{
			removeEventListener(Event.ENTER_FRAME, render);
		}
		
		//--------------------------------------------------------------------------
		//
		//  private
		//
		//--------------------------------------------------------------------------
		private function createShape():void
		{
			graphics.lineStyle(1);
			graphics.drawRect(-_stageW * 0.5, -_stageH * 0.5, _stageW, _stageH);
		}
		
		private function render(event:Event = null):void
		{
			if (_isNoRender)
				return;
			
			var thisMatrix : Matrix = this.transform.matrix;
			_targetMatrix.identity();
			_targetMatrix.translate(_stageW / 2, _stageH / 2);
			thisMatrix.invert();
			thisMatrix.concat(_targetMatrix);
			_target.transform.matrix = thisMatrix;
		}
		
		//--------------------------------------------------------------------------
		//
		//  getter/setter
		//
		//--------------------------------------------------------------------------
		public function get scale():Number { return _scale; }
		
		public function set scale(value:Number):void 
		{
			scaleX = scaleY = _scale = value;
		}
		
		public function get isNoRender():Boolean { return _isNoRender; }
		
		public function set isNoRender(value:Boolean):void 
		{
			_isNoRender = value;
		}
	}
}