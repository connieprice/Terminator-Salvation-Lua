require("units/beings/player_tank/gui/MachineHudPanel")
require("units/beings/player_tank/gui/MachineText")
require("units/beings/player_tank/gui/OverHeatBar")
OverHeatPanel = OverHeatPanel or class(MachineHudPanel)
function OverHeatPanel.init(A0_0, A1_1, A2_2, A3_3)
	MachineHudPanel.init(A0_0, A1_1)
	A0_0._parent_panel = A1_1
	A0_0._use_sound = A3_3
	A0_0._height = 52
	A0_0._width = A0_0._parent_panel:width() * 3 / 4
	A0_0._x = A0_0._parent_panel:width() / 2
	A0_0._y = A0_0._parent_panel:height() - tweak_data.machine.hud.TURRET_PANEL_HEIGHT - A0_0._height
	A0_0._overheat_panel = A0_0._parent_panel:panel({
		name = "overheat_panel",
		width = A0_0._width,
		height = A0_0._height,
		layer = 100
	})
	A0_0._overheat_panel:set_center_x(A0_0._x)
	A0_0._overheat_panel:set_top(A0_0._y)
	A0_0._center_y = A0_0._overheat_panel:center_y()
	A0_0._size_modifier = 1
	A0_0:_set_up_meters_texts()
	A0_0:_set_up_meters()
	A0_0:set_alpha(0)
	A0_0._unit = A2_2
	A0_0._player_data = A0_0._unit:player_data()
	A0_0._parent_panel_height = A0_0._parent_panel:height()
	A0_0._tank_overheat_warning_sound = nil
	A0_0._tank_overheat_warning_maxed_sound = nil
	A0_0._next_update_time = 0
	A0_0._next_alpha_update_time = 0
	A0_0._dt_since_last_update = 0
	A0_0._dt_since_last_alpha_update = 0
	A0_0._need_boot_update = true
end
function OverHeatPanel.panel(A0_4)
	local L1_5
	L1_5 = A0_4._overheat_panel
	return L1_5
end
function OverHeatPanel._play_max_overheat_sound(A0_6)
	if not A0_6._tank_overheat_warning_maxed_sound or not A0_6._tank_overheat_warning_maxed_sound:is_playing() then
		A0_6._tank_overheat_warning_maxed_sound = A0_6._player_data.on_rail_vehicle:play("tank_overheat_warning_maxed")
	end
	if A0_6._tank_overheat_warning_sound and A0_6._tank_overheat_warning_sound:is_playing() then
		A0_6._tank_overheat_warning_sound:stop()
		A0_6._tank_overheat_warning_sound = nil
	end
end
function OverHeatPanel._play_overheat_sound(A0_7)
	if not A0_7._tank_overheat_warning_sound or not A0_7._tank_overheat_warning_sound:is_playing() then
		A0_7._tank_overheat_warning_sound = A0_7._player_data.on_rail_vehicle:play("tank_overheat_warning")
	end
	if A0_7._tank_overheat_warning_maxed_sound and A0_7._tank_overheat_warning_maxed_sound:is_playing() then
		A0_7._tank_overheat_warning_maxed_sound:stop()
		A0_7._tank_overheat_warning_maxed_sound = nil
	end
end
function OverHeatPanel._stop_sounds(A0_8)
	if A0_8._tank_overheat_warning_sound and A0_8._tank_overheat_warning_sound:is_playing() then
		A0_8._tank_overheat_warning_sound:stop()
		A0_8._tank_overheat_warning_sound = nil
	end
	if A0_8._tank_overheat_warning_maxed_sound and A0_8._tank_overheat_warning_maxed_sound:is_playing() then
		A0_8._tank_overheat_warning_maxed_sound:stop()
		A0_8._tank_overheat_warning_maxed_sound = nil
	end
end
function OverHeatPanel.update_meters_value(A0_9)
	local L1_10, L2_11, L3_12, L4_13, L5_14, L6_15, L7_16, L8_17
	L1_10 = A0_9._unit
	L2_11 = L1_10
	L1_10 = L1_10.base
	L1_10 = L1_10(L2_11)
	L2_11 = L1_10
	L1_10 = L1_10.get_weapon_overheat_percent
	L2_11 = L1_10(L2_11)
	L3_12 = L1_10.primary_l
	L4_13 = L1_10.primary_r
	L5_14 = L2_11.primary_l
	L6_15 = L2_11.primary_r
	L7_16 = A0_9._value_l
	if L7_16 == L3_12 then
		L7_16 = A0_9._value_r
		if L7_16 == L4_13 then
			L7_16 = A0_9._status_l
			if L7_16 == L5_14 then
				L7_16 = A0_9._status_r
				if L7_16 == L6_15 then
					return
				end
			end
		end
	end
	A0_9._value_l = L3_12
	A0_9._value_r = L4_13
	A0_9._status_l = L5_14
	A0_9._status_r = L6_15
	L7_16 = math
	L7_16 = L7_16.min
	L8_17 = math
	L8_17 = L8_17.floor
	L8_17 = L8_17(L3_12 * A0_9._nr_of_bars)
	L7_16(L8_17, A0_9._nr_of_bars)
	L7_16 = math
	L7_16 = L7_16.min
	L8_17 = math
	L8_17 = L8_17.floor
	L8_17 = L8_17(L3_12 * A0_9._nr_of_bars)
	L7_16 = L7_16(L8_17, A0_9._nr_of_bars)
	L8_17 = math
	L8_17 = L8_17.min
	L8_17 = L8_17(math.floor(L4_13 * A0_9._nr_of_bars), A0_9._nr_of_bars)
	if A0_9._use_sound then
		if L5_14 or L6_15 then
			A0_9:_play_max_overheat_sound()
		elseif math.max(L3_12, L4_13) > 0.7 then
			A0_9:_play_overheat_sound()
		else
			A0_9:_stop_sounds()
		end
	end
	for _FORV_12_ = 1, L7_16 do
		A0_9._left_overheat[_FORV_12_]:activate()
	end
	for _FORV_12_ = 1, L8_17 do
		A0_9._right_overheat[_FORV_12_]:activate()
	end
	for _FORV_12_ = L7_16 + 1, A0_9._nr_of_bars do
		A0_9._left_overheat[_FORV_12_]:inactivate()
	end
	for _FORV_12_ = L8_17 + 1, A0_9._nr_of_bars do
		A0_9._right_overheat[_FORV_12_]:inactivate()
	end
