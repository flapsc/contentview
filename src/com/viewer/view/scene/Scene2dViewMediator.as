package com.viewer.view.scene 
{
	import com.viewer.IContext;
	import com.viewer.view.scene.screens.MainMenuScreen;
	import com.viewer.view.scene.screens.ProgressBarScreen;
	import com.viewer.view.scene.screens.ScreenEvent;
	import com.viewer.view.scene.screens.ScreenId;
	import com.viewer.view.scene.screens.VideoPlayerScreen;
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
		
		//
		private var _menuMaximized:Boolean;
		
		private var _localShowScreenEvent:ScreenEvent = new ScreenEvent(ScreenEvent.SHOW_SCREEN, "");
		
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
			addUIEventListeners();
			addContextEventListeners();
		}
		
		private function addUIEventListeners():void 
		{
			_menuBtn.addEventListener(Event.TRIGGERED, menuBtn_triggeredHandler);
		}
		
		private function menuBtn_triggeredHandler(e:Event):void 
		{
			_localShowScreenEvent.screenTitle = "Main menu";
			_localShowScreenEvent.screenId = ScreenId.MAIN_MENU_SCREEN;
			context_SHOW_SCREEN_Handler( _localShowScreenEvent )
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
				_context.appView.needRenderAway3d = false;
				_context.appView.view2D.content = _navigator; 
			}
			else
			{
				_context.appView.view2D.content = _feathersRootDisplay;
				_context.appView.needRenderAway3d = true;
			}
		}
		
		private function drawUI():void 
		{
			_menuBtn = new Button();
			_menuBtn.label = "Main Menu";
			_menuBtn.addEventListener(Event.TRIGGERED, menuBtn_touch_Handler)
			
			_feathersRootDisplay.addChild( _menuBtn );
		}
		
		private function menuBtn_touch_Handler(e:Event):void 
		{
		}
		
		
		private function registerScreens():void
		{
			_navigator = new StackScreenNavigator();
			
			//Progress bar screen
			var progressBarItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(ProgressBarScreen, null, null, {context:_context});
			_navigator.addScreen(ScreenId.PROGRESS_BAR_SCREEN, progressBarItem);
			
			// Main Menu screen
			var mainMenuItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(MainMenuScreen, null, null, {context:_context});
			_navigator.addScreen(ScreenId.MAIN_MENU_SCREEN, mainMenuItem);
			
			// Video player screen
			var videoPlayerItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(VideoPlayerScreen, null, null, {context:_context});
			videoPlayerItem.addPopEvent( Event.COMPLETE );
			_navigator.addScreen(ScreenId.VIDEO_PLAYER_SCREEN, videoPlayerItem);					
			
			
		}
		
		private function loadDataConfigErr():void
		{
			
		}
		
	}
}