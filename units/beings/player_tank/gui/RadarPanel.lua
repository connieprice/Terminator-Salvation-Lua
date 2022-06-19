require("units/beings/player_tank/gui/MachineHudPanel")
require("units/beings/player_tank/gui/MachineText")
require("units/beings/player_tank/gui/RadarBlip")
if not RadarPanel then
	RadarPanel = class(MachineHudPanel)
end
RadarPanel.init = function(l_1_0, l_1_1, l_1_2)
	MachineHudPanel.init(l_1_0, l_1_1)
	l_1_0._parent_panel = l_1_1
	l_1_0._unit = l_1_2
	l_1_0._player_data = l_1_0._unit:player_data()
	l_1_0._x = 90
	l_1_0._y = 25
	l_1_0._width = tweak_data.machine.hud.RADAR_PANEL_WIDTH
	l_1_0._height = tweak_data.machine.hud.RADAR_PANEL_HEIGHT
	l_1_0._center_x = tweak_data.machine.hud.RADAR_PANEL_WIDTH / 2
	l_1_0._center_y = tweak_data.machine.hud.RADAR_PANEL_HEIGHT / 2
	l_1_0._radar_sweep_center_x = tweak_data.machine.hud.RADAR_PANEL_HEIGHT * 2 / 3
	l_1_0._size_modifier = 1
	l_1_0._color = tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK
	l_1_0._radius = 128
	l_1_0._radar_distance = 5000
	l_1_0._view_distance = 10000
	l_1_0._radar_speed = 2.5
	l_1_0._testpoints = 10
	l_1_0._testpoints_radius = 15
	local l_1_3, l_1_4 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_5 = {}
	l_1_5.name = "radar_panel"
	l_1_5.width = l_1_0._width
	l_1_5.height = l_1_0._height
	l_1_5.layer = 100
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._radar_panel = l_1_3
	l_1_3 = l_1_0._radar_panel
	l_1_3, l_1_4 = l_1_3:set_lefttop, l_1_3
	l_1_5 = l_1_0._x
	l_1_3(l_1_4, l_1_5, l_1_0._y)
	l_1_3 = l_1_0._radar_panel
	l_1_3, l_1_4 = l_1_3:bitmap, l_1_3
	l_1_3, l_1_5 = l_1_3(l_1_4, l_1_5), {name = "gui_machine_radar", texture = "gui_machine_radar"}
	l_1_0._radar_texture = l_1_3
	l_1_3 = l_1_0._radar_texture
	l_1_3, l_1_4 = l_1_3:set_center_x, l_1_3
	l_1_5 = l_1_0._center_x
	l_1_3(l_1_4, l_1_5)
	l_1_3 = l_1_0._radar_texture
	l_1_3, l_1_4 = l_1_3:set_bottom, l_1_3
	l_1_5 = l_1_0._radar_sweep_center_x
	l_1_3(l_1_4, l_1_5)
	l_1_3 = l_1_0._radar_texture
	l_1_3, l_1_4 = l_1_3:set_color, l_1_3
	l_1_5 = l_1_0._color
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_3(l_1_4, l_1_5)
	l_1_3 = l_1_0._radar_panel
	l_1_3, l_1_4 = l_1_3:bitmap, l_1_3
	l_1_3, l_1_5 = l_1_3(l_1_4, l_1_5), {name = "gui_machine_radar_background", texture = "gui_machine_radar_background"}
	l_1_0._radar_background_texture = l_1_3
	l_1_3 = l_1_0._radar_background_texture
	l_1_3, l_1_4 = l_1_3:set_center_x, l_1_3
	l_1_5 = l_1_0._center_x
	l_1_3(l_1_4, l_1_5)
	l_1_3 = l_1_0._radar_background_texture
	l_1_3, l_1_4 = l_1_3:set_top, l_1_3
	l_1_5 = 0
	l_1_3(l_1_4, l_1_5)
	l_1_3 = l_1_0._radar_background_texture
	l_1_3, l_1_4 = l_1_3:set_color, l_1_3
	l_1_5 = l_1_0._color
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_3(l_1_4, l_1_5)
	l_1_0._current_angle = 90
	l_1_3, l_1_4 = l_1_0:set_angle, l_1_0
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_3(l_1_4, l_1_5)
	l_1_0._radar_blips, l_1_3 = l_1_3, {}
	l_1_0._radar_units, l_1_3 = l_1_3, {}
	l_1_0._unit_list, l_1_3 = l_1_3, {}
	l_1_3, l_1_4 = l_1_0:set_size_y, l_1_0
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_3(l_1_4, l_1_5)
	l_1_0._next_update_time = 0
	l_1_0._next_alpha_update_time = 0
	l_1_0._next_unit_list_update = 0
	l_1_0._dt_since_last_update = 0
	l_1_0._dt_since_last_alpha_update = 0
	l_1_0._need_boot_update = true
