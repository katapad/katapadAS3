package com.katapad.sound
{
import com.greensock.easing.Linear;
import com.greensock.TweenMax;

import flash.display.Stage;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;

/**
 * サウンドマネージャ
 * //TODO  remove系の実装 @2010/04/16 21:00 - katapad
 * //TODO  Tweenエンジンを切り離したい @2010/04/16 21:00 - katapad
 * @author nanlow, katapad
 * @version 0.2.0
 * @since 2010/04/01 15:40:30
 */
public class SoundManager extends EventDispatcher
{
	public static const MASTER_VOLUME_CHANGE:String = 'volumeChange';


	private var _defaultVolume:Number;
	private var _seList:Array = [];
	private var _bgmList:Array = [];
	protected var _masterVolume:Number;
	protected var _currentBGM:SoundData;

	protected var _masterTarget:Object;
	//private var _stage:Stage;
	protected var _soundTransform:SoundTransform;


	public function SoundManager(defaultVolume:Number = 0.5)
	{
		SoundData.manager = this;
		_init(defaultVolume);
	}

	/**
	 * 初期化
	 */
	private function _init(defaultVolume:Number):void
	{
		_defaultVolume = defaultVolume;
		_masterVolume = _defaultVolume;
	}

	//--------------------------------------------------------------------------
	//
	//  public
	//
	//--------------------------------------------------------------------------
	//public function _checkSE(soundID:String):void
	//{
	//for (var i:* in _seList)
	//{
	//if (i == soundID)
	//throw new Error("soundID : " + soundID + " はすでに登録されています。" );
	//}
	//}

	//----------------------------------
	//  add
	//----------------------------------
	/**
	 * 音データの追加
	 */
	public function addBGM(soundID:String, sound:Sound, volume:Number):SoundData
	{
		if (containsBGM(soundID))
			_throwAddError(soundID);
		_bgmList[soundID] = new SoundData(sound, volume, soundID);
		return _bgmList[soundID];
	}

	/**
	 * 音データの追加
	 */
	public function add(soundID:String, sound:Sound, volume:Number = 0.5):void
	{
		/*for (var i:* in _seList)
		 {
		 trace( "i : " + i );
		 trace( "soundID : " + soundID );
		 if (i == soundID)
		 throw new Error("soundID : " + soundID + " はすでに登録されています。" );
		 }*/

		if (containsSE(soundID))
			_throwAddError(soundID);
		//trace("volume : " + volume);
		_seList[soundID] = new SoundData(sound, volume, soundID);
	}

	/**
	 * SEが登録されているかどうか
	 * @param    soundID
	 * @return
	 */
	public function containsSE(soundID:String):Boolean
	{
		return _seList[soundID] != null;
	}

	/**
	 * BGMが登録されているかどうか
	 * @param    soundID
	 * @return
	 */
	public function containsBGM(soundID:String):Boolean
	{
		return _bgmList[soundID] != null;
	}

	//----------------------------------
	//  play/stop control
	//----------------------------------
	/**
	 * 再生
	 */
	public function play(soundID:String, overwrite:Boolean = true):SoundChannel
	{
		if (overwrite)
			stop(soundID);

		var sData:SoundData = _getSE(soundID);
		if (!sData)
			return null;
		sData.volume = sData.defaultVolume;
		return sData.play(false, _masterVolume);
	}

	/**
	 * 停止
	 */
	public function stop(soundID:String):void
	{
		var data:SoundData = _getSE(soundID);
		if (data)
			data.stop();
	}

	/**
	 * BGMの再生
	 */
	public function playBGM(soundID:String, loop:Boolean = true):void
	{
		fadeInBGM(soundID, loop, 0, 0);
	}

	public function stopBGM():void
	{
		fadeOutBGM();
	}

	/**
	 * BGMの停止
	 */
	public function fadeOutBGM(animTime:Number = 0):void
	{
		if (_currentBGM)
		{
			TweenMax.killTweensOf(_currentBGM);

			if (_masterVolume != 0 && animTime != 0)
			{
				TweenMax.to(_currentBGM, animTime, { volume: 0, ease: Linear.easeNone, onComplete: _stopBGM, onCompleteParams: [_currentBGM] });
			}
			else
			{
				_currentBGM.volume = 0;
				_currentBGM.stop();
			}

			_currentBGM = null;
		}
	}

	public function fadeOutBGMTemporary(animTime:Number = 0):void
	{
		if (_currentBGM)
		{
			TweenMax.killTweensOf(_currentBGM);
			TweenMax.to(_currentBGM, animTime, { volume: 0, ease: Linear.easeNone, onComplete: _currentBGM.stop });
//			TweenMax.to(_currentBGM, animTime, { volume: _currentBGM.defaultVolume * 0.3, ease: Linear.easeNone });
		}
	}
	public function fadeInBGMTemporary(animTime:Number = 0):void
	{
		if (_currentBGM && _currentBGM.volume == 0)
		{
			TweenMax.killTweensOf(_currentBGM);
			_currentBGM.stop();
			_currentBGM.play(true, _currentBGM.defaultVolume);
			TweenMax.to(_currentBGM, 0.01, { volume: _currentBGM.defaultVolume, ease: Linear.easeNone });
		}
	}

	private function _stopBGM(bgm:SoundData):void
	{
		if (bgm != _currentBGM)
			bgm.stop();
	}

	public function fadeInBGM(soundID:String, loop:Boolean = true, animTime:Number = 0.5, delayTime:Number = 0.04):void
	{
		var newBGM:SoundData = _getBgm(soundID);
		if (newBGM != _currentBGM)
		{
			fadeOutBGM();
			_fadeInBGM(newBGM, animTime, delayTime, loop);
		}
	}

	private function _fadeInBGM(newBGM:SoundData, animTime:Number, delayTime:Number, loop:Boolean):void
	{
		if (newBGM)
		{
			TweenMax.killTweensOf(newBGM);
			if (_masterVolume != 0 && animTime != 0)
			{
				newBGM.volume = 0;
				TweenMax.to(newBGM, animTime, {
					volume: newBGM.defaultVolume * _masterVolume,
					ease: Linear.easeNone,
					delay: delayTime,
					onStart: _startChange,
					onStartParams: [newBGM, loop]
				});
			}
			else
			{
				newBGM.volume = newBGM.defaultVolume * _masterVolume;
				if (!newBGM.isPlaying)
					newBGM.play(loop, newBGM.defaultVolume * _masterVolume);
			}
			_currentBGM = newBGM;
		}
	}

	/**
	 * BGMの変更
	 */
	public function changeBGM(soundID:String, loop:Boolean = true, showAnimTime:Number = 0.5):void
	{
		var newBGM:SoundData = _getBgm(soundID);
		if (newBGM != _currentBGM)
		{
			var delayTime:Number = 0.0;
			if (_currentBGM)
			{
				fadeOutBGM(0.5);
				delayTime = 0.3;
			}
			_fadeInBGM(newBGM, showAnimTime, delayTime, loop);
		}
	}

	/**
	 * 全て停止
	 */
	public function stopAll():void
	{
		var sound:SoundData;
		for each(sound in _seList)
		{
			sound.stop();
		}
		for each(sound in _bgmList)
		{
			sound.stop();
		}
		/*for (var i:* in _seList)
		 {
		 _seList[i].stop();
		 }
		 for (i in _bgmList)
		 {
		 _bgmList[i].stop();
		 }*/
		_currentBGM = null;
	}

	//----------------------------------
	//  Volume
	//----------------------------------
	/**
	 * 指定サウンドのボリュームを変更
	 */
	public function setVolume(soundID:String, num:Number):void
	{
		_getSound(soundID).volume = num;
	}

	/**
	 * ボリュームのフェードアウト
	 */
	public function fadeOut():void
	{
		//Tweener.addTween(this, { masterVolume:0.0, transition:'linear', time:0.5 } );
		TweenMax.to(this, 0.5, { masterVolume: 0.0, transition: 'linear' });
	}

	/**
	 * ボリュームのフェードイン
	 */
	public function fadeIn():void
	{
		//Tweener.addTween(this, { masterVolume:_defaultVolume, transition:'linear', time:0.5 } );
		TweenMax.to(this, 0.5, { masterVolume: _defaultVolume, transition: 'linear' });
	}


	/**
	 * サウンドデータの取得
	 */
	public function getSound(soundID:String):Sound
	{
		var data:SoundData = _getSound(soundID);
		if (data)
			return data.sound;
		else
			return null;
		//return _getSound(soundID).sound;
	}

	public function getSoundData(soundID:String):SoundData
	{
		return _getSound(soundID);
	}

	//--------------------------------------------------------------------------
	//
	//  private
	//
	//--------------------------------------------------------------------------
	//----------------------------------
	//  get
	//----------------------------------
	protected function _getSound(soundID:String):SoundData
	{
		var se:SoundData = _seList[soundID];
		var bgm:SoundData = _bgmList[soundID];

		if (se == null && bgm == null)
			_throwGetError(soundID);

		return se ? se : bgm;
	}

	protected function _getSE(soundID:String):SoundData
	{
		if (!containsSE(soundID))
			_throwGetError(soundID);
		return _seList[soundID];
	}

	protected function _getBgm(soundID:String):SoundData
	{
		if (!containsBGM(soundID))
			_throwGetError(soundID);
		return _bgmList[soundID];
	}

	//----------------------------------
	//  change
	//----------------------------------

	protected function _startChange(data:SoundData, loop:Boolean):void
	{
		data.volume = 0;
		if (!data.isPlaying)
			data.play(loop, 0, data.currentTime);
		_currentBGM = data;
	}

	//----------------------------------
	//  Error
	//----------------------------------
	private function _throwGetError(soundID:String):void
	{
		//throw new Error('指定されたID : ' + soundID + ' に対応するデータがありません。');
		trace('指定されたID : ' + soundID + ' に対応するデータがありません。');
	}

	private function _throwAddError(soundID:String):void
	{
		//throw new Error("soundID : " + soundID + " はすでに登録されています。" );
		trace("soundID : " + soundID + " はすでに登録されています。");
	}

	//--------------------------------------------------------------------------
	//
	//  getter/setter
	//
	//--------------------------------------------------------------------------
	public function get masterVolume():Number
	{
		return _masterVolume
	};
	public function set masterVolume(value:Number):void
	{
		var sound:SoundData
		if (value <= 0)
		{
			for each(sound in _seList)
			{
				sound.volume = 0;
				//trace("sound.volume : " + sound.volume, sound.sound);
			}
			for each(sound in _bgmList)
			{
				sound.volume = 0;
				//sound.volume = value;
			}

		}
		else
		{
			for each(sound in _seList)
			{
				sound.volume = sound.defaultVolume * value;
				//trace("sound.volume : " + sound.volume, sound.sound);
			}
			for each(sound in _bgmList)
			{
				sound.volume = sound.defaultVolume * value;
				trace("sound.volume : " + sound.volume, sound.sound);

			}
		}

		if (_masterTarget != value)
			dispatchEvent(new Event(MASTER_VOLUME_CHANGE));

		_masterVolume = value;

		if (_masterTarget)
		{
			_setMasterTargetVolume();
		}
	}

	private function _setMasterTargetVolume():void
	{
		if (masterTarget is Stage)
		{
			return;
		}
		else
		{
			_soundTransform = _masterTarget.soundTransform;
			_soundTransform.volume = _masterVolume;
			_masterTarget.soundTransform = _soundTransform;
		}
	}

	public function get masterTarget():Object
	{
		return _masterTarget;
	}

	public function set masterTarget(value:Object):void
	{
		_masterTarget = value;
		_setMasterTargetVolume();
	}
}
}
