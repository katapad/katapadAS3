package com.katapad.utils 
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.errors.IllegalOperationError;
import flash.geom.Matrix;
import flash.text.TextField;
import flash.utils.getDefinitionByName;

/**
	 * DisplayObject周りの作業を簡略化するユーティリティ
	 * @author katapad
	 * @version 0.2
	 * @since 2008/05/26 20:17
	 */

	public class DOUtils
	{
		/**
		 * Shortcut of mc.x = -mc.width * 0.5; mc.y = -mc.height * 0.5;
		 * @param	mc
		 * @param	round
		 */
		public static function mcCentering(mc:DisplayObject, round:Boolean = false):void
		{
			if (round)
			{
				mc.x = -mc.width >> 1;
				mc.y = -mc.height >> 1;
			}
			else
			{
				mc.x = -mc.width * 0.5;
				mc.y = -mc.height * 0.5;
			}
		}
		
		/**
		 * いちいちこのように<code>mc._xscale = mc._yscale = value;</code>書くのが面倒なときに使う。
		 * @param	mc
		 * @param	value
		 */
		public static function scale(dobj:DisplayObject, value:Number):void
		{
			dobj.scaleX = dobj.scaleY = value;
		}
		
		
		/**
		 * _autoAlpha = 0;っぽいことをします。
		 * visible = false; alpha = 0.0;に設定します。
		 * @param	...args	mcの入った配列をひとつかDOUtils.hide([mc1, mc2, mc3])、mcを列挙していきます（DOUtils.hide(mc1, mc2, mc3);
		 */
		public static function hide(...args):void
		{
			if (args[0] == undefined)
				return
			
			var list:Array = getMCList(args);
			 
			for each(var mc:DisplayObject in list) 
			{
				mc.alpha = 0;
				mc.visible = false;
			}
		}
		
		/**
		 * _autoAlpha = 1.0;っぽいことをします。
		 * visible = true; alpha = 1.0;に設定します。
		 * @param	...args	mcの入った配列をひとつかDOUtils.show([mc1, mc2, mc3])、mcを列挙していきます（DOUtils.show(mc1, mc2, mc3);
		 */
		public static function show(...args):void
		{
			if (args[0] == undefined)
				return
			
			var list:Array = getMCList(args);
			
			for each(var mc:DisplayObject in list) 
			{
				mc.alpha = 1.0;
				mc.visible = true;
			}
		}
		
		/**
		 * コンテナ内部の子要素をすべてremoveします。
		 * @param	container
		 */
		public static function removeChildren(container:DisplayObjectContainer):void
		{
			for (var i:int = container.numChildren - 1; i >= 0; --i) 
			{
				container.removeChild(container.getChildAt(i));
			}
			/*while (container.numChildren) 
			{
				container.removeChild(container.getChildAt(0));
			}*/
		}
		
		/**
		 * マウス操作系をロックします。Sprite以上ならボタンモードのオフ・子要素も排除します。
		 * @param	obj
		 */
		public static function lock(obj:InteractiveObject):void
		{
			obj.mouseEnabled = false;
			if (obj is Sprite)
				Sprite(obj).mouseChildren = Sprite(obj).buttonMode = false;
		}
		/**
		 * mc.mouseChildren = mc.mouseEnabled = false;
		 * @param	...args
		 */
		public static function mouseLock(...args):void
		{
			if (args[0] == undefined)
				return
			
			var list:Array = getMCList(args);
			for each(var mc:Sprite in list) 
			{
				mc.mouseChildren = mc.mouseEnabled = false;
			}
		}
		
		/**
		 * mc.mouseChildren = mc.mouseEnabled = false;
		 * @param	...args
		 */
		public static function mouseUnlock(...args):void
		{
			if (args[0] == undefined)
				return
			
			var list:Array = getMCList(args);
			for each(var mc:Sprite in list) 
			{
				mc.mouseChildren = mc.mouseEnabled = true;
			}
		}
		
		/**
		 * テキストフィールドのマウス系をロック
		 * @param	...args
		 */
		public static function textLock(...args):void
		{
			if (args[0] == undefined)
				return
			
			var list:Array = getMCList(args);
			for each(var txt:TextField in list) 
			{
				txt.mouseEnabled = txt.mouseWheelEnabled = false;
			}
		}
		
		public static function lockByArray(list:Array):void
		{
			for each(var mc:Sprite  in list) 
			{
				mc.mouseChildren = mc.mouseEnabled = false;
			}
		}
		
		/**
		 * マウス操作系のロックを解除します。Sprite以上ならButtonModeもtrueにします。
		 * @param	obj
		 */
		public static function unlock(obj:InteractiveObject):void
		{
			obj.mouseEnabled = true;
			if (obj is DisplayObjectContainer)
				Sprite(obj).mouseChildren = Sprite(obj).buttonMode = true;
		}
		
		/**
		 * getDefinitionByNameするやつのinstanceを返す
		 * @usage	classが実際に使われている形跡がないとエラーになる 
		 * 			http://www.bongo.ne.jp/~gankon/blog/2006/08/flashamazonecs_14.html
		 * @param	fullClassPath
		 * @return	new fullClassPath()
		 */
		public static function getClassInstance(fullClassPath:String):*
		{
			var classDefinition:Class = getDefinitionByName(fullClassPath) as Class;
			return new classDefinition();
		}
		/**
		 * AS2のattachMovie的なこと。initObjectは非対応。
		 * @usage	classが実際に使われている形跡がないとエラーになる 
		 * 			http://www.bongo.ne.jp/~gankon/blog/2006/08/flashamazonecs_14.html
		 * @param	target
		 * @param	fullClassPath
		 * @param	depth
		 * @return	new fullClassPath()
		 */
		public static function attachMovie(target:DisplayObjectContainer, fullClassPath:String, depth:uint = undefined):*
		{
			var instance:DisplayObject = getClassInstance(fullClassPath) as DisplayObject;
			if (depth)
				target.addChildAt(instance, depth);
			else
				target.addChild(instance);
			return instance;
		}
		
		/**
		 * _1とか_2とかのナンバリングされたMCをArrayにぶちこみます
		 * @param	layer
		 * @param	prefix
		 * @param	postfix
		 * @param	startNum
		 * @return
		 */
		public static function numberingedMC2Array(layer:DisplayObjectContainer, prefix:String = '_', postfix:String = '', startNum:uint = 0):Array
		{
			var result:Array = [];
			var i:uint = startNum;
			var mc:DisplayObject;
			while ((mc = layer.getChildByName(prefix + i + postfix)) != null) 
			{
				result.push(mc);
				++i;
			}
			return result;
		}
		
		/**
		 * childの上にaddをおきます
		 * @param	chlid
		 * @param	add
		 */
		public static function addAbove(child:DisplayObject, add:DisplayObject):void
		{
			var parent:DisplayObjectContainer = child.parent;
			if (!parent)
			{
				throw new Error("childのparentがnullです");
				return;
			}
			
			//同一の親だったとき
			if (add.parent == parent)
			{
				if (parent.getChildIndex(add) < parent.getChildIndex(child))
				{
					parent.setChildIndex(add, parent.getChildIndex(child) + 1);
				}
			}
			//addに親がないとき
			else if (add.parent == null)
			{
				parent.addChildAt(add, parent.getChildIndex(child));
			}
			else
			{
				throw new Error("add側がすでに違うparentにaddされています")
			}
		}
		
		/**
		 * Childを配列にして返します
		 * @param	container
		 * @return
		 */
		public static function getChildren(container:DisplayObjectContainer):Array
		{
			var result:Array = [];
			for (var i:int = 0, n:int = container.numChildren; i < n; ++i) 
			{
				result[i] = container.getChildAt(i);
			}
			return result;
		}
		
		/**
		 * x, yをコピーします
		 * @param	from
		 * @param	to
		 */
		public static function pasteXY(from:DisplayObject, to:DisplayObject):void
		{
			to.x = from.x;
			to.y = from.y;
		}
		
		/**
		 * 複数のMCに対して、一気にフィルターをかけます
		 * @param	...args	[0] = filters:Array, [1-n] mcs, or mcList:Array
		 */
		public static function applyFilters(...args):void
		{
			if (args[0] == undefined)
				return
			var filters:Array = args.shift();
			var list:Array = getMCList(args);
			for each(var mc:DisplayObject in list) 
			{
				mc.filters = filters;
			}
		}
		/**
		 * 内包するMCすべてにmc.stop();をかけます。再帰です。
		 * @param	mc
		 */
		public static function stopAllChildren(mc:DisplayObjectContainer):void
		{
			for (var i:int = 0, n:int = mc.numChildren; i < n; ++i) 
			{
				var child:DisplayObject = mc.getChildAt(i);
				if (child is MovieClip)
				{
					MovieClip(child).stop();
				}
				if (child is DisplayObjectContainer)
				{
					stopAllChildren(DisplayObjectContainer(child));
				}
			}
		}
		
		/**
		 * 内包するMCすべてにmc.play();をかけます。再帰です。
		 * @param	mc
		 */
		public static function playAllChildren(mc:DisplayObjectContainer):void
		{
			for (var i:int = 0, n:int = mc.numChildren; i < n; ++i) 
			{
				var child:DisplayObject = mc.getChildAt(i);
				if (child is MovieClip)
				{
					MovieClip(child).play();
				}
				if (child is DisplayObjectContainer)
				{
					DOUtils.playAllChildren(DisplayObjectContainer(child));
				}
			}
		}
		
		/**
		 * 内包するMCすべてにmc.gotoAndStop();をかけます。再帰です。
		 * @param	mc
		 */
		public static function gotoAndStopAllChildren(mc:DisplayObjectContainer, frame:Object = 1):void
		{
			for (var i:int = 0, n:int = mc.numChildren; i < n; ++i) 
			{
				var child:DisplayObject = mc.getChildAt(i);
				if (child is MovieClip)
				{
					MovieClip(child).gotoAndStop(frame);
				}
				if (child is DisplayObjectContainer)
				{
					stopAllChildren(DisplayObjectContainer(child));
				}
			}
		}
		
		/**
		 * 内包するMCすべてにmc.gotoAndPlay();をかけます。再帰です。
		 * @param	mc
		 */
		public static function gotoAndPlayAllChildren(mc:DisplayObjectContainer, frame:Object = 1):void
		{
			for (var i:int = 0, n:int = mc.numChildren; i < n; ++i) 
			{
				var child:DisplayObject = mc.getChildAt(i);
				if (child is MovieClip)
				{
					MovieClip(child).gotoAndPlay(frame);
				}
				if (child is DisplayObjectContainer)
				{
					gotoAndPlayAllChildren(DisplayObjectContainer(child));
				}
			}
		}
		
		/**
		 * 再帰的に子どもを見て行って、最初にみつけた名前のmcを返します
		 * @param	mc
		 * @return
		 */
		public static function getChildByName(mc:DisplayObjectContainer, name:String):DisplayObject
		{
			var result:DisplayObject;
			for (var i:int = 0, n:int = mc.numChildren; i < n; ++i) 
			{
				var child:DisplayObject = mc.getChildAt(i);
				if (child.name == name)
				{
					result = child;
					break;
				}
				if (child is MovieClip)
				{
					result = getChildByName(MovieClip(child), name)
					if (result)
						break;
				}
			}
			
			return result;
		}
		
		/**
		 * アスペクト比を保ちながら、長辺にあわせて縮小します
		 * @param	mc
		 */
		public static function setMaxSize(mc:DisplayObject, w:Number, h:Number):void
		{
			var scale:Number = Math.min(w / mc.width, h / mc.height);
			mc.scaleX = mc.scaleY = scale;
		}
		public static function setMiinSize(mc:DisplayObject, w:Number, h:Number):void
		{
			var scale:Number = Math.max(w / mc.width, h / mc.height);
			mc.scaleX = mc.scaleY = scale;
		}
		
		/**
		 * parent調べてエラーなしでremoveChild
		 */
		public static function removeChild(target:DisplayObject):DisplayObject 
		{
			if (target.parent)
				return target.parent.removeChild(target);
			
			return null;
		}
		
		/**
		 * matrix3dでボヤボヤになった画像をシャキッとさせたいときにつかう。matrix3dを消します
		 * @param	mc
		 * @version	fp10
		 */
		public static function removeMatrix3d(mc:DisplayObject):void
		{
			if (!mc.transform || !mc.transform.matrix3D)
				return;
			var matrix:Matrix = new Matrix();
			matrix.translate(mc.transform.matrix3D.position.x, mc.transform.matrix3D.position.y);
			mc.transform.matrix = matrix;
		}
		
		/**
		 * DisplayObjectContainerを階層構造でトレースします・
		 * @see	http://whirlpower.net/blog/?p=147
		 * @param	node
		 * @param	spacer
		 */
		public static function traceChildren( node:DisplayObjectContainer, spacer:String = "" ):void
		{
			trace( spacer + "" + node.name + " : " + node );
			for ( var i:int = 0; i < node.numChildren; i++ )
			{
				if ( node.getChildAt( i ) is DisplayObjectContainer )
				{
					spacer += "|   ";
					traceChildren( node.getChildAt( i ) as DisplayObjectContainer, spacer);
					spacer = spacer.slice( 0, -4 );
				}
			}
		}
		
		public static function mouseLockCheck(mc:DisplayObject):Boolean 
		{
			var result:Boolean;
			var parent:DisplayObjectContainer = mc.parent;
			if (!parent.mouseEnabled || !parent.mouseChildren)
			{
				trace('mouseLockCheck', parent);
				return true;
			}
			while (parent.parent)
			{
				if (!parent.mouseEnabled || !parent.mouseChildren)
				{
					trace('mouseLockCheck', parent);
					return true;
				}
				parent = parent.parent;
			}
			
			return false;
		}

		/**
		 * 入れ替える
		 * @param replacee
		 * @param replace
		 */
		public static function replace(replacee:DisplayObject, replace:DisplayObject):void
		{
			if (!replacee.parent)
				throw new Error('no parent');

			var parent:DisplayObjectContainer = replacee.parent;
			var index:int = parent.getChildIndex(replacee);
			replace.x = replacee.x;
			replace.y = replacee.y;
			parent.addChildAt(replace, index);
			parent.removeChild(replacee);
		}


		//--------------------------------------------------------------------------
		//
		//  PRIVATE
		//
		//--------------------------------------------------------------------------
		private static function getMCList(args:*):Array
		{
			var result:Array;
			if (args[0] is Array)
				result = args[0];
			else
				result = args.concat();
			return result;
		}
		
		/**
		 * コンストラクタは禁止
		 */
		public function DOUtils() 
		{
			throw new IllegalOperationError("Dont construct");
		}


		public static function toggle(show:Boolean, ...args):void
		{
			if (args[0] == undefined)
				return;

			var list:Array = getMCList(args);

			for each(var mc:DisplayObject in list)
			{
				mc.alpha = 1.0;
				mc.visible = show;
			}
		}
	}
	
}
