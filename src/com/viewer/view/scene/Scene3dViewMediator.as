package com.viewer.view.scene
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.events.MouseEvent3D;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.AssetType;
	import away3d.loaders.Loader3D;
	import away3d.loaders.parsers.OBJParser;
	import away3d.materials.ColorMaterial;
	import away3d.materials.MaterialBase;
	import away3d.materials.TextureMaterial;
	import com.viewer.view.scene.screens.ScreenEvent;
	import com.viewer.view.scene.screens.ScreenId;
	import flash.display.LoaderInfo;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.GestureEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.TransformGestureEvent;
	import flash.geom.Vector3D;
	import flash.net.URLRequest;
	import starling.animation.Transitions;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class Scene3dViewMediator extends BaseViewMediator
	{
		//App Stage(flash.display.Stage) 
		private var _stage:Stage;
		
		//view's and controllers( away3d )
		private var _view:View3D;
		private var _cameraController:HoverController;
		
		//navigation variables
		private var _move:Boolean = false;
		private var _lastPanAngle:Number;
		private var _lastTiltAngle:Number;
		private var _lastMouseX:Number;
		private var _lastMouseY:Number;
		private var _maxZoom:Number;
		private var _minZoom:Number;
		
		private var _currZoom:Number = 1;
		private var _currZoomX:Number = 1;
		private var _currZoomY:Number = 1;
		/**
		 * Constructor.
		 */
		public function Scene3dViewMediator()
		{
		
		}
		
		/**
		 * @inheritDoc
		 */
		internal final override function contextReady():void
		{
			_view = _context.appView.view3D;
			_stage = _context.appView.stage;
			setupScene();
			loadApp3dModel();
		}
		
		private var _loader3D:Loader3D
		private function loadApp3dModel():void
		{
			_context.dispatchEvent( new ScreenEvent(ScreenEvent.SHOW_SCREEN, ScreenId.PROGRESS_BAR_SCREEN, _context.dataConfigVO.model3DVO.url) );
			/**
			 * TODO
			 * need create cash content bytes service,
			 * and move this block.
			 */
			const modelUrl:String = _context.dataConfigVO.model3DVO.url;
			
			_loader3D = new Loader3D();
			//_loader3D.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			_loader3D.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onLoaderResourceComplete);
			_loader3D.addEventListener(LoaderEvent.DEPENDENCY_COMPLETE, onLoaderResourceDEPENDENCYComplete);
			_loader3D.addEventListener(ProgressEvent.PROGRESS, onLoaderResourceProgress);
			_loader3D.load(new URLRequest(_context.dataConfigVO.model3DVO.url), null, null, new OBJParser());
		}
		
		private function onLoaderResourceDEPENDENCYComplete(e:LoaderEvent):void 
		{
			trace(e.url);
		}
		
		private function onLoaderResourceProgress(e:LoaderEvent):void 
		{
			_context.dispatchEvent(e.clone());
			//trace( e.url, e.message);
		}
		
		private function onLoaderResourceComplete(e:LoaderEvent):void 
		{
			var container:ObjectContainer3D = new ObjectContainer3D();
			var child:ObjectContainer3D;
			var material:MaterialBase;
			while(_loader3D.numChildren)
			{
				
				child = _loader3D.getChildAt(0);
				if ( child is Mesh )
				{
					material = (child as Mesh).material;
					
					if ( material is TextureMaterial )
					{
						(material as TextureMaterial).alpha = .5;
					}
					else if ( material is ColorMaterial )
					{
						(material as ColorMaterial).alpha = .5;
					}
				}
				/**
				 * TODO
				 * add interactive event listeners an all scene objects, 
				 * for handle and set target position of base hover controller
				 * 
				 * Simple code:
				 * child.mouseEnabled =	child.mouseChildren = true;
				 * 
				 * child.addEventListener
				 * (
				 * 		MouseEvent3D.MOUSE_DOWN,
				 * 		function( event:MouseEvent3D ):void
				 * 		{
				 * 			var targetContainer:ObjectContainer3D = event.target as ObjectContainer3D;
				 * 			_cameraController.lookAtPosition = new Vector3D
				 * 			(
				 * 				(container.minX + container.maxX) * .5,
				 * 				(container.minY + container.maxY) * .5,
				 * 				(container.minZ + container.maxZ) * .5,
				 * 			)
				 * 		}
				 * 
				 * );
				 * 
				 */
				container.addChild(child);
			}
			_view.scene.addChild( container );
			
			_cameraController.lookAtPosition = new Vector3D
			(
				(container.minX + container.maxX) * .5,
				(container.minY + container.maxY) * .5,
				(container.minZ + container.maxZ) * .5
			);
			
			_minZoom = container.maxY - container.minY;
			_maxZoom = _minZoom * 12;
			
			_cameraController.distance = _maxZoom;
			_context.appView.stage.addEventListener(TransformGestureEvent.GESTURE_ZOOM, view_GESTURE_ZOOM_Handler);
			_context.dispatchEvent( new ScreenEvent(ScreenEvent.HIDE_SCREEN, ScreenId.PROGRESS_BAR_SCREEN) );
		}
		
		private function view_GESTURE_ZOOM_Handler(e:TransformGestureEvent):void 
		{
			_currZoomX += 1 - e.scaleX;
			_currZoomY += 1 - e.scaleY;
			
			_currZoomX = Math.min(_currZoomX, 1);
			_currZoomX = Math.max(_currZoomX, 0.01);
			
			_currZoomY = Math.min(_currZoomY, 1);
			_currZoomY = Math.max(_currZoomY, 0.01);
			
			_currZoom = (_currZoomX + _currZoomY) * .5;
			_currZoom = Math.min(_currZoom, 1);
			_currZoom = Math.max(_currZoom, 0.01);
			_cameraController.distance = _minZoom + (_maxZoom - _minZoom) * _currZoom;
		}
		private function setupScene():void
		{
			//setup the camera for optimal shadow rendering
			_view.camera.lens.far = 2100;
			
			//setup controller to be used on the camera
			_cameraController = new HoverController(_view.camera, null, 45, 20, 1000, 10);
			
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_stage.addEventListener(Event.ENTER_FRAME, stage_EnterFrame_Handler);
		}
		
		/**
		 * Navigation and render loop
		 */
		private function stage_EnterFrame_Handler(event:Event):void
		{
			if (_move)
			{
				_cameraController.panAngle = 0.3 * (_stage.mouseX - _lastMouseX) + _lastPanAngle;
				_cameraController.tiltAngle = 0.3 * (_stage.mouseY - _lastMouseY) + _lastTiltAngle;
			}
		}
		
		/**
		 * Mouse down listener for navigation
		 */
		private function onMouseDown(event:MouseEvent):void
		{
			_lastPanAngle = _cameraController.panAngle;
			_lastTiltAngle = _cameraController.tiltAngle;
			_lastMouseX = _stage.mouseX;
			_lastMouseY = _stage.mouseY;
			_move = true;
			
			/**
			 * For web
			 */
			//_stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		/**
		 * Mouse up listener for navigation
		 */
		private function onMouseUp(event:MouseEvent):void
		{
			_move = false;
			_stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		/**
		 * Mouse stage leave listener for navigation
		 */
		private function onStageMouseLeave(event:Event):void
		{
			_move = false;
			_stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
	
	}

}