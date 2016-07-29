package com.viewer.services.view 
{
	import away3d.containers.View3D;
	import com.viewer.services.view.ext.FeathersDrivers;
	import flash.display.Stage;
	import flash.events.IEventDispatcher;
	import starling.display.Sprite;
	
	/**
	 * Inteface of application view,
	 * @author Mihaylenko A.L.
	 */
	public interface IApplicationView extends IEventDispatcher
	{
		/**
		 * Initialize current application view.
		 * @param	stage
		 */
		function init(stage:Stage ):void;
		
		/**
		 * Current application stage( flash.displayStage ) instance.
		 */
		function get stage():Stage;
		
		/**
		 * Current  away3d.containers.View3D instance.
		 */
		function get view3D():View3D;
		
		/**
		 * Current starling.display.Sprite instance.
		 */
		function get view2D():FeathersDrivers;
		
		/**
		 * Flag, true when view service are ready.
		 */
		function get isReady():Boolean;
		
		function get needRenderAway3d():Boolean;
		function set needRenderAway3d( value:Boolean ):void;
		
		
	}
	
}