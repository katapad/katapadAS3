package com.katapad.effect 
{
import com.greensock.TweenMax;
import com.greensock.easing.Quint;
import com.katapad.utils.StStage;

import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.filters.DisplacementMapFilter;
import flash.geom.Point;

/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2008/10/21 21:14
	 */
	public class YuragiFX extends EventDispatcher
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		//private var
		private var _w:Number/* = 500*/;
		private var _h:Number/* = 200*/;
		private var _octaves:int = 2;
		private var _offset:Array;
		private var _speed:Array;
		private var _rdm:Number = Math.floor(Math.random() * 10000);
		private var _target:DisplayObject;
		private var _bmd:BitmapData;
		private var _mappoint:Point;
		private var _dpmScale:Number = 0;
		private var _dmf:DisplacementMapFilter;
		
		/**
		 * コンストラクタ
		 */
		public function YuragiFX(target:DisplayObject) 
		{
			init(target);
		}
		
		/**
		 * 初期化
		 */
		private function init(target:DisplayObject):void 
		{
			_target = target;
			_speed = [];
			_offset = [];
			_w = target.width;
			_h = target.height;
//			_h = target.height * 0.5;
			//_dpmScale = 100;
			_bmd = new BitmapData(_w, _h, true, 0);
			_mappoint = new Point((_target.width - _w) * 0.5, (_target.height - _h) * 0.5);
			//_mappoint = new Point(10, 10);
			_dmf = new DisplacementMapFilter(_bmd, _mappoint, 1, 1, _dpmScale, -_dpmScale);
			
			for (var i:int = 0; i < _octaves; i++)
			{
				_offset[i] = new Point(Math.random() * _w, Math.random()* _h);
				_speed[i] = new Point(Math.random() * 2 - 1, Math.random() * 2 - 1);
			}
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
		public function run(delayTime:Number = 0):void
		{
			//StStage.stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			TweenMax.to(_dmf, 1.5, { scaleX: 0, scaleY: 0,
				bezier : [ { scaleX: 900, scaleY: 100} ],
				ease: Quint.easeOut, delay: delayTime
				, onUpdate: yurameki
//				, onComplete: destroy
			});

//			Tweener.addTween(_dmf, { scaleX: 0, scaleY: 0, _bezier : { scaleX: 100, scaleY: 100}, time: 2.5, delay: 0.0, transition: "easeOutQuad", onUpdate: yurameki , onComplete: destroy} );
			//Tweener.addTween(_dmf, { scaleX: 100, scaleY: 100 time: 0.8, delay: 0.0, transition: "easeInOutQuad", onUpdate: yurameki } );
			//Tweener.addTween(_dmf, { scaleX: 0, scaleY: 0, time: 0.7, delay: 1.0, transition: "easeInOutQuad", onUpdate: yurameki, onComplete: destroy } );
//			yurameki();
		}
		
		private function destroy():void
		{
			_dmf = null;
			_target.filters = [];
			_target = null;
			_bmd = null;
		}
		
		private function yurameki():void
		{
			_bmd.lock();
			_bmd.perlinNoise(_w * 0.03, _h * 0.03, _octaves, _rdm, false, true, 1, true, _offset);
			for(var i:int = 0; i < _octaves; i++){
				_offset[i].x += _speed[i].x;
				_offset[i].y += _speed[i].y;
			}
			_target.filters = [_dmf];
			_bmd.unlock();
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
		private function enterFrameHandler(event:Event):void 
		{
			_bmd.lock();
			for(var i:int = 0; i < _octaves; i++){
				_offset[i].x += _speed[i].x;
				_offset[i].y += _speed[i].y;
			}
			//  マウス位置によって変化量を調整
			var scalex:Number = (StStage.stage.mouseX - _w * .5) * .5;
			var scaley:Number = (StStage.stage.mouseY - _h * .5) * .5;

			_bmd.perlinNoise(_w / 30, _h / 30, _octaves, _rdm, false, true, 1, true, _offset);
			//var dmf:DisplacementMapFilter = new DisplacementMapFilter(_bmd, _mappoint, 1, 1, scalex, scaley);
			//_dmf = new DisplacementMapFilter(_bmd, _mappoint, 1, 1, _dpmScale, -_dpmScale);
			_dpmScale += (0 - _dpmScale) * 0.1;
			//_dmf.scaleX = _dpmScale;
			//_dmf.scaleY = _dpmScale;
			_dmf.scaleX = scalex;
			_dmf.scaleY = scaley;
			_bmd.unlock();
			_target.filters = [_dmf];
			
			//if (_dpmScale < 1)
			//{
				//StStage.stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				//dispatchEvent(new Event(Event.COMPLETE));
			//}
		}
		
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
