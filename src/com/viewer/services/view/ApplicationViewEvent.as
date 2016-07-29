package com.viewer.services.view 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class ApplicationViewEvent extends Event 
	{
		//
		static public const APP_VIEW_READY:String = "com.viewer.services.view.ApplicationViewEvent";
		
		
		public function ApplicationViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ApplicationViewEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ApplicationViewEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}