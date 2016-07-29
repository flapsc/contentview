package com.viewer 
{
	import com.viewer.view.scene.IBaseViewMediator;
	import com.viewer.view.scene.Scene2dViewMediator;
	import com.viewer.view.scene.Scene3dViewMediator;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	/**
	 * @author Mihaylenko A.L.
	 */
	public class ContentViewDocumentClass extends Sprite
	{
		
		/**
		 * TODO need move to external local config data settings.
		 */
		static private const APP_HOST:String = "https://appdev.virtualviewing.co.uk";
		static private const APP_CONFIG:String = "test/test.json";
		
		private var _context:IContext;
		
		
		/**
		 * Constructor.
		 */
		public function ContentViewDocumentClass() 
		{
			if (stage)
				this_addedToStage_Handler();
			else
				addEventListener(Event.ADDED_TO_STAGE, this_addedToStage_Handler )
		}
		
		private function this_addedToStage_Handler( event:Event=null ):void
		{
			_context = new Context();
			_context.init(stage, new Scene2dViewMediator(), new Scene3dViewMediator());
			_context.loadAppDataConfig(APP_HOST + "/" + APP_CONFIG);
		}
	}

}