package com.katapad.bitmap.slice 
{
	import com.hexagonstar.util.debug.Debug;
	import flash.display.BitmapData;
	import flash.errors.IllegalOperationError;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author katapad
	 * @version 0.1.2
	 * @since 2009/01/19 19:49
	 */
	public class BitmapSlicer 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private static var _matrix:Matrix = new Matrix();
		
		/**
		 * コンストラクタ
		 */
		public function BitmapSlicer() 
		{
			throw new IllegalOperationError("cannot construct");
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
		 * 並べられたbitmapDataから個別の画像を切り出す
		 * たとえば2880px * 2880pxなどの大きな画像にたくさんのサムネイルを並べ、そいつから個別の画像を切り出すときに使います。
		 * 
		 * @param	singleW
		 * @param	singleH
		 * @param	sorce
		 * @param	max	数に制限があるときはこれを入力。なければ自動で2880px * 2880pxを元に算出した数だけbitmapdataを作る
		 * @return
		 */
		public static function slice(singleW:int, singleH:int, sorce:BitmapData, max:int = 0):Array
		{
			var result:Array = [];
			var cols:int = Math.floor(sorce.width / singleW);
			var rows:int = Math.floor(sorce.height / singleH);
			//逆数をかけたほうが速いので
			var reciprocalRows:Number = 1 / cols;
			var mtx:Matrix = _matrix;
			var bitmapdata:BitmapData;
			max = max || cols * rows;
			//trace( "max : " + max );
			Debug.timerStart();
			//ループがひとつのほうが速いけど、あんま変わらない。Math.floorがあると重いけど、気にしない。
			for (var i:int = 0; i < max; i++) 
			{
				bitmapdata = new BitmapData(singleW, singleH, true, 0x0);
				mtx.tx = -(i % cols) * singleW;
				mtx.ty = -Math.floor(i * reciprocalRows) * singleH;
				//trace( "mtx.ty : " + mtx.ty , i);
				bitmapdata.draw(sorce, mtx);
				result[i] = bitmapdata;
			}
			//こっちはループが2つなのと、pushしてるところが、ちょっとだけ遅い。
			/*for (var i:int = 0; i < rows; i++) 
			{
				for (var j:int = 0; j < cols; j++) 
				{
					bitmapdata = new BitmapData(singleW, singleH, true, 0x0);
					mtx.tx = -j * singleW;
					mtx.ty = -i * singleH;
					bitmapdata.draw(sorce, mtx);
					result.push(bitmapdata);
				}
			}*/
			Debug.timerStopToString();
			return result;
		}
		
		/**
		 * 複数の大きな画像（2880px * 2880pxなど）からひとつにまとめたbitmapdata配列を返す
		 * @param	singleW
		 * @param	singleH
		 * @param	sorceBitmapDataList
		 * @param	lastMax
		 * @return
		 */
		public static function multiSlice(singleW:int, singleH:int, sorceBitmapDataList:Array, lastMax:int = 0):Array
		{
			var result:Array = [];
			var tmp:Array;
			for (var i:int = 0, n:int = sorceBitmapDataList.length; i < n; i++) 
			{
				if (i == n - 1)
					tmp = BitmapSlicer.slice(singleW, singleH, sorceBitmapDataList[i], lastMax);
				else
					tmp = BitmapSlicer.slice(singleW, singleH, sorceBitmapDataList[i]);
				result = result.concat(tmp);
			}
			return result;
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