end
function OverHeatPanel._set_up_meters_texts(A0_18)
	A0_18._meters_percent_texts = {}
	A0_18._meters_percent_texts[1] = A0_18._overheat_panel:text({
		text = Localizer:lookup("machine_hud_plasma_gatling_overheat"),
		font = tweak_data.machine.hud.text.TEXT_FONT,
		font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE_NORMAL,
		color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(0),
		x = 10,
		y = 0
	})
	A0_18._meters_percent_texts[2] = A0_18._overheat_panel:text({
		text = Localizer:lookup("machine_hud_plasma_gatling_overheat"),
		font = tweak_data.machine.hud.text.TEXT_FONT,
		font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE_NORMAL,
		color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(0),
		x = -10,
		y = 0
	})
	A0_18._meters_percent_texts[3] = A0_18._overheat_panel:text({
		text = "0 %",
		font = tweak_data.machine.hud.text.TEXT_FONT,
		font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE_BIG,
		color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(0),
		x = 0,
		y = 20
	})
	A0_18._meters_percent_texts[4] = A0_18._overheat_panel:text({
		text = "0 %",
		font = tweak_data.machine.hud.text.TEXT_FONT,
		font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE_BIG,
		color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(0),
		x = 0,
		y = 20
	})
	A0_18._meters_percent_texts[2]:set_align("right")
	A0_18._meters_percent_texts[4]:set_align("right")
end
function OverHeatPanel._set_up_meters(A0_19)
	local L1_20, L2_21, L3_22, L4_23, L5_24, L6_25, L8_26, L9_27
	L1_20 = A0_19._size_modifier
	L1_20 = 10 * L1_20
	A0_19._bar_width = L1_20
	L1_20 = A0_19._size_modifier
	L1_20 = 3 * L1_20
	A0_19._bar_space = L1_20
	L1_20 = A0_19._width
	L1_20 = L1_20 / 2
	L1_20 = L1_20 - 100
	A0_19._total_bars_width = L1_20
	L1_20 = A0_19._size_modifier
	L1_20 = 128 * L1_20
	A0_19._bar_texture_size = L1_20
	L1_20 = 0
	L2_21 = 33
	L3_22 = A0_19._coop_player_2
	if L3_22 then
		L2_21 = 20
	end
	L3_22 = A0_19._size_modifier
	if L3_22 <= 0.5 then
		L2_21 = 27
	end
	L3_22 = 30
	L4_23 = A0_19._width
	L5_24 = A0_19._size_modifier
	L5_24 = 64 * L5_24
	L5_24 = L5_24 + 30
	L4_23 = L4_23 - L5_24
	L5_24 = {}
	A0_19._left_overheat = L5_24
	L5_24 = {}
	A0_19._right_overheat = L5_24
	L5_24 = A0_19._total_bars_width
	L5_24 = L5_24 / L6_25
	for _FORV_9_ = 1, L5_24 do
		A0_19._left_overheat[_FORV_9_] = OverHeatBar:new(A0_19._overheat_panel, "gui_machine_bar_small", L3_22 + L1_20, L2_21, tweak_data.machine.hud.MAIN_ALPHA, tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK)
		A0_19._left_overheat[_FORV_9_]:set_image_height(32 * A0_19._size_modifier)
		A0_19._left_overheat[_FORV_9_]:set_texture_size(64 * A0_19._size_modifier)
		A0_19._right_overheat[_FORV_9_] = OverHeatBar:new(A0_19._overheat_panel, "gui_machine_bar_small", L4_23 - L1_20, L2_21, tweak_data.machine.hud.MAIN_ALPHA, tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK)
		A0_19._right_overheat[_FORV_9_]:set_image_height(32 * A0_19._size_modifier)
		A0_19._right_overheat[_FORV_9_]:set_texture_size(64 * A0_19._size_modifier)
		L1_20 = _FORV_9_ * (A0_19._bar_width + A0_19._bar_space)
	end
	A0_19._nr_of_bars = L5_24
end
function OverHeatPanel.update(A0_28, A1_29, A2_30)
	if A0_28._need_boot_update then
		MachineHudPanel.update(A0_28, A2_30)
	end
	A0_28._need_boot_update = A0_28._wants_to_shut_down or A0_28._wants_to_start_up
	A0_28._time = A1_29
	A0_28._dt_since_last_update = A0_28._dt_since_last_update + A2_30
	A0_28._dt_since_last_alpha_update = A0_28._dt_since_last_alpha_update + A2_30
	if A1_29 > A0_28._next_update_time then
		A0_28:update_meters_value()
		A0_28._next_update_time = A1_29 + tweak_data.machine.hud.UPDATE_FREQUENCY
		A0_28._dt_since_last_update = 0
	end
	if A1_29 > A0_28._next_alpha_update_time then
		if A0_28._left_overheat and A0_28._right_overheat then
			for 