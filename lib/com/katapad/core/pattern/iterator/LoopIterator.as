package com.katapad.core.pattern.iterator 
{
	/**
	 * イテレータっぽいけど、flashでよくやる循環型にしてある。
	 * @author katapad
	 * @version 0.1
	 * @since 2008/08/13 18:26
	 */
	public class LoopIterator 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _range:int;
		private var _index:int;
		
		/**
		 * コンストラクタ
		 */
		public function LoopIterator(index:int, range:int) 
		{
			init(index, range);
		}
		
		/**
		 * 初期化
		 */
		private function init(index:int, range:int):void 
		{
			_index = index;
			_range = range;
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		/**
		 * indexを次へ移動
		 * @return	変更後のindex値
		 */
		public function next():int
		{
			//_index++;
			//_index %= _range;
			_index = getNextIndex();
			return _index;
		}
		
		/**
		 * indexを前へ移動
		 * @return	変更後のindex値
		 */
		public function prev():int
		{
			//_index--;
			//if (_index < 0)
				//_index = _range - 1;
			_index = getPrevIndex();
			return _index;
		}
		
		/**
		 * 次のindex値を取得。index値の変更はしない
		 * @return	次に取る値
		 */
		public function getNextIndex():int
		{
			var result:int = _index + 1;
			result %= _range;
			return result;
		}
		
		/**
		 * 前のindex値を取得。index値の変更はしない
		 * @return	前に取る値
		 */
		public function getPrevIndex():int
		{
			var result:int = _index - 1;
			if (result < 0)
				result = _range - 1;
			return result;
		}
		
		/**
		 * ステップ数の計算をして、少ないステップ数を返す。indexの変更はしない
		 * @param	targetIndex
		 * @return	ステップ数を返す
		 */
		public function getSteps(targetIndex:int):int
		{
			checkValue(targetIndex);
			if (targetIndex == _index)
				return 0;
			
			var result:int;
			var startIndex:int = _index;
			
			var minus:int = (startIndex + _range - targetIndex) % _range;
			var plus:int = (targetIndex + _range - startIndex) % _range;
			
			if (plus == minus || plus < minus)
				result = plus;
			else
				result = minus * -1;
			
			return result;
		}
		
		/**
		 * ステップ数を元にindex値を更新する
		 * @param	step
		 * @return
		 */
		public function setIndexByStep(step:int):int
		{
			_index = (_index + range + step) % range;
			return _index;
		}
		
		/**
		 * ほとんどsetIndex()に近いけれど、ステップ数を計算せずに渡す；
		 * @param	targetIndex
		 * @return	変更されたindex
		 */
		public function setIndexByPreStepIndex(targetIndex:int):int
		{
			var step:int = getSteps(targetIndex);
			_index = (_index + range + step) % range;
			return _index;
		}
		
		/**
		 * 強引にsetIndex()みたいなことをする。
		 * @param	value
		 * @return	変更されたindex
		 */
		public function setIndexByRowIndex(value:int):int
		{
			checkValue(value);
			_index = value % _range;
			return _index;
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
		private function checkValue(value:int):void
		{
			if (value < 0)
				throw new ArgumentError("targetIndexは0以上を指定してください");
			else if (value > _range)
				throw new ArgumentError("targetIndexの値がrangeを超えています");
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
		public function get index():int { return _index; }
		public function get range():int { return _range; }
	
	}
	
}
