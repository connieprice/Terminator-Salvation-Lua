require("units/beings/player_tank/gui/MachineText")
TargetPanel = TargetPanel or class()
function TargetPanel.init(A0_0, A1_1, A2_2)
	A0_0._player_unit = A2_2
	A0_0._player_data = A2_2:player_data()
	A0_0._safe_panel = A1_1
	A0_0._x = A0_0._safe_panel:width() / 2 + 100
	A0_0._y = 100
	A0_0._width = tweak_data.machine.hud.TARGET_PANEL_WIDTH
	A0_0._height = tweak_data.machine.hud.TARGET_PANEL_HEIGHT
	A0_0._target_panel = A0_0._safe_panel:panel({
		name = "target_panel ",
		width = A0_0._width,
		height = A0_0._height,
		layer = 100
	})
	A0_0._target_panel:set_lefttop(A0_0._x, A0_0._y)
	A0_0._target_textures = {}
	A0_0._color = tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK
	A0_0._terminate_text = Localizer:lookup("machine_hud_terminate")
	A0_0._terminated_text = Localizer:lookup("machine_hud_terminated")
	A0_0._target_text = Localizer:lookup("machine_hud_target")
	A0_0._distance_text = Localizer:lookup("machine_hud_distance")
	A0_0._status_text = Localizer:lookup("machine_hud_status")
	A0_0._threat_text = Localizer:lookup("machine_hud_threat")
	A0_0._grid_alpha_modifier = 0.1
	A0_0._target_texture_alpha_modifier = 0.8
	A0_0._size_modifier = 1
	A0_0:_set_up_grid()
	A0_0:_set_up_texts()
	A0_0:set_alpha(0)
	A0_0._wants_to_fade_in = false
	A0_0._wants_to_fade_out = false
	A0_0._target_display_time = tweak_data.machine.hud.TARGET_PANEL_MINIMUM_DISPLAY_TIME
	A0_0._alpha_interpolator = Interpolator:new(0, tweak_data.machine.hud.RETICULE_ARROW_MOVE_IN_SPEED)
	A0_0._next_update_time = 0
	A0_0._dt_since_last_update = 0
end
function TargetPanel.panel(A0_3)
	local L1_4
	L1_4 = A0_3._target_panel
	return L1_4
end
function TargetPanel._set_up_texts(A0_5)
	local L1_6, L2_7, L3_8, L4_9, L5_10
	L1_6 = 140
	L2_7 = 260
	L3_8 = 5
	L4_9 = A0_5._size_modifier
	L4_9 = 18 * L4_9
	L5_10 = {}
	A0_5._texts = L5_10
	L5_10 = A0_5._texts
	L5_10.action = MachineText:new(A0_5._target_panel, L1_6, L3_8 + 110 * A0_5._size_modifier, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	L5_10 = A0_5._texts
	L5_10.target = MachineText:new(A0_5._target_panel, L1_6, L3_8, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	L5_10 = A0_5._texts
	L5_10["target name"] = MachineText:new(A0_5._target_panel, L2_7, L3_8, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	L5_10 = A0_5._texts
	L5_10.threat = MachineText:new(A0_5._target_panel, L1_6, L3_8 + L4_9, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	L5_10 = A0_5._texts
	L5_10.threat_level = MachineText:new(A0_5._target_panel, L2_7, L3_8 + L4_9, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	L5_10 = A0_5._texts
	L5_10.target_distance_text = MachineText:new(A0_5._target_panel, L1_6, L3_8 + L4_9 * 2, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	L5_10 = A0_5._texts
	L5_10.target_distance_number = MachineText:new(A0_5._target_panel, L2_7, L3_8 + L4_9 * 2, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	L5_10 = A0_5._texts
	L5_10.target_status = MachineText:new(A0_5._target_panel, L1_6, L3_8 + L4_9 * 3, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
	L5_10 = A0_5._texts
	L5_10.target_status_number = MachineText:new(A0_5._target_panel, L2_7, L3_8 + L4_9 * 3, tweak_data.machine.hud.text.TEXT_FONT_SCALE_SMALL_SIZE)
end
function TargetPanel._set_up_grid(A0_11)
	local L1_12, L2_13, L3_14, L4_15, L5_16, L6_17, L7_18, L8_19, L9_20, L10_21
	L1_12 = tweak_data
	L1_12 = L1_12.machine
	L1_12 = L1_12.hud
	L1_12 = L1_12.ADD_GRID
	if not L1_12 then
		L1_12 = {}
		A0_11._grid = L1_12
		return
	end
	L1_12 = A0_11._size_modifier
	L1_12 = 130 * L1_12
	L2_13 = A0_11._size_modifier
	L2_13 = 130 * L2_13
	L3_14 = A0_11._size_modifier
	L3_14 = 10 * L3_14
	L4_15 = 5
	L5_16 = 5
	A0_11._grid = L6_17
	for L9_20 = 5, L2_13 + L3_14, L3_14 do
		L10_21 = {}
		if L9_20 == 5 then
			table.insert(L10_21, Vector3(L4_15 - 1, L5_16 - 1, 0))
		end
		table.insert(L10_21, Vector3(L4_15, L9_20, 0))
		table.insert(L10_21, Vector3(L4_15 + L1_12, L9_20, 0))
		A0_11._grid[L9_20] = A0_11._target_panel:polyline({name = "grid"})
		A0_11._grid[L9_20]:set_points(L10_21)
	end
	for L9_20 = 5, L1_12 + L3_14, L3_14 do
		L10_21 = {}
		table.insert(L10_21, Vector3(L9_20, L5_16, 0))
		table.insert(L10_21, Vector3(L9_20, L5_16 + L2_13, 0))
		A0_11._grid[L9_20 + 1] = A0_11._target_panel:polyline({name = "grid"})
		A0_11._grid[L9_20 + 1]:set_points(L10_21)
	end
end
function TargetPanel.get_alpha(A0_22)
	local L1_23
	L1_23 = A0_22._alpha
	return L1_23
end
function TargetPanel.set_alpha(A0_24, A1_25)
	A0_24._alpha = A1_25
	for 