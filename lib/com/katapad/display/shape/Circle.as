﻿package com.katapad.display.shape 
{
	import com.katapad.core.DOAlign;
	import com.katapad.utils.DrawUtils;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import caurina.transitions.Tweener;
	
	/**
	 * ...
	 * @author katapad
	 * @version 0.1
	 * @since 2009/10/09 13:49
	 */
	public class Circle extends Shape 
	{
		//----------------------------------
		//  static var/const
		//----------------------------------
		
		//----------------------------------
		//  instance var 
		//----------------------------------
		//private var
		
		public function Circle(radius:Number, color:uint = 0, alpha:Number = 1.0, basePoint:uint = DOAlign.MC)  
		{
			DrawUtils.drawFillPoint(graphics, basePoint, 0, 0, radius, radius, DrawUtils.CIRCLE, color, alpha);
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
