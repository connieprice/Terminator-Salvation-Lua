require("menu/2D/widgets/Menu2DWidgetBase.lua")
if not Menu2DWidgetBitmap then
	Menu2DWidgetBitmap = class(Menu2DWidgetBase)
end
Menu2DWidgetBitmap.init = function(l_1_0, l_1_1)
	Menu2DWidgetBase.init(l_1_0, l_1_1)
end

Menu2DWidgetBitmap.parse = function(l_2_0, l_2_1)
	l_2_0._params.texture = l_2_1.texture
	l_2_0._params.x = tonumber(l_2_1.x)
	l_2_0._params.y = tonumber(l_2_1.y)
end

Menu2DWidgetBitmap.create_gui = function(l_3_0)
	Menu2DWidgetBase.create_gui(l_3_0)
	local l_3_1, l_3_2 = l_3_0._params.panel:bitmap, l_3_0._params.panel
	local l_3_3 = {}
	l_3_3.texture = l_3_0._params.texture
	l_3_3.w = l_3_0._params.panel:w()
	l_3_3.h = l_3_0._params.panel:h()
	l_3_3.layer = tweak_data.menu2d.layer_normal
	l_3_1 = l_3_1(l_3_2, l_3_3)
	l_3_0._bmp = l_3_1
	l_3_1 = l_3_0._bmp
	l_3_1, l_3_2 = l_3_1:set_texture_rect, l_3_1
	l_3_3 = l_3_0._params
	l_3_3 = l_3_3.x
	l_3_3 = l_3_3 * Menu2DWidgetBase._tile_size
	l_3_1(l_3_2, l_3_3, l_3_0._params.y * Menu2DWidgetBase._tile_size, Menu2DWidgetBase._tile_size, Menu2DWidgetBase._tile_size)
end

Menu2DWidgetBitmap.destroy = function(l_4_0)
end

Menu2DWidgetBitmap.mouse_input = function(l_5_0, l_5_1)
end


