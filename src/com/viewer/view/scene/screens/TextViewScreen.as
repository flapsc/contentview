package com.viewer.view.scene.screens 
{
	import com.viewer.model.StaticEmbedFonts;
	import feathers.controls.Header;
	import feathers.controls.LayoutGroup;
	import feathers.controls.ScrollText;
	import feathers.controls.supportClasses.IViewPort;
	import feathers.controls.supportClasses.TextFieldViewPort;
	import feathers.layout.AnchorLayoutData;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import starling.display.BlendMode;
	import starling.events.Event;
	import starling.filters.GlowFilter;
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class TextViewScreen extends BaseContentViewPanelScreen
	{
		
		private var _scrolledText:ScrollText;
		
		public function TextViewScreen() 
		{
			super();
			
		}
		
		override protected function initialize():void 
		{
			
			super.initialize();
			headerFactory = customHeaderFactory;
			_scrolledText = new ScrollText();		
			_scrolledText.layoutData = new AnchorLayoutData(0);
			_scrolledText.addEventListener(Event.ADDED_TO_STAGE, scrolledTextADDET_TO_STAGEHandler);

			addChild(_scrolledText);
		}
		
		private function scrolledTextADDET_TO_STAGEHandler(e:Event):void 
		{
			_scrolledText.removeEventListener(Event.ADDED_TO_STAGE, scrolledTextADDET_TO_STAGEHandler);

			_scrolledText.textFormat.size = 60;
			_scrolledText.textFormat.font = StaticEmbedFonts.DEFAULT_GLOBAL_FONT_NAME;
			_scrolledText.textFormat.color = 0xFFFFFF;
			_scrolledText.textFormat.align = TextFormatAlign.LEFT;
			_scrolledText.embedFonts = true;
			_scrolledText.viewPort.y = (_scrolledText.layoutData as AnchorLayoutData).top;
			_scrolledText.text = _context.currentSelectedContentVO.content;
			
		}
		
		override public function dispose():void 
		{
			_scrolledText.removeFromParent( true );
			_scrolledText = null;
			super.dispose();
		}
	}

}