end

RadarPanel.panel = function(l_2_0)
	return l_2_0._radar_panel
end

RadarPanel._set_up_frame = function(l_3_0)
	local l_3_1 = {}
	table.insert(l_3_1, Vector3(0, 0, 0))
	table.insert(l_3_1, Vector3(0, l_3_0._radar_panel:height(), 0))
	table.insert(l_3_1, Vector3(l_3_0._radar_panel:width(), l_3_0._radar_panel:height(), 0))
	table.insert(l_3_1, Vector3(l_3_0._radar_panel:width(), 0, 0))
	local l_3_2, l_3_3 = l_3_0._radar_panel:polyline, l_3_0._radar_panel
	local l_3_4 = {}
	l_3_4.name = "frame"
	l_3_4.line_width = 2
	l_3_2 = l_3_2(l_3_3, l_3_4)
	l_3_0._frame = l_3_2
	l_3_2 = l_3_0._frame
	l_3_2, l_3_3 = l_3_2:set_color, l_3_2
	l_3_4 = Color
	l_3_2(l_3_3, l_3_4)
	l_3_2 = l_3_0._frame
	l_3_2, l_3_3 = l_3_2:set_points, l_3_2
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_2(l_3_3, l_3_4)
	l_3_2 = l_3_0._frame
	l_3_2, l_3_3 = l_3_2:set_closed, l_3_2
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_2(l_3_3, l_3_4)
end

RadarPanel.update = function(l_4_0, l_4_1, l_4_2)
	if l_4_0._need_boot_update then
		MachineHudPanel.update(l_4_0, l_4_2)
	end
	if not l_4_0._wants_to_shut_down then
		l_4_0._need_boot_update = l_4_0._wants_to_start_up
	end
	if not l_4_0.startup_done or l_4_0._shuting_down or l_4_0._disabled then
		return 
	end
	l_4_0._dt_since_last_alpha_update = l_4_0._dt_since_last_alpha_update + l_4_2
	local l_4_3 = 360 / l_4_0._radar_speed * l_4_2
	l_4_0._current_angle = l_4_0._current_angle + l_4_3
	if l_4_0._current_angle > 360 then
		l_4_0._current_angle = l_4_0._current_angle - 360
		l_4_0:_play_unit_sound("tank_radar_rotate")
	end
	l_4_0:set_angle(l_4_0._current_angle)
	if l_4_0._next_alpha_update_time < l_4_1 then
		l_4_0:_update_radar_blips(l_4_0._dt_since_last_alpha_update)
		l_4_0._next_alpha_update_time = l_4_1 + tweak_data.machine.hud.ALPHA_UPDATE_FREQUENCY
		l_4_0._dt_since_last_alpha_update = 0
	end
	if l_4_0._next_unit_list_update < l_4_1 then
		l_4_0:_update_units_list()
		l_4_0:_update_radar_units()
		l_4_0._next_unit_list_update = l_4_1 + 1
	end
