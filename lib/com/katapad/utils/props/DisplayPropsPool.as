package com.katapad.utils.props
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.utils.Dictionary;

	/**
	 * DisplayObjectの表示に関わるプリミティブな値を保存します。
	 * @author katapad.com
	 * @version 0.1
	 * @since 2009/09/23 16:30
	 */
	public class DisplayPropsPool
	{
		//----------------------------------
		//  static var/const
		//----------------------------------

		//----------------------------------
		//  instance var
		//----------------------------------
		private var _dict:Dictionary;

		/**
		 * DisplayObjectの表示に関わるプリミティブな値を保存します。
		 * 保存対象は x, y, alpha, rotation, scaleX, scaleY です。transformは保存しません。
		 *
		 * @param	container	addFromContainerを最初にしたいとき用です
		 * @see	#addFromContainer
		 */
		public function DisplayPropsPool(container:DisplayObjectContainer = null)
		{
			init(container);
		}

		/**
		 * 初期化します
		 */
		public function init(container:DisplayObjectContainer = null):void
		{
			_dict = new Dictionary();
			if (container)
				addFromContainer(container);
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
		 * DisplayObjectの基本プロパティを保存します。引数は
		 * DisplayObjectのインスタンス もしくは DisplayObjectのインスタンスが入った配列を指定します。
		 * 可変長引数なので、どちらも同時に複数のDisplayObjectを扱えます。
		 * @param	...args
		 */
		public function add(...args):void
		{
			if (args[0] == undefined)
				return

			var list:Array = getMCList(args);
			for each(var mc:DisplayObject in list)
			{
				_dict[mc] = new DisplayProps(mc)
			}
		}

		/**
		 * コンテナの中に入っているMCの位置をすべて保存します。
		 * @param	container
		 */
		public function addFromContainer(container:DisplayObjectContainer):void
		{
			for (var i:int = 0, n:int = container.numChildren; i < n; ++i)
			{
				var mc:DisplayObject = container.getChildAt(i);
				_dict[mc] = new DisplayProps(mc);
			}
		}

		/**
		 * DisplayObjectのコレクションから MCのpropsを保存します
		 * @param	list
		 */
		public function addFromArray(list:Array):void
		{
			for each(var mc:DisplayObject in list)
			{
				_dict[mc] = new DisplayProps(mc);
			}
		}

		/**
		 * プロパティを保存したかどうか
		 * @param	mc
		 * @return
		 */
		public function has(mc:DisplayObject):Boolean
		{
			return _dict[mc] != undefined;
		}

		/**
		 * 保存したプロパティを取得します。
		 * @param	mc
		 * @return	DisplayProps
		 */
		public function get(mc:DisplayObject):DisplayProps
		{
			var props:DisplayProps = _dict[mc];
			if (!props)
				throw new Error("指定されたmcがaddされていません");
			return props;
		}

		/**
		 * x
		 * @param	mc
		 * @return	DisplayProps
		 */
		public function getX(mc:DisplayObject):Number
		{
			var props:DisplayProps = _dict[mc];
			if (!props)
				throw new Error("指定されたmcがaddされていません");
			return props.x;
		}

		/**
		 * y
		 * @param	mc
		 * @return	DisplayProps
		 */
		public function getY(mc:DisplayObject):Number
		{
			var props:DisplayProps = _dict[mc];
			if (!props)
				throw new Error("指定されたmcがaddされていません");
			return props.y;
		}

		/**
		 * y
		 * @param	mc
		 * @return	DisplayProps
		 */
		public function getRotate(mc:DisplayObject):Number
		{
			var props:DisplayProps = _dict[mc];
			if (!props)
				throw new Error("指定されたmcがaddされていません");
			return props.rotation;
		}

		/**
		 * OffsetX
		 * @param	mc
		 * @return	DisplayProps
		 */
		public function setOffsetX(mc:DisplayObject, offsetX:Number = 0):Number
		{
			var props:DisplayProps = _dict[mc];
			if (!props)
				throw new Error("指定されたmcがaddされていません");
			return mc.x = props.x + offsetX;
		}

		/**
		 * OffsetY
		 * @param	mc
		 * @return	DisplayProps
		 */
		public function setOffsetY(mc:DisplayObject, offsetY:Number = 0):Number
		{
			var props:DisplayProps = _dict[mc];
			if (!props)
				throw new Error("指定されたmcがaddされていません");
			return mc.y = props.y + offsetY;
		}

		/**
		 * OffsetY
		 * @param	mc
		 * @return	DisplayProps
		 */
		public function setOffsetXY(mc:DisplayObject, offsetX:Number = 0, offsetY:Number = 0):DisplayProps
		{
			var props:DisplayProps = _dict[mc];
			if (!props)
				throw new Error("指定されたmcがaddされていません");

			mc.x = props.x + offsetX;
			mc.y = props.y + offsetY;
			return props;
		}

		/**
		 * 元の配置に戻しますc
		 * @param	mc
		 */
		public function returnProps(mc:DisplayObject):void
		{
			var prop:DisplayProps = get(mc);
			mc.x = prop.x;
			mc.y = prop.y;
			mc.rotation = prop.rotation;
			mc.scaleX = prop.scaleX;
			mc.scaleY = prop.scaleY;
			mc.alpha = prop.alpha;
		}

		/**
		 * 削除します
		 * @param	mc
		 * @return
		 */
		public function remove(mc:DisplayObject):DisplayProps
		{
			return _remove(mc);
		}

		/**
		 * 複数の保存されたプロパティを削除します
		 * @param	...args
		 */
		public function removeMCs(...args):void
		{
			if (args[0] == undefined)
				return;

			var list:Array = getMCList(args);
			for each(var mc:DisplayObject in list)
			{
				//_remove(mc);
				//戻り値を使わないのでシンプルに
				delete _dict[mc];
			}
		}

		/**
		 * 保存されたプロパティをすべて削除します
		 */
		public function removeAll():void
		{
			for (var key:* in _dict)
			{
				delete _dict[key];
			}
		}

		/**
		 * すべてを破棄します。再利用できません。
		 */
		public function destroy():void
		{
			removeAll();
			_dict = null;
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
		private function _remove(mc:DisplayObject):DisplayProps
		{
			var props:DisplayProps = _dict[mc];
			delete _dict[mc];
			return props;
		}

		private function getMCList(args:*):Array
		{
			var result:Array;
			if (args[0] is Array)
				result = args[0];
			else
				result = args.concat();
			return result;
		}

		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------

	}

}
