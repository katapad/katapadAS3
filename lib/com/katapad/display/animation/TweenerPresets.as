package com.katapad.display.animation 
{
	import caurina.transitions.Tweener;
	import com.katapad.utils.DOUtils;
	import flash.display.DisplayObject;
	import flash.errors.IllegalOperationError;
	
	/**
	 * Tweenerのアニメーションプリセット
	 * @author katapad
	 * @version 0.1
	 * @since 2008/09/05 18:59
	 */
	public class TweenerPresets 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		//private var
		
		/**
		 * コンストラクタ禁止
		 */
		public function TweenerPresets() 
		{
			throw new IllegalOperationError("TweenerPresets クラスはインスタンス化できません");
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		/**
		 * 点滅アニメーション
		 * @param	target			DisplayObject
		 * @param	delayTime		delayTime
		 * @param	blinkTimes		チカチカする回数
		 * @param	intervalTime	チカチカする間隔
		 * @param	alpha
		 * @return
		 */
		public static function blink(target:DisplayObject, delayTime:Number = 0.0, blinkTimes:uint = 2, intervalTime:Number = 0.03, alpha:Number = 0.0):Number
		{
			for (var i:int = 0; i < blinkTimes * 2; i += 2) 
			{
				//Tweener.addTween(target, { visible: true, time: 0.0, delay: delayTime + intervalTime * i, transition: "linear" });
				//Tweener.addTween(target, { visible: false, time: 0.0, delay: delayTime + intervalTime * (i + 1), transition: "linear" });
				Tweener.addTween(target, { alpha: 1.0, time: 0.0, delay: delayTime + intervalTime * i, transition: "linear" });
				Tweener.addTween(target, { alpha: alpha, time: 0.0, delay: delayTime + intervalTime * (i + 1), transition: "linear" });
			}
			var lastDelayTime:Number = delayTime + intervalTime * i;
			//Tweener.addTween(target, { visible: true, time: 0.0, delay: lastDelayTime, transition: "linear" } );
			Tweener.addTween(target, { alpha: 1.0, time: 0.0, delay: lastDelayTime, transition: "linear" } );
			return lastDelayTime;
		}
		
		//----------------------------------
		//  mask
		//----------------------------------
		private function maskTextPropsInit(textMC:DisplayObject, maskMC:DisplayObject):void
		{
			//maskMC.x = maskMC.saveX - 80;
			maskMC.scaleX = 0;
			//textMC.x = textMC.saveX + 45;
			textMC.alpha = 50;
		}
		
		private function maskTextTween(textMC:DisplayObject, maskMC:DisplayObject, delayTime:Number, animationTime:Number):void
		{
			animationTime = animationTime ? animationTime : 1.0;
			Tweener.addTween(textMC, { x: textMC[DOUtils.SAVED_X], alpha: 100, time: animationTime, delay: delayTime, transition: "easeOutQuint" });
			Tweener.addTween(maskMC, { x: maskMC[DOUtils.SAVED_X], scaleX: 100, time: animationTime, delay: delayTime, transition: "easeOutQuint" });
		}
		
		private function fadeUpInit(mc:DisplayObject, addY:Number):void
		{
			//mc.y = mc.saveY + addY;
			mc.alpha = 0;
		}
		
		private function fadeUp(mc:DisplayObject, delayTime:Number, animationTime:Number):void
		{
			animationTime = animationTime ? animationTime : 0.8;
			Tweener.addTween(mc, { y: mc[DOUtils.SAVED_Y], alpha: 100, time: animationTime, delay: delayTime, transition: "easeOutQuint" });
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
