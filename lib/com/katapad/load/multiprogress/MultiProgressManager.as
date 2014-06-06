/*
 * Licensed under the MIT License
 * 
 * Copyright (c) 2009 katapad.com
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package com.katapad.load.multiprogress 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * 複数のプログレスを一本化して扱うクラスです.
	 * 
	 * <p>外部設定や複数のファイルを読み込むことがたくさんあるときに、それぞれのプログレスを一本化します。</p>
	 * <p>以下のような流れを持つのFlashに最適です。</p>
	 * <ol>
	 *   <li>メインのSWFを読むプログレス</li>
	 *   <li>xmlを読むプログレス</li>
	 *   <li>画像を読むプログレス</li>
	 *   <li>オブジェクトをビルドしまくる時間がかかる。</li>
	 * </ol>
	 * <p>このときの流れをまとめて0～1までのパーセントにして扱うクラスです。</p>
	 * <p>使い方</p>
	 * <listing>_progressManager = new MultiProgressManager();
	 * 
	 * //ローダーで普通に読み込み
	 * var loader:Loader = new Loader();
	 * addChild(_loader);
	 * 
	 * //loaderが担当するプログレスの範囲 0% から 50%、までに設定
	 * var model:AbstractProgressModel = new ProgressEventModel(loader.contentLoaderInfo, 0.5);
	 * _progressManager.addProgress(model);
	 * 
	 * //残り50%をほかのロードに割り当て
	 * 	var urlLoader:URLLoader = new URLLoader();
	 * _progressManager.addProgress(new ProgressEventModel(urlLoader, 0.5);
	 * 
	 * //このイベントにまとめられたパーセントのプログレスが入っています。
	 * _progressManager.addEventListener(ProgressPercentEvent.PERCENT_PROGRESS, progressHandler);
	 * //パーセントが100%まで行ったときの完了イベント
	 * _progressManager.addEventListener(ProgressPercentEvent.PERCENT_COMPLETE, completeHandler);
	 * 
	 * _progressManager.start();
	 * loader.load(new URLRequest("main.swf"));
	 * urlLoader.load(new URLRequest("config.xml"));
	 * 
	 * </listing>
	 * <p><code>ProgressPercentEvent.PERCENT_COMPLETE</code>が飛んでくると、ロード済みの<code>AbstractProgressModel</code>インスタンスが自動で破棄されます。</p>
	 * 
	 * <p>
	 * 	現状、ロード時のセキュリティエラーやIOエラーの監視は行っていません。
	 * </p>
	 * 
	 * @author katapad
	 * @version 0.1.21
	 * @since 2009/02/06 18:39
	 */
	public class MultiProgressManager extends EventDispatcher 
	{
		/**
		 * Progressイベント
		 * @eventType com.katapad.load.multiprogress.ProgressPercentEvent.PERCENT_PROGRESS
		 */
		[Event(name = "percent_progress", type = "com.katapad.load.multiprogress.ProgressPercentEvent")]
		
		/**
		 * Completeイベント
		 * @eventType com.katapad.load.multiprogress.ProgressPercentEvent.PERCENT_COMPLETE
		 */
		[Event(name = "percent_complete", type = "com.katapad.load.multiprogress.ProgressPercentEvent")]
		
		/**
		 * Cancelイベント
		 * @eventType Event.CANCEL
		 */
		[Event(name = "cancel", type = "flash.events.Event")]
		
		//----------------------------------
		//  static var/const
		//----------------------------------
		/**
		 * 2009/08/28 15:34
		 */
		public static const VERSION:String = "0.1.21";
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _progressModelDict:/*AbstractProgressModel*/Dictionary;
		private var _totalPercentRange:Number;
		
		private var _enterframe:DisplayObject;
		private var _percent:Number;
		private var _frictionPercent:Number;
		private var _maxSpeed:Number;
		
		private var _friction:Number;
		private var _useFriction:Boolean;
		
		
		/**
		 * 複数のプログレスをまとめるクラスを作ります
		 * @param	enterframe		EnterFrame用DisplayObject。通常はstageの参照を渡します。
		 * @param	useFriction		パーセントをスムーズにするかどうか
		 * @param	friction		スムーズにするときのfrictionの値。
		 * @param	maxSpeed		useFriction時にパーセントの伸びの1フレームあたりの限界値を設定します。0.1を設定すると 0から1に一気にいくのではなく、0.1、0.2、0.3…とあがっていきます
		 */
		public function MultiProgressManager(enterframe:DisplayObject = null, useFriction:Boolean = true, friction:Number = 0.3, maxSpeed:Number = NaN) 
		{
			init(enterframe, useFriction, friction, maxSpeed);
		}
		
		/**
		 * 初期化
		 * @param	enterframe
		 * @param	useFriction
		 * @param	friction
		 * @param	maxSpeed
		 */
		private function init(enterframe:DisplayObject, useFriction:Boolean, friction:Number, maxSpeed:Number):void 
		{
			_enterframe = enterframe || new Shape();
			_useFriction = useFriction;
			_friction = friction;
			_maxSpeed = maxSpeed;
			_percent = _frictionPercent = _totalPercentRange = 0;
			createDict();
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
		 * progressModelを追加します。
		 * @param	progressModel
		 * @return	addProgressされたProgressModelを返します
		 */
		public function addProgress(progressModel:AbstractProgressModel):AbstractProgressModel
		{
			if (!_progressModelDict)
				createDict();
			if (_totalPercentRange + progressModel.pecentRange > 1)
				throw new Error("percentRangeが大きすぎます。トータルで1.0になるように設定してください");
			_totalPercentRange += progressModel.pecentRange;
			_progressModelDict[progressModel] = progressModel;
			return progressModel;
		}
		
		/**
		 * ModelがaddProgressされてるかどうか
		 * @param	progressModel
		 * @return	ModelがaddProgressされてるかどうか
		 */
		public function hasModel(progressModel:AbstractProgressModel):Boolean
		{
			return progressModel in _progressModelDict;
		}
		
		/**
		 * Modelのインスタンスを投げて削除します
		 * @param	progressModel	削除したいmodel
		 * @param	isDestroyModel	ついでにmodelもdestroyするかどうか
		 * @return	AbstractProgressModel
		 */
		public function removeProgress(progressModel:AbstractProgressModel, isDestroyModel:Boolean = true):AbstractProgressModel
		{
			if (!hasModel(progressModel))
				throw new Error("指定されたAbstractProgressModelがありません。");
			
			removeProgressModelProc(progressModel, isDestroyModel);
			return progressModel;
		}
		
		/**
		 * エラーが起きたときなどに、modelをNullProgressModelに入れ替えます
		 * @param	progressModel
		 * @return
		 */
		public function replaceNullProgress(progressModel:AbstractProgressModel):NullProgressModel
		{
			var range:Number = progressModel.pecentRange;
			removeProgress(progressModel);
			var result:NullProgressModel = new NullProgressModel(range);
			addProgress(result);
			return result;
		}
		
		/**
		 * これを呼ぶとEnterFrameで監視し、progresseventが発生します。
		 */
		public function start():void
		{
			updateOn();
		}
		
		/**
		 * パーセントの監視を中断します
		 */
		public function pause():void
		{
			updateOff();
		}
		
		/**
		 * パーセントの監視を再開します
		 */
		public function resume():void
		{
			updateOn();
		}
		
		/**
		 * キャンセルします。現状destroy()と同じ挙動で、キャンセル後にイベントを発信します
		 * //TODO キャンセルきちんとつくる @2009/04/18 3:00 - katapad
		 */
		public function cancel():void
		{
			destroy();
			dispatchEvent(new Event(Event.CANCEL));
		}
		
		/**
		 * 破棄します
		 */
		public function destroy():void
		{
			if (!_progressModelDict)
				return;
			for each(var model:AbstractProgressModel in _progressModelDict) 
			{
				model.destroy();
			}
			
			//updateOff();
			
			_progressModelDict = null;
			//_enterframe = null;
			/*_totalPercentRange = 0;
			_percent = 0;*/
		}
		
		public function reuse(enterframe:DisplayObject, useFriction:Boolean = true, friction:Number = 0.3, maxSpeed:Number = NaN):void
		{
			destroy();
			_totalPercentRange = 0;
			_percent = 0;
			
			trace( "reuse   enterframe : " + enterframe );
			if (!enterframe)
				throw new Error("EnterFrame がないよ");
			init(enterframe, useFriction, friction, maxSpeed);
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
		private function update(event:Event = null):void 
		{
			//TODO 前のフレームとの変化がなければイベント発信しないほうがいいかもしれない @2009/04/18 3:04 - katapad
			_percent = getTotalPercent();
			calcFrictionPercent();
			//TODO Thresholdにしといたほうがいいかな？ @2009/04/18 3:01 - katapad
			if (1 - _frictionPercent <= 0.001)
				complete();
			else
				dispatchEvent(new ProgressPercentEvent(ProgressPercentEvent.PERCENT_PROGRESS, _frictionPercent));
		}
		
		//--------------------------------------------------------------------------
		//
		//  PRIVATE
		//
		//--------------------------------------------------------------------------
		/**
		 * completeになったらEnterFrameをとめてprogressEventとcompleteイベントを配信し、自動で破棄します
		 */
		private function complete():void
		{
			updateOff();
			_percent = 1.0;
			dispatchEvent(new ProgressPercentEvent(ProgressPercentEvent.PERCENT_PROGRESS, _percent));
			dispatchEvent(new ProgressPercentEvent(ProgressPercentEvent.PERCENT_COMPLETE, _percent));
			destroy();
		}
		
		private function updateOn():void
		{
			trace( "_enterframe : " + _enterframe );
			_enterframe.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function updateOff():void
		{
			_enterframe.removeEventListener(Event.ENTER_FRAME, update);
		}
		
		private function createDict():void
		{
			_progressModelDict = new Dictionary(false);
		}
		
		private function removeProgressModelProc(progressModel:AbstractProgressModel, isDestroyModel:Boolean):void
		{
			_totalPercentRange -= progressModel.pecentRange;
			delete _progressModelDict[progressModel];
			if (isDestroyModel)
				progressModel.destroy();
		}
		
		//----------------------------------
		//  calc
		//----------------------------------
		private function getTotalPercent():Number
		{
			var result:Number = 0.0;
			for each(var model:AbstractProgressModel in _progressModelDict) 
			{
				result += model.revisedPercent;
			}
			return result;
		}
		
		private function calcFrictionPercent():void
		{
			//frictionを使うなら
			if (_useFriction)
			{
				var vx:Number = (_percent - _frictionPercent) * _friction;
				if (isNaN(_maxSpeed))
					_frictionPercent += vx;
				else
					_frictionPercent += Math.min(_maxSpeed, vx)
			}
			//frictionなしならそのまま
			else
			{
				_frictionPercent = _percent;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
		/**
		 * トータルのパーセントを取得します
		 */
		public function get totalPercentRange():Number { return _totalPercentRange; }
		
		/**
		 * 現状のパーセントを取得します
		 */
		public function get percent():Number { return _percent; }
	
		/**
		 * percentRangeが1になるまで、あといくつかを返します
		 * @return Number
		 */
		public function get remainedPercentRange():Number
		{
			return 1 - _totalPercentRange;
		}
		
		/**
		 * パーセントの上昇ををスムーズ（線形補完）にするかどうか
		 */
		public function get useFriction():Boolean { return _useFriction; }
		
		public function set useFriction(value:Boolean):void 
		{
			_useFriction = value;
		}
		
		/**
		 * スムーズにするときのfrictionの値。
		 */
		public function get friction():Number { return _friction; }
		
		public function set friction(value:Number):void 
		{
			_friction = value;
		}
		
		/**
		 * useFriction時にパーセントの伸びの1フレームあたりの限界値を設定します。0.1を設定すると 0から1に一気にいくのではなく、0.1、0.2、0.3…とあがっていきます
		 */
		public function get maxSpeed():Number { return _maxSpeed; }
		
		public function set maxSpeed(value:Number):void 
		{
			_maxSpeed = value;
		}
		
	}
	
}
