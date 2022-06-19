require("units/beings/player_tank/gui/MachineHudPanel")
require("units/beings/player_tank/gui/MachineText")
require("units/beings/player_tank/gui/RadarBlip")
RadarPanel = RadarPanel or class(MachineHudPanel)
function RadarPanel.init(A0_0, A1_1, A2_2)
	MachineHudPanel.init(A0_0, A1_1)
	A0_0._parent_panel = A1_1
	A0_0._unit = A2_2
	A0_0._player_data = A0_0._unit:player_data()
	A0_0._x = 90
	A0_0._y = 25
	A0_0._width = tweak_data.machine.hud.RADAR_PANEL_WIDTH
	A0_0._height = tweak_data.machine.hud.RADAR_PANEL_HEIGHT
	A0_0._center_x = tweak_data.machine.hud.RADAR_PANEL_WIDTH / 2
	A0_0._center_y = tweak_data.machine.hud.RADAR_PANEL_HEIGHT / 2
	A0_0._radar_sweep_center_x = tweak_data.machine.hud.RADAR_PANEL_HEIGHT * 2 / 3
	A0_0._size_modifier = 1
	A0_0._color = tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK
	A0_0._radius = 128
	A0_0._radar_distance = 5000
	A0_0._view_distance = 10000
	A0_0._radar_speed = 2.5
	A0_0._testpoints = 10
	A0_0._testpoints_radius = 15
	A0_0._radar_panel = A0_0._parent_panel:panel({
		name = "radar_panel",
		width = A0_0._width,
		height = A0_0._height,
		layer = 100
	})
	A0_0._radar_panel:set_lefttop(A0_0._x, A0_0._y)
	A0_0._radar_texture = A0_0._radar_panel:bitmap({
		name = "gui_machine_radar",
		texture = "gui_machine_radar"
	})
	A0_0._radar_texture:set_center_x(A0_0._center_x)
	A0_0._radar_texture:set_bottom(A0_0._radar_sweep_center_x)
	A0_0._radar_texture:set_color(A0_0._color:with_alpha(0))
	A0_0._radar_background_texture = A0_0._radar_panel:bitmap({
		name = "gui_machine_radar_background",
		texture = "gui_machine_radar_background"
	})
	A0_0._radar_background_texture:set_center_x(A0_0._center_x)
	A0_0._radar_background_texture:set_top(0)
	A0_0._radar_background_texture:set_color(A0_0._color:with_alpha(tweak_data.machine.hud.MAIN_ALPHA))
	A0_0._current_angle = 90
	A0_0:set_angle(A0_0._current_angle)
	A0_0._radar_blips = {}
	A0_0._radar_units = {}
	A0_0._unit_list = {}
	A0_0:set_size_y(0)
	A0_0._next_update_time = 0
	A0_0._next_alpha_update_time = 0
	A0_0._next_unit_list_update = 0
	A0_0._dt_since_last_update = 0
	A0_0._dt_since_last_alpha_update = 0
	A0_0._need_boot_update = true
end
function RadarPanel.panel(A0_3)
	local L1_4
	L1_4 = A0_3._radar_panel
	return L1_4
end
function RadarPanel._set_up_frame(A0_5)
	local L1_6
	L1_6 = {}
	table.insert(L1_6, Vector3(0, 0, 0))
	table.insert(L1_6, Vector3(0, A0_5._radar_panel:height(), 0))
	table.insert(L1_6, Vector3(A0_5._radar_panel:width(), A0_5._radar_panel:height(), 0))
	table.insert(L1_6, Vector3(A0_5._radar_panel:width(), 0, 0))
	A0_5._frame = A0_5._radar_panel:polyline({name = "frame", line_width = 2})
	A0_5._frame:set_color(Color(1, 1, 1))
	A0_5._frame:set_points(L1_6)
	A0_5._frame:set_closed(true)
