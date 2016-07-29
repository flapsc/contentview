package com.viewer.model.vo 
{
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class Model3dVO implements IModel3DVO
	{
		private var _url:String;
		private var _name:String;
		
		public function Model3dVO(){}
		/**
		 * Serialize input data
		 * @param	data
		 */
		public function serialize( data:Object ):void
		{
			_url = String(data.url);
			_name = String(data.name);
		}
		
		/**
		 * 3d model url( OBJ mesh data format )
		 */		
		public function get url():String
		{
			return _url;
		}

		/**
		 * 3d model name
		 */
		public function get name():String 
		{
			return _name;
		}

		
	}

}