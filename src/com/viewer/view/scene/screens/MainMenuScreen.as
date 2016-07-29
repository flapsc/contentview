package com.viewer.view.scene.screens 
{
	import com.viewer.model.vo.menu.IContentMenuItemVO;
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Header;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayoutData;
	import starling.display.DisplayObject;
	import starling.events.Event;
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class MainMenuScreen extends BaseContentViewPanelScreen 
	{
		
		private var _buttonGroup:ButtonGroup;
		
		public function MainMenuScreen() 
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		override protected function initialize():void 
		{
			super.initialize();
			
			const menuItemsDPL:ListCollection = new ListCollection();
			const menuItemsCongigData:Vector.<IContentMenuItemVO> = _context.dataConfigVO.menuItems;
			const menuItemsLn:uint = menuItemsCongigData.length;
			
			var menuItemData:IContentMenuItemVO;
			
			for ( var i:uint = 0; i < menuItemsLn; i++ )
			{
				menuItemData = menuItemsCongigData[i];
				menuItemsDPL.addItem({ label:menuItemData.name,  triggered: button_triggeredHandler});
			}
			_buttonGroup = new ButtonGroup();
			_buttonGroup.dataProvider = menuItemsDPL;
			
			var buttonGroupLayoutData:AnchorLayoutData = new AnchorLayoutData();
			buttonGroupLayoutData.horizontalCenter = 0;
			buttonGroupLayoutData.verticalCenter = 0;
			
			_buttonGroup.layoutData = buttonGroupLayoutData;
			headerFactory = customHeaderFactory;
			addChild( _buttonGroup );
			
		}
		
		private function customHeaderFactory():Header
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
		
		private function backButton_triggeredHandler(event:Event):void
		{
			_context.dispatchEvent( new ScreenEvent( ScreenEvent.HIDE_SCREEN, ScreenId.MAIN_MENU_SCREEN ) );
		}		
		
		private function button_triggeredHandler(event:Event):void 
		{
			trace(event);
		}
		
	}

}