end
function RadarPanel.update(A0_7, A1_8, A2_9)
	if A0_7._need_boot_update then
		MachineHudPanel.update(A0_7, A2_9)
	end
	A0_7._need_boot_update = A0_7._wants_to_shut_down or A0_7._wants_to_start_up
	if not A0_7.startup_done or A0_7._shuting_down or A0_7._disabled then
		return
	end
	A0_7._dt_since_last_alpha_update = A0_7._dt_since_last_alpha_update + A2_9
	A0_7._current_angle = A0_7._current_angle + 360 / A0_7._radar_speed * A2_9
	if 360 < A0_7._current_angle then
		A0_7._current_angle = A0_7._current_angle - 360
		A0_7:_play_unit_sound("tank_radar_rotate")
	end
	A0_7:set_angle(A0_7._current_angle)
	if A1_8 > A0_7._next_alpha_update_time then
		A0_7:_update_radar_blips(A0_7._dt_since_last_alpha_update)
		A0_7._next_alpha_update_time = A1_8 + tweak_data.machine.hud.ALPHA_UPDATE_FREQUENCY
		A0_7._dt_since_last_alpha_update = 0
	end
	if A1_8 > A0_7._next_unit_list_update then
		A0_7:_update_units_list()
		A0_7:_update_radar_units()
		A0_7._next_unit_list_update = A1_8 + 1
	end
end
function RadarPanel.set_angle(A0_10, A1_11)
	local L2_12, L3_13, L4_14
	L2_12 = A1_11
	L3_13 = A0_10._center_x
	L4_14 = A0_10._radius
	L4_14 = L4_14 * math.cos(L2_12 - 90)
	L3_13 = L3_13 + L4_14
	L4_14 = A0_10._radar_sweep_center_x
	L4_14 = L4_14 - A0_10._radius
	L4_14 = L4_14 + A0_10._radius * math.sin(L2_12 - 90)
	A0_10._radar_texture:set_rotation(L2_12)
	A0_10._radar_texture:set_center_x(L3_13)
	A0_10._radar_texture:set_top(L4_14)
end
function RadarPanel._update_units_list(A0_15)
	local L1_16, L2_17, L3_18, L4_19, L5_20, L6_21, L7_22
	L1_16 = {}
	A0_15._unit_list = L1_16
	L1_16 = World
	L2_17 = L1_16
	L1_16 = L1_16.find_units_quick
	L6_21 = managers
	L6_21 = L6_21.slot
	L7_22 = L6_21
	L6_21 = L6_21.get_mask
	L7_22 = L6_21(L7_22, "enemies")
	L1_16 = L1_16(L2_17, L3_18, L4_19, L5_20, L6_21, L7_22, L6_21(L7_22, "enemies"))
	L2_17 = World
	L2_17 = L2_17.find_units_quick
	L6_21 = L5_20
	L6_21 = A0_15._radar_distance
	L7_22 = managers
	L7_22 = L7_22.slot
	L7_22 = L7_22.get_mask
	L7_22 = L7_22(L7_22, "vehicles")
	L2_17 = L2_17(L3_18, L4_19, L5_20, L6_21, L7_22, L7_22(L7_22, "vehicles"))
	for L6_21, L7_22 in L3_18(L4_19) do
		table.insert(A0_15._unit_list, L7_22)
	end
	for L6_21, L7_22 in L3_18(L4_19) do
		if L7_22:name() ~= "rail_vehicle_tank" then
			table.insert(A0_15._unit_list, L7_22)
		end
	end
