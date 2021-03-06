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
	import feathers.media.VolumeSlider;
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
		private var _volumeSlider:VolumeSlider;
		//private var _fullScreenButton:FullScreenToggleButton;
		
		public function VideoPlayerScreen() 
		{
			super();
			
		}
		override protected function initialize():void 
		{
			super.initialize();
			
			this._videoPlayer = new VideoPlayer();
			this._videoPlayer.autoSizeMode = AutoSizeMode.STAGE;
			this._videoPlayer.addEventListener(Event.READY, videoPlayer_readyHandler);
			this._videoPlayer.addEventListener(MediaPlayerEventType.DISPLAY_STATE_CHANGE, videoPlayer_displayStateChangeHandler);
			this._videoPlayer.addEventListener(FeathersEventType.ERROR, videoPlayer_errorHandler);
			
			this._view = new ImageLoader();
			_view.maintainAspectRatio = true;
			
			_videoPlayer.addChild(this._view);
			
			this._controls = new LayoutGroup();
			this._controls.touchable = false;
			this._controls.styleNameList.add(LayoutGroup.ALTERNATE_STYLE_NAME_TOOLBAR);
			this._videoPlayer.addChild(this._controls);
			
			this._playPauseButton = new PlayPauseToggleButton();
			this._controls.addChild(this._playPauseButton);
			
			this._seekSlider = new SeekSlider();
			this._seekSlider.layoutData = new HorizontalLayoutData(100);
			this._controls.addChild(this._seekSlider);
			
			_muteButton = new MuteToggleButton();
			_controls.addChild(this._muteButton);			
			
			_volumeSlider = new VolumeSlider();
			_controls.addChild( _volumeSlider );
			
			var controlsLayoutData:AnchorLayoutData = new AnchorLayoutData();
			controlsLayoutData.left = 0;
			controlsLayoutData.right = 0;
			controlsLayoutData.bottom = 10;
			
			this._controls.layoutData = controlsLayoutData;

			var viewLayoutData:AnchorLayoutData = new AnchorLayoutData();
			viewLayoutData.left = 0;
			viewLayoutData.right = 0;
			
			
			viewLayoutData.bottomAnchorDisplayObject = this._controls;
			this._view.layoutData = viewLayoutData;
			
			_videoPlayer.layoutData = viewLayoutData;
			scrollBarDisplayMode = SCROLL_POLICY_OFF;
			addChild(_videoPlayer);
			
			_videoPlayer.videoSource = _context.currentSelectedContentVO.content;
			
			headerFactory = customHeaderFactory;
		}
		
		private function onBackButton():void
		{
			this.dispatchEventWith(Event.COMPLETE);
		}		
		
		protected function videoPlayer_readyHandler(event:Event):void
		{
			this._videoPlayer.removeEventListener(Event.READY, videoPlayer_readyHandler);
			_view.source = _videoPlayer.texture;
			_controls.touchable = true;
		}
		
		protected function videoPlayer_displayStateChangeHandler(event:Event):void
		{
			/**
			 * TODO
			 */
		}		
		override public function dispose():void 
		{
			
			_controls.removeFromParent(true);
			
			_view.removeFromParent(true);
			_view = null;
			
			_videoPlayer.removeFromParent(true)
			_videoPlayer = null;
			
			
			super.dispose();
			
		}
		protected function videoPlayer_errorHandler(event:Event):void
		{
			Alert.show("Cannot play selected video.",
				"Video Error", new ListCollection([{ label: "OK" }]));
			trace("VideoPlayer Error: " + event.data);
		}		
		
	}

}