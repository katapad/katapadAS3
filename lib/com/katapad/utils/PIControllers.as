package com.katapad.utils 
{
	import com.katapad.display.shape.InteractiveSquare;
	import com.katapad.utils.PIControllerFactory;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2009/02/19 13:57
	 */
	dynamic public class PIControllers extends Sprite 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		private static const CONTROLLER_MARGIN_RIGHT:Number = 2;
		private static const MARGIN_SIDE:Number = 10;
		private static const MARGIN_VERTICAL:Number = 10;
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		private var _controllerList:Array;
		private var _totalW:Number;
		private var _dictionary:Dictionary;
		private var _container:Sprite;
		private var _bg:InteractiveSquare;
		
		
		private static var _instance:PIControllers = new PIControllers();
		/**
		 * getInstance
		 */
		public static function get instance():PIControllers
		{
			return _instance;
		}
		
		/**
		 * コンストラクタ
		 */
		public function PIControllers() 
		{
			_instance = this;
			init();
		}
		
		/**
		 * 初期化
		 */
		private function init():void 
		{
			_dictionary = new Dictionary();
			_controllerList = [];
			_totalW = 0;
			
			_bg = new InteractiveSquare(10, 10, 0xFFFFFF, 0.5);
			addChild(_bg);
			_bg.buttonMode = true;
			_bg.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			_bg.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			
			_container = addChild(new Sprite()) as Sprite;
			_container.x = MARGIN_SIDE;
			_container.y = MARGIN_VERTICAL;
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
		public function addController(labelTxt:String, Hi:Number = 100, Low:Number = 0):void
		{
			var pi:PI_NumberController = PIControllerFactory.create(labelTxt, Hi, Low);
			_dictionary[labelTxt] = pi;
			addDisplay(pi);
		}
		
		public function enterFrame():void
		{
			for each(var cont:PI_NumberController in _controllerList) 
			{
				cont.enterFrame();
			}
		}
		
		public function getValue(labelTxt:String):Number
		{
			var pi:PI_NumberController = _dictionary[labelTxt];
			return pi.value;
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
		private function mouseUpHandler(event:MouseEvent):void 
		{
			stopDrag();
		}
		
		private function mouseDownHandler(event:MouseEvent):void 
		{
			startDrag();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  PRIVATE
		//
		//--------------------------------------------------------------------------
		private function addDisplay(mc:DisplayObject):void
		{
			_container.addChild(mc);
			mc.x = _totalW;
			_totalW = mc.x + mc.width + PIControllers.CONTROLLER_MARGIN_RIGHT;
			_controllerList.push(mc);
			fitBg();
		}
		
		private function fitBg():void
		{
			_bg.width = _container.width + MARGIN_SIDE * 2;
			_bg.height = _container.height + MARGIN_VERTICAL * 2;
		}
		
		//--------------------------------------------------------------------------
		//
		//  GETTER/SETTER
		//
		//--------------------------------------------------------------------------
		//public function get dictionary():Dictionary { return _dictionary; }
	}
	
}
