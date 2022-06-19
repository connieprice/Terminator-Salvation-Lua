require("units/beings/player_tank/gui/MachineHudPanel")
require("units/beings/player_tank/gui/MachineText")
require("units/beings/player_tank/gui/PowerUpBar")
if not PowerUpPanel then
	PowerUpPanel = class(MachineHudPanel)
end
PowerUpPanel.init = function(l_1_0, l_1_1, l_1_2)
	MachineHudPanel.init(l_1_0, l_1_1)
	l_1_0._parent_panel = l_1_1
	l_1_0._x = 0
	l_1_0._y = 40
	l_1_0._width = l_1_0._parent_panel:width()
	l_1_0._height = l_1_0._parent_panel:height() * 2 / 3
	local l_1_3, l_1_4 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_5 = {}
	l_1_5.name = "powerup_panel "
	l_1_5.width = l_1_0._width
	l_1_5.height = l_1_0._height
	l_1_5.layer = 100
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._powerup_panel = l_1_3
	l_1_3 = l_1_0._powerup_panel
	l_1_3, l_1_4 = l_1_3:set_lefttop, l_1_3
	l_1_5 = l_1_0._x
	l_1_3(l_1_4, l_1_5, l_1_0._y)
	l_1_0._size_modifier = 1
	l_1_3, l_1_4 = l_1_0:_set_up_meters, l_1_0
	l_1_3(l_1_4)
	l_1_3, l_1_4 = l_1_0:_set_up_meters_texts, l_1_0
	l_1_3(l_1_4)
	l_1_0._total_startup_time = 0
	l_1_0._unit = l_1_2
	l_1_3 = l_1_0._parent_panel
	l_1_3, l_1_4 = l_1_3:height, l_1_3
	l_1_3 = l_1_3(l_1_4)
	l_1_0._parent_panel_height = l_1_3
	l_1_3 = l_1_0._unit
	l_1_3, l_1_4 = l_1_3:player_data, l_1_3
	l_1_3 = l_1_3(l_1_4)
	l_1_0._player_data = l_1_3
	l_1_0._power_up_l_sound_played = false
	l_1_0._power_up_r_sound_played = false
	l_1_0._value_l = 0
	l_1_0._value_r = 0
	l_1_0._next_update_time = 0
	l_1_0._next_alpha_update_time = 0
	l_1_0._dt_since_last_update = 0
	l_1_0._dt_since_last_alpha_update = 0
end

PowerUpPanel.panel = function(l_2_0)
	return l_2_0._powerup_panel
end

PowerUpPanel._set_up_meters_texts = function(l_3_0)
	l_3_0._meters_percent_texts = {}
	local l_3_1 = l_3_0._meters_percent_texts
	local l_3_2, l_3_3 = l_3_0._powerup_panel:text, l_3_0._powerup_panel
	local l_3_4 = {}
	l_3_4.text = "100 %"
	l_3_4.font = tweak_data.machine.hud.text.TEXT_FONT
	l_3_4.font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE_BIG
	l_3_4.color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(0)
	l_3_4.x = 10
	l_3_4.y = 0
	l_3_2 = l_3_2(l_3_3, l_3_4)
	l_3_1[1] = l_3_2
	l_3_1 = l_3_0._meters_percent_texts
	l_3_2 = l_3_0._powerup_panel
	l_3_2, l_3_3 = l_3_2:text, l_3_2
	l_3_2, l_3_4 = l_3_2(l_3_3, l_3_4), {text = "100 %", font = tweak_data.machine.hud.text.TEXT_FONT, font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE_BIG, color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(0), x = -10, y = 0}
	l_3_1[2] = l_3_2
	l_3_1 = l_3_0._meters_percent_texts
	l_3_2 = l_3_0._powerup_panel
	l_3_2, l_3_3 = l_3_2:text, l_3_2
	l_3_2, l_3_4 = l_3_2(l_3_3, l_3_4), {text = "0 %", font = tweak_data.machine.hud.text.TEXT_FONT, font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE_BIG, color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(0), x = 10, y = l_3_0._height - 24}
	l_3_1[3] = l_3_2
	l_3_1 = l_3_0._meters_percent_texts
	l_3_2 = l_3_0._powerup_panel
	l_3_2, l_3_3 = l_3_2:text, l_3_2
	l_3_2, l_3_4 = l_3_2(l_3_3, l_3_4), {text = "0 %", font = tweak_data.machine.hud.text.TEXT_FONT, font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE_BIG, color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(0), x = -10, y = l_3_0._height - 24}
	l_3_1[4] = l_3_2
	l_3_1 = l_3_0._meters_percent_texts
	l_3_1 = l_3_1[2]
	l_3_1, l_3_2 = l_3_1:set_align, l_3_1
	l_3_3 = "right"
	l_3_1(l_3_2, l_3_3)
	l_3_1 = l_3_0._meters_percent_texts
	l_3_1 = l_3_1[4]
	l_3_1, l_3_2 = l_3_1:set_align, l_3_1
	l_3_3 = "right"
	l_3_1(l_3_2, l_3_3)
