/**
* @author katapad
* @version 0.1.4
* @since 2008/03/27 18:19
*/

package com.katapad.utils 
{
	import com.katapad.display.shape.Square;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.Event;
	import flash.utils.getTimer;
	import flash.system.System;
	
	import com.katapad.utils.TextFieldUtils;
	
	/**
	 * FPSを表示しておくクラス。
	 */
	public class FpsMonitor 
	{
		private var _framesElapsed:Number = 0; // Number of frames elapsed in the last second
		private var _frameCounterTime:Number = 0;
		private var _fpsTf:TextField;
		private var _fpsLabel:TextField;
		private var _memoryField:TextField;
		private var _underLine:Sprite;
		private var _wrap:Sprite;
		private var _offset:int;
		private var _basePoint:uint;
		private var _targetMC:DisplayObjectContainer;
		private var _bg:Shape;
		
		private var _textColor:Number = 0x000000;
		
		private var _stageFps:Number;
		
		/**
		 * 表示位置を決める定数
		 */
		public static const TL:uint = 1;
		public static const TR:uint = 2;
		public static const BL:uint = 3;
		public static const BR:uint = 4;
		
		//メンバ変数
		
		//インスタンス変数
		//private var
		
		/**
		 * コンストラクタ
		 * @param	targetMc 置く場所
		 * @param	textcolor 色
		 * @param	position TL, TR, BL, BRのいずれか
		 * @param	offset オフセット
		 */
		public function FpsMonitor(targetMc:DisplayObjectContainer, textcolor:Number = 0, position:uint = FpsMonitor.TL, offset:int = 5) 
		{
			if (!targetMc)
				throw new Error("FpsMonitorを設置するspriteが定義されていません");
			init(targetMc, textcolor, position, offset);
		}
		
		/**
		 * 初期化
		 */
		private function init( targetMc:DisplayObjectContainer, textcolor:Number, position:uint, offset:int ):void 
		{
			_targetMC = targetMc;
			_stageFps = targetMc.stage.frameRate;
			_basePoint = position;
			_offset = offset;
			_frameCounterTime = getTimer(); // Last time it was measured
			createElements( targetMc );
			setPos();
			
			//targetMc.addEventListener(Event.ADDED, depthTop, false, 0, true);
		}
		
		private function setPos():void
		{
			onResize();
			if (_basePoint != TL)
				_wrap.stage.addEventListener(Event.RESIZE, onResize);
		}
		
		private function createElements(targetMc:DisplayObjectContainer):void 
		{
			_wrap = new Sprite();
			targetMc.addChild(_wrap);
			_wrap.addEventListener( Event.ENTER_FRAME, onEnterFrameHandler);
			
			createBg();
			createTextField();
			createUnderline();
			
			_wrap.x = 5;
			_wrap.y = 5;
		}
		
		
		private function createBg():void
		{
			_bg = new Square(100, 25, 0xFFFFFF, 0.4);
			_wrap.addChild(_bg);
		}
		
		private function createTextField():void 
		{
			_fpsLabel = TextFieldUtils.createTextField(0, 0, 30, 20);
			_wrap.addChild(_fpsLabel);
			
			_fpsTf= TextFieldUtils.createTextField(17, 0, 30, 30);
			_wrap.addChild(_fpsTf);
			
			_memoryField = TextFieldUtils.createTextField(50, 0, 70, 30);
			_wrap.addChild(_memoryField);
			
			setupTextFormat();
			
			_fpsLabel.text = "fps";
			_fpsTf.text = _targetMC.stage.frameRate.toString();
			_memoryField.text = "";
		}
		
		private function setupTextFormat():void
		{
			_fpsLabel.defaultTextFormat =  new TextFormat("Helvetica", 11); 
			_fpsTf.defaultTextFormat = new TextFormat("Helvetica", 18, _textColor, true); 
			var memFormat:TextFormat = new TextFormat("_sans", 9, _textColor);
			memFormat.letterSpacing = 1;
			memFormat.leading = -2;
			_memoryField.defaultTextFormat = memFormat;
		}
		
		private function createUnderline():void
		{
			_underLine = new Sprite();
			_wrap.addChild(_underLine);
			drawUnderline();
		}
		
		private function drawUnderline():void 
		{
			var g:Graphics = _underLine.graphics;
			g.lineStyle( 1.5, _textColor, 10 );
			g.moveTo ( 40, 3);
			g.beginFill( _textColor );
			g.lineTo( 0, 3);
			g.drawRect(0, 0, 17, 3);
			g.endFill();
			_underLine.y = _fpsLabel.height -2;
		}
		
		/**
		 * エンターフレーム
		 */
		private function onEnterFrameHandler (event:Event):void  
		{
			// Simple script to update the "frame per seconds" textfield
			// with the number of frames rendered in the last second
			//毎フレーム 1を足していく
			_framesElapsed++;
			if (_frameCounterTime + 1000 < getTimer()) {
				// More than one second past since the last update
				//1秒後に 毎フレーム足していった数字を代入する
				_fpsTf.text = String(_framesElapsed);
				_frameCounterTime += 1000;
				_framesElapsed = 0;
			}
			
			_memoryField.text = "mem:\n" + String(Math.round(System.totalMemory * 0.001)) + "kb";
		}
		
		private function onResize(event:Event = null):void 
		{
			if (_basePoint == FpsMonitor.TL || _basePoint == FpsMonitor.TR)
				_wrap.y = _offset;
			else
				_wrap.y = _wrap.stage.stageHeight - _wrap.height - _offset;
			if (_basePoint == FpsMonitor.TL || _basePoint == FpsMonitor.BL)
				_wrap.x = _offset;
			else
				_wrap.x = _wrap.stage.stageWidth - _wrap.width - _offset;
		}
		
		private function depthTop(event:Event = null):void
		{
			_targetMC.swapChildrenAt(_targetMC.getChildIndex(_wrap), _targetMC.numChildren - 1);
		}
	}
	
}
