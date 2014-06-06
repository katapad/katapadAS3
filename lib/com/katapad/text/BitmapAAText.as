package com.katapad.text 
{
	import flash.display.*;
	import flash.errors.IllegalOperationError;
	import flash.geom.*;
	import flash.filters.*;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.utils.getTimer;

	public class BitmapAAText
	{
		public static var AA_MARGIN_WIDTH:Number   = 16;		// 生成するビットマップに多少の余白を持たせる
		public static var AA_MARGIN_HEIGHT:Number  = 16;		// 
		public static var AA_BMP_MAX_WIDTH:uint  = 2800;		// 生成するビットマップの最大サイズ
		public static var AA_BMP_MAX_HEIGHT:uint = 2800;		//
		public static var AA_MAX_SCALE:Number      = 3;		// 最大拡大率
		public static var AA_BLUR_STRENGTH:Number  = 2;		// ぼかしの強さ
		public static var AA_BLUR_QUALITY:Number   = 2;		// ぼかしのクオリティ
		
		private static var _isMac:Boolean;
		private static var _stage:Stage;
		static private var _identityPoint:Point = new Point();
		
		/**
		 * F-site | デバイスフォントにアンチエイリアス
		 * http://f-site.org/articles/2007/04/08165536.html
		 */
		public function BitmapAAText()
		{
			throw new IllegalOperationError("BitmapAAText cannot construct");
		}
		
		/**
		 * 
		 * @param	marginWidth
		 * @param	marginHeight
		 * @param	maxScale
		 * @param	blurStrength
		 * @param	blurQuality
		 * @param	bmpMaxWidth
		 * @param	bmpMaxHeight
		 */
		public static function setConfig(marginWidth:Number = 16 , marginHeight:Number = 16, maxScale:Number = 3, blurStrength:Number = 2, blurQuality:Number = 2, bmpMaxWidth:uint = 2800, bmpMaxHeight:uint = 2800):void
		{
			AA_MARGIN_WIDTH = marginWidth;
			AA_MARGIN_HEIGHT = marginHeight;
			
			AA_BMP_MAX_WIDTH = bmpMaxWidth;
			AA_BMP_MAX_HEIGHT = bmpMaxHeight;
			
			AA_MAX_SCALE = maxScale;
			
			AA_BLUR_STRENGTH = blurStrength;
			AA_BLUR_QUALITY = blurQuality;
			
		}
		
		public static function init(stage:Stage):void
		{
			if (_stage)
				return;
			_isMac = Capabilities.os.toLowerCase().indexOf("mac") > -1;
			_stage = stage;
		}
		/**
		 * 
		 * @param	target
		 * @param	bBest
		 * @return
		 */
		public static function getAAText(target:DisplayObject, bBest:Boolean):BitmapData 
		{
			if (!_stage)
				throw new Error("まずBitmapAAText.initしてください");
			if (_isMac)
			{
				var bm:BitmapData = new BitmapData(target.width, target.height, true, 0);
				bm.draw(target);
				return bm;
			}

			var startTime:Number = getTimer();

			var oldQuality:String = _stage.quality;
			_stage.quality = StageQuality.HIGH;
			
			// 結果BitmapDataのサイズを取得
			var aaWidth:Number;
			var aaHeight:Number;
			if (target is TextField)
			{
				aaWidth = TextField(target).textWidth + AA_MARGIN_WIDTH;
				aaHeight = TextField(target).textHeight + AA_MARGIN_HEIGHT;
			}
			else
			{
				aaWidth = target.width + AA_MARGIN_WIDTH;
				aaHeight = target.height + AA_MARGIN_HEIGHT;
			}

			// アンチエイリアス処理の設定
			var aaScale:Number    = Math.min(AA_MAX_SCALE, Math.min(AA_BMP_MAX_WIDTH / aaWidth, AA_BMP_MAX_HEIGHT / aaHeight));
			var aaStrength:Number = AA_BLUR_STRENGTH;
			var aaQuality:Number  = AA_BLUR_QUALITY;

			// 「拡大用BitmapData」と「結果用BitmapData」を準備
			var bmpCanvas:BitmapData = new BitmapData(aaWidth * aaScale, aaHeight * aaScale, true, 0x00000000);
			var bmpResult:BitmapData = new BitmapData(aaWidth, aaHeight, true, 0x000000);

			// BESTクオリティでの描画を行うか？
			// AA(ぼかし)処理をFlash内部描画に任せます。
			// → ほとんどのサイズで綺麗だけど処理重いよ :-(
			var myMatrix:Matrix = new Matrix();
			var myColor:ColorTransform = new ColorTransform();
			
			
			if (bBest) 
			{
				_stage.quality = StageQuality.BEST;

				// 1.拡大描画
				myMatrix = new Matrix();
				myMatrix.scale(aaScale, aaScale);
				bmpCanvas.draw(target, myMatrix, new ColorTransform(), null, null, true);
				
				// 2.縮小描画
				myColor.alphaMultiplier= 1.3;
				myMatrix.a = myMatrix.d = 1;
				myMatrix.scale(1 / aaScale, 1 / aaScale);
				bmpResult.draw(bmpCanvas, myMatrix, myColor, null, null, true);

			} 
			else 
			{
				// 1.拡大描画
				myMatrix.scale(aaScale, aaScale);
				bmpCanvas.draw(target, myMatrix, new ColorTransform(), null, null, true);
				
				// 2.ぼかし処理
				// ToDo:フォントサイズや用途でパラメータを弄る必要有
				var myFilter:BlurFilter = new BlurFilter(aaStrength, aaStrength, aaQuality);
				bmpCanvas.applyFilter(bmpCanvas, new Rectangle(0, 0, bmpCanvas.width, bmpCanvas.height), _identityPoint, myFilter);
				//bmpCanvas.draw(target, myMatrix, new ColorTransform(), null, null, true);
				bmpCanvas.draw(target, myMatrix, null, null, null, true);
				
				// 3.縮小描画
				myColor.alphaMultiplier= 1.1;
				myMatrix.a = myMatrix.d = 1;
				myMatrix.scale(1 / aaScale, 1 / aaScale);
				bmpResult.draw(bmpCanvas, myMatrix, myColor, null, null, true);
				//bmpResult.draw(bmpCanvas, myMatrix, new ColorTransform(), null, null, true);
				bmpResult.draw(bmpCanvas, myMatrix, null, null, null, true);
			}

			// 後処理
			bmpCanvas.dispose();
			_stage.quality = oldQuality;

			//trace("scale:" + aaScale + " time:" + (getTimer() - startTime));
			return bmpResult;
		}
		
		static public function get isMac():Boolean { return _isMac; }
	}
}
