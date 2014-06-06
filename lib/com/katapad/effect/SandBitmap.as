package com.katapad.effect 
{
	import com.hexagonstar.util.debug.Debug;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import caurina.transitions.Tweener;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2009/12/01 13:23
	 */
	public class SandBitmap extends Bitmap 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		private static const _NO_MARGIN:Array = [0, 0, 0, 0];
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _pixels:Array/*Px*/;
		private var _margin:Array;
		
		/**
		 * コンストラクタ
		 */
		public function SandBitmap(pixels:Array, margin:Array = null) 
		{
			init(pixels, margin);
		}
		
		/**
		 * 初期化
		 */
		private function init(pixels:Array, margin:Array):void 
		{
			_pixels = pixels;
			
			if (margin && margin.length == 4)
				_margin = margin;
			else if (margin == null)
				_margin = _NO_MARGIN;
			else 
				throw new Error("marginがおかしいです。T R B Lの順にいれてください。Numberです");
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
		//----------------------------------
		//  STATIC
		//----------------------------------
		/**
		 * 
		 * @param	mc
		 * @param	margin	Top Right Bottom Left
		 * @param	autoAddChild
		 * @param	autoRemoveTarget
		 * @return
		 */
		public static function create(mc:DisplayObject, margin:Array = null, autoAddChild:Boolean = true, autoRemoveTarget:Boolean = true):SandBitmap
		{
			var mcParent:DisplayObjectContainer = mc.parent;
			var bitmapRect:Rectangle = mc.getBounds(mc);
			bitmapRect.x = mc.x;
			bitmapRect.y = mc.y;
			
			var rect:Rectangle = mc.getBounds(mc);
			var tmpBmd:BitmapData = new BitmapData(rect.width, rect.height, true, 0);
			tmpBmd.draw(mc);
			var list:Array = [];
			
			var prevPx:Px;
			var px:Px;
			for (var i:int = 0, n:int = rect.width; i < n; ++i) 
			{
				for (var j:int = 0, m:int = rect.height; j < m; ++j) 
				{
					var color:uint = tmpBmd.getPixel32(i, j);
					if (color > 0)
					{
						prevPx = px;
						px = new Px(i, j, i, j, color);
						list.push(px);
						if (prevPx)
							prevPx.next = px;
					}
				}
			}
			
			__fixRect(margin, bitmapRect);
			
			var result:SandBitmap = new SandBitmap(list, margin);
			result.bitmapData = new BitmapData(bitmapRect.width, bitmapRect.height, true, 0x0);
			
			result.x = bitmapRect.x;
			result.y = bitmapRect.y;
			
			
			if (mcParent)
			{
				var idx:int = mcParent.getChildIndex(mc);
				if (autoRemoveTarget)
					mcParent.removeChild(mc);
				
				if (autoAddChild)
					mcParent.addChildAt(result, idx);
			}
			
			return result;
		}
		
		private static function __fixRect(margin:Array, bitmapRect:Rectangle):void
		{
			if (margin)
			{
				for (var i:int = 0, n:int = margin.length; i < n; ++i) 
				{
					var mar:Number = margin[i];
					switch (i) 
					{
						case 0:
							bitmapRect.height += mar;
							bitmapRect.y -= mar;
							break;
						case 1:
							bitmapRect.width += mar;
							break;
						case 2:
							bitmapRect.height += mar;
							break;
						case 3:
							bitmapRect.width += mar;
							bitmapRect.x -= mar;
							break;
					}
				}
			}
		}
		
		public function clear():void
		{
			bitmapData.fillRect(bitmapData.rect, 0x0);
		}
		
		public function draw():void
		{
			bitmapData.fillRect(bitmapData.rect, 0x0);
			bitmapData.lock();
			var mH:Number = _margin[0];
			var mW:Number = _margin[3];
			var px:Px = _pixels[0];
			bitmapData.setPixel32(px.x + mW, px.y + mH, px.blendColor);
			while (px.next)
			{
				px = px.next
				bitmapData.setPixel32(px.x + mW, px.y + mH, px.blendColor);
			}
			bitmapData.unlock();
			
			//trace( "px.blendColor : " + ((px.blendColor & 0xFF000000 ) >> 24).toString(16) );
			//trace( "px.alpha : " + px.alpha.toString(16));
			//trace( "px.ta : " + px.ta.toString(16));
		}
		
		public function get pixels():Array { return _pixels; }
		
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
