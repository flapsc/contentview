package com.viewer.view.scene.screens 
{
	import com.viewer.IContext;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.PanelScreen;
	import feathers.layout.AnchorLayout;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
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
			}
		}
		
		internal function customHeaderFactory():Header
		{
			var header:Header = new Header();
			//this screen doesn't use a back button on tablets because the main
			//app's uses a split layout
			var backButton:Button = new Button();
			backButton.styleNameList.add(Button.ALTERNATE_STYLE_NAME_BACK_BUTTON);
			backButton.label = "Back";
			backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);
			header.leftItems = new <DisplayObject>
			[
				backButton
			];
			return header;
		}		
		internal function backButton_triggeredHandler(event:Event):void
		{
			this.dispatchEventWith(Event.COMPLETE);
		}		
		
		public final function set context( value:IContext ):void{ _context = value; }
		
		override public function dispose():void 
		{
			if ( header )
			{
				header.removeFromParent(true);
			}
			super.dispose();
		}
	}

}