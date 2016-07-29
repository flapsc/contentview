package com.viewer.model.vo 
{
	
	/**
	 * Base interface of value object serialize.
	 * @author Mihaylenko A.L.
	 */
	public interface IJSONVOSerializable 
	{
		/**
		 * Serialize input data
		 * @param	data - content view JSON data.
		 */
		function serialize( data:String ):void;
		
		/**
		 * 
		 */
		function get isReady():Boolean;
	}
	
}