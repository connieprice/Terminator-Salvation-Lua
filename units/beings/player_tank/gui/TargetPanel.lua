require("units/beings/player_tank/gui/MachineText")
if not TargetPanel then
	TargetPanel = class()
end
TargetPanel.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._player_unit = l_1_2
	l_1_0._player_data = l_1_2:player_data()
	l_1_0._safe_panel = l_1_1
	l_1_0._x = l_1_0._safe_panel:width() / 2 + 100
	l_1_0._y = 100
	l_1_0._width = tweak_data.machine.hud.TARGET_PANEL_WIDTH
	l_1_0._height = tweak_data.machine.hud.TARGET_PANEL_HEIGHT
	local l_1_3, l_1_4 = l_1_0._safe_panel:panel, l_1_0._safe_panel
	local l_1_5 = {}
	l_1_5.name = "target_panel "
	l_1_5.width = l_1_0._width
	l_1_5.height = l_1_0._height
	l_1_5.layer = 100
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._target_panel = l_1_3
	l_1_3 = l_1_0._target_panel
	l_1_3, l_1_4 = l_1_3:set_lefttop, l_1_3
	l_1_5 = l_1_0._x
	l_1_3(l_1_4, l_1_5, l_1_0._y)
	l_1_0._target_textures, l_1_3 = l_1_3, {}
	l_1_3 = tweak_data
	l_1_3 = l_1_3.machine
	l_1_3 = l_1_3.hud
	l_1_3 = l_1_3.HIGHLIGHT_COLOR_TWEAK
	l_1_0._color = l_1_3
	l_1_3 = Localizer
	l_1_3, l_1_4 = l_1_3:lookup, l_1_3
	l_1_5 = "machine_hud_terminate"
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._terminate_text = l_1_3
	l_1_3 = Localizer
	l_1_3, l_1_4 = l_1_3:lookup, l_1_3
	l_1_5 = "machine_hud_terminated"
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._terminated_text = l_1_3
	l_1_3 = Localizer
	l_1_3, l_1_4 = l_1_3:lookup, l_1_3
	l_1_5 = "machine_hud_target"
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._target_text = l_1_3
	l_1_3 = Localizer
	l_1_3, l_1_4 = l_1_3:lookup, l_1_3
	l_1_5 = "machine_hud_distance"
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._distance_text = l_1_3
	l_1_3 = Localizer
	l_1_3, l_1_4 = l_1_3:lookup, l_1_3
	l_1_5 = "machine_hud_status"
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._status_text = l_1_3
	l_1_3 = Localizer
	l_1_3, l_1_4 = l_1_3:lookup, l_1_3
	l_1_5 = "machine_hud_threat"
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._threat_text = l_1_3
	l_1_0._grid_alpha_modifier = 0.1
	l_1_0._target_texture_alpha_modifier = 0.8
	l_1_0._size_modifier = 1
	l_1_3, l_1_4 = l_1_0:_set_up_grid, l_1_0
	l_1_3(l_1_4)
	l_1_3, l_1_4 = l_1_0:_set_up_texts, l_1_0
	l_1_3(l_1_4)
	l_1_3, l_1_4 = l_1_0:set_alpha, l_1_0
	l_1_5 = 0
	l_1_3(l_1_4, l_1_5)
	l_1_0._wants_to_fade_in = false
	l_1_0._wants_to_fade_out = false
	l_1_3 = tweak_data
	l_1_3 = l_1_3.machine
	l_1_3 = l_1_3.hud
	l_1_3 = l_1_3.TARGET_PANEL_MINIMUM_DISPLAY_TIME
	l_1_0._target_display_time = l_1_3
	l_1_3 = Interpolator
	l_1_3, l_1_4 = l_1_3:new, l_1_3
	l_1_5 = 0
	l_1_3 = l_1_3(l_1_4, l_1_5, tweak_data.machine.hud.RETICULE_ARROW_MOVE_IN_SPEED)
	l_1_0._alpha_interpolator = l_1_3
	l_1_0._next_update_time = 0
	l_1_0._dt_since_last_update = 0
end

TargetPanel.panel = function(l_2_0)
	return l_2_0._target_panel
end

TargetPanel._set_up_texts = function(l_3_0)
	local l_3_1 = 140
	local l_3_2 = 260
	local l_3_3 = 5
	local l_3_4 = 18 * l_3_0._size_modifier
	l_3_0._texts = {}
	l_3_0._texts.action = MachineText:new(l_3_0._target_panel, l_3_1, l_3_3 + 110 * l_3_0._size_modifier, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	l_3_0._texts.target = MachineText:new(l_3_0._target_panel, l_3_1, l_3_3, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	l_3_0._texts["target name"] = MachineText:new(l_3_0._target_panel, l_3_2, l_3_3, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	l_3_0._texts.threat = MachineText:new(l_3_0._target_panel, l_3_1, l_3_3 + l_3_4, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	l_3_0._texts.threat_level = MachineText:new(l_3_0._target_panel, l_3_2, l_3_3 + l_3_4, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	l_3_0._texts.target_distance_text = MachineText:new(l_3_0._target_panel, l_3_1, l_3_3 + l_3_4 * 2, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	l_3_0._texts.target_distance_number = MachineText:new(l_3_0._target_panel, l_3_2, l_3_3 + l_3_4 * 2, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	l_3_0._texts.target_status = MachineText:new(l_3_0._target_panel, l_3_1, l_3_3 + l_3_4 * 3, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	l_3_0._texts.target_status_number = MachineText:new(l_3_0._target_panel, l_3_2, l_3_3 + l_3_4 * 3, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
end

TargetPanel._set_up_grid = function(l_4_0)
	if not tweak_data.machine.hud.ADD_GRID then
		l_4_0._grid = {}
		return 
	end
	local l_4_1 = 130 * l_4_0._size_modifier
	local l_4_2 = 130 * l_4_0._size_modifier
	local l_4_3 = 10 * l_4_0._size_modifier
	local l_4_4 = 5
	local l_4_5 = 5
	l_4_0._grid = {}
	for l_4_9 = 5, l_4_2 + l_4_3, l_4_3 do
		local l_4_10 = {}
		if l_4_9 == 5 then
			table.insert(l_4_10, Vector3(l_4_4 - 1, l_4_5 - 1, 0))
		end
		table.insert(l_4_10, Vector3(l_4_4, l_4_9, 0))
		table.insert(l_4_10, Vector3(l_4_4 + l_4_1, l_4_9, 0))
		local l_4_11 = l_4_0._grid
		local l_4_12, l_4_13 = l_4_0._target_panel:polyline, l_4_0._target_panel
		local l_4_14 = {}
		l_4_14.name = "grid"
		l_4_12 = l_4_12(l_4_13, l_4_14)
		l_4_11[l_4_9] = l_4_12
		l_4_11 = l_4_0._grid
		l_4_11 = l_4_11[l_4_9]
		l_4_11, l_4_12 = l_4_11:set_points, l_4_11
		l_4_13 = l_4_10
		l_4_11(l_4_12, l_4_13)
	end
	for l_4_18 = 5, l_4_1 + l_4_3, l_4_3 do
		local l_4_19 = {}
		table.insert(l_4_19, Vector3(l_4_18, l_4_5, 0))
		table.insert(l_4_19, Vector3(l_4_18, l_4_5 + l_4_2, 0))
		local l_4_20 = l_4_0._grid
		local l_4_21 = l_4_18 + 1
		local l_4_22, l_4_23 = l_4_0._target_panel:polyline, l_4_0._target_panel
		local l_4_24 = {}
		l_4_24.name = "grid"
		l_4_22 = l_4_22(l_4_23, l_4_24)
		l_4_20[l_4_21] = l_4_22
		l_4_20 = l_4_0._grid
		l_4_21 = l_4_18 + 1
		l_4_20 = l_4_20[l_4_21]
		l_4_20, l_4_21 = l_4_20:set_points, l_4_20
		l_4_22 = l_4_19
		l_4_20(l_4_21, l_4_22)
	end
end

TargetPanel.get_alpha = function(l_5_0)
	return l_5_0._alpha
end

TargetPanel.set_alpha = function(l_6_0, l_6_1)
	local l_6_5, l_6_6, l_6_7, l_6_8, l_6_9, l_6_10, l_6_11, l_6_12 = nil
	l_6_0._alpha = l_6_1
	for i_0,i_1 in pairs(l_6_0._grid) do
		i_1:set_color(l_6_0._color:with_alpha(l_6_1 * l_6_0._grid_alpha_modifier * tweak_data.machine.hud.MAIN_ALPHA))
	end
	for i_0,i_1 in pairs(l_6_0._texts) do
		i_1:set_text_alpha(l_6_1)
	end
	if l_6_0._target_texture then
		l_6_0._target_texture:set_color(l_6_0._color:with_alpha(l_6_1 * l_6_0._target_texture_alpha_modifier * tweak_data.machine.hud.MAIN_ALPHA))
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

TargetPanel.visible = function(l_7_0)
	return l_7_0._alpha > 0
end

TargetPanel.fade_in = function(l_8_0)
	l_8_0._alpha_interpolator:set_speed(tweak_data.machine.hud.RETICULE_ARROW_MOVE_IN_SPEED)
	l_8_0._alpha_interpolator:set_target(1)
end

TargetPanel.fade_out = function(l_9_0)
	l_9_0._alpha_interpolator:set_speed(tweak_data.machine.hud.RETICULE_ARROW_MOVE_IN_SPEED)
	l_9_0._alpha_interpolator:set_target(0)
end

TargetPanel.set_target = function(l_10_0, l_10_1)
	l_10_0._target = l_10_1
	l_10_0._target_damage_data = l_10_0._target:damage_data()
	if l_10_0._target_data then
		local l_10_2 = l_10_0._target_data.unit_name
		local l_10_3 = l_10_0._target_data.texture_name
		local l_10_4 = nil
		if l_10_0._target_textures[l_10_2] then
			l_10_4 = l_10_0._target_textures[l_10_2]
		else
			local l_10_5 = l_10_0._target_textures
			local l_10_6, l_10_7 = l_10_0._target_panel:bitmap, l_10_0._target_panel
			local l_10_8 = {}
			l_10_8.name = l_10_2
			l_10_8.texture = l_10_3
			l_10_6 = l_10_6(l_10_7, l_10_8)
			l_10_5[l_10_2] = l_10_6
			l_10_5 = l_10_0._target_textures
			l_10_5 = l_10_5[l_10_2]
			l_10_5, l_10_6 = l_10_5:set_lefttop, l_10_5
			l_10_7 = 5
			l_10_8 = 5
			l_10_5(l_10_6, l_10_7, l_10_8)
			l_10_5 = l_10_0._target_textures
			l_10_5 = l_10_5[l_10_2]
			l_10_5, l_10_6 = l_10_5:set_size, l_10_5
			l_10_7 = l_10_0._target_textures
			l_10_7 = l_10_7[l_10_2]
			l_10_7, l_10_8 = l_10_7:width, l_10_7
			l_10_7 = l_10_7(l_10_8)
			l_10_8 = l_10_0._size_modifier
			l_10_7 = l_10_7 * l_10_8
			l_10_8 = l_10_0._target_textures
			l_10_8 = l_10_8[l_10_2]
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_10_5(l_10_6, l_10_7, l_10_8)
			l_10_5 = l_10_0._target_textures
			l_10_4 = l_10_5[l_10_2]
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_10_0._target_texture and l_10_0._target_texture ~= l_10_4 then
			l_10_0._target_texture:set_color(l_10_0._color:with_alpha(0))
		end
		l_10_0._target_texture = l_10_4
		l_10_0._target_texture:set_color(l_10_0._color:with_alpha(l_10_0._alpha * l_10_0._target_texture_alpha_modifier * tweak_data.machine.hud.MAIN_ALPHA))
	end
end

TargetPanel.display_target = function(l_11_0)
	local l_11_1 = l_11_0:_get_target_status()
	if l_11_1 == l_11_0._terminated_text then
		l_11_0._texts.action:set_text("", false)
	else
		l_11_0._texts.action:set_text(l_11_0._terminate_text, true)
	end
	l_11_0._texts.target:set_text(l_11_0._target_text)
	l_11_0._texts["target name"]:set_text(l_11_0:_get_target_name())
	l_11_0._texts.threat:set_text(l_11_0._threat_text)
	l_11_0._texts.threat_level:set_text(l_11_0:_get_target_threat_level())
	l_11_0._texts.target_distance_text:set_text(l_11_0._distance_text)
	l_11_0._texts.target_distance_number:set_text("")
	l_11_0._texts.target_status:set_text(l_11_0._status_text)
	l_11_0._texts.target_status_number:set_text(l_11_1)
	l_11_0:fade_in()
end

TargetPanel.remove_target = function(l_12_0)
	l_12_0:fade_out()
end

TargetPanel.update = function(l_13_0, l_13_1, l_13_2, l_13_3)
	if l_13_0._disabled then
		return 
	end
	if not l_13_0._alpha_interpolator:has_reached_target() then
		l_13_0._alpha_interpolator:update(l_13_2)
		l_13_0:set_alpha(l_13_0._alpha_interpolator:value())
	end
	if l_13_3 and not l_13_0._target then
		l_13_0._target_data = l_13_3:machine_hud_data()
		l_13_0:set_target(l_13_3)
		l_13_0:display_target()
		l_13_0._target_displayed_time = 0
		l_13_0._player_data.on_rail_vehicle:play("hud_target")
	elseif l_13_3 and l_13_0._target and l_13_3 ~= l_13_0._target then
		l_13_0._target_data = l_13_3:machine_hud_data()
		l_13_0:set_target(l_13_3)
		l_13_0:display_target()
		l_13_0._target_displayed_time = 0
		l_13_0._player_data.on_rail_vehicle:play("hud_target")
	elseif l_13_0._target and not l_13_3 and l_13_0._target_display_time <= l_13_0._target_displayed_time then
		l_13_0:remove_target()
		l_13_0._target = nil
	end
	if l_13_0._target then
		l_13_0._target_displayed_time = l_13_0._target_displayed_time + l_13_2
	end
	l_13_0._dt_since_last_update = l_13_0._dt_since_last_update + l_13_2
	if l_13_0._next_update_time < l_13_1 then
		if l_13_0._target then
			l_13_0:update_target_data(l_13_0._dt_since_last_update)
		end
		l_13_0._next_update_time = l_13_1 + tweak_data.machine.hud.UPDATE_FREQUENCY
		l_13_0._dt_since_last_update = 0
	end
end

TargetPanel.update_target_data = function(l_14_0, l_14_1)
	l_14_0._texts.target_status_number:update_text(l_14_0:_get_target_status())
	local l_14_5, l_14_6 = l_14_0._texts.target_distance_number:update_text, l_14_0._texts.target_distance_number
	l_14_5(l_14_6, l_14_0:_get_target_distance())
	l_14_5 = pairs
	l_14_6 = l_14_0._texts
	l_14_5 = l_14_5(l_14_6)
	for i_0,i_1 in l_14_5 do
		l_14_4:update(l_14_1)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

TargetPanel._get_target_name = function(l_15_0)
	local l_15_1 = ""
	if l_15_0._target_data then
		l_15_1 = Localizer:lookup(l_15_0._target_data.unit_name)
		if l_15_1 == "" then
			l_15_1 = l_15_0._target_data.unit_name
		end
	else
		l_15_1 = l_15_1:upper()
	end
	return l_15_1
end

TargetPanel._get_target_status = function(l_16_0)
	local l_16_1 = ""
	if alive(l_16_0._target) then
		local l_16_2 = (l_16_0._target_damage_data.health - l_16_0._target_damage_data.damage) / l_16_0._target_damage_data.health * 100
		if l_16_2 > 75 then
			l_16_1 = "100 %"
		end
	elseif l_16_2 > 50 then
		l_16_1 = "75 %"
	elseif l_16_2 > 25 then
		l_16_1 = "50 %"
	elseif l_16_2 > 0 then
		l_16_1 = "25 %"
	else
		l_16_1 = l_16_0._terminated_text
	end
	return l_16_1
end

TargetPanel._get_target_distance = function(l_17_0)
	local l_17_1 = ""
	if alive(l_17_0._target) then
		local l_17_2 = l_17_0._target:position() - l_17_0._player_unit:position()
		local l_17_3 = l_17_2:length() / 100
		l_17_1 = string.format("%." .. 2 .. "f", l_17_3)
	end
	return l_17_1
end

TargetPanel._get_target_threat_level = function(l_18_0)
	local l_18_1 = ""
	if l_18_0._target_data then
		l_18_1 = Localizer:lookup(l_18_0._target_data.threat_level)
	end
	return l_18_1
end

TargetPanel.use_position = function(l_19_0, l_19_1, l_19_2)
	l_19_0._y = 100 * l_19_2
	if l_19_0._player_unit:name() == "player2_tank" then
		l_19_0._y = l_19_0._y + 70
	end
	l_19_0._x = l_19_0._safe_panel:width() / 2 + 100 * l_19_1
	l_19_0._target_panel:set_lefttop(l_19_0._x, l_19_0._y)
end

TargetPanel.disable = function(l_20_0)
	l_20_0:set_alpha(0)
	l_20_0._disabled = true
end

TargetPanel.use_size = function(l_21_0, l_21_1)
	if not l_21_1 then
		l_21_1 = 1
	end
	if l_21_1 ~= l_21_0._size_modifier then
		l_21_0._size_modifier = l_21_1
		l_21_0:set_alpha(0)
		l_21_0:_set_up_grid()
		l_21_0._target_textures = {}
		l_21_0:_set_up_texts()
		l_21_0:set_alpha(0)
	end
	l_21_0._disabled = false
end

TargetPanel.show = function(l_22_0)
	do
		local l_22_1, l_22_2 = l_22_0._alpha_before_hide or 1
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_22_0:set_alpha(l_22_1)
	l_22_0.hidden = false
end

TargetPanel.hide = function(l_23_0)
	l_23_0._alpha_before_hide = l_23_0._alpha
	l_23_0:set_alpha(0)
	l_23_0.hidden = true
end


