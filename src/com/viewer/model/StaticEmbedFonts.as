package com.viewer.model 
{
	import flash.text.Font;
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class StaticEmbedFonts 
	{
		
		
		static public const DEFAULT_GLOBAL_FONT_NAME:String = "defaultGlobalFontName";
		
		[Embed(source="../../../../libs/embed/AveriaSansLibre-Bold.ttf", fontName = "defaultGlobalFontName", embedAsCFF = "false")]
		static private const GlobalFontCls:Class;
		
		static public function registerFonts():void
		{
			Font.registerFont( GlobalFontCls ); 
		}
	}

}