package com.viewer.model.vo 
{
	import com.viewer.model.vo.menu.IContentMenuItemVO;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public interface IContentViewVO extends IJSONVOSerializable
	{
		/**
		 * The menu items value object.
		 */
		function get menuItems():Vector.<IContentMenuItemVO>;
		
		/**
		 * 3D model info value object.
		 */
		function get model3DVO():IModel3DVO;
		
		/**
		 * Flag, for check load and parse 3d model.
		 */
		function set model3DLoaded( val:Boolean ):void;
		function get model3DLoaded():Boolean;
		
	}
	
}