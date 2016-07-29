package com.viewer.view.scene 
{
	import com.viewer.IContext;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public interface IBaseViewMediator extends IEventDispatcher
	{
		/**
		 * Public property( write only ).
		 * Application context.
		 */
		function set context( value:IContext ):void;
		
		/**
		 * Destroy allicated data.
		 */
		function destroy():void;
	}
	
}