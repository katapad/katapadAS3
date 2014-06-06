package com.katapad.utils 
{
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2009/02/05 20:02
	 */
	public class PathUtils 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		//public static const LOCAL_FILE:String = "local_file";
		public static const HTTP:String = "http";
		public static const HTTPS:String = "https";
		public static const HTTP_OR_HTTPS:String = "http_or_https";
		private static var _stage:Stage;
		
		
		/**
		 * [static]ファイルパスなどのStringを使いやすくするUtilです。
		 * コンストラクトできません。
		 */
		public function PathUtils() 
		{
			throw new IllegalOperationError("cannot construct");
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
		public static function addQuery(path:String, query:Object):String
		{
			var operator:String;
			if (path.indexOf("?") == -1)
				operator = "?";
			else
				operator = "&";
			
			for (var name:String in query) 
			{
				path += operator + name + "=" + query[name];
				//ifで分岐する意味がなかったので（if (i!=0）としても、おなじ処理を繰り返すので、もう代入したほうが早い）
				operator = "&";
			}
			return path;
		}
		
		public static function addNoCacheQuery(path:String):String
		{
			var query:String;
			if (path.indexOf("?") == -1)
				path += "?";
			else
				path += "&fl_nocache="
				
			return path + new Date().getTime();
		}
		
		public static function initStage(stage:Stage):void
		{
			_stage = stage;
		}
		
		public static function isConnectHTTP(path:String, mode:String = PathUtils.HTTP_OR_HTTPS):Boolean
		{
			return httpTest(path, mode);
		}
		
		public static function isStageConnectHttp(mode:String = PathUtils.HTTP_OR_HTTPS):Boolean
		{
			checkStage();
			return httpTest(_stage.loaderInfo.url, mode);
		}
		
		/**
		 * 拡張子のみ抜き出します。ドットがなければnullを返します
		 * @param	path
		 * @param	containsDot	ドットも含めるかどうか
		 * @return
		 */
		public static function getFileExtension(path:String, containsDot:Boolean = true):String
		{
			var dotIndex:int = path.lastIndexOf(".");
			if (dotIndex == -1)
				return null;
			if (!containsDot)
				++dotIndex;
			return path.substring(dotIndex, path.length);
		}
		
		/**
		 * 拡張子を抜いたファイル名のみ取得します。
		 * @param	path
		 * @return
		 */
		public static function getFileName(path:String):String
		{
			return path.substring(path.lastIndexOf("/") + 1, path.lastIndexOf("."));
		}
		
		/**
		 * 拡張子まで含めたファイル名を取得します.不正なフォーマットだとnullを返します。
		 * @param	path
		 * @return
		 */
		public static function getFileNameWithExtension(path:String):String
		{
			if (!validatePath(path))
				return null;
			return path.substring(path.lastIndexOf("/") + 1, path.length);
		}
		
		/**
		 * ディレクトリのパスを拾ってきます。不正なフォーマットだとnullを返します。
		 * @param	path
		 * @param	isEndSlash	最後にスラッシュが必要かどうか
		 * @return
		 */
		public static function getDirectoryPath(path:String, isEndSlash:Boolean = true):String
		{
			if (!validatePath(path))
				return null;
			
			var lastIndex:int = path.lastIndexOf("/");
			if (isEndSlash)
				++lastIndex;
			return path.substring(0, lastIndex);
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
		private static function validatePath(path:String):Boolean
		{
			if (path.indexOf("/") == -1)
			{
				//throw new Error("pathに「/」が含まれていません");
				return false;
			}
			return true;
		}
		
		private static function checkStage():void
		{
			if (!_stage)
				throw new Error("stageの参照が必要です。PathUtils.initStage(stage:Stage)してください");
		}
		private static function httpTest(path:String, mode:String):Boolean
		{
			var result:Boolean = false;
			switch (mode) 
			{
				case PathUtils.HTTP:
					result = /^http:\/\//.test(path);
					break;
				case PathUtils.HTTPS:
					result = /^https:\/\//.test(path);
					break;
				case PathUtils.HTTP_OR_HTTPS:
					result = /^http:\/\//.test(path) || /^https:\/\//.test(path);
					break;
			}
			return result;
		}
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
	
	}
	
}
