package com.katapad.sound 
{
	import com.katapad.utils.StStage;
	import flash.net.SharedObject;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2010/04/16 19:05
	 */
	public class SiSoundManager extends SoundManager 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		public static const DEFAULT_VOLUME:Number = 1;
		
		public static const SO_NAME:String = 'soundVolume';
		
		private static var _instance:SiSoundManager;
		private var _so:SharedObject;
		/**
		 * getInstance
		 */
		public static function getInstance():SiSoundManager
		{
			if (_instance == null) 
				_instance = new SiSoundManager(new SingletonEnforcer());
			return _instance;
		}
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		//private var
		
		/**
		 * コンストラクタ
		 */
		public function SiSoundManager(enforcer:SingletonEnforcer) 
		{
			super();
			_init();
		}
		
		private function _initVolume():void 
		{
			_so = SharedObject.getLocal('sounds', '/');
			var volume:Number;
			if (_so.data.soundVolume == undefined)
			{
				_so.setProperty(SO_NAME, DEFAULT_VOLUME);
				volume = DEFAULT_VOLUME;

			}
			else
			{
				volume = _so.data.soundVolume;
				volume = _checkVolume(volume);
			}
			_masterVolume = volume;
//			_masterVolume = 1;
		}
		
		private function _checkVolume(volume:Number):Number 
		{
			if (volume < 0 || 1 < volume)
			{
				throw new Error('volumeの値が不正です。 -> ' + volume);
				return DEFAULT_VOLUME;
			}
			
			return volume;
		}
		
		private function _init():void
		{
			_initVolume();
			masterTarget = StStage.stage;
		}
		
		public function mute():void
		{
			masterVolume = 0;
		}
		
		public function unmute():void
		{
			masterVolume = DEFAULT_VOLUME;
		}
		
		public function initVolume():void
		{
			_initVolume();
		}

		public function get isMute():Boolean
		{
			return masterVolume <= 0;
		}
		//--------------------------------------------------------------------------
		//
		//  OVERRIDE
		//
		//--------------------------------------------------------------------------
		override public function get masterVolume():Number { return super.masterVolume; }
		
		override public function set masterVolume(value:Number):void 
		{
			if (_masterVolume == value)
				return;
			super.masterVolume = value;
			_so.setProperty(SO_NAME, value);
		}
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		
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

class SingletonEnforcer 
{
	function SingletonEnforcer() 
	{
	}
}
