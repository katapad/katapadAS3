package com.katapad.model 
{
	import com.katapad.core.command.GetURLCommand;
	import flash.display.Bitmap;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2009/12/03 17:13
	 */
	public class ImgData 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _command:GetURLCommand;
		private var _src:String;
		private var _bitmap:Bitmap;
		
		public function ImgData(src:String, command:GetURLCommand) 
		{
			_src = src;
			_command = command;
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
		public function toString():String 
		{
			return "[ImgData " + "src: " + _src + ", command: " + _command + "]";
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
		public function get hasLink():Boolean 
		{
			return _command != null;
		}
		public function get bitmap():Bitmap { return _bitmap; }
		
		public function set bitmap(value:Bitmap):void 
		{
			_bitmap = value;
		}
		
		public function get src():String { return _src; }
		
		public function get command():GetURLCommand { return _command; }
	
	}
	
}
