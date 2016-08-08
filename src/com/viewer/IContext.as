package com.viewer 
{
	import com.viewer.model.vo.IContentViewVO;
	import com.viewer.model.vo.menu.IContentMenuItemVO;
	import com.viewer.services.view.IApplicationView;
	import com.viewer.view.scene.IBaseViewMediator;
	import flash.display.Stage;
	import flash.events.IEventDispatcher;
	
	/**
	 * Current application context.
	 * @author Mihaylenko A.L.
	 */
	public interface IContext extends IEventDispatcher
	{
		/**
		 * 
		 * @param	stage
		 * @param	scene2dViewMediator
		 * @param	scene3dViewMediator
		 */
		function init( stage:Stage, scene2dViewMediator:IBaseViewMediator, scene3dViewMediator:IBaseViewMediator ):void;
		
		/**
		 * Application data config.
		 * Public property( read only ).
		 */
		function get dataConfigVO():IContentViewVO;
		
		/**
		 * Start load application data config.
		 * @param	url - The url to download the main app config
		 */
		function loadAppDataConfig( url:String ):void;
		
		/**
		 * Public property( read only ).
		 * Service of application view.
		 */
		function get appView():IApplicationView;
		
		function set currentSelectedContentVO(value:IContentMenuItemVO):void;
		function get currentSelectedContentVO():IContentMenuItemVO;
		
		function get isReady():Boolean;
	}
	
}