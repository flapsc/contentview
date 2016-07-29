package com.viewer.model.vo 
{
	import com.viewer.model.vo.menu.ContentMenuItemVO;
	import com.viewer.model.vo.menu.IContentMenuItemVO;
	/**
	 * Content view value object.
	 * @author Mihaylenko A.L.
	 */
	public final class ContentViewVO implements IContentViewVO
	{
		private var _menuItemsVo:Vector.<IContentMenuItemVO>;
		
		private var _model3DVO:IModel3DVO;
		
		private var _isReady:Boolean;
		
		private var _model3DLoaded:Boolean;
		
		private var _needRenderAway3d:Boolean = true;
		
		public function ContentViewVO(){}
		
		/**
		 * The menu items value object.
		 */
		public function get menuItems():Vector.<IContentMenuItemVO>
		{
			return _menuItemsVo;
		}
		
		/**
		 * 3D model info value object.
		 */
		public function get model3DVO():IModel3DVO
		{
			return _model3DVO;
		}
		
		/**
		 * Serialize input data
		 * @param	data - content view JSON data.
		 */
		public final function serialize( data:String ):void		
		{
			_isReady = true;
			try
			{
				const serializedData:Object = JSON.parse(data);
				
				_model3DVO = new Model3dVO()
				_model3DVO.serialize( serializedData.model3d );
				
				const menuSerializedItems:Array = serializedData.menu;
				const ln:uint = menuSerializedItems.length;
				
				_menuItemsVo = Vector.<IContentMenuItemVO>([]);
				_menuItemsVo.length = ln;
				_menuItemsVo.fixed = true;
				
				var menuItemVO:IContentMenuItemVO;
				
				for ( var index:uint = 0; index < ln; index++ )
				{
					menuItemVO = new ContentMenuItemVO();
					menuItemVO.serialize( menuSerializedItems[index] );
					
					_menuItemsVo[index] = menuItemVO;
				}
			}
			catch (error:Error)
			{
				_isReady = false
			}
		}
		
		/**
		 * Flag, for check load and parse 3d model.
		 */
		public function set model3DLoaded( val:Boolean ):void{_model3DLoaded = val; }
		public function get model3DLoaded():Boolean{ return _model3DLoaded; }
		
		
		
		/**
		 * 
		 */
		public function get isReady():Boolean{return _isReady; }
		
		/**
		 * 
		 */
		public function get needRenderAway3d():Boolean{ return _needRenderAway3d; }
		public function set needRenderAway3d( value:Boolean ):void{ _needRenderAway3d = value; }
		
				
		private var _screenTitle:String;
		public function set screenTitle( value:String ):void{ _screenTitle = value; }
		public function get screenTitle():String{ return _screenTitle; }
		
	}
}