package com.viewer.view.scene 
{
	import com.viewer.IContext;
	import com.viewer.view.scene.screens.ProgressBarScreen;
	import com.viewer.view.scene.screens.ScreenEvent;
	import com.viewer.view.scene.screens.ScreenId;
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.StackScreenNavigator;
	import feathers.controls.StackScreenNavigatorItem;
	import feathers.controls.supportClasses.TextFieldViewPort;
	import feathers.events.FeathersEventType;
	import feathers.motion.Cover;
	import feathers.motion.Reveal;
	import flash.utils.setTimeout;
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
		private var _menuBtnLabel:TextFieldViewPort;
		
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
			addContextEventListeners();
		}
		
		private function addContextEventListeners():void 
		{
			_context.addEventListener(ScreenEvent.SHOW_SCREEN, context_SHOW_SCREEN_Handler);
			_context.addEventListener(ScreenEvent.HIDE_SCREEN, context_HIDE_SCREEN_Handler);
		}
		
		private function context_HIDE_SCREEN_Handler(e:ScreenEvent):void 
		{
			_navigator.addEventListener(FeathersEventType.TRANSITION_COMPLETE, navigator_TRANSITION_HIDE_COMPLETE_Handler);
			_navigator.popAll(Reveal.createRevealDownTransition());
		}
		
		private function context_SHOW_SCREEN_Handler(e:ScreenEvent):void 
		{
			toogleMenuBtnAndScreens(true);
			
			_context.dataConfigVO.screenTitle = e.screenTitle;
			
			_navigator.addEventListener(FeathersEventType.TRANSITION_COMPLETE, navigator_TRANSITION_SHOW_COMPLETE_Handler);
			_navigator.pushScreen(e.screenId, null, Cover.createCoverUpTransition());
		}
		
		private function navigator_TRANSITION_SHOW_COMPLETE_Handler(event:Object):void
		{
			_navigator.removeEventListener(FeathersEventType.TRANSITION_COMPLETE, navigator_TRANSITION_SHOW_COMPLETE_Handler);
		}
		
		private function navigator_TRANSITION_HIDE_COMPLETE_Handler(event:Object):void
		{
			_navigator.removeEventListener(FeathersEventType.TRANSITION_COMPLETE, navigator_TRANSITION_HIDE_COMPLETE_Handler);
			toogleMenuBtnAndScreens(false);
		}
		
		private function toogleMenuBtnAndScreens( toNavigator:Boolean ):void
		{
			if ( toNavigator )
			{
				
				//_feathersRootDisplay.removeChild(_navigator);
				
				//_feathersRootDisplay.addChild( _menuBtn );
				//_feathersRootDisplay.addChild( _menuBtnLabel );
				_context.appView.needRenderAway3d = false;
				
				_context.appView.view2D.content = _navigator;
			}
			else
			{
				_context.appView.view2D.content = _feathersRootDisplay;
				_context.appView.needRenderAway3d = true;
				
				//setTimeout(function():void{
				//_feathersRootDisplay.removeChild( _menuBtn );
				//_feathersRootDisplay.removeChild( _menuBtnLabel );
				//_feathersRootDisplay.addChild(_navigator); }, 2000);
			}
		}
		
		private function drawUI():void 
		{
			_menuBtnLabel= new TextFieldViewPort();
			_menuBtnLabel.text = "Main menu";
			_feathersRootDisplay.addChild( _menuBtnLabel );
			
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
			_navigator = new StackScreenNavigator();
			
			var progressBarItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(ProgressBarScreen, null, null, {context:_context});
			progressBarItem.addPopEvent(Event.COMPLETE);
			_navigator.addScreen(ScreenId.PROGRESS_BAR_SCREEN, progressBarItem);
		}
		
		private function loadDataConfigErr():void
		{
			
		}
		
	}
}