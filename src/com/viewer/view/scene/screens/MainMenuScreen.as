package com.viewer.view.scene.screens 
{
	import com.viewer.model.ContentTypes;
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
			
			_buttonGroup = new ButtonGroup();
			_buttonGroup.buttonFactory = function():Button
			{
				return new MenuButton( );
			}
			_buttonGroup.buttonInitializer = function( button:MenuButton, data:IContentMenuItemVO ):void
			{
				button.data = data as IContentMenuItemVO;
				button.addEventListener(Event.TRIGGERED, button_triggeredHandler);
			};
			
			_buttonGroup.dataProvider = new ListCollection(_context.dataConfigVO.menuItems);
			
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
			var button:MenuButton = MenuButton(event.currentTarget);
			var screenEvent:ScreenEvent;
			switch( button.contentType )
			{
				case ContentTypes.VIDEO_CONTENT_TYPE:
					screenEvent = new ScreenEvent( ScreenEvent.SHOW_SCREEN, ScreenId.VIDEO_PLAYER_SCREEN );
					break;
				case ContentTypes.IMAGE_CONTENT_TYPE:
					screenEvent = new ScreenEvent( ScreenEvent.SHOW_SCREEN, ScreenId.IMAGE_VIEW_SCREEN );
					break;
			}
			
			if ( screenEvent )
			{
				_context.currentSelectedContentVO = button.data;
				_context.dispatchEvent(screenEvent);
			}
		}
		
	}

}