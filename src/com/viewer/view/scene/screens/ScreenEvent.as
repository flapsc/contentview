package com.viewer.view.scene.screens 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class ScreenEvent extends Event 
	{
		static public const SHOW_SCREEN:String = "com.viewer.view.scene.screens.SHOW_SCREEN";
		static public const HIDE_SCREEN:String = "com.viewer.view.scene.screens.HIDE_SCREEN";
		static public const HIDE_ALL_SCREEN:String = "com.viewer.view.scene.screens.HIDE_ALL_SCREEN"
		
		private var _screenId:String;
		private var _screenTitle:String;
		public function ScreenEvent(type:String, screenId:String, screenTitle:String = null, bubbles:Boolean = false, cancelable:Boolean = false) 
		{ 
			super(type, bubbles, cancelable);
			_screenId = screenId;
			_screenTitle = screenTitle;
		} 
		
		public override function clone():Event 
		{ 
			return new ScreenEvent(type, _screenId, _screenTitle, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ScreenEvent", "type", "screenId", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get screenId():String{ return _screenId; }
		public function set screenId(val:String ):void{ _screenId = val; }
		
		public function get screenTitle():String{return _screenTitle; }
		public function set screenTitle( val:String ):void{ _screenTitle = val; }
	}
	
}