end

PowerUpPanel._set_up_meters = function(l_4_0)
	l_4_0._bar_height = 10 * l_4_0._size_modifier
	l_4_0._total_bars_height = l_4_0._height - 50
	local l_4_1 = 128 * l_4_0._size_modifier
	local l_4_2 = -20 * l_4_0._size_modifier
	local l_4_3 = l_4_0._width + 18 * l_4_0._size_modifier - l_4_1
	local l_4_4 = -15 + (30 - 30 * l_4_0._size_modifier)
	local l_4_5 = l_4_0:_get_nr_of_bars()
	l_4_0:_clear_meters()
	l_4_0._left_powerup = {}
	l_4_0._right_powerup = {}
	for l_4_9 = l_4_5, 1, -1 do
		l_4_0._left_powerup[l_4_9] = PowerUpBar:new(l_4_0._powerup_panel, "gui_machine_bar_cell", l_4_2, l_4_4, l_4_1, l_4_1)
		l_4_0._right_powerup[l_4_9] = PowerUpBar:new(l_4_0._powerup_panel, "gui_machine_bar_cell", l_4_3, l_4_4, l_4_1, l_4_1)
		l_4_0._left_powerup[l_4_9]:set_alpha(0)
		l_4_0._right_powerup[l_4_9]:set_alpha(0)
		l_4_4 = l_4_4 + l_4_0._bar_height * 2
	end
	l_4_0._nr_of_bars = l_4_5
end

PowerUpPanel._clear_meters = function(l_5_0)
	local l_5_4, l_5_5, l_5_6, l_5_7, l_5_11, l_5_12, l_5_13, l_5_14 = nil
	if l_5_0._left_powerup then
		for i_0,i_1 in pairs(l_5_0._left_powerup) do
			i_1:set_alpha(0)
		end
	end
	if l_5_0._right_powerup then
		for i_0,i_1 in pairs(l_5_0._right_powerup) do
			i_1:set_alpha(0)
		end
	end
end

PowerUpPanel._get_nr_of_bars = function(l_6_0)
	l_6_0._total_bars_height = l_6_0._height - 50
	return math.round(l_6_0._total_bars_height / (l_6_0._bar_height * 2)) - 1
end

PowerUpPanel.update = function(l_7_0, l_7_1, l_7_2)
	local l_7_6, l_7_7, l_7_8, l_7_9, l_7_10, l_7_11, l_7_12, l_7_13, l_7_14, l_7_15, l_7_16, l_7_17 = nil
	l_7_0._time = l_7_1
	l_7_0._dt_since_last_update = l_7_0._dt_since_last_update + l_7_2
	l_7_0._dt_since_last_alpha_update = l_7_0._dt_since_last_alpha_update + l_7_2
	if l_7_0._shutdown_start_time and l_7_0._shutdown_start_time < l_7_1 then
		l_7_0:_shutdown()
		return 
	end
	if l_7_0._next_update_time < l_7_1 then
		if not l_7_0._startup_done then
			l_7_0:_update_startup(l_7_0._dt_since_last_update)
		else
			l_7_0:_update_meters_value(l_7_1)
			l_7_0:_update_sounds()
		end
		l_7_0._next_update_time = l_7_1 + tweak_data.machine.hud.UPDATE_FREQUENCY
		l_7_0._dt_since_last_update = 0
	end
	if l_7_0._next_alpha_update_time < l_7_1 then
		for i_0,i_1 in pairs(l_7_0._left_powerup) do
			if i_1.need_update then
				i_1:update(l_7_0._dt_since_last_alpha_update)
			end
		end
		for i_0,i_1 in pairs(l_7_0._right_powerup) do
			if i_1.need_update then
				i_1:update(l_7_0._dt_since_last_alpha_update)
			end
		end
		l_7_0._next_alpha_update_time = l_7_1 + tweak_data.machine.hud.ALPHA_UPDATE_FREQUENCY
		l_7_0._dt_since_last_alpha_update = 0
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

PowerUpPanel._update_meters_value = function(l_8_0, l_8_1)
	local l_8_2 = l_8_0._unit:base():get_weapon_power_up_percent()
	local l_8_3 = l_8_2.secondary_l
	local l_8_4 = l_8_2.secondary_r
	if l_8_0._value_l == l_8_3 and l_8_0._value_r == l_8_4 then
		return 
	end
	l_8_0._value_l = l_8_3
	l_8_0._value_r = l_8_4
	local l_8_5 = math.min(math.floor(l_8_3 * l_8_0._nr_of_bars), l_8_0._nr_of_bars)
	local l_8_6 = math.min(math.floor(l_8_4 * l_8_0._nr_of_bars), l_8_0._nr_of_bars)
	if l_8_5 == l_8_0._nr_of_bars then
		for l_8_10 = 1, l_8_5 do
			l_8_0._left_powerup[l_8_10]:full_activate()
		end
	else
		for l_8_14 = 1, l_8_5 do
			l_8_0._left_powerup[l_8_14]:activate()
		end
		for l_8_18 = l_8_5 + 1, l_8_0._nr_of_bars do
			l_8_0._left_powerup[l_8_18]:inactivate()
		end
	end
	if l_8_6 == l_8_0._nr_of_bars then
		for l_8_22 = 1, l_8_6 do
			l_8_0._right_powerup[l_8_22]:full_activate()
		end
	else
		for l_8_26 = 1, l_8_6 do
			l_8_0._right_powerup[l_8_26]:activate()
		end
		for l_8_30 = l_8_6 + 1, l_8_0._nr_of_bars do
			l_8_0._right_powerup[l_8_30]:inactivate()
		end
	end
end

PowerUpPanel._update_sounds = function(l_9_0)
	local l_9_1 = l_9_0._unit:base():get_weapon_power_up_percent()
	local l_9_2 = l_9_1.secondary_l
	local l_9_3 = l_9_1.secondary_r
	if l_9_2 == 1 and not l_9_0._power_up_l_sound_played then
		l_9_0:_play_unit_sound("tank_plasma_reload")
		l_9_0._power_up_l_sound_played = true
	elseif l_9_2 < 1 and l_9_0._power_up_l_sound_played then
		l_9_0._power_up_l_sound_played = false
	end
	if l_9_3 == 1 and not l_9_0._power_up_r_sound_played then
		l_9_0:_play_unit_sound("tank_plasma_reload")
		l_9_0._power_up_r_sound_played = true
	elseif l_9_3 < 1 and l_9_0._power_up_r_sound_played then
		l_9_0._power_up_r_sound_played = false
	end
end

PowerUpPanel.startup = function(l_10_0, l_10_1)
	if l_10_1 then
		l_10_0._start_time = math.random(l_10_1 * 100) / 100
		if l_10_0._total_startup_time and l_10_0._start_time < l_10_0._total_startup_time then
			l_10_0._start_time = l_10_0._total_startup_time
		end
	else
		l_10_0._start_time = 0
	end
end

PowerUpPanel._update_startup = function(l_11_0, l_11_1)
	l_11_0._total_startup_time = l_11_0._total_startup_time + l_11_1
	if l_11_0._start_time and l_11_0._start_time < l_11_0._total_startup_time then
		local l_11_2 = 3
		local l_11_3 = (l_11_0._total_startup_time - l_11_0._start_time) / l_11_2
		local l_11_4 = math.min(math.floor(l_11_3 * l_11_0._nr_of_bars), l_11_0._nr_of_bars)
		local l_11_5 = math.min(math.floor(l_11_3 * l_11_0._nr_of_bars), l_11_0._nr_of_bars)
		for l_11_9 = 1, l_11_4 do
			l_11_0._left_powerup[l_11_9]:inactivate()
		end
		for l_11_13 = 1, l_11_5 do
			local l_11_17, l_11_19, l_11_21 = nil
			l_11_17 = l_11_0._right_powerup
			l_11_17 = l_11_17[l_11_13]
			l_11_17, l_11_19 = l_11_17:inactivate, l_11_17
			local l_11_18, l_11_20, l_11_22 = nil
			l_11_17(l_11_19)
		end
	if l_11_3 >= 1 then
		end
		l_11_0._startup_done = true
		for i_0,i_1 in pairs(l_11_0._meters_percent_texts) do
			i_1:set_color(i_1:color():with_alpha(tweak_data.machine.hud.MAIN_ALPHA))
		end
	end
end

PowerUpPanel.shutdown = function(l_12_0, l_12_1, l_12_2)
	if l_12_2 then
		l_12_0._shutdown_start_time = math.random(l_12_1 * 100) / 100
	do
		elseif not l_12_1 then
			 -- DECOMPILER ERROR: Attempted to build a boolean expression without a pending context

		end
		l_12_0._shutdown_start_time = 0
	end
	l_12_0._shutdown_start_time = l_12_0._time + l_12_0._shutdown_start_time
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

PowerUpPanel._shutdown = function(l_13_0)
	local l_13_4, l_13_5, l_13_6, l_13_7, l_13_8, l_13_9, l_13_10, l_13_11, l_13_12, l_13_13, l_13_14, l_13_15, l_13_16, l_13_17 = nil
	for i_0,i_1 in pairs(l_13_0._left_powerup) do
		i_1:set_alpha(0)
	end
	for i_0,i_1 in pairs(l_13_0._right_powerup) do
		i_1:set_alpha(0)
	end
	for i_0,i_1 in pairs(l_13_0._meters_percent_texts) do
		i_1:set_color(i_1:color():with_alpha(0))
	end
	l_13_0._meters_percent_texts = {}
	l_13_0._left_powerup = {}
	l_13_0._right_powerup = {}
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

PowerUpPanel.enable = function(l_14_0, l_14_1)
	local l_14_5, l_14_6, l_14_7, l_14_8, l_14_12, l_14_13, l_14_14, l_14_15, l_14_19, l_14_20, l_14_21, l_14_22 = nil
	l_14_0._size_modifier = l_14_1
	l_14_0._height = l_14_0._parent_panel:height() * 2 / 3
	l_14_0:_set_up_meters()
	l_14_0._meters_percent_texts[4]:set_top(l_14_0._height - 24)
	l_14_0._meters_percent_texts[3]:set_top(l_14_0._height - 24)
	if l_14_1 <= 0.25 then
		for i_0,i_1 in pairs(l_14_0._meters_percent_texts) do
			i_1:set_font_size(tweak_data.machine.hud.text.TEXT_FONT_SIZE_SMALL)
		end
	elseif l_14_1 <= 0.5 then
		for i_0,i_1 in pairs(l_14_0._meters_percent_texts) do
			i_1:set_font_size(tweak_data.machine.hud.text.TEXT_FONT_SIZE)
		end
	else
		for i_0,i_1 in pairs(l_14_0._meters_percent_texts) do
			i_1:set_font_size(tweak_data.machine.hud.text.TEXT_FONT_SIZE_BIG)
		end
	end
end

PowerUpPanel.show = function(l_15_0)
	local l_15_4, l_15_5, l_15_6, l_15_7, l_15_8, l_15_9, l_15_10, l_15_11, l_15_12, l_15_13, l_15_14, l_15_15, l_15_16, l_15_17 = nil
	l_15_0._powerup_panel:show()
	for i_0,i_1 in pairs(l_15_0._left_powerup) do
		i_1:show()
	end
	for i_0,i_1 in pairs(l_15_0._right_powerup) do
		i_1:show()
	end
	for i_0,i_1 in pairs(l_15_0._meters_percent_texts) do
		i_1:set_color(i_1:color():with_alpha(tweak_data.machine.hud.MAIN_ALPHA))
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

PowerUpPanel.hide = function(l_16_0)
	l_16_0._powerup_panel:hide()
end

PowerUpPanel._play_unit_sound = function(l_17_0, l_17_1)
	if l_17_0._player_data.on_rail_vehicle then
		l_17_0._player_data.on_rail_vehicle:play(l_17_1)
	end
end


