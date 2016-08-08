package com.viewer.view.scene.screens 
{
	import com.viewer.IContext;
	import feathers.controls.PanelScreen;
	import feathers.layout.AnchorLayout;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class BaseContentViewPanelScreen extends PanelScreen 
	{
		internal var _context:IContext;
		
		public function BaseContentViewPanelScreen() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			layout = new AnchorLayout();
			clipContent = false;
			if (_context.currentSelectedContentVO)
			{
				title = _context.currentSelectedContentVO.name;
			}
			else if ( _context.dataConfigVO.screenTitle )
			{
				title = _context.dataConfigVO.screenTitle;
				_context.dataConfigVO.screenTitle = null;
			}
		}
		
		public final function set context( value:IContext ):void{ _context = value; }
	}

}