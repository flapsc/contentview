package com.viewer.view.scene.screens 
{
	import com.viewer.model.ContentTypes;
	import com.viewer.model.vo.menu.IContentMenuItemVO;
	import feathers.controls.Button;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class MenuButton extends Button 
	{
		private var _itemData:IContentMenuItemVO;
		public function MenuButton() 
		{
			super();
		}

		public function set data(data:IContentMenuItemVO):void
		{
			_itemData = data;
			label = data.name;
			isEnabled = ContentTypes.isContentEnabled( _itemData.type );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function dispose():void 
		{
			_itemData = null;
			removeEventListeners();
			super.dispose();
		}
		public function get data():IContentMenuItemVO{ return _itemData; }
		public function get contentType():String
		{
			return _itemData?_itemData.type:null;
		}
	}

}