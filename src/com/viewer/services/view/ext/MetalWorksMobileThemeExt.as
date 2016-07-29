package com.viewer.services.view.ext 
{
	import feathers.themes.MetalWorksMobileTheme;
	import flash.geom.Rectangle;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class MetalWorksMobileThemeExt extends MetalWorksMobileTheme 
	{
		
		public function MetalWorksMobileThemeExt() 
		{
		}
		
		public final function get textureButton():Texture
		{
			return this.buttonUpSkinTexture;
		}
		
		public final function get buttonScale9Grid():Rectangle{ return BUTTON_SCALE9_GRID; }
		
	}

}