require("menu/2D/widgets/Menu2DWidgetBase.lua")
if not Menu2DWidgetVolume then
	Menu2DWidgetVolume = class(Menu2DWidgetBase)
end
Menu2DWidgetVolume._foreground_alpha_active = 1
Menu2DWidgetVolume._foreground_alpha = 0.4
Menu2DWidgetVolume._background_alpha_active = 0.4
Menu2DWidgetVolume._background_alpha = 0.15
Menu2DWidgetVolume.init = function(l_1_0, l_1_1)
	Menu2DWidgetBase.init(l_1_0, l_1_1)
end

Menu2DWidgetVolume.post_init = function(l_2_0)
	managers.menu2d:sound():preload_sound(l_2_0._sound_up, l_2_0._sound_up)
end

Menu2DWidgetVolume.parse = function(l_3_0, l_3_1)
	l_3_0._params.min = l_3_0._params.min ~= "" and tonumber(l_3_0._params.min) or 0
	l_3_0._params.max = l_3_0._params.max ~= "" and tonumber(l_3_0._params.max) or 1
	l_3_0._sound_up = l_3_0._params.sound ~= "" and l_3_0._params.sound or "menu_up"
	l_3_0._sound_down = l_3_0._params.sound ~= "" and l_3_0._params.sound or "menu_down"
	l_3_0._params = l_3_1
end

Menu2DWidgetVolume.show = function(l_4_0, l_4_1, l_4_2)
	l_4_0._root_panel = l_4_1
	Menu2DWidgetBase.show(l_4_0, l_4_1, l_4_2)
end

Menu2DWidgetVolume.create_gui = function(l_5_0)
	l_5_0._bars = {}
	l_5_0._bars_bg = {}
	l_5_0._text_w = 80
	l_5_0._steps = 10
	local l_5_1 = 32
	local l_5_2 = l_5_0._bars
	local l_5_3, l_5_4 = l_5_0._params.panel:bitmap, l_5_0._params.panel
	local l_5_5 = {}
	l_5_5.texture = "gui_menu_volumebar_line"
	l_5_5.w = 1
	l_5_5.x = 0
	l_5_5.h = 1
	l_5_5.layer = tweak_data.menu2d.layer_normal
	l_5_3 = l_5_3(l_5_4, l_5_5)
	l_5_2[1] = l_5_3
	l_5_2 = l_5_0._bars
	l_5_2 = l_5_2[1]
	l_5_2, l_5_3 = l_5_2:texture_height, l_5_2
	l_5_2 = l_5_2(l_5_3)
	l_5_3 = l_5_0._params
	l_5_3 = l_5_3.panel
	l_5_3, l_5_4 = l_5_3:h, l_5_3
	l_5_3 = l_5_3(l_5_4)
	l_5_2 = l_5_2 / l_5_3
	l_5_3 = l_5_0._params
	l_5_3 = l_5_3.panel
	l_5_3, l_5_4 = l_5_3:w, l_5_3
	l_5_3 = l_5_3(l_5_4)
	l_5_4 = l_5_0._text_w
	l_5_3 = l_5_3 - l_5_4
	l_5_4 = math
	l_5_4 = l_5_4.floor
	l_5_5 = l_5_0._steps
	l_5_5 = (l_5_3) / l_5_5
	l_5_4 = l_5_4(l_5_5)
	l_5_3 = l_5_4
	l_5_4 = 3
	l_5_5 = 1
	local l_5_6 = 0.3
	local l_5_7 = l_5_0:initial_value()
	l_5_0._step_value = (l_5_0._params.max - l_5_0._params.min) / l_5_0._steps
	l_5_0._bars[1]:set_w(l_5_3)
	l_5_0._bars[1]:set_h(l_5_1)
	l_5_0._bars[1]:set_x(l_5_4)
	l_5_0._bars[1]:set_center_y(l_5_0._params.panel:center_y())
	local l_5_8 = l_5_0._bars_bg
	local l_5_9, l_5_10 = l_5_0._params.panel:bitmap, l_5_0._params.panel
	local l_5_11 = {}
	l_5_11.texture = "gui_menu_volumebar_line"
	l_5_11.w = l_5_3
	l_5_11.x = l_5_4
	l_5_11.h = l_5_1
	l_5_11.blend_mode = "add"
	l_5_11.layer = tweak_data.menu2d.layer_normal
	l_5_9 = l_5_9(l_5_10, l_5_11)
	l_5_8[1] = l_5_9
	l_5_8 = l_5_0._bars_bg
	l_5_8 = l_5_8[1]
	l_5_8, l_5_9 = l_5_8:set_center_y, l_5_8
	l_5_10 = l_5_0._params
	l_5_10 = l_5_10.panel
	l_5_10, l_5_11 = l_5_10:center_y, l_5_10
	l_5_11, l_5_10 = .end, l_5_10(l_5_11)
	l_5_8(l_5_9, l_5_10, l_5_11)
	if l_5_7 < 1 then
		l_5_8 = l_5_0._bars
		l_5_8 = l_5_8[1]
		l_5_8, l_5_9 = l_5_8:hide, l_5_8
		l_5_8(l_5_9)
	end
	l_5_8 = 2
	l_5_9 = l_5_0._steps
	l_5_10 = 1
	for l_5_11 = l_5_8, l_5_9, l_5_10 do
		l_5_4 = l_5_4 + l_5_3
		local l_5_12 = l_5_0._bars
		local l_5_13, l_5_14 = l_5_0._params.panel:bitmap, l_5_0._params.panel
		local l_5_15 = {}
		l_5_15.texture = "gui_menu_volumebar_line"
		l_5_15.w = l_5_3
		l_5_15.x = l_5_4
		l_5_15.h = l_5_1
		l_5_15.layer = tweak_data.menu2d.layer_normal
		l_5_13 = l_5_13(l_5_14, l_5_15)
		l_5_12[l_5_11] = l_5_13
		l_5_12 = l_5_0._bars_bg
		l_5_13 = l_5_0._params
		l_5_13 = l_5_13.panel
		l_5_13, l_5_14 = l_5_13:bitmap, l_5_13
		l_5_13, l_5_15 = l_5_13(l_5_14, l_5_15), {texture = "gui_menu_volumebar_line", w = l_5_3, x = l_5_4, h = l_5_1, blend_mode = "add", layer = tweak_data.menu2d.layer_normal}
		l_5_12[l_5_11] = l_5_13
		l_5_12 = l_5_0._bars
		l_5_12 = l_5_12[l_5_11]
		l_5_12, l_5_13 = l_5_12:set_center_y, l_5_12
		l_5_14 = l_5_0._params
		l_5_14 = l_5_14.panel
		l_5_14, l_5_15 = l_5_14:center_y, l_5_14
		l_5_15, l_5_14 = .end, l_5_14(l_5_15)
		l_5_12(l_5_13, l_5_14, l_5_15)
		l_5_12 = l_5_0._bars_bg
		l_5_12 = l_5_12[l_5_11]
		l_5_12, l_5_13 = l_5_12:set_center_y, l_5_12
		l_5_14 = l_5_0._params
		l_5_14 = l_5_14.panel
		l_5_14, l_5_15 = l_5_14:center_y, l_5_14
		l_5_15, l_5_14 = .end, l_5_14(l_5_15)
		l_5_12(l_5_13, l_5_14, l_5_15)
		if l_5_7 < l_5_11 then
			l_5_12 = l_5_0._bars
			l_5_12 = l_5_12[l_5_11]
			l_5_12, l_5_13 = l_5_12:hide, l_5_12
			l_5_12(l_5_13)
		end
	end
	l_5_0._val = l_5_7
	local l_5_16, l_5_17 = nil
	do
		local l_5_18 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_5_0._text = l_5_0._params.panel:text({color = Color(l_5_16, l_5_17, l_5_18, 1), font = "faith_font_22", w = l_5_0._text_w, x = l_5_0._bars[l_5_16]:right() + l_5_5, align = "center", vertical = "center", text = "", layer = tweak_data.menu2d.layer_normal})
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_5_0._bar_bg = l_5_0._root_panel:bitmap({texture = "gui_menu_volumebar_gradient", blend_mode = "add", h = l_5_0._params.panel:h(), layer = tweak_data.menu2d.layer_normal})
		l_5_0._bar_bg:set_h(l_5_0._bars[1]:h() * 1.4)
		l_5_0._bar_bg:set_world_x(l_5_0._params.panel:world_x())
		l_5_0._bar_bg:set_world_center_y(l_5_0._params.panel:world_center_y())
		l_5_0._width = l_5_0._text:x()
		l_5_0:update()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DWidgetVolume.destroy = function(l_6_0)
	l_6_0._bar_bg:parent():remove(l_6_0._bar_bg)
end

Menu2DWidgetVolume.input = function(l_7_0, l_7_1)
	local l_7_2 = nil
	if l_7_1.x > 0 and l_7_0._val < l_7_0._steps then
		l_7_2 = l_7_0._val + 1
	elseif l_7_1.x < 0 and l_7_0._val > 0 then
		l_7_2 = l_7_0._val - 1
	end
	if l_7_2 then
		l_7_0:_set_value(l_7_2)
	end
end

Menu2DWidgetVolume._set_value = function(l_8_0, l_8_1)
	local l_8_2 = l_8_0._val
	l_8_0._val = l_8_1
	if l_8_2 < l_8_1 then
		managers.menu2d:sound():play(l_8_0._sound_up)
	elseif l_8_1 < l_8_2 then
		managers.menu2d:sound():play(l_8_0._sound_down)
	end
	for l_8_6 = 1, l_8_0._steps do
		local l_8_7 = l_8_0._bars[l_8_6]
		if l_8_1 < l_8_6 then
			l_8_7:hide()
		else
			l_8_7:show()
		end
	end
	if l_8_0._params.connection_set then
		managers.menu2d:use_connection(l_8_0._params.connection_set, l_8_0._step_value * l_8_0._val + l_8_0._params.min, l_8_0._params)
		l_8_0:update()
	else
		Application:error("no connection_set in volume widget, correct menu2D.xml, " .. tostring(l_8_0._params.connection_set))
	end
end

Menu2DWidgetVolume.update = function(l_9_0)
	local l_9_1 = l_9_0._val / l_9_0._steps
	l_9_0._bar_bg:set_w(l_9_0._width * l_9_1)
	l_9_0._text:set_text(tostring(math.round(l_9_1 * 100)) .. "%")
end

Menu2DWidgetVolume.text = function(l_10_0)
	return tostring(math.round(l_10_0._val / l_10_0._steps * 100)) .. "%"
end

Menu2DWidgetVolume.initial_value = function(l_11_0)
	local l_11_1 = l_11_0._params.initial_value
	if l_11_0._params.connection_get and l_11_0._params.connection_get ~= "" then
		l_11_1 = managers.menu2d:use_connection(l_11_0._params.connection_get, l_11_0._params)
	else
		if l_11_0._params.initial_value then
			l_11_1 = l_11_0._params.initial_value
		end
	else
		l_11_1 = l_11_0._prams.min
	end
	local l_11_2 = l_11_0._params.max
	local l_11_3 = l_11_0._params.min
	local l_11_4 = math.clamp
	local l_11_5 = l_11_1
	l_11_4 = l_11_4(l_11_5, l_11_3 < l_11_2 and l_11_3 or l_11_2, l_11_3 < l_11_2 and l_11_2 or l_11_3)
	l_11_1 = l_11_4
	l_11_1 = l_11_1 - l_11_3
	l_11_4 = l_11_2 - l_11_3
	l_11_1 = (l_11_1) / (l_11_4)
	l_11_4 = math
	l_11_4 = l_11_4.round
	l_11_5 = l_11_0._steps
	l_11_5 = l_11_5 * (l_11_1)
	l_11_4 = l_11_4(l_11_5)
	l_11_0._val = l_11_4
	l_11_4 = l_11_0._val
	return l_11_4
end

Menu2DWidgetVolume.set_active = function(l_12_0, l_12_1)
	if not l_12_1 then
		for l_12_5 = 1, 10 do
			l_12_0._bars[l_12_5]:stop()
			l_12_0._bars_bg[l_12_5]:stop()
			if l_12_5 <= l_12_0._val then
				l_12_0._bars[l_12_5]:animate(Menu2DAnimations.flash, tweak_data.menu2d.animation.choice_text_flash_speed, tweak_data.menu2d.animation.choice_text_flash_times, l_12_0._foreground_alpha, l_12_0._foreground_alpha_active)
			else
				l_12_0._bars[l_12_5]:animate(Menu2DAnimations.fade_in, 0, 0.1, l_12_0._foreground_alpha_active)
			end
		end
		l_12_0._text:animate(Menu2DAnimations.flash, tweak_data.menu2d.animation.choice_text_flash_speed, tweak_data.menu2d.animation.choice_text_flash_times, tweak_data.menu2d.animation.choice_text_flash_min_alpha, tweak_data.menu2d.animation.choice_text_flash_max_alpha)
	end
	l_12_0._bar_bg:show()
	l_12_0:update()
	l_12_0._active = true
end

Menu2DWidgetVolume.set_inactive = function(l_13_0, l_13_1)
	local l_13_5, l_13_6, l_13_7, l_13_8, l_13_9, l_13_10, l_13_11, l_13_12, l_13_13, l_13_14, l_13_15, l_13_16, l_13_17, l_13_18 = nil
	l_13_0._bar_bg:hide()
	if not l_13_1 then
		for i_0,i_1 in ipairs(l_13_0._bars) do
			i_1:stop()
			l_13_0._bars_bg[i_0]:stop()
			i_1:animate(Menu2DAnimations.fade_out, 0, 0.1, l_13_0._foreground_alpha)
			l_13_0._bars_bg[i_0]:animate(Menu2DAnimations.fade_out, 0, 0.1, l_13_0._background_alpha)
		end
	end
	l_13_0._text:stop()
	l_13_0._text:animate(Menu2DAnimations.fade_out, 0, 0.1, l_13_0._foreground_alpha)
	l_13_0._active = false
end

Menu2DWidgetVolume.animate = function(l_14_0, l_14_1, l_14_2)
	local l_14_7, l_14_8, l_14_9, l_14_10, l_14_11, l_14_12, l_14_13, l_14_14, l_14_15, l_14_16, l_14_17, l_14_18, l_14_19, l_14_20, l_14_21, l_14_22, l_14_23 = nil
	local l_14_3 = clone(l_14_2)
	if l_14_1 == "fade_in" then
		if l_14_0._active then
			l_14_2[3] = l_14_0._foreground_alpha_active
		else
			l_14_2[3] = l_14_0._foreground_alpha
		end
		l_14_3[3] = l_14_0._background_alpha
	end
	for i_0,i_1 in ipairs(l_14_0._bars) do
		if l_14_1 == "fade_in" then
			i_1:set_color(i_1:color():with_alpha(0))
			l_14_0._bars_bg[i_0]:set_color(l_14_0._bars_bg[i_0]:color():with_alpha(0))
		end
		i_1:animate(Menu2DAnimations[l_14_1], unpack(l_14_2))
		l_14_0._bars_bg[i_0]:animate(Menu2DAnimations[l_14_1], unpack(l_14_3))
	end
	l_14_0._text:animate(Menu2DAnimations[l_14_1], unpack(l_14_2))
	l_14_0._bar_bg:animate(Menu2DAnimations[l_14_1], unpack(l_14_2))
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DWidgetVolume.confirm_mode = function(l_15_0)
	local l_15_1 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_15_1
end

Menu2DWidgetVolume.mouse_input = function(l_16_0, l_16_1)
	if not l_16_0._mouse_set_value_mode and l_16_1.select_pressed then
		l_16_0._mouse_set_value_mode = true
	end
	if l_16_0._mouse_set_value_mode and l_16_1.select_down then
		for l_16_5 = 1, l_16_0._steps do
			local l_16_6, l_16_7 = Menu2DUtilities.position_over_gui_object(l_16_1.cursor_position, l_16_0._bars[l_16_5])
			if l_16_6 ~= nil then
				if l_16_6 < 0.5 then
					l_16_0:_set_value(l_16_5 - 1)
				else
					l_16_0:_set_value(l_16_5)
					return 
				end
			end
		else
			l_16_0._mouse_set_value_mode = nil
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

Menu2DWidgetBase.selection_changed = function(l_17_0)
	l_17_0._mouse_set_value_mode = nil
end