end

RadarPanel.set_angle = function(l_5_0, l_5_1)
	local l_5_2 = l_5_1
	local l_5_3 = l_5_0._center_x + l_5_0._radius * math.cos(l_5_2 - 90)
	local l_5_4 = l_5_0._radar_sweep_center_x - l_5_0._radius + l_5_0._radius * math.sin(l_5_2 - 90)
	l_5_0._radar_texture:set_rotation(l_5_2)
	l_5_0._radar_texture:set_center_x(l_5_3)
	l_5_0._radar_texture:set_top(l_5_4)
end

RadarPanel._update_units_list = function(l_6_0)
	l_6_0._unit_list = {}
	local l_6_1 = World:find_units_quick("sphere", l_6_0._unit:position(), l_6_0._radar_distance, managers.slot:get_mask("enemies"))
	local l_6_6 = World:find_units_quick
	local l_6_7 = World
	l_6_6 = l_6_6(l_6_7, "sphere", l_6_0._unit:position(), l_6_0._radar_distance, managers.slot:get_mask("vehicles"))
	local l_6_2 = nil
	l_6_7 = pairs
	l_6_2 = l_6_1
	l_6_7 = l_6_7(l_6_2)
	for i_0,i_1 in l_6_7 do
		do
			table.insert(l_6_0._unit_list, l_6_5)
		end
		for i_0,i_1 in pairs(l_6_6) do
			if i_1:name() ~= "rail_vehicle_tank" then
				table.insert(l_6_0._unit_list, i_1)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RadarPanel._update_radar_units = function(l_7_0)
	local l_7_4, l_7_5, l_7_6, l_7_7, l_7_8, l_7_9, l_7_17, l_7_18, l_7_19, l_7_20 = nil
	for i_0,i_1 in pairs(l_7_0._unit_list) do
		if alive(i_1) then
			local l_7_12 = nil
			local l_7_13 = nil
			local l_7_14 = nil
			local l_7_15 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

			local l_7_16 = nil
			if not l_7_0._radar_blips[l_7_11] then
				l_7_0._radar_blips[l_7_11] = RadarBlip:new(l_7_0._radar_panel, l_7_0._center_x + l_7_12:length() / l_7_0._radar_distance * 100 * l_7_0._size_modifier * math.cos(l_7_0._unit:rotation():roll() - Rotation(i_1:position() - l_7_0._unit:position(), Vector3(0, 0, 1)):roll() - 90), l_7_0._radar_sweep_center_x + l_7_12:length() / l_7_0._radar_distance * 100 * l_7_0._size_modifier * math.sin(l_7_15 - 90), true, l_7_0._size_modifier)
			end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			l_7_0._radar_blips[l_7_11]:update_position(l_7_0._center_x + l_7_12:length() / l_7_0._radar_distance * 100 * l_7_0._size_modifier * math.cos(l_7_0._unit:rotation():roll() - Rotation(i_1:position() - l_7_0._unit:position(), Vector3(0, 0, 1)):roll() - 90), l_7_0._radar_sweep_center_x + l_7_12:length() / l_7_0._radar_distance * 100 * l_7_0._size_modifier * math.sin(l_7_15 - 90))
		end
	end
	for i_0,i_1 in pairs(l_7_0._radar_blips) do
		do
			if alive(i_0) and l_7_0._radar_distance < l_7_0._unit:position() - i_0:position():length() then
				l_7_0._radar_blips[l_7_21]:kill()
				l_7_0._radar_blips[l_7_21] = nil
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RadarPanel._update_radar_blips = function(l_8_0, l_8_1)
	local l_8_5, l_8_6, l_8_7, l_8_8, l_8_9, l_8_10, l_8_11, l_8_12, l_8_13, l_8_14, l_8_15, l_8_16 = nil
	for i_0,i_1 in pairs(l_8_0._radar_blips) do
		i_1:update(l_8_1)
		if not alive(i_0) then
			l_8_0._radar_blips[i_0]:kill()
		end
		if i_1:is_done() then
			l_8_0._radar_blips[i_0] = nil
		end
	end
	local l_8_17 = (Vector3(l_8_0._center_x, l_8_0._radar_sweep_center_x, 0) + Vector3(0, -100, 0) * l_8_0._size_modifier:rotate_with(Rotation(Vector3(0, 0, 1), l_8_0._current_angle)).x - l_8_0._center_x) / l_8_0._testpoints
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_8_18 = (Vector3(l_8_0._center_x, l_8_0._radar_sweep_center_x, 0) + Vector3(0, -100, 0) * l_8_0._size_modifier:rotate_with(Rotation(Vector3(0, 0, 1), l_8_0._current_angle)).y - l_8_0._radar_sweep_center_x) / l_8_0._testpoints
	local l_8_19 = {}
	for l_8_23 = 1, l_8_0._testpoints do
		local l_8_27, l_8_29, l_8_31, l_8_33, l_8_35 = nil
		l_8_27 = table
		l_8_27 = l_8_27.insert
		local l_8_28, l_8_30, l_8_32, l_8_34, l_8_36 = nil
		l_8_29 = l_8_19
		l_8_31 = Vector3
		l_8_33 = l_8_0._center_x
		l_8_35 = l_8_17 * l_8_23
		l_8_33 = l_8_33 + l_8_35
		l_8_35 = l_8_0._radar_sweep_center_x
		l_8_28 = l_8_18 * l_8_23
		l_8_35 = l_8_35 + l_8_28
		l_8_28 = 0
		l_8_33, l_8_31 = .end, l_8_31(l_8_33, l_8_35, l_8_28)
		l_8_27(l_8_29, l_8_31, l_8_33, l_8_35, l_8_28, l_8_30, l_8_32, l_8_34, l_8_36)
	end
	for i_0,i_1 in pairs(l_8_0._radar_blips) do
		if not i_1:visible() and i_1:hit_by_radar_line(l_8_19, l_8_0._testpoints_radius) then
			i_1:show()
			l_8_0:_play_unit_sound("tank_radar_beep")
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RadarPanel.get_target_size = function(l_9_0)
	return l_9_0._width, l_9_0._height
