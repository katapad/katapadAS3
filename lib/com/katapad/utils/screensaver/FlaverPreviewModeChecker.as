package com.katapad.utils.screensaver 
{
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2009/03/19 23:20
	 */
	public class FlaverPreviewModeChecker 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		//private var
		
		/**
		 * コンストラクタ
		 */
		public function FlaverPreviewModeChecker() 
		{
			throw new IllegalOperationError("FlaverPreviewModeChecker Class use Static only");
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		public static function isPreview(stage:Stage):Boolean
		{
			var mode:String = stage.loaderInfo.parameters["flavermode"];
			var result:Boolean;
			switch (mode)
			{
				case "normal" :
					result = false;
					break;
				case "preview" :
					result = true;
					break;
				default :
					result = false;
					break;
			}
			return result;
		}
		
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
