package com.viewer.view.scene.screens 
{
	import com.viewer.model.ContentTypes;
	import com.viewer.model.vo.menu.IContentMenuItemVO;
	import feathers.controls.Alert;
	import feathers.controls.AutoSizeMode;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.events.MediaPlayerEventType;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayoutData;
	import feathers.media.FullScreenToggleButton;
	import feathers.media.MuteToggleButton;
	import feathers.media.PlayPauseToggleButton;
	import feathers.media.SeekSlider;
	import feathers.media.VideoPlayer;
	import starling.display.DisplayObject;
	import starling.events.Event;
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class VideoPlayerScreen extends BaseContentViewPanelScreen 
	{
		private var _videoPlayer:VideoPlayer;
		private var _view:ImageLoader;
		private var _controls:LayoutGroup;
		private var _playPauseButton:PlayPauseToggleButton;
		private var _seekSlider:SeekSlider;
		private var _muteButton:MuteToggleButton;
		//private var _fullScreenButton:FullScreenToggleButton;
		
		public function VideoPlayerScreen() 
		{
			super();
			
		}
		override protected function initialize():void 
		{
			super.initialize();
			
			//this.width = stage.stageWidth;
			//this.height = stage.stageHeight;
			
			this._videoPlayer = new VideoPlayer();
			this._videoPlayer.autoSizeMode = AutoSizeMode.STAGE;
			this._videoPlayer.addEventListener(Event.READY, videoPlayer_readyHandler);
			this._videoPlayer.addEventListener(MediaPlayerEventType.DISPLAY_STATE_CHANGE, videoPlayer_displayStateChangeHandler);
			this._videoPlayer.addEventListener(FeathersEventType.ERROR, videoPlayer_errorHandler);
			this.addChild(this._videoPlayer);
			
			this._view = new ImageLoader();
			this._videoPlayer.addChild(this._view);
			
			this._controls = new LayoutGroup();
			this._controls.touchable = false;
			this._controls.styleNameList.add(LayoutGroup.ALTERNATE_STYLE_NAME_TOOLBAR);
			this._videoPlayer.addChild(this._controls);
			
			//this._playPauseButton = new PlayPauseToggleButton();
			//this._controls.addChild(this._playPauseButton);
			
			this._seekSlider = new SeekSlider();
			this._seekSlider.layoutData = new HorizontalLayoutData(100);
			this._controls.addChild(this._seekSlider);
			
			this._muteButton = new MuteToggleButton();
			this._controls.addChild(this._muteButton);

			//this._fullScreenButton = new FullScreenToggleButton();
			//this._controls.addChild(this._fullScreenButton);
			
			var controlsLayoutData:AnchorLayoutData = new AnchorLayoutData();
			controlsLayoutData.left = 0;
			controlsLayoutData.right = 0;
			controlsLayoutData.bottom = 0;			
			
			this._controls.layoutData = controlsLayoutData;

			var viewLayoutData:AnchorLayoutData = new AnchorLayoutData();
			viewLayoutData.bottom - 0;
			viewLayoutData.left = 0;
			viewLayoutData.right = 0;
			
			//viewLayoutData.horizontalCenter = 0;
			//viewLayoutData.verticalCenter = 0;
			viewLayoutData.bottomAnchorDisplayObject = this._controls;
			this._view.layoutData = viewLayoutData;
			
			var videoURL:String = getVideoContentURL();
			
			_videoPlayer.videoSource = videoURL;
			//_videoPlayer.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			//_videoPlayer.toggleFullScreen();
			this.headerFactory = this.customHeaderFactory;
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
			this.dispatchEventWith(Event.COMPLETE);
		}
		
		private function onBackButton():void
		{
			this.dispatchEventWith(Event.COMPLETE);
		}		
		
		private function getVideoContentURL():String
		{
			const items:Vector.<IContentMenuItemVO> = _context.dataConfigVO.menuItems;
			const ln:uint = items.length;
			for ( var i:uint = 0; i < ln; i++ )
				if ( items[i].type == ContentTypes.VIDEO_CONTENT_TYPE )
					return items[i].content;
					
			return null;
		}
		
		protected function videoPlayer_readyHandler(event:Event):void
		{
			this._view.source = this._videoPlayer.texture;
			this._controls.touchable = true;
		}
		
		protected function videoPlayer_displayStateChangeHandler(event:Event):void
		{
			/**
			 * TODO
			 */
		}		
		
		protected function videoPlayer_errorHandler(event:Event):void
		{
			Alert.show("Cannot play selected video.",
				"Video Error", new ListCollection([{ label: "OK" }]));
			trace("VideoPlayer Error: " + event.data);
		}		
		
	}

}