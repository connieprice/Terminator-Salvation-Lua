require("menu/2D/widgets/Menu2DWidgetBase.lua")
Menu2DWidgetBitmap = Menu2DWidgetBitmap or class(Menu2DWidgetBase)
function Menu2DWidgetBitmap.init(A0_0, A1_1)
	Menu2DWidgetBase.init(A0_0, A1_1)
end
function Menu2DWidgetBitmap.parse(A0_2, A1_3)
	local L2_4
	L2_4 = A0_2._params
	L2_4.texture = A1_3.texture
	L2_4 = A0_2._params
	L2_4.x = tonumber(A1_3.x)
	L2_4 = A0_2._params
	L2_4.y = tonumber(A1_3.y)
end
function Menu2DWidgetBitmap.create_gui(A0_5)
	Menu2DWidgetBase.create_gui(A0_5)
	A0_5._bmp = A0_5._params.panel:bitmap({
		texture = A0_5._params.texture,
		w = A0_5._params.panel:w(),
		h = A0_5._params.panel:h(),
		layer = tweak_data.menu2d.layer_normal
	})
	A0_5._bmp:set_texture_rect(A0_5._params.x * Menu2DWidgetBase._tile_size, A0_5._params.y * Menu2DWidgetBase._tile_size, Menu2DWidgetBase._tile_size, Menu2DWidgetBase._tile_size)
end
function Menu2DWidgetBitmap.destroy(A0_6)
	local L1_7
end
function Menu2DWidgetBitmap.mouse_input(A0_8, A1_9)
end
