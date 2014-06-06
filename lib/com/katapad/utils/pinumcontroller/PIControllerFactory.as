package com.katapad.utils.pinumcontroller 
{
	import flash.errors.IllegalOperationError;
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2009/02/19 13:58
	 */
	public class PIControllerFactory 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		//private var
		
		/**
		 * cannot construct
		 */
		public function PIControllerFactory() 
		{
			throw new IllegalOperationError("LogoTypoPosition cannot construct");
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
		 * 
		 * @param	labelText
		 * @param	Hi
		 * @param	Low
		 * @return
		 */
		public static function create(labelText:String, Hi:Number = 100, Low:Number = 0):PI_NumberController
		{
			var result:PI_NumberController = new PI_NumberController();
			result.label = labelText;
			result.Hi = Hi;
			result.Low = Low;
			result.enterFrame();
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
