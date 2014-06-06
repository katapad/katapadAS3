/**
* @author katapad
* @version 0.1.5
* @since 2008/05/24 19:47
*/

package com.katapad.utils 
{
	import com.katapad.core.PointData;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * Draw系のユーティリティ。
	 * com.katapad.utils.MaskUtilsと組み合わせて使うこと、勝手にマスクをかけてくれたりする
	 * @see com.katapad.utils.MaskUtils
	 */
	public class DrawUtils 
	{
		//メンバ変数
		public static const RECT:uint = 1;
		public static const ROUND_RECT:uint = 2;
		public static const CIRCLE:uint = 3;
		public static const ELLIPSE:uint = 4;
		public static const DONUTS:uint = 5;
		
		public static const TL:uint = 1;
		public static const TC:uint = 2;
		public static const TR:uint = 3;
		public static const ML:uint = 4;
		public static const MC:uint = 5;
		public static const MR:uint = 6;
		public static const BL:uint = 7;
		public static const BC:uint = 8;
		public static const BR:uint = 9;
		
		private static var _identityPoint:PointData;
		
		/**
		 * bitmapでfill
		 * @param	graphics
		 * @param	bitmapData
		 * @param	basePoint
		 * @param	x
		 * @param	y
		 * @param	w
		 * @param	h
		 * @param	drawType
		 * @param	matrix
		 * @param	repeat
		 * @param	smooth
		 * @param	round
		 */
		public static function drawBitmapFillPoint(graphics:Graphics, bitmapData:BitmapData, basePoint:uint, x:Number, y:Number, w:Number, h:Number, drawType:uint = DrawUtils.RECT, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false, round:Number = 0.0):void
		{
			getBasePosition(basePoint, x, y, w, h, drawType);
			drawBitmapFill(graphics, bitmapData, identityPoint.x, identityPoint.y, w, h, drawType, matrix, repeat, smooth, round);
		}
		/**
		 * bitmapでfill
		 * @param	graphics
		 * @param	bitmapData
		 * @param	x
		 * @param	y
		 * @param	w
		 * @param	h
		 * @param	drawType
		 * @param	matrix
		 * @param	repeat
		 * @param	smooth
		 * @param	round
		 */
		public static function drawBitmapFill(graphics:Graphics, bitmapData:BitmapData, x:Number, y:Number, w:Number, h:Number, drawType:uint = RECT, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false, round:Number = 0.0):void
		{
			graphics.beginBitmapFill(bitmapData, matrix, repeat, smooth);
			drwaByTypeCode(graphics, x, y, w, h, round, drawType);
			graphics.endFill();
		}
		
		/**
		 * 基準点を設けて描画してFILLする
		 * Circleも左上がデフォルトの基準点にしてある
		 * @param	graphics:Graphics
		 * @param	basePoint [1-9] or [DrawUtils.TL - DrawUtils.BR]
		 * @param	x
		 * @param	y
		 * @param	w
		 * @param	h
		 * @param	drawType [RECT, ROUND_RECT, CIRCLE, ELLIPSE]
		 * @param	color
		 * @param	alpha
		 * @param	round
		 */
		public static function drawFillPoint(graphics:Graphics, basePoint:uint, x:Number, y:Number, w:Number, h:Number, drawType:uint = DrawUtils.RECT, color:uint = 0, alpha:Number = 1.0, round:Number = 0.0):void
		{
			getBasePosition(basePoint, x, y, w, h, drawType);
			drawFill(graphics, identityPoint.x, identityPoint.y, w, h, drawType, color, alpha, round);
		}
		
		private static function getBasePosition(basePoint:uint, x:Number, y:Number, w:Number, h:Number, drawType:uint = DrawUtils.RECT):PointData
		{
			identityPoint.x = x;
			identityPoint.y = y;
			
			if (drawType != CIRCLE)
			{
				if (basePoint == TC || basePoint == MC || basePoint == BC )
					identityPoint.x -= w * 0.5;
				else if (basePoint == TR || basePoint == MR || basePoint == BR )
					identityPoint.x -= w;
				
				if (basePoint == ML || basePoint == MC || basePoint == MR )
					identityPoint.y -= h * 0.5;
				else if (basePoint == BL || basePoint == BC || basePoint == BR )
					identityPoint.y -= h;
			}
			else 
			{
				if (basePoint == TL || basePoint == ML || basePoint == BL )
					identityPoint.x += w;
				else if (basePoint == TR || basePoint == MR || basePoint == BR )
					identityPoint.x -= w;
				
				if (basePoint == TL || basePoint == TC || basePoint == TR )
					identityPoint.y += w;
				else if (basePoint == BL || basePoint == BC || basePoint == BR )
					identityPoint.y -= h;
			}
			return identityPoint;
		}
		
		/**
		 * FILLして描画。こっちの基準点は生のままなので、Circleのときは中心に来る
		 * @param	sprite
		 * @param	drawType
		 * @param	x
		 * @param	y
		 * @param	w
		 * @param	h
		 * @param	color
		 * @param	alpha
		 */
		public static function drawFill(graphics:Graphics, x:Number, y:Number, w:Number, h:Number, drawType:uint = RECT, color:uint = 0, alpha:Number = 1.0, round:Number = 0.0):void
		{
			graphics.beginFill(color, alpha);
			drwaByTypeCode(graphics, x, y, w, h, round, drawType);
			graphics.endFill();
		}
		
		/**
		 * Fillしない描画
		 * @param	graphics
		 * @param	basePoint
		 * @param	x
		 * @param	y
		 * @param	w
		 * @param	h
		 * @param	drawType
		 * @param	round
		 */
		public static function drawNoFillPoint(graphics:Graphics, basePoint:uint, x:Number, y:Number, w:Number, h:Number, drawType:uint = DrawUtils.RECT, round:Number = 0.0):void
		{
			getBasePosition(basePoint, x, y, w, h, drawType);
			//drawFill(graphics, identityPoint.x, identityPoint.y, w, h, drawType, color, alpha, round);
			drwaByTypeCode(graphics, identityPoint.x, identityPoint.y, w, h, round, drawType);
		}
		
		/**
		 * typecodeに応じて描画をわける
		 * @param	sprite
		 * @param	drawKind
		 */
		private static function drwaByTypeCode(graphics:Graphics, x:Number, y:Number, w:Number, h:Number, round:Number, drawType:uint = DrawUtils.RECT):void
		{
			switch (drawType) 
			{
				case RECT:
				{
					graphics.drawRect(x, y, w, h);
					break;
				}
				case ROUND_RECT:
				{
					graphics.drawRoundRect(x, y, w, h, round, round);
					break;
				}
				case CIRCLE:
				{
					graphics.drawCircle(x, y, w);
					break;
				}
				case ELLIPSE: 
				{
					graphics.drawEllipse(x, y, w, h);
					break;
				}
			}
		}
		
		/**
		 * 中心点のshapeを一番上にもっていきます。
		 * @param	container
		 * @param	color
		 * @param	length
		 * @param	addIndex
		 * @return
		 */
		public static function addCenterPoint(container:DisplayObjectContainer, color:uint = 0, length:int = 6, addIndex:Number = NaN):Shape
		{
			var shape:Shape = new Shape();
			drawCenterPoint(shape.graphics, color, length);
			container.addChild(shape);
			if (addIndex)
				container.setChildIndex(shape, addIndex);
			return shape;
		}
		
		/**
		 * 中心点を書く
		 * @param	graphics
		 * @param	color
		 * @param	length
		 */
		public static function drawCenterPoint(graphics:Graphics, color:uint = 0, length:int = 6):void
		{
			graphics.lineStyle(1, color, 1.0, true);
			graphics.moveTo(-length * 0.5, 0);
			graphics.lineTo(length * 0.5, 0);
			
			graphics.moveTo(0, -length * 0.5);
			graphics.lineTo(0, length * 0.5);
		}
		
		/**
		 * 円弧を描く。引数多くてややこい。
		 * @param	graphics
		 * @param	destX
		 * @param	destY
		 * @param	radius
		 * @param	startDegree
		 * @param	arcDegree
		 * @param	isFirstLineTo	ドーナツを描くための引数。trueだと
		 * @param	isLineFromCenter これがtrueだとisFirstLineToを無視して、PI状に描きます。
		 * @return
		 */
		public static function drawArc(graphics:Graphics, destX:Number, destY:Number, radius:Number, startDegree:Number, arcDegree:Number, isFirstLineTo:Boolean, isLineFromCenter:Boolean = false):Array
		{
			//arcDegree %= 360;
			
			var theta0:Number = MathUtils.degreeToRadian(startDegree);
			//var theta1:Number = MathUtils.degreeToRadian(arcDegree);
			
			var aPoint0:Point = new Point(
				radius * Math.cos( theta0 ) + destX, 
				radius * Math.sin( theta0 ) + destY
			);
			
			var segs:int = Math.ceil(Math.abs(arcDegree) / 45);
			if (segs == 0)
				return null;
			var segAngle:Number = arcDegree / segs;
			var theta:Number = (segAngle / 180) * Math.PI;
			
			var angle:Number = (startDegree / 180) * Math.PI;
//			var ax:Number = destX - Math.cos(angle) * radius;
//			var ay:Number = destY - Math.sin(angle) * radius;
			
			if (isLineFromCenter)
			{
				graphics.moveTo(destX, destY);
				graphics.lineTo(aPoint0.x, aPoint0.y);
			}
			else
			{
				if (isFirstLineTo)
					graphics.lineTo(aPoint0.x, aPoint0.y);
				else
					graphics.moveTo(aPoint0.x, aPoint0.y);
			}
				
			for (var i:int = 0; i < segs; ++i) 
			{
				angle += theta;
				var angleMid:Number = angle - (theta / 2);
				var aX1:Number = destX + Math.cos(angle) * radius;
				var aY1:Number = destY + Math.sin(angle) * radius;
				var cx:Number = destX + Math.cos(angleMid) * (radius / Math.cos(theta / 2));
				var cy:Number = destY + Math.sin(angleMid) * (radius / Math.cos(theta / 2));
				graphics.curveTo(cx, cy, aX1, aY1);
			}
			
			return [aPoint0, new Point(aX1, aY1)];
		}
		
		public static function drawPI():void
		{
			
		}
		
		public static function drawDonuts(graphics:Graphics, destX:Number, destY:Number, radius:Number, innerRadius:Number, startDegree:Number = -90, arcDegree:Number = 360):void
		{
			var pointList:Array = DrawUtils.drawArc(graphics, destX, destY, innerRadius, startDegree, arcDegree, false);
			if (pointList)
				graphics.moveTo(pointList[0].x, pointList[0].y);
			
			var pointList2:Array = DrawUtils.drawArc(graphics, destX, destY, radius, startDegree, arcDegree, true);
			if (pointList)
				graphics.lineTo(pointList[1].x, pointList[1].y);
		}
		
		public static function drawDonutsFill(graphics:Graphics, destX:Number, destY:Number, radius:Number, innerRadius:Number, color:uint = 0, alpha:Number = 1.0, startDegree:Number = -90, arcDegree:Number = 360):void
		{
			graphics.beginFill(color);
			DrawUtils.drawDonuts(graphics, destX, destY, radius, innerRadius, startDegree, arcDegree);
			graphics.endFill();
		}
		
		/**
		 * コンストラクタ（禁止）
		 */
		public function DrawUtils() 
		{
			throw new ArgumentError("Do not constract");
		}
		
		private static function get identityPoint():PointData 
		{ 
			if (!_identityPoint)
				_identityPoint = new PointData();
			return _identityPoint; 
		}
	}
}
