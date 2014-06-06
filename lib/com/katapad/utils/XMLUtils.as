package com.katapad.utils 
{
	import flash.errors.IllegalOperationError;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2009/11/02 19:58
	 */
	public class XMLUtils 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		/**
		 * Dont construct
		 */
		public function XMLUtils() 
		{
			throw new IllegalOperationError("XMLUtils cannot construct");
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC
		//
		//--------------------------------------------------------------------------
		/**
		 * 名前空間を削除します
		 * via http://clockmaker.jp/blog/2008/09/delete_xml_e4x_namespace/
		 * @param	xmlText
		 * @return namespace宣言を取り去ったXML
		 */
		public static function deleteNameSpace(xmlText:String):XML
		{
			xmlText = xmlText.replace(new RegExp("xmlns[^\"]*\"[^\"]*\"", "gi"), "");
			xmlText = xmlText.replace(new RegExp("xsi[^\"]*\"[^\"]*\"", "gi"), "");
			return new XML(xmlText);
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
