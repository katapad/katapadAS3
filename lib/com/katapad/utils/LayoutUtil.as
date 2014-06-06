package com.katapad.utils 
{
	import flash.display.DisplayObject;
	import flash.errors.IllegalOperationError;
	import flash.text.TextField;
	/**
	 * ...
	 * @author kakehashi
	 * @version 0.1
	 * @since 2010/09/02 17:31
	 */
	public class LayoutUtil 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		//private var
		
		/**
		 * コンストラクタ
		 */
		public function LayoutUtil() 
		{
			throw new IllegalOperationError("LayoutUtil cannot construct");
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
		 * MCの隣に配置します (X)
		 * @param	base
		 * @param	placee
		 * @param	marginX
		 */
		public static function placeByAsideX(placee:DisplayObject, base:DisplayObject, marginX:Number = 0):void
		{
			placee.x = base.x + base.width + marginX;
		}
		
		/**
		 * MCの隣に配置します (Y)
		 * @param	base
		 * @param	placee
		 * @param	marginX
		 */
		public static function placeByAsideY(placee:DisplayObject, base:DisplayObject, marginY:Number = 0):void
		{
			placee.y = base.y + base.height + marginY;
		}
		
		/**
		 * MCの隣に配置します (XY)
		 * @param	base
		 * @param	placee
		 * @param	marginX
		 */
		public static function placeByAsideXY(placee:DisplayObject, base:DisplayObject, marginX:Number = 0, marginY:Number = 0):void
		{
			placee.x = base.x + base.width + marginX;
			placee.y = base.y + base.height + marginY;
		}
		
		/**
		 * TextgFieldの隣に配置します (X)
		 * @param	base
		 * @param	placee
		 * @param	marginX
		 */
		public static function placeByAsideXTF(placee:DisplayObject, base:TextField, marginX:Number = 0):void
		{
			placee.x = base.x + base.textWidth + marginX;
		}
		
		/**
		 * TextgFieldの隣に配置します (Y)
		 * @param	base
		 * @param	placee
		 * @param	marginX
		 */
		public static function placeByAsideYTF(placee:DisplayObject, base:TextField, marginY:Number = 0):void
		{
			placee.y = base.y + base.textHeight + marginY;
		}
		
		/**
		 * TextgFieldの隣に配置します (XY)
		 * @param	base
		 * @param	placee
		 * @param	marginX
		 */
		public static function placeByAsideXYTF(placee:DisplayObject, base:TextField, marginX:Number = 0, marginY:Number = 0):void
		{
			placee.x = base.x + base.textWidth + marginX;
			placee.y = base.y + base.textHeight + marginY;
		}
		
		/**
		 * textfieldの右端の座標を返します
		 * @param	txt
		 * @return
		 */
		public static function getRightTF(txt:TextField):Number
		{
			return txt.x + txt.textWidth;
		}
		/**
		 * textfieldの下の座標を返します
		 * @param	txt
		 * @return
		 */
		public static function getBottomTF(txt:TextField):Number
		{
			return txt.y + txt.textHeight;
		}
		
		
		
		public static function layout(mc:DisplayObject, i:int, cols:int, /*rows:int, */marginX:Number = 0, baseX:Number = 0, marginY:Number = 0, baseY:Number = 0):void
		{
			mc.x = (i % cols) * marginX + baseX;
			mc.y = int(i / cols) * marginY + baseY;
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
