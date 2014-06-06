/**
* @author katapad
* @version 0.1.1
* @since 2008/05/24 19:03
*/

package com.katapad.utils 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * マスクユーティリティ。
	 * めんどくさいマスクを勝手にやってくれる。
	 * @see Dcom.katapad.utils.DrawUtils
	 * @TODO 日本能率協会に持ち込んで手帳にしてもらう
	 */
	public class MaskUtils 
	{
		
		/**
		 * 普通のマスクをかける
		 * ターゲットは左上基準限定
		 * @param	putTarget
		 * @param	maskTarget
		 * @param	depth
		 * @return Shape 
		 */
		public static function applyRectangleMask( putTarget:DisplayObjectContainer, maskTarget:DisplayObject, defaultScale:Number = 1.0, maskName:String = "_mask", depth:int = 0 ):Shape 
		{
			//trace( "defaultScale : " + defaultScale );
			//var tmpDepth: Number = ( depth ) ? depth: putTarget.getNextHighestDepth();
			var maskMC:Shape = new Shape();
			maskMC.name = maskName;
			putTarget.addChild(maskMC);
			putTarget.swapChildren(maskTarget, maskMC);
			
			var originalRotation:Number = maskTarget.rotation;
			maskTarget.rotation = 0;
			
			DrawUtils.drawFill(maskMC.graphics, 0, 0, maskTarget.width, maskTarget.height, DrawUtils.RECT);
			maskMC.rotation = maskTarget.rotation = originalRotation;
			
			var targetRect:Rectangle = maskTarget.getBounds(putTarget);
			var maskRect:Rectangle = maskMC.getBounds(putTarget);
			maskMC.x -= maskRect.left - targetRect.left;
			maskMC.y -= maskRect.top - targetRect.top;
			maskTarget.mask = maskMC;
			if (defaultScale != 1.0)
				dObjScaler(maskMC, defaultScale);

			return maskMC;
		}

		/**
		 * 基準点を設けてマスクをかける。
		 * @param	putTarget
		 * @param	maskTarget
		 * @param	maskName
		 * @param	basePoint
		 * @param	depth
		 * @return
		 */
		public static function applyRectangleMaskPoint( putTarget:DisplayObjectContainer, maskTarget:DisplayObject, defaultScale:Number = 1.0, maskName:String = "_mask", basePoint:uint = 1, depth:uint = 0 ):Shape
		{
			//var tmpName: String = ( maskName ) ? maskName: "_mask";
			//var tmpDepth: Number = ( depth ) ? depth: putTarget.getNextHighestDepth();
			//var tmpBasePoint: Number = ( basePoint ) ? basePoint: 1;
			var maskMC:Shape = new Shape();
			maskMC.name = maskName;
			putTarget.addChild(maskMC);
			putTarget.swapChildren(maskTarget, maskMC);
			
			var originalRotation:Number = maskTarget.rotation;
			maskTarget.rotation = 0;
			var targetRect:Rectangle = maskTarget.getBounds(putTarget);
			
			DrawUtils.drawFillPoint( maskMC.graphics, basePoint, 0, 0, targetRect.right - targetRect.left, targetRect.bottom - targetRect.top, DrawUtils.RECT, 0, 1.0);

			maskMC.rotation = maskTarget.rotation = originalRotation;
			
			var maskRect:Rectangle = maskMC.getBounds(putTarget);
			targetRect = maskTarget.getBounds(putTarget);
			maskMC.x -= maskRect.left - targetRect.left;
			maskMC.y -= maskRect.top - targetRect.top;
			maskTarget.mask = maskMC;
			if (defaultScale != 1.0)
				dObjScaler(maskMC, defaultScale);

			return maskMC;
		}
		
		
		private static function dObjScaler(mc:DisplayObject, num:Number):void
		{
			mc.scaleX = mc.scaleY = num;
		}
		
		/**
		 * コンストラクタ
		 */
		public function MaskUtils() 
		{
			throw new Error("Do not instantation MaskUtils");
		}
		
	}
	
}
