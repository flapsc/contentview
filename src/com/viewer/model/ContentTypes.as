package com.viewer.model 
{
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class ContentTypes 
	{
		
		static public const VIDEO_CONTENT_TYPE	:String = "video";
		static public const IMAGE_CONTENT_TYPE	:String = "image";
		static public const PDF_CONTENT_TYPE	:String = "pdf";
		static public const DESCRIPTION_TYPE	:String = "description";
		
		static private const ENABLED_TYPES:Vector.<String> = Vector.<String>([VIDEO_CONTENT_TYPE, IMAGE_CONTENT_TYPE, DESCRIPTION_TYPE]);
		
		static public function isContentEnabled( type:String ):Boolean
		{
			return ENABLED_TYPES.indexOf(type) !=-1;
		}
	}

}