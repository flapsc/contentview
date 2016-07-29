package com.viewer.view.scene 
{
	import com.viewer.ApplicationEvent;
	import com.viewer.IContext;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * Implementation of base mediator.
	 * @author Mihaylenko A.L.
	 */
	public class BaseViewMediator  extends EventDispatcher implements IBaseViewMediator
	{
		
		internal var _context:IContext;
		
		/**
		 * Constructor.
		 */
		public function BaseViewMediator(){}
		
		/**
		 * Public property( write only ).
		 * Application context.
		 */
		public final function set context( value:IContext ):void
		{
			_context = value;
			context_READY_Handler();
		}
		/**
		 * Destroy allicated data.
		 */
		public function destroy():void
		{
			_context = null;
		}		
		/**
		 * Internal method, executes when context ready.
		 */
		internal function contextReady():void{}
		
		private function context_READY_Handler( event:Event=null ):void
		{
			if ( event )
			{
				_context.removeEventListener(ApplicationEvent.APPLICATION_CONTEXT_READY, context_READY_Handler);
			}
			
			if ( _context.isReady )
				contextReady();
			else
				_context.addEventListener(ApplicationEvent.APPLICATION_CONTEXT_READY, context_READY_Handler);
		}
		
	}

}