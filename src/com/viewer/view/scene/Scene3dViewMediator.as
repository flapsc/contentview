package com.viewer.view.scene
{
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.AssetType;
	import away3d.loaders.parsers.OBJParser;
	import away3d.materials.MaterialBase;
	import away3d.materials.TextureMaterial;
	import away3d.textures.Texture2DBase;
	import flash.display.Stage;
	import flash.display3D.textures.Texture;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class Scene3dViewMediator extends BaseViewMediator
	{
		private var _view:View3D;
		private var _stage:Stage;
		private var _cameraController:HoverController;
		
		//navigation variables
		private var _move:Boolean = false;
		private var _lastPanAngle:Number;
		private var _lastTiltAngle:Number;
		private var _lastMouseX:Number;
		private var _lastMouseY:Number;
		
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
		
		private var _loader:URLLoader;
		private function loadApp3dModel():void
		{
			/**
			 * TODO
			 * need create cash content bytes service,
			 * and move this block.
			 */
			const modelUrl:String = _context.dataConfigVO.model3DVO.url;
			AssetLibrary.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			AssetLibrary.addEventListener(AssetEvent.MATERIAL_COMPLETE, onAssetComplete);
			AssetLibrary.load(new URLRequest(_context.dataConfigVO.model3DVO.url), null, null, new OBJParser());
			
		}
		
		private function loader_progressHandler(e:ProgressEvent):void 
		{
			trace(e.bytesLoaded / e.bytesTotal);
		}
		
		private function loader_ProgressHandler(e:ProgressEvent):void 
		{
			//todo
		}
		
		private function parse3dModelByes( data:* ):void
		{
			AssetLibrary.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			AssetLibrary.loadData( data );
		}
		
		
		private function getContentFileName( url:String ):String
		{
			var arr:Array = url.split("/");
			var fileName:String = arr[arr.length - 1];
			return fileName;
			//return url.split
		}
		
		private function onAssetComplete(event:AssetEvent):void 
		{
			if (event.asset.assetType == AssetType.MESH) 
			{
				_view.scene.addChild( event.asset as Mesh)
			}
			else if (event.asset.assetType == AssetType.MATERIAL && event.asset is TextureMaterial)
			{
				var material:TextureMaterial = event.asset as TextureMaterial;
				material.alpha = .5;
			}
		}
		
		private function setupScene():void
		{
			//setup the camera for optimal shadow rendering
			_view.camera.lens.far = 2100;
			
			//setup controller to be used on the camera
			_cameraController = new HoverController(_view.camera, null, 45, 20, 1000, 10);
			
			_stage.addEventListener(Event.DEACTIVATE, stage_DeactivateHandler);
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_stage.addEventListener(Event.ENTER_FRAME, stage_EnterFrame_Handler);
		
		}
		
		
		private function stage_DeactivateHandler(e:Event):void
		{
		
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