end
function RadarPanel._update_radar_units(A0_23)
	local L1_24, L2_25, L3_26, L4_27, L5_28, L6_29, L7_30, L8_31, L9_32, L10_33, L11_34, L12_35
	for L4_27, L5_28 in L1_24(L2_25) do
		L6_29 = alive
		L7_30 = L5_28
		L6_29 = L6_29(L7_30)
		if L6_29 then
			L7_30 = L5_28
			L6_29 = L5_28.position
			L6_29 = L6_29(L7_30)
			L7_30 = A0_23._unit
			L8_31 = L7_30
			L7_30 = L7_30.position
			L7_30 = L7_30(L8_31)
			L6_29 = L6_29 - L7_30
			L7_30 = A0_23._unit
			L8_31 = L7_30
			L7_30 = L7_30.rotation
			L7_30 = L7_30(L8_31)
			L8_31 = L7_30
			L7_30 = L7_30.roll
			L7_30 = L7_30(L8_31)
			L8_31 = Rotation
			L9_32 = L6_29
			L10_33 = Vector3
			L11_34 = 0
			L12_35 = 0
			L12_35 = L10_33(L11_34, L12_35, 1)
			L8_31 = L8_31(L9_32, L10_33, L11_34, L12_35, L10_33(L11_34, L12_35, 1))
			L9_32 = L8_31
			L8_31 = L8_31.roll
			L8_31 = L8_31(L9_32)
			L9_32 = L7_30 - L8_31
			L11_34 = L6_29
			L10_33 = L6_29.length
			L10_33 = L10_33(L11_34)
			L11_34 = A0_23._radar_distance
			L10_33 = L10_33 / L11_34
			L10_33 = L10_33 * 100
			L11_34 = A0_23._size_modifier
			L10_33 = L10_33 * L11_34
			L11_34 = A0_23._center_x
			L12_35 = math
			L12_35 = L12_35.cos
			L12_35 = L12_35(L9_32 - 90)
			L12_35 = L10_33 * L12_35
			L11_34 = L11_34 + L12_35
			L12_35 = A0_23._radar_sweep_center_x
			L12_35 = L12_35 + L10_33 * math.sin(L9_32 - 90)
			if not A0_23._radar_blips[L5_28] then
				A0_23._radar_blips[L5_28] = RadarBlip:new(A0_23._radar_panel, L11_34, L12_35, true, A0_23._size_modifier)
			else
				A0_23._radar_blips[L5_28]:update_position(L11_34, L12_35)
			end
		end
	end
	for L4_27, L5_28 in L1_24(L2_25) do
		L6_29 = alive
		L7_30 = L4_27
		L6_29 = L6_29(L7_30)
		if L6_29 then
			L6_29 = A0_23._unit
			L7_30 = L6_29
			L6_29 = L6_29.position
			L6_29 = L6_29(L7_30)
			L8_31 = L4_27
			L7_30 = L4_27.position
			L7_30 = L7_30(L8_31)
			L6_29 = L6_29 - L7_30
			L8_31 = L6_29
			L7_30 = L6_29.length
			L7_30 = L7_30(L8_31)
			L8_31 = A0_23._radar_distance
			if L7_30 > L8_31 then
				L8_31 = A0_23._radar_blips
				L8_31 = L8_31[L4_27]
				L9_32 = L8_31
				L8_31 = L8_31.kill
				L8_31(L9_32)
				L8_31 = A0_23._radar_blips
				L8_31[L4_27] = nil
			end
		end
	end
end
function RadarPanel._update_radar_blips(A0_36, A1_37)
	local L2_38, L3_39, L4_40, L5_41, L6_42, L7_43
	for L5_41, L6_42 in L2_38(L3_39) do
		L7_43 = L6_42.update
		L7_43(L6_42, A1_37)
		L7_43 = alive
		L7_43 = L7_43(L5_41)
		if not L7_43 then
			L7_43 = A0_36._radar_blips
			L7_43 = L7_43[L5_41]
			L7_43 = L7_43.kill
			L7_43(L7_43)
		end
		L7_43 = L6_42.is_done
		L7_43 = L7_43(L6_42)
		if L7_43 then
			L7_43 = A0_36._radar_blips
			L7_43[L5_41] = nil
		end
	end
	L5_41 = 0
	L5_41 = 0
	L6_42 = 0
	L7_43 = 1
	L5_41 = A0_36._current_angle
	L5_41 = 0
	L6_42 = -100
	L7_43 = 0
	L5_41 = A0_36._size_modifier
	L6_42 = L4_40
	L5_41 = L4_40.rotate_with
	L7_43 = L3_39
	L5_41 = L5_41(L6_42, L7_43)
	L5_41 = L4_40.x
	L6_42 = A0_36._center_x
	L5_41 = L5_41 - L6_42
	L6_42 = A0_36._testpoints
	L5_41 = L5_41 / L6_42
	L6_42 = L4_40.y
	L7_43 = A0_36._radar_sweep_center_x
	L6_42 = L6_42 - L7_43
	L7_43 = A0_36._testpoints
	L6_42 = L6_42 / L7_43
	L7_43 = {}
	for _FORV_11_ = 1, A0_36._testpoints do
		table.insert(L7_43, Vector3(A0_36._center_x + L5_41 * _FORV_11_, A0_36._radar_sweep_center_x + L6_42 * _FORV_11_, 0))
	end
	for 