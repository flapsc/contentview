package com.viewer.model.vo.menu 
{
	import com.viewer.model.vo.IObjectSerializable;
	
	/**
	 * Menu of content view VO.
	 * @author Mihaylenko A.L.
	 */
	public interface IContentMenuItemVO extends IObjectSerializable
	{
		/**
		 * Content type.
		 */
		function get type():String;
		
		/**
		 * Content name.
		 */
		function get name():String;
		
		/**
		 * Current content.
		 */
		function get content():String;
	}
	
}