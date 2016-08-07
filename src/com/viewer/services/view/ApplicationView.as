package com.viewer.services.view 
{
	import away3d.containers.View3D;
	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	import away3d.debug.AwayStats;
	import away3d.events.Stage3DEvent;
	import com.viewer.services.view.ext.FeathersDrivers;
	import feathers.utils.ScreenDensityScaleFactorManager;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.utils.setTimeout;
	import starling.core.Starling;
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class ApplicationView extends EventDispatcher implements IApplicationView 
	{
		// Stage, stage 3d manager and proxy instances
		private var _stage3DManager : Stage3DManager;
		private var _stage3DProxy : Stage3DProxy;		
		private var _stage:Stage;
		
		//3d and 2d view.
		private var _away3dView:View3D;
		private var _view2D:FeathersDrivers;
		private var _scaler:ScreenDensityScaleFactorManager;
		private var _starling:Starling;
		private var _isReady:Boolean;
		
		private var _awayStats:AwayStats;
		private var _needRenderAway3d:Boolean = true;
		
		/**
		 * Constructor.
		 */
		public function ApplicationView(){}
		
		/**
		 * Initialize current application view.
		 * @param	stage
		 */
		public function init(stage:Stage ):void
		{
			_stage = stage;
			
			_stage.scaleMode = StageScaleMode.NO_SCALE;
			_stage.align = StageAlign.TOP_LEFT;
			
			initProxies();
		}
		/**
		 * Current application stage( flash.displayStage ) instance.
		 */
		public final function get stage():Stage
		{
			return _stage;
		}
		
		/**
		 * Current  away3d.containers.View3D instance.
		 */
		public final function get view3D():View3D
		{
			return _away3dView;
		}
		
		/**
		 * Current feathers drivers instance.
		 */
		public final function get view2D():FeathersDrivers
		{
			return _view2D;
		}
		
		
		/**
		 * 
		 */
		public function get needRenderAway3d():Boolean{ return _needRenderAway3d; }
		public function set needRenderAway3d( value:Boolean ):void{ _needRenderAway3d = value; }		
		
		/**
		 * Flag, true when view service are ready.
		 */
		public final function get isReady():Boolean{ return _isReady; }
		
		/**
		 * Initialise the Stage3D proxies
		 */
		private function initProxies():void
		{
			// Define a new Stage3DManager for the Stage3D objects
			_stage3DManager = Stage3DManager.getInstance(stage);
		  
			// Create a new Stage3D proxy to contain the separate views
			_stage3DProxy = _stage3DManager.getFreeStage3DProxy();
			_stage3DProxy.addEventListener(Stage3DEvent.CONTEXT3D_CREATED, stage3DProxy_CONTEXT3D_CREATED_Handler);
			_stage3DProxy.antiAlias = 8;
			_stage3DProxy.color = 0x000000;
		}		
		
		private function stage3DProxy_CONTEXT3D_CREATED_Handler(e:Stage3DEvent):void 
		{
			initAway3D();
			initFeathers();
		}
		
		private function initFeathers():void 
		{
			Starling.multitouchEnabled = true;
			_starling = new Starling(FeathersDrivers, _stage, _stage3DProxy.viewPort, _stage3DProxy.stage3D, Context3DRenderMode.AUTO, Context3DProfile.BASELINE);
			_starling.antiAliasing = 8;
			_starling.supportHighResolutions = true;
			_starling.skipUnchangedFrames = true;
			//_starling.simulateMultitouch = true;
			//_starling.setRequiresRedraw();
			_scaler = new ScreenDensityScaleFactorManager(_starling);
			
			
			if(!_starling.root)
			{
				_starling.addEventListener("rootCreated", starling_rootCreatedHandler);
			}
			else
			{
				starling_rootCreatedHandler();
			}

		}
		
		private function stage_ResizeHandler(e:Event = null):void 
		{
			
			_stage3DProxy.width = _away3dView.width = _stage.fullScreenWidth;
			_stage3DProxy.height = _away3dView.height = _stage.fullScreenHeight;
			if (_awayStats)
			{
				_awayStats.x = _stage.fullScreenWidth - _awayStats.width;
				_awayStats.y = _stage.fullScreenHeight - _awayStats.height;
			}
			_starling.viewPort = new Rectangle(0, 0, _stage3DProxy.width, _stage3DProxy.height);
		}
		
		private function stage_EnterFrameHandler(e:Event):void 
		{
			// Clear the Context3D object
			 _stage3DProxy.clear();
			 
			 // Render the Away3D layer
			 if (_needRenderAway3d)
			 {
				_away3dView.render();
			 }
			 
			 // Render the Starling animation layer
			 _starling.nextFrame();
			 
			 // Present the Context3D object to Stage3D
			 _stage3DProxy.present();			
		}
		
		private function stage_deactivateHandler(e:Event):void 
		{
			if (_starling.isStarted)
			{
				_starling.stop();
			}
			_stage.removeEventListener(Event.ENTER_FRAME, stage_EnterFrameHandler);
			_stage.addEventListener(Event.ACTIVATE, stage_activateHandler, false, 0, true );
		}
		
		private function stage_activateHandler(e:Event = null):void 
		{
			_stage.removeEventListener(Event.ACTIVATE, stage_activateHandler);
			_stage.addEventListener(Event.ENTER_FRAME, stage_EnterFrameHandler, false, 0, true );
			
			if (!_starling.isStarted)
			{
				_starling.start();
			}
			
		}
		
		private function starling_rootCreatedHandler(e:Object = null):void 
		{
			if (e)
			{
				_starling.removeEventListener("rootCreated", starling_rootCreatedHandler);
			}
			_view2D = _starling.root as FeathersDrivers;
			stage_activateHandler();
			_stage.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
			_stage.addEventListener(Event.RESIZE, stage_ResizeHandler);
			_isReady = true;
			dispatchEvent( new ApplicationViewEvent(ApplicationViewEvent.APP_VIEW_READY) );
			_starling.start();
			//stage_ResizeHandler();
		}
		
		/**
		 * Initialise the Away3D views
		 */
		private function initAway3D() : void
		{
			// Create the first Away3D view which holds the cube objects.
			_stage3DProxy.width = _stage.fullScreenWidth;
			_stage3DProxy.height = _stage.fullScreenHeight;
			_away3dView = new View3D();
			_away3dView.stage3DProxy = _stage3DProxy;
			_away3dView.shareContext = true;
		  
			_stage.addChild(_away3dView);
			
			
			//if (Capabilities.isDebugger)
			//{
				
				_awayStats = new AwayStats( _away3dView);
				_awayStats.x = _stage.fullScreenWidth - _awayStats.width;
				_awayStats.y = _stage.fullScreenHeight - _awayStats.height;
				_stage.addChild( _awayStats );
			//}
			
		}
	}
}