package com.katapad.utils.tweens 
{
	import fl.motion.BezierSegment;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author katapad
	 */
	public class SuperExpo 
	{
		
		public function SuperExpo() 
		{
			
		}
		
		public static function easeOut(t:Number, b:Number, c:Number, d:Number):Number
		{
			var points:Array = [
				{point:[0,0],pre:[0,0],post:[0,1.33]},
				{point:[1,1],pre:[0.18,0.93],post:[1,1]}
			];
			var bezier:BezierSegment = null;
			for (var i:int = 0; i < points.length - 1; i++) {
				if (t / d >= points[i].point[0] && t / d <= points[i+1].point[0]) {
					bezier = new BezierSegment(
						new Point(points[i].point[0], points[i].point[1]),
						new Point(points[i].post[0], points[i].post[1]),
						new Point(points[i+1].pre[0], points[i+1].pre[1]),
						new Point(points[i+1].point[0], points[i+1].point[1]));
					break;
				}
			}
			return c * bezier.getYForX(t / d) + b;
		}
		
		public static function easeIn(t:Number, b:Number, c:Number, d:Number):Number
		{
			var points:Array = [
				{point:[0,0],pre:[0,0],post:[0.18,0.93]},
				{point:[1,1],pre:[0,1.33],post:[1,1]}
			];
			var bezier:BezierSegment = null;
			for (var i:int = 0; i < points.length - 1; i++) {
				if (t / d >= points[i].point[0] && t / d <= points[i+1].point[0]) {
					bezier = new BezierSegment(
						new Point(points[i].point[0], points[i].point[1]),
						new Point(points[i].post[0], points[i].post[1]),
						new Point(points[i+1].pre[0], points[i+1].pre[1]),
						new Point(points[i+1].point[0], points[i+1].point[1]));
					break;
				}
			}
			return c * bezier.getYForX(t / d) + b;
		}
		
	}
	
}