package com.viewer.view.scene.screens 
{
	import away3d.events.LoaderEvent;
	import com.viewer.IContext;
	import feathers.controls.ProgressBar;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.Direction;
	import feathers.skins.IStyleProvider;
	import flash.events.ProgressEvent;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Canvas;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class ProgressBarScreen extends BaseContentViewPanelScreen 
	{
		
		private var _progressBar:ProgressBar;
		private var _progressTween:Tween;
		private var _currURL:String;
		/**
		 * Constructor.
		 */
		public function ProgressBarScreen() 
		{
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			_currURL = title;
			title = "Loading 3d model dependency\n url:" + _currURL;
			_context.addEventListener(ProgressEvent.PROGRESS, contextPROGRESSHandler);
			_progressBar = new ProgressBar();
			_progressBar.layoutData = new AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
			_progressBar.direction = Direction.HORIZONTAL;
			_progressBar.minimum = 0.00001;
			_progressBar.maximum = 1.0000;
			_progressBar.value = 0.01;
			
			addChild( _progressBar );
			
			//_progressTween = new Tween(this._progressBar, 5);
			//_progressTween.animate("value", 1);
			//_progressTween.repeatCount = int.MAX_VALUE;
			//Starling.juggler.add(this._progressTween);			
			
			addEventListener(Event.REMOVED_FROM_STAGE, this_REMOVED_FROM_STAGE_Handler);
		}
		
		private function contextPROGRESSHandler(e:LoaderEvent):void 
		{
			if ( _currURL != e.url )
			{
				_currURL = e.url;
				title = "Loading 3d model dependency\n url:" + _currURL;
			}
			_progressBar.value = Number( e.message );
		}
		
		/**
		 * 
		 */
		private function this_REMOVED_FROM_STAGE_Handler( event:Event ):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, this_REMOVED_FROM_STAGE_Handler);
			if ( _progressTween )
			{
				Starling.juggler.remove(_progressTween);
				_progressTween = null;
			}
			
			if ( _progressBar )
			{
				_progressBar.removeFromParent(true);
				_progressBar = null;
			}
		}
	}
}