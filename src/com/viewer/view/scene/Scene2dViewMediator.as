package com.viewer.view.scene 
{
	import com.viewer.IContext;
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.StackScreenNavigator;
	import feathers.controls.supportClasses.TextFieldViewPort;
	import starling.events.Event;
	/**
	 * Main scene view implementation,
	 * contains menu and menu items handlers.
	 * @author Mihaylenko A.L.
	 */
	public final class Scene2dViewMediator extends BaseViewMediator 
	{
		
		//Current stack screen navigator.
		private var _navigator:StackScreenNavigator;
		
		//
		private var _feathersRootDisplay:LayoutGroup;
		
		//The menu button
		private var _menuBtn:Button;
		
		//
		private var _menuMaximized:Boolean;
		
		/**
		 * Constructor.
		 */
		public function Scene2dViewMediator(){}
		
		/**
		 * @inheritDoc
		 */
		internal override function contextReady():void 
		{
			_feathersRootDisplay = _context.appView.view2D.content as LayoutGroup;
			registerScreens();
			drawUI();
			//_context.addEventListener(
		}
		
		private function drawUI():void 
		{
			var tf:TextFieldViewPort = new TextFieldViewPort();
			tf.text = "Main menu";
			_feathersRootDisplay.addChild( tf );
			
			_menuBtn = new Button();
			_menuBtn.width = 60;
			_menuBtn.addEventListener(Event.TRIGGERED, menuBtn_touch_Handler)
			
			_feathersRootDisplay.addChild( _menuBtn );
			
			
			
		}
		
		private function menuBtn_touch_Handler(e:Event):void 
		{
		}
		
		
		private function registerScreens():void
		{
			
		}
		
		private function loadDataConfigErr():void
		{
			
		}
		
	}
}