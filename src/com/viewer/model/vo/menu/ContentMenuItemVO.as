package com.viewer.model.vo.menu 
{
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class ContentMenuItemVO implements IContentMenuItemVO
	{
		private var _type:String;
		private var _name:String;
		private var _content:String;
		
		/**
		 * Constructor.
		 */
		public function ContentMenuItemVO(){}
		
		/**
		 * Content type.
		 */		
		public function get type():String 
		{
			return _type;
		}
		/**
		 * Content name.
		 */		
		public function get name():String 
		{
			return _name;
		}
		/**
		 * Content url
		 */		
		public function get content():String 
		{
			return _content;
		}
		
		public function serialize(data:Object):void 
		{
			_type = String(data.type);
			_name = String( data.name);
			_content = data.hasOwnProperty("url")?String( data.url ):String( data.text );
		}
		
	}

}