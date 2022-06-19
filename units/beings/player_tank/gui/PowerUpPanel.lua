require("units/beings/player_tank/gui/MachineHudPanel")
require("units/beings/player_tank/gui/MachineText")
require("units/beings/player_tank/gui/PowerUpBar")
PowerUpPanel = PowerUpPanel or class(MachineHudPanel)
function PowerUpPanel.init(A0_0, A1_1, A2_2)
	MachineHudPanel.init(A0_0, A1_1)
	A0_0._parent_panel = A1_1
	A0_0._x = 0
	A0_0._y = 40
	A0_0._width = A0_0._parent_panel:width()
	A0_0._height = A0_0._parent_panel:height() * 2 / 3
	A0_0._powerup_panel = A0_0._parent_panel:panel({
		name = "powerup_panel ",
		width = A0_0._width,
		height = A0_0._height,
		layer = 100
	})
	A0_0._powerup_panel:set_lefttop(A0_0._x, A0_0._y)
	A0_0._size_modifier = 1
	A0_0:_set_up_meters()
	A0_0:_set_up_meters_texts()
	A0_0._total_startup_time = 0
	A0_0._unit = A2_2
	A0_0._parent_panel_height = A0_0._parent_panel:height()
	A0_0._player_data = A0_0._unit:player_data()
	A0_0._power_up_l_sound_played = false
	A0_0._power_up_r_sound_played = false
	A0_0._value_l = 0
	A0_0._value_r = 0
	A0_0._next_update_time = 0
	A0_0._next_alpha_update_time = 0
	A0_0._dt_since_last_update = 0
	A0_0._dt_since_last_alpha_update = 0
end
function PowerUpPanel.panel(A0_3)
	local L1_4
	L1_4 = A0_3._powerup_panel
	return L1_4
end
function PowerUpPanel._set_up_meters_texts(A0_5)
	A0_5._meters_percent_texts = {}
	A0_5._meters_percent_texts[1] = A0_5._powerup_panel:text({
		text = "100 %",
		font = tweak_data.machine.hud.text.TEXT_FONT,
		font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE_BIG,
		color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(0),
		x = 10,
		y = 0
	})
	A0_5._meters_percent_texts[2] = A0_5._powerup_panel:text({
		text = "100 %",
		font = tweak_data.machine.hud.text.TEXT_FONT,
		font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE_BIG,
		color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(0),
		x = -10,
		y = 0
	})
	A0_5._meters_percent_texts[3] = A0_5._powerup_panel:text({
		text = "0 %",
		font = tweak_data.machine.hud.text.TEXT_FONT,
		font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE_BIG,
		color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(0),
		x = 10,
		y = A0_5._height - 24
	})
	A0_5._meters_percent_texts[4] = A0_5._powerup_panel:text({
		text = "0 %",
		font = tweak_data.machine.hud.text.TEXT_FONT,
		font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE_BIG,
		color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(0),
		x = -10,
		y = A0_5._height - 24
	})
	A0_5._meters_percent_texts[2]:set_align("right")
	A0_5._meters_percent_texts[4]:set_align("right")
end
function PowerUpPanel._set_up_meters(A0_6)
	local L1_7, L2_8, L3_9, L4_10, L5_11
	L1_7 = A0_6._size_modifier
	L1_7 = 10 * L1_7
	A0_6._bar_height = L1_7
	L1_7 = A0_6._height
	L1_7 = L1_7 - 50
	A0_6._total_bars_height = L1_7
	L1_7 = A0_6._size_modifier
	L1_7 = 128 * L1_7
	L2_8 = A0_6._size_modifier
	L2_8 = -20 * L2_8
	L3_9 = A0_6._width
	L4_10 = A0_6._size_modifier
	L4_10 = 18 * L4_10
	L3_9 = L3_9 + L4_10
	L3_9 = L3_9 - L1_7
	L4_10 = A0_6._size_modifier
	L4_10 = 30 * L4_10
	L4_10 = 30 - L4_10
	L4_10 = -15 + L4_10
	L5_11 = A0_6._get_nr_of_bars
	L5_11 = L5_11(A0_6)
	A0_6:_clear_meters()
	A0_6._left_powerup = {}
	A0_6._right_powerup = {}
	for _FORV_9_ = L5_11, 1, -1 do
		A0_6._left_powerup[_FORV_9_] = PowerUpBar:new(A0_6._powerup_panel, "gui_machine_bar_cell", L2_8, L4_10, L1_7, L1_7)
		A0_6._right_powerup[_FORV_9_] = PowerUpBar:new(A0_6._powerup_panel, "gui_machine_bar_cell", L3_9, L4_10, L1_7, L1_7)
		A0_6._left_powerup[_FORV_9_]:set_alpha(0)
		A0_6._right_powerup[_FORV_9_]:set_alpha(0)
		L4_10 = L4_10 + A0_6._bar_height * 2
	end
	A0_6._nr_of_bars = L5_11
end
function PowerUpPanel._clear_meters(A0_12)
	if A0_12._left_powerup then
		for 