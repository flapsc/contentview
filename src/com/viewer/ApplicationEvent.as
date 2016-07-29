package com.viewer 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class ApplicationEvent extends Event 
	{
		
		static public const APPLICATION_CONTEXT_READY:String = "com.viewer.APPLICATION_CONTEXT_READY";
		
		public function ApplicationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ApplicationEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ApplicationEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}