package com.viewer.view.scene
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.AssetType;
	import away3d.loaders.Loader3D;
	import away3d.loaders.parsers.OBJParser;
	import away3d.materials.TextureMaterial;
	import com.viewer.view.scene.screens.ScreenEvent;
	import com.viewer.view.scene.screens.ScreenId;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
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
			_context.dispatchEvent( new ScreenEvent(ScreenEvent.SHOW_SCREEN, ScreenId.PROGRESS_BAR_SCREEN, "Loading 3d model, please wait...") );
			/**
			 * TODO
			 * need create cash content bytes service,
			 * and move this block.
			 */
			const modelUrl:String = _context.dataConfigVO.model3DVO.url;
			
			_loader3D = new Loader3D();
			//_loader3D.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			_loader3D.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onLoaderResourceComplete);
			_loader3D.load(new URLRequest(_context.dataConfigVO.model3DVO.url), null, null, new OBJParser());
		}
		
		private function onLoaderResourceComplete(e:LoaderEvent):void 
		{
			trace("onLoaderResourceComplete");
			
			//var childrenLn:uint = _loader3D.numChildren;
			var child:ObjectContainer3D;
			//for ( var i:uint = 0; i < childrenLn; i++ )
			while(_loader3D.numChildren)
			{
				
				child = _loader3D.getChildAt(0);
				if ( child is Mesh )
				{
					((child as Mesh).material as TextureMaterial).alpha = .5;
					
					
				}
				_view.scene.addChild( child );
			}
			_context.dispatchEvent( new ScreenEvent(ScreenEvent.HIDE_SCREEN, ScreenId.PROGRESS_BAR_SCREEN) );
		}
		
		/**
		 * Asset load complete event handler, correctly in 3ds parser.
		 * @param	event - AssetEvent instance.
		 * TODO need fix OBJParser
		 */
		//private function onAssetComplete(event:AssetEvent):void 
		//{
			//trace(event.type, event.asset.assetType);
			//
			//if (event.asset.assetType == AssetType.MESH) 
			//{
				////var mesh:Mesh = event.asset as Mesh;
				////_view.scene.addChild( mesh )
			//}
			//else if (event.asset.assetType == AssetType.MATERIAL)//TODO not work in loader3d for OBJParser(.obj data format), set alpha to 50% for texture material when resource complete.
			//{
				//var asset:* = event.asset;
				//trace(asset);
			//}
		//}
		
		[Inline]
		private static function updateMaterial( mesh:Mesh ):void
		{
			mesh.material.alphaPremultiplied = true;
			var material:TextureMaterial = mesh.material && mesh.material is TextureMaterial?mesh.material as TextureMaterial:null;
			if (material)
			{
				
				material.alpha = .5;
			}
			else
			{
				//mesh.material.alphaPremultiplied
				trace( mesh );
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