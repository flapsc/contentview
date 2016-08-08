package com.viewer 
{
	import com.viewer.model.StaticEmbedFonts;
	import com.viewer.model.vo.ContentViewVO;
	import com.viewer.model.vo.IContentViewVO;
	import com.viewer.model.vo.menu.IContentMenuItemVO;
	import com.viewer.services.view.ApplicationView;
	import com.viewer.services.view.ApplicationViewEvent;
	import com.viewer.services.view.IApplicationView;
	import com.viewer.view.scene.IBaseViewMediator;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class Context  extends EventDispatcher implements IContext
	{
		
		private var _dataConfig:IContentViewVO;
		private var _scene2dViewMediator:IBaseViewMediator;
		private var _scene3dViewMediator:IBaseViewMediator;
		private var _appView:IApplicationView;
		private var _configLoader:URLLoader;
		
		/**
		 * Constructor.
		 */
		public function Context() 
		{
			
		}
		
		/**
		 * 
		 * @param	stage
		 * @param	scene2dViewMediator
		 * @param	scene3dViewMediator
		 */
		public final function init( stage:Stage, scene2dViewMediator:IBaseViewMediator, scene3dViewMediator:IBaseViewMediator ):void
		{

			
			_scene2dViewMediator = scene2dViewMediator;
			_scene3dViewMediator = scene3dViewMediator;
			
			_scene3dViewMediator.context =
			_scene2dViewMediator.context = this;			
			
			_appView = new ApplicationView();
			_appView.addEventListener(ApplicationViewEvent.APP_VIEW_READY, appView_READY_Handler);
			_appView.init( stage )
		}
		
		private function appView_READY_Handler(e:ApplicationViewEvent):void 
		{
			_appView.removeEventListener(ApplicationViewEvent.APP_VIEW_READY, appView_READY_Handler);
			checkReady();
		}
		
		/**
		 * Application data config.
		 * Public property( read only ).
		 */
		public final function get dataConfigVO():IContentViewVO{ return _dataConfig; }
		
		/**
		 * Start load application data config.
		 * @param	url - The url to download the main app config
		 */
		public final function loadAppDataConfig( url:String ):void
		{
			_configLoader = new URLLoader();
			_configLoader.dataFormat = URLLoaderDataFormat.TEXT;
			addConfigLoaderListeners();
			_configLoader.load( new URLRequest(url) );
		}
		
		/**
		 * Public property( read only ).
		 * Service of application view.
		 */
		public final function get appView():IApplicationView{ return _appView; }
		
		
		public final function get isReady():Boolean
		{
			return _dataConfig && _appView && _appView.isReady;
		}
		
		private var _currentSelectedContentVO:IContentMenuItemVO;
		public final function set currentSelectedContentVO(value:IContentMenuItemVO):void{ _currentSelectedContentVO = value; }
		public final function get currentSelectedContentVO():IContentMenuItemVO{ return _currentSelectedContentVO; }
		
		
	//////////////////////// CONFIG LOADER//////////////////////////////
	//////////////////////// TODO NEED IMPLEMENT TO LOAD CONFIG SERVICE/
		private function addConfigLoaderListeners():void
		{
			_configLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, configLoader_COMPLETE_Handler);
			_configLoader.addEventListener(IOErrorEvent.IO_ERROR, configLoader_COMPLETE_Handler);
			_configLoader.addEventListener(Event.COMPLETE, configLoader_COMPLETE_Handler);
		}
		
		private function removeConfigLoaderListeners():void
		{
			_configLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, configLoader_COMPLETE_Handler);
			_configLoader.removeEventListener(IOErrorEvent.IO_ERROR, configLoader_COMPLETE_Handler);
			_configLoader.removeEventListener(Event.COMPLETE, configLoader_COMPLETE_Handler);			
		}
		private function configLoader_COMPLETE_Handler(e:Event):void 
		{
			removeConfigLoaderListeners();
			_dataConfig = new ContentViewVO();
			
			if (e.type == Event.COMPLETE)
			{
				_dataConfig.serialize( _configLoader.data );
			}
			_configLoader = null;
			checkReady();			
		}		
		private function configLoader_ERROR_Handler(e:IOErrorEvent):void 
		{

		}		
	///////////////////////////////////////////////////////////////////
		private function checkReady():void
		{
			if ( isReady )
			{
				StaticEmbedFonts.registerFonts();
				dispatchEvent( new ApplicationEvent(ApplicationEvent.APPLICATION_CONTEXT_READY) );
			}
		}
	
	
	}

}