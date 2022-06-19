require("menu/2D/widgets/Menu2DWidgetBase.lua")
if not Menu2DWidgetCheckButton then
	Menu2DWidgetCheckButton = class(Menu2DWidgetBase)
end
Menu2DWidgetCheckButton._enabled = {}
Menu2DWidgetCheckButton._enabled.texture = "gui_menu_tickbox_on"
local l_0_0 = Menu2DWidgetCheckButton._enabled
local l_0_1 = {}
l_0_1.x = 0
l_0_1.y = 0
l_0_0.texcoord = l_0_1
l_0_0 = Menu2DWidgetCheckButton
l_0_0._disabled, l_0_1 = l_0_1, {}
l_0_0 = Menu2DWidgetCheckButton
l_0_0 = l_0_0._disabled
l_0_0.texture = "gui_menu_tickbox_off"
l_0_0 = Menu2DWidgetCheckButton
l_0_0 = l_0_0._disabled
l_0_0.texcoord, l_0_1 = l_0_1, {x = 0, y = 0}
l_0_0 = Menu2DWidgetCheckButton
l_0_1 = function(l_1_0, l_1_1)
	Menu2DWidgetBase.init(l_1_0, l_1_1)
end

l_0_0.init = l_0_1
l_0_0 = Menu2DWidgetCheckButton
l_0_1 = function(l_2_0, l_2_1)
	l_2_0._params.enabled = toboolean(l_2_1.enabled)
end

l_0_0.parse = l_0_1
l_0_0 = Menu2DWidgetCheckButton
l_0_1 = function(l_3_0)
	Menu2DWidgetBase.create_gui(l_3_0)
	local l_3_1 = Application:screen_resolution().y / 720
	local l_3_2, l_3_3 = l_3_0._params.panel:bitmap, l_3_0._params.panel
	local l_3_4 = {}
	l_3_4.texture = l_3_0._enabled.texture
	l_3_4.blend_mode = "add"
	l_3_4.layer = tweak_data.menu2d.layer_normal
	l_3_2 = l_3_2(l_3_3, l_3_4)
	l_3_0._bmp_enabled = l_3_2
	l_3_2 = l_3_0._bmp_enabled
	l_3_2, l_3_3 = l_3_2:set_center_y, l_3_2
	l_3_4 = l_3_0._params
	l_3_4 = l_3_4.panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_2(l_3_3, l_3_4)
	l_3_2 = l_3_0._bmp_enabled
	l_3_2, l_3_3 = l_3_2:set_texture_rect, l_3_2
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_2(l_3_3, l_3_4, 0, l_3_0._bmp_enabled:texture_width(), l_3_0._bmp_enabled:texture_height())
	l_3_2 = l_3_0._params
	l_3_2 = l_3_2.panel
	l_3_2, l_3_3 = l_3_2:bitmap, l_3_2
	l_3_2, l_3_4 = l_3_2(l_3_3, l_3_4), {texture = l_3_0._disabled.texture, blend_mode = "add", layer = tweak_data.menu2d.layer_normal}
	l_3_0._bmp_disabled = l_3_2
	l_3_2 = l_3_0._bmp_disabled
	l_3_2, l_3_3 = l_3_2:set_center_y, l_3_2
	l_3_4 = l_3_0._params
	l_3_4 = l_3_4.panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_2(l_3_3, l_3_4)
	l_3_2, l_3_3 = l_3_0:_set_state, l_3_0
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_2(l_3_3, l_3_4)
end

l_0_0.create_gui = l_0_1
l_0_0 = Menu2DWidgetCheckButton
l_0_1 = function(l_4_0)
	l_4_0._enable = not l_4_0._enable
	l_4_0:set_enable(l_4_0._enable)
end

l_0_0.activate = l_0_1
l_0_0 = Menu2DWidgetCheckButton
l_0_1 = function(l_5_0, l_5_1)
	if l_5_1 then
		l_5_0._bmp_enabled:show()
		l_5_0._bmp_disabled:hide()
		l_5_0._visible_bmp = l_5_0._bmp_enabled
		l_5_0._enable = true
	else
		l_5_0._bmp_enabled:hide()
		l_5_0._bmp_disabled:show()
		l_5_0._visible_bmp = l_5_0._bmp_disabled
		l_5_0._enable = false
	end
	managers.menu2d:use_connection(l_5_0._params.connection_set, l_5_0._enable, l_5_0._params)
end

l_0_0._set_state = l_0_1
l_0_0 = Menu2DWidgetCheckButton
l_0_1 = function(l_6_0, l_6_1)
	l_6_0:_set_state(l_6_1)
	managers.menu2d:sound():play("menu_small_select")
end

l_0_0.set_enable = l_0_1
l_0_0 = Menu2DWidgetCheckButton
l_0_1 = function(l_7_0)
end

l_0_0.destroy = l_0_1
l_0_0 = Menu2DWidgetCheckButton
l_0_1 = function(l_8_0)
	if l_8_0._params.connection_get then
		l_8_0._enable = managers.menu2d:use_connection(l_8_0._params.connection_get, l_8_0._params)
	else
		l_8_0._enable = l_8_0._params._enabled or true
	end
	return l_8_0._enable
end

l_0_0.initial_value = l_0_1
l_0_0 = Menu2DWidgetCheckButton
l_0_1 = function(l_9_0)
	l_9_0._visible_bmp:set_color(tweak_data.menu2d.normal_menu.choice_text_color_active)
	l_9_0._visible_bmp:animate(Menu2DAnimations.flash, tweak_data.menu2d.animation.choice_text_flash_speed, tweak_data.menu2d.animation.choice_text_flash_times, tweak_data.menu2d.animation.choice_text_flash_min_alpha, tweak_data.menu2d.animation.choice_text_flash_max_alpha)
end

l_0_0.set_active = l_0_1
l_0_0 = Menu2DWidgetCheckButton
l_0_1 = function(l_10_0)
	l_10_0._visible_bmp:set_color(tweak_data.menu2d.normal_menu.choice_text_color)
end

l_0_0.set_inactive = l_0_1
l_0_0 = Menu2DWidgetCheckButton
l_0_1 = function(l_11_0, l_11_1, l_11_2)
	if l_11_1 == "fade_in" then
		l_11_0._visible_bmp:set_color(l_11_0._visible_bmp:color():with_alpha(0))
	end
	l_11_0._visible_bmp:animate(Menu2DAnimations[l_11_1], unpack(l_11_2))
end

l_0_0.animate = l_0_1
l_0_0 = Menu2DWidgetCheckButton
l_0_1 = function(l_12_0)
	if l_12_0._enable then
		return l_12_0._bmp_enabled
	else
		return l_12_0._bmp_disabled
	end
end

l_0_0._visible_gui_object = l_0_1
l_0_0 = Menu2DWidgetCheckButton
l_0_1 = function(l_13_0, l_13_1)
	if l_13_1.select and Menu2DUtilities.is_position_over_gui_object(l_13_1.cursor_position, l_13_0:_visible_gui_object()) then
		l_13_0:set_enable(not l_13_0._enable)
	end
end

l_0_0.mouse_input = l_0_1
l_0_0 = Menu2DWidgetCheckButton
l_0_1 = function(l_14_0)
	return "toggle"
end

l_0_0.confirm_mode = l_0_1

