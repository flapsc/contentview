package com.viewer.model.vo 
{
	
	/**
	 * @author Mihaylenko A.L.
	 */
	public interface IModel3DVO extends IObjectSerializable
	{
		/**
		 * 3d model name
		 */
		function get name():String;
		
		/**
		 * 3d model url( OBJ mesh data format )
		 */
		function get url():String;
	}
	
}