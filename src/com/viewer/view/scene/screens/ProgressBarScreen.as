package com.viewer.view.scene.screens 
{
	import feathers.controls.PanelScreen;
	import feathers.skins.IStyleProvider;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class ProgressBarScreen extends PanelScreen 
	{
		/**
		 * Global progress bar style
		 */
		public static var globalStyleProvider:IStyleProvider
		
		public function ProgressBarScreen() 
		{
			super();
			
		}
		override protected function get defaultStyleProvider():IStyleProvider
		{
			return ProgressBarScreen.globalStyleProvider;
		}		
		
		
		
		
	}
}