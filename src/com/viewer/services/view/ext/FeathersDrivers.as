package com.viewer.services.view.ext 
{
	import feathers.controls.Drawers;
	import feathers.controls.LayoutGroup;
	import feathers.core.FeathersControl;
	import flash.geom.Rectangle;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class FeathersDrivers extends Drawers 
	{
		private var _contentExt:LayoutGroup;
		private var _theme:MetalWorksMobileThemeExt;
		
		public function FeathersDrivers() 
		{
			_theme = new MetalWorksMobileThemeExt();
			super();
		}
		override protected function initialize():void 
		{
			super.initialize();
			_contentExt = new LayoutGroup();
			content = _contentExt;
		}
		
		public final function get buttonTexture():Texture{ return _theme.textureButton; }
		public final function get buttonScale9Grid():Rectangle{ return _theme.buttonScale9Grid; }
	}

}