end

RadarPanel.set_startup_done = function(l_10_0)
	if not l_10_0._startup_done and not l_10_0._disabled then
		l_10_0._radar_texture:set_color(l_10_0._color:with_alpha(1 * tweak_data.machine.hud.MAIN_ALPHA))
		l_10_0:set_size_y(l_10_0._height)
	end
	MachineHudPanel.set_startup_done(l_10_0)
end

RadarPanel.set_size_y = function(l_11_0, l_11_1)
	l_11_0._radar_texture:set_height(l_11_1)
	l_11_0._radar_texture:set_center_y(l_11_0._center_y)
	l_11_0._radar_background_texture:set_height(l_11_1)
	l_11_0._radar_background_texture:set_center_y(l_11_0._center_y)
end

RadarPanel.shutdown = function(l_12_0, l_12_1, l_12_2)
	local l_12_6, l_12_7, l_12_8, l_12_9 = nil
	for i_0,i_1 in pairs(l_12_0._radar_blips) do
		i_1:kill()
	end
	l_12_0._shuting_down = true
	MachineHudPanel.shutdown(l_12_0, l_12_1, l_12_2)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RadarPanel._show_debug_view_cone = function(l_13_0)
	local l_13_1 = 10
	l_13_0._view_cone = {}
	l_13_0._view_cone[1] = {}
	l_13_0._view_cone[2] = {}
	for l_13_5 = 1, 100 do
		local l_13_6 = l_13_0._view_cone[1]
		local l_13_7 = {}
		l_13_7.x = l_13_5
		l_13_7.y = l_13_1 + l_13_5 * 1.8
		l_13_7.w = 1
		l_13_7.h = 1
		l_13_6[l_13_5] = l_13_7
		l_13_6 = l_13_0._view_cone
		l_13_6 = l_13_6[2]
		l_13_6[l_13_5], l_13_7 = l_13_7, {x = 210 - l_13_5, y = l_13_1 + l_13_5 * 1.8, w = 1, h = 1}
	end
	if not l_13_0._debug_view_cone then
		l_13_0._debug_view_cone = {}
	end
	for l_13_11 = 1, #l_13_0._view_cone do
		for l_13_15 = 1, #l_13_0._view_cone[l_13_11] do
			local l_13_16 = {}
			local l_13_17 = Vector3(l_13_0._view_cone[l_13_11][l_13_15].x, l_13_0._view_cone[l_13_11][l_13_15].y, 0)
			local l_13_18 = l_13_0._view_cone[l_13_11][l_13_15].w
			local l_13_19 = l_13_0._view_cone[l_13_11][l_13_15].h
			table.insert(l_13_16, l_13_17)
			table.insert(l_13_16, l_13_17 + Vector3(l_13_18, 0, 0))
			table.insert(l_13_16, l_13_17 + Vector3(l_13_18, l_13_19, 0))
			table.insert(l_13_16, l_13_17 + Vector3(0, l_13_19, 0))
			table.insert(l_13_16, l_13_17)
			if l_13_0._debug_view_cone[l_13_15 * l_13_11] then
				l_13_0._debug_view_cone[l_13_15 * l_13_11]:hide()
				l_13_0._debug_view_cone[l_13_15 * l_13_11] = nil
			end
			local l_13_20 = l_13_0._debug_view_cone
			local l_13_21 = l_13_15 * l_13_11
			l_13_20[l_13_21] = l_13_0._radar_panel:polyline()
			l_13_20 = l_13_0._debug_view_cone
			l_13_21 = l_13_15 * l_13_11
			l_13_20 = l_13_20[l_13_21]
			l_13_20, l_13_21 = l_13_20:set_color, l_13_20
			l_13_20(l_13_21, Color(1, 1, 1))
			l_13_20 = l_13_0._debug_view_cone
			l_13_21 = l_13_15 * l_13_11
			l_13_20 = l_13_20[l_13_21]
			l_13_20, l_13_21 = l_13_20:set_points, l_13_20
			l_13_20(l_13_21, l_13_16)
		end
	end
end

RadarPanel._show_debug_dots = function(l_14_0, l_14_1)
	if not l_14_0._debug_dots then
		l_14_0._debug_dots = {}
	end
	for l_14_5 = 1, l_14_0._testpoints do
		local l_14_6 = {}
		local l_14_7 = l_14_0._testpoints_radius / 2
		table.insert(l_14_6, l_14_1[l_14_5] + Vector3(-l_14_7, -l_14_7, 0))
		table.insert(l_14_6, l_14_1[l_14_5] + Vector3(l_14_7, -l_14_7, 0))
		table.insert(l_14_6, l_14_1[l_14_5] + Vector3(l_14_7, l_14_7, 0))
		table.insert(l_14_6, l_14_1[l_14_5] + Vector3(-l_14_7, l_14_7, 0))
		table.insert(l_14_6, l_14_1[l_14_5] + Vector3(-l_14_7, -l_14_7, 0))
		if l_14_0._debug_dots[l_14_5] then
			l_14_0._debug_dots[l_14_5]:hide()
			l_14_0._debug_dots[l_14_5] = nil
		end
		l_14_0._debug_dots[l_14_5] = l_14_0._radar_panel:polyline()
		l_14_0._debug_dots[l_14_5]:set_color(Color(1, 1, 1))
		l_14_0._debug_dots[l_14_5]:set_points(l_14_6)
	end
end

RadarPanel.disable = function(l_15_0)
	l_15_0._radar_texture:set_color(l_15_0._color:with_alpha(0))
	local l_15_4, l_15_5 = l_15_0._radar_background_texture:set_color, l_15_0._radar_background_texture
	l_15_4(l_15_5, l_15_0._color:with_alpha(0))
	l_15_4 = pairs
	l_15_5 = l_15_0._radar_blips
	l_15_4 = l_15_4(l_15_5)
	for i_0,i_1 in l_15_4 do
		l_15_3:kill()
	end
	l_15_0._disabled = true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RadarPanel.enable = function(l_16_0, l_16_1)
	local l_16_6, l_16_7 = nil
	l_16_0._size_modifier = l_16_1 or 1
	l_16_0._width = tweak_data.machine.hud.RADAR_PANEL_WIDTH * l_16_0._size_modifier
	l_16_0._height = tweak_data.machine.hud.RADAR_PANEL_HEIGHT * l_16_0._size_modifier
	l_16_0._center_x = tweak_data.machine.hud.RADAR_PANEL_WIDTH / 2 * l_16_0._size_modifier
	l_16_0._center_y = tweak_data.machine.hud.RADAR_PANEL_HEIGHT / 2 * l_16_0._size_modifier
	l_16_0._radar_sweep_center_x = tweak_data.machine.hud.RADAR_PANEL_HEIGHT * 2 / 3 * l_16_0._size_modifier
	l_16_0._testpoints_radius = 15 * l_16_0._size_modifier
	l_16_0._radar_texture:set_size(256 * l_16_0._size_modifier, 256 * l_16_0._size_modifier)
	l_16_0._radar_texture:set_center_x(l_16_0._center_x)
	l_16_0._radar_texture:set_bottom(l_16_0._radar_sweep_center_x)
	local l_16_5 = l_16_0._radar_background_texture:set_size
	l_16_5(l_16_0._radar_background_texture, 256 * l_16_0._size_modifier, 256 * l_16_0._size_modifier)
	l_16_5 = l_16_0._radar_background_texture
	l_16_5(l_16_5, l_16_0._center_x)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_16_5(l_16_5, 0)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_16_0._radius = l_16_5
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0,i_1 in l_16_5 do
		i_1:kill()
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if not l_16_5 then
		l_16_0:set_size_y(0)
	end
	l_16_0._disabled = false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RadarPanel.show = function(l_17_0)
	if l_17_0._disabled then
		return 
	end
	MachineHudPanel.show(l_17_0)
	l_17_0._radar_texture:set_color(l_17_0._color:with_alpha(tweak_data.machine.hud.MAIN_ALPHA))
	local l_17_4, l_17_5 = l_17_0._radar_background_texture:set_color, l_17_0._radar_background_texture
	l_17_4(l_17_5, l_17_0._color:with_alpha(tweak_data.machine.hud.MAIN_ALPHA))
	l_17_4 = pairs
	l_17_5 = l_17_0._radar_blips
	l_17_4 = l_17_4(l_17_5)
	for i_0,i_1 in l_17_4 do
		l_17_3:unhide()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RadarPanel.hide = function(l_18_0)
	MachineHudPanel.hide(l_18_0)
	l_18_0._radar_texture:set_color(l_18_0._color:with_alpha(0))
	local l_18_4, l_18_5 = l_18_0._radar_background_texture:set_color, l_18_0._radar_background_texture
	l_18_4(l_18_5, l_18_0._color:with_alpha(0))
	l_18_4 = pairs
	l_18_5 = l_18_0._radar_blips
	l_18_4 = l_18_4(l_18_5)
	for i_0,i_1 in l_18_4 do
		l_18_3:hide()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RadarPanel._play_unit_sound = function(l_19_0, l_19_1)
	if l_19_0._player_data.on_rail_vehicle then
		l_19_0._player_data.on_rail_vehicle:play(l_19_1)
	end
end


