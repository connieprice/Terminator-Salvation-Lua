require("menu/2D/widgets/Menu2DWidgetBase.lua")
Menu2DWidgetCheckButton = Menu2DWidgetCheckButton or class(Menu2DWidgetBase)
Menu2DWidgetCheckButton._enabled = {}
Menu2DWidgetCheckButton._enabled.texture = "gui_menu_tickbox_on"
Menu2DWidgetCheckButton._enabled.texcoord = {x = 0, y = 0}
Menu2DWidgetCheckButton._disabled = {}
Menu2DWidgetCheckButton._disabled.texture = "gui_menu_tickbox_off"
Menu2DWidgetCheckButton._disabled.texcoord = {x = 0, y = 0}
function Menu2DWidgetCheckButton.init(A0_0, A1_1)
	Menu2DWidgetBase.init(A0_0, A1_1)
end
function Menu2DWidgetCheckButton.parse(A0_2, A1_3)
	A0_2._params.enabled = toboolean(A1_3.enabled)
end
function Menu2DWidgetCheckButton.create_gui(A0_4)
	Menu2DWidgetBase.create_gui(A0_4)
	A0_4._bmp_enabled = A0_4._params.panel:bitmap({
		texture = A0_4._enabled.texture,
		blend_mode = "add",
		layer = tweak_data.menu2d.layer_normal
	})
	A0_4._bmp_enabled:set_center_y(A0_4._params.panel:center_y())
	A0_4._bmp_enabled:set_texture_rect(0, 0, A0_4._bmp_enabled:texture_width(), A0_4._bmp_enabled:texture_height())
	A0_4._bmp_disabled = A0_4._params.panel:bitmap({
		texture = A0_4._disabled.texture,
		blend_mode = "add",
		layer = tweak_data.menu2d.layer_normal
	})
	A0_4._bmp_disabled:set_center_y(A0_4._params.panel:center_y())
	A0_4:_set_state(A0_4:initial_value())
end
function Menu2DWidgetCheckButton.activate(A0_5)
	A0_5._enable = not A0_5._enable
	A0_5:set_enable(A0_5._enable)
end
function Menu2DWidgetCheckButton._set_state(A0_6, A1_7)
	if A1_7 then
		A0_6._bmp_enabled:show()
		A0_6._bmp_disabled:hide()
		A0_6._visible_bmp = A0_6._bmp_enabled
		A0_6._enable = true
	else
		A0_6._bmp_enabled:hide()
		A0_6._bmp_disabled:show()
		A0_6._visible_bmp = A0_6._bmp_disabled
		A0_6._enable = false
	end
	managers.menu2d:use_connection(A0_6._params.connection_set, A0_6._enable, A0_6._params)
end
function Menu2DWidgetCheckButton.set_enable(A0_8, A1_9)
	A0_8:_set_state(A1_9)
	managers.menu2d:sound():play("menu_small_select")
end
function Menu2DWidgetCheckButton.destroy(A0_10)
	local L1_11
end
function Menu2DWidgetCheckButton.initial_value(A0_12)
	if A0_12._params.connection_get then
		A0_12._enable = managers.menu2d:use_connection(A0_12._params.connection_get, A0_12._params)
	else
		A0_12._enable = A0_12._params._enabled or true
	end
	return A0_12._enable
end
function Menu2DWidgetCheckButton.set_active(A0_13)
	A0_13._visible_bmp:set_color(tweak_data.menu2d.normal_menu.choice_text_color_active)
	A0_13._visible_bmp:animate(Menu2DAnimations.flash, tweak_data.menu2d.animation.choice_text_flash_speed, tweak_data.menu2d.animation.choice_text_flash_times, tweak_data.menu2d.animation.choice_text_flash_min_alpha, tweak_data.menu2d.animation.choice_text_flash_max_alpha)
end
function Menu2DWidgetCheckButton.set_inactive(A0_14)
	A0_14._visible_bmp:set_color(tweak_data.menu2d.normal_menu.choice_text_color)
end
function Menu2DWidgetCheckButton.animate(A0_15, A1_16, A2_17)
	local L3_18, L4_19
	if A1_16 == "fade_in" then
		L3_18 = A0_15._visible_bmp
		L4_19 = L3_18
		L3_18 = L3_18.set_color
		L3_18(L4_19, A0_15._visible_bmp:color():with_alpha(0))
	end
	L3_18 = A0_15._visible_bmp
	L4_19 = L3_18
	L3_18 = L3_18.animate
	L3_18(L4_19, Menu2DAnimations[A1_16], unpack(A2_17))
end
function Menu2DWidgetCheckButton._visible_gui_object(A0_20)
	if A0_20._enable then
		return A0_20._bmp_enabled
	else
		return A0_20._bmp_disabled
	end
end
function Menu2DWidgetCheckButton.mouse_input(A0_21, A1_22)
	if A1_22.select and Menu2DUtilities.is_position_over_gui_object(A1_22.cursor_position, A0_21:_visible_gui_object()) then
		A0_21:set_enable(not A0_21._enable)
	end
end
function Menu2DWidgetCheckButton.confirm_mode(A0_23)
	local L1_24
	L1_24 = "toggle"
	return L1_24
end
