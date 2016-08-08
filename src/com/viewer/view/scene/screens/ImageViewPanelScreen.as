package com.viewer.view.scene.screens 
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.layout.AnchorLayoutData;
	import starling.display.DisplayObject;
	import starling.events.Event;
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class ImageViewPanelScreen extends BaseContentViewPanelScreen
	{
		private var _imageView:ImageLoader;
		public function ImageViewPanelScreen() 
		{
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			scrollBarDisplayMode = SCROLL_POLICY_AUTO;
			
			_imageView = new ImageLoader();
			_imageView.layoutData = new AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
			_imageView.scaleContent = true;
			_imageView.source = _context.currentSelectedContentVO.content;
			addChild( _imageView );
			
			_headerFactory = customHeaderFactory;
			
		}
		
		override public function dispose():void 
		{
			_imageView.removeFromParent( true );
			_imageView = null;
			super.dispose();
		}
	}

}