package com.katapad.sound
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author nanlow
	 * @version 0.0.1
	 * @since 2010/04/01 18:12:52
	 */
	public class SoundData 
	{
		private var _sound:Sound;
		private var _channelList:/*SoundChannel*/Array = [];
		private var _volume:Number;
		private var _defaultVolume:Number;
		private var _isLoop:Boolean;
		public static var manager:SoundManager;
		private var _id:String;
		private var _currentTime:Number;
		
		public function SoundData(sound:Sound, volume:Number, id:String = null)
		{
			_id = id;
			_currentTime = 0;
			_init(sound, volume);
		}
		/**
		 * 初期化
		 */
		private function _init(sound:Sound, volume:Number):void
		{
			_sound = sound;
			_volume = volume;
			_defaultVolume = volume;
		}
		//--------------------------------------------------------------------------
		//
		//  private
		//
		//--------------------------------------------------------------------------
		//--------------------------------------------------------------------------
		//
		//  public
		//
		//--------------------------------------------------------------------------
		public function play(loop:Boolean = false, masterVolume:Number = 0, startTime:Number = 0):SoundChannel
		{
			try
			{
				_isLoop = loop;
				var channel:SoundChannel = _sound.play(startTime);
				channel.soundTransform = new SoundTransform(_volume * masterVolume);
				channel.addEventListener(Event.SOUND_COMPLETE, _onSoundCompleteHandler);
				_channelList.push(channel);
				return channel;
			}
			catch (err:Error)
			{
				
			}
			return null;
		}
		//public function pause():void
		//{
			//
		//}
		public function stop():void
		{
			for (var i:int = 0, len:uint = _channelList.length; i < len; i++)
			{
				if (i == 0)
					_currentTime = _channelList[0].position;
				_channelList[i].stop();
			}
			_channelList = [];
		}

		//--------------------------------------------------------------------------
		//
		//  getter/setter
		//
		//--------------------------------------------------------------------------
		public function get sound():Sound { return _sound; }
		public function get volume():Number { return _volume; }
		public function set volume(value:Number):void
		{
			for (var i:int = 0, len:uint = _channelList.length; i < len; i++)
			{
				_channelList[i].soundTransform = new SoundTransform(value);
			}
			_volume = value;
		}
		
		public function get defaultVolume():Number { return _defaultVolume; }
		//--------------------------------------------------------------------------
		//
		//  handler
		//
		//--------------------------------------------------------------------------
		private function _onSoundCompleteHandler(e:Event):void 
		{
			e.target.removeEventListener(Event.SOUND_COMPLETE, _onSoundCompleteHandler);
			_channelList.shift();
			
			if (_isLoop)
				play(_isLoop, manager.masterVolume);
		}

		public function get id():String
		{
			return _id;
		}

		public function get currentTime():Number
		{
			return _currentTime;
		}

		public function get isPlaying():Boolean
		{
			return _channelList.length > 0;
		}
	}
}
