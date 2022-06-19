require("units/beings/player_tank/gui/MachineHudPanel")
require("units/beings/player_tank/gui/MachineText")
require("units/beings/player_tank/gui/OverHeatBar")
if not OverHeatPanel then
	OverHeatPanel = class(MachineHudPanel)
end
OverHeatPanel.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	MachineHudPanel.init(l_1_0, l_1_1)
	l_1_0._parent_panel = l_1_1
	l_1_0._use_sound = l_1_3
	l_1_0._height = 52
	l_1_0._width = l_1_0._parent_panel:width() * 3 / 4
	l_1_0._x = l_1_0._parent_panel:width() / 2
	l_1_0._y = l_1_0._parent_panel:height() - tweak_data.machine.hud.TURRET_PANEL_HEIGHT - l_1_0._height
	local l_1_4, l_1_5 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_6 = {}
	l_1_6.name = "overheat_panel"
	l_1_6.width = l_1_0._width
	l_1_6.height = l_1_0._height
	l_1_6.layer = 100
	l_1_4 = l_1_4(l_1_5, l_1_6)
	l_1_0._overheat_panel = l_1_4
	l_1_4 = l_1_0._overheat_panel
	l_1_4, l_1_5 = l_1_4:set_center_x, l_1_4
	l_1_6 = l_1_0._x
	l_1_4(l_1_5, l_1_6)
	l_1_4 = l_1_0._overheat_panel
	l_1_4, l_1_5 = l_1_4:set_top, l_1_4
	l_1_6 = l_1_0._y
	l_1_4(l_1_5, l_1_6)
	l_1_4 = l_1_0._overheat_panel
	l_1_4, l_1_5 = l_1_4:center_y, l_1_4
	l_1_4 = l_1_4(l_1_5)
	l_1_0._center_y = l_1_4
	l_1_0._size_modifier = 1
	l_1_4, l_1_5 = l_1_0:_set_up_meters_texts, l_1_0
	l_1_4(l_1_5)
	l_1_4, l_1_5 = l_1_0:_set_up_meters, l_1_0
	l_1_4(l_1_5)
	l_1_4, l_1_5 = l_1_0:set_alpha, l_1_0
	l_1_6 = 0
	l_1_4(l_1_5, l_1_6)
	l_1_0._unit = l_1_2
	l_1_4 = l_1_0._unit
	l_1_4, l_1_5 = l_1_4:player_data, l_1_4
	l_1_4 = l_1_4(l_1_5)
	l_1_0._player_data = l_1_4
	l_1_4 = l_1_0._parent_panel
	l_1_4, l_1_5 = l_1_4:height, l_1_4
	l_1_4 = l_1_4(l_1_5)
	l_1_0._parent_panel_height = l_1_4
	l_1_0._tank_overheat_warning_sound = nil
	l_1_0._tank_overheat_warning_maxed_sound = nil
	l_1_0._next_update_time = 0
	l_1_0._next_alpha_update_time = 0
	l_1_0._dt_since_last_update = 0
	l_1_0._dt_since_last_alpha_update = 0
	l_1_0._need_boot_update = true
end

OverHeatPanel.panel = function(l_2_0)
	return l_2_0._overheat_panel
end

OverHeatPanel._play_max_overheat_sound = function(l_3_0)
	if not l_3_0._tank_overheat_warning_maxed_sound or not l_3_0._tank_overheat_warning_maxed_sound:is_playing() then
		l_3_0._tank_overheat_warning_maxed_sound = l_3_0._player_data.on_rail_vehicle:play("tank_overheat_warning_maxed")
	end
	if l_3_0._tank_overheat_warning_sound and l_3_0._tank_overheat_warning_sound:is_playing() then
		l_3_0._tank_overheat_warning_sound:stop()
		l_3_0._tank_overheat_warning_sound = nil
	end
end

OverHeatPanel._play_overheat_sound = function(l_4_0)
	if not l_4_0._tank_overheat_warning_sound or not l_4_0._tank_overheat_warning_sound:is_playing() then
		l_4_0._tank_overheat_warning_sound = l_4_0._player_data.on_rail_vehicle:play("tank_overheat_warning")
	end
	if l_4_0._tank_overheat_warning_maxed_sound and l_4_0._tank_overheat_warning_maxed_sound:is_playing() then
		l_4_0._tank_overheat_warning_maxed_sound:stop()
		l_4_0._tank_overheat_warning_maxed_sound = nil
	end
end

OverHeatPanel._stop_sounds = function(l_5_0)
	if l_5_0._tank_overheat_warning_sound and l_5_0._tank_overheat_warning_sound:is_playing() then
		l_5_0._tank_overheat_warning_sound:stop()
		l_5_0._tank_overheat_warning_sound = nil
	end
	if l_5_0._tank_overheat_warning_maxed_sound and l_5_0._tank_overheat_warning_maxed_sound:is_playing() then
		l_5_0._tank_overheat_warning_maxed_sound:stop()
		l_5_0._tank_overheat_warning_maxed_sound = nil
	end
end

OverHeatPanel.update_meters_value = function(l_6_0)
	local l_6_1, l_6_2 = l_6_0._unit:base():get_weapon_overheat_percent()
	local l_6_3 = l_6_1.primary_l
	local l_6_4 = l_6_1.primary_r
	local l_6_5 = l_6_2.primary_l
	local l_6_6 = l_6_2.primary_r
	if l_6_0._value_l == l_6_3 and l_6_0._value_r == l_6_4 and l_6_0._status_l == l_6_5 and l_6_0._status_r == l_6_6 then
		return 
	end
	l_6_0._value_l = l_6_3
	l_6_0._value_r = l_6_4
	l_6_0._status_l = l_6_5
	l_6_0._status_r = l_6_6
	math.min(math.floor(l_6_3 * l_6_0._nr_of_bars), l_6_0._nr_of_bars)
	local l_6_7 = math.min(math.floor(l_6_3 * l_6_0._nr_of_bars), l_6_0._nr_of_bars)
	local l_6_8 = math.min(math.floor(l_6_4 * l_6_0._nr_of_bars), l_6_0._nr_of_bars)
	if l_6_0._use_sound then
		if l_6_5 or l_6_6 then
			l_6_0:_play_max_overheat_sound()
		end
	else
		if math.max(l_6_3, l_6_4) > 0.7 then
			l_6_0:_play_overheat_sound()
		end
	else
		l_6_0:_stop_sounds()
	end
	for l_6_12 = 1, l_6_7 do
		l_6_0._left_overheat[l_6_12]:activate()
	end
	for l_6_16 = 1, l_6_8 do
		l_6_0._right_overheat[l_6_16]:activate()
	end
	for l_6_20 = l_6_7 + 1, l_6_0._nr_of_bars do
		l_6_0._left_overheat[l_6_20]:inactivate()
	end
	for l_6_24 = l_6_8 + 1, l_6_0._nr_of_bars do
		l_6_0._right_overheat[l_6_24]:inactivate()
	end
end

OverHeatPanel._set_up_meters_texts = function(l_7_0)
	l_7_0._meters_percent_texts = {}
	local l_7_1 = Localizer:lookup("machine_hud_plasma_gatling_overheat")
	local l_7_2 = l_7_0._meters_percent_texts
	local l_7_3, l_7_4 = l_7_0._overheat_panel:text, l_7_0._overheat_panel
	local l_7_5 = {}
	l_7_5.text = l_7_1
	l_7_5.font = tweak_data.machine.hud.text.TEXT_FONT
	l_7_5.font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE_NORMAL
	l_7_5.color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(0)
	l_7_5.x = 10
	l_7_5.y = 0
	l_7_3 = l_7_3(l_7_4, l_7_5)
	l_7_2[1] = l_7_3
	l_7_2 = l_7_0._meters_percent_texts
	l_7_3 = l_7_0._overheat_panel
	l_7_3, l_7_4 = l_7_3:text, l_7_3
	l_7_3, l_7_5 = l_7_3(l_7_4, l_7_5), {text = l_7_1, font = tweak_data.machine.hud.text.TEXT_FONT, font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE_NORMAL, color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(0), x = -10, y = 0}
	l_7_2[2] = l_7_3
	l_7_2 = l_7_0._meters_percent_texts
	l_7_3 = l_7_0._overheat_panel
	l_7_3, l_7_4 = l_7_3:text, l_7_3
	l_7_3, l_7_5 = l_7_3(l_7_4, l_7_5), {text = "0 %", font = tweak_data.machine.hud.text.TEXT_FONT, font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE_BIG, color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(0), x = 0, y = 20}
	l_7_2[3] = l_7_3
	l_7_2 = l_7_0._meters_percent_texts
	l_7_3 = l_7_0._overheat_panel
	l_7_3, l_7_4 = l_7_3:text, l_7_3
	l_7_3, l_7_5 = l_7_3(l_7_4, l_7_5), {text = "0 %", font = tweak_data.machine.hud.text.TEXT_FONT, font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE_BIG, color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(0), x = 0, y = 20}
	l_7_2[4] = l_7_3
	l_7_2 = l_7_0._meters_percent_texts
	l_7_2 = l_7_2[2]
	l_7_2, l_7_3 = l_7_2:set_align, l_7_2
	l_7_4 = "right"
	l_7_2(l_7_3, l_7_4)
	l_7_2 = l_7_0._meters_percent_texts
	l_7_2 = l_7_2[4]
	l_7_2, l_7_3 = l_7_2:set_align, l_7_2
	l_7_4 = "right"
	l_7_2(l_7_3, l_7_4)
end

OverHeatPanel._set_up_meters = function(l_8_0)
	l_8_0._bar_width = 10 * l_8_0._size_modifier
	l_8_0._bar_space = 3 * l_8_0._size_modifier
	l_8_0._total_bars_width = l_8_0._width / 2 - 100
	l_8_0._bar_texture_size = 128 * l_8_0._size_modifier
	local l_8_1 = 0
	local l_8_2 = 33
	if l_8_0._coop_player_2 then
		l_8_2 = 20
	end
	if l_8_0._size_modifier <= 0.5 then
		l_8_2 = 27
	end
	local l_8_3 = 30
	local l_8_4 = l_8_0._width - (64 * l_8_0._size_modifier + 30)
	l_8_0._left_overheat = {}
	l_8_0._right_overheat = {}
	local l_8_5 = l_8_0._total_bars_width / (l_8_0._bar_width + l_8_0._bar_space)
	for l_8_9 = 1, l_8_5 do
		l_8_0._left_overheat[l_8_9] = OverHeatBar:new(l_8_0._overheat_panel, "gui_machine_bar_small", l_8_3 + l_8_1, l_8_2, tweak_data.machine.hud.MAIN_ALPHA, tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK)
		l_8_0._left_overheat[l_8_9]:set_image_height(32 * l_8_0._size_modifier)
		l_8_0._left_overheat[l_8_9]:set_texture_size(64 * l_8_0._size_modifier)
		l_8_0._right_overheat[l_8_9] = OverHeatBar:new(l_8_0._overheat_panel, "gui_machine_bar_small", l_8_4 - l_8_1, l_8_2, tweak_data.machine.hud.MAIN_ALPHA, tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK)
		l_8_0._right_overheat[l_8_9]:set_image_height(32 * l_8_0._size_modifier)
		l_8_0._right_overheat[l_8_9]:set_texture_size(64 * l_8_0._size_modifier)
		l_8_1 = l_8_9 * (l_8_0._bar_width + l_8_0._bar_space)
	end
	l_8_0._nr_of_bars = l_8_5
end

OverHeatPanel.update = function(l_9_0, l_9_1, l_9_2)
	local l_9_6, l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_12, l_9_13 = nil
	if l_9_0._need_boot_update then
		MachineHudPanel.update(l_9_0, l_9_2)
	end
	if not l_9_0._wants_to_shut_down then
		l_9_0._need_boot_update = l_9_0._wants_to_start_up
	end
	l_9_0._time = l_9_1
	l_9_0._dt_since_last_update = l_9_0._dt_since_last_update + l_9_2
	l_9_0._dt_since_last_alpha_update = l_9_0._dt_since_last_alpha_update + l_9_2
	if l_9_0._next_update_time < l_9_1 then
		l_9_0:update_meters_value()
		l_9_0._next_update_time = l_9_1 + tweak_data.machine.hud.UPDATE_FREQUENCY
		l_9_0._dt_since_last_update = 0
	end
	if l_9_0._next_alpha_update_time < l_9_1 then
		if l_9_0._left_overheat and l_9_0._right_overheat then
			for i_0,i_1 in pairs(l_9_0._left_overheat) do
				i_1:update(l_9_0._dt_since_last_alpha_update)
			end
			for i_0,i_1 in pairs(l_9_0._right_overheat) do
				i_1:update(l_9_0._dt_since_last_alpha_update)
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
		l_9_0._next_alpha_update_time = l_9_1 + tweak_data.machine.hud.ALPHA_UPDATE_FREQUENCY
		l_9_0._dt_since_last_alpha_update = 0
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

OverHeatPanel.set_alpha = function(l_10_0, l_10_1)
	local l_10_5, l_10_6, l_10_7, l_10_8, l_10_9, l_10_10, l_10_11, l_10_12, l_10_13, l_10_14, l_10_15, l_10_16, l_10_17, l_10_18 = nil
	if l_10_0._alpha ~= l_10_1 then
		l_10_0._alpha = l_10_1
		for i_0,i_1 in pairs(l_10_0._meters_percent_texts) do
			i_1:set_color(i_1:color():with_alpha(l_10_1))
		end
		for i_0,i_1 in pairs(l_10_0._left_overheat) do
			i_1:set_alpha(l_10_1)
		end
		for i_0,i_1 in pairs(l_10_0._right_overheat) do
			i_1:set_alpha(l_10_1)
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

OverHeatPanel.get_target_size = function(l_11_0)
	return l_11_0._width, l_11_0._height
end

OverHeatPanel.set_startup_done = function(l_12_0)
	if not l_12_0._startup_done then
		l_12_0:set_size_y(l_12_0._height)
	end
	MachineHudPanel.set_startup_done(l_12_0)
end

OverHeatPanel.shutdown = function(l_13_0, l_13_1, l_13_2)
	local l_13_6, l_13_7, l_13_8, l_13_9, l_13_10, l_13_11 = nil
	for i_0,i_1 in pairs(l_13_0._meters_percent_texts) do
		i_1:set_color(i_1:color():with_alpha(0))
	end
	l_13_0._shuting_down = true
	MachineHudPanel.shutdown(l_13_0, l_13_1, l_13_2)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

OverHeatPanel.set_size_y = function(l_14_0, l_14_1)
	if l_14_1 > 20 then
		l_14_0:set_alpha(tweak_data.machine.hud.MAIN_ALPHA)
	end
	if l_14_1 < 20 and l_14_0._left_overheat then
		l_14_0:set_alpha(0)
	end
end

OverHeatPanel.enable = function(l_15_0, l_15_1, l_15_2)
	l_15_0._size_modifier = l_15_1
	if l_15_1 <= 0.25 then
		l_15_0._meters_percent_texts[1]:set_font_size(tweak_data.machine.hud.text.TEXT_FONT_SIZE_VERY_SMALL)
		l_15_0._meters_percent_texts[2]:set_font_size(tweak_data.machine.hud.text.TEXT_FONT_SIZE_VERY_SMALL)
		l_15_0._meters_percent_texts[3]:set_font_size(tweak_data.machine.hud.text.TEXT_FONT_SIZE_SMALL)
		l_15_0._meters_percent_texts[4]:set_font_size(tweak_data.machine.hud.text.TEXT_FONT_SIZE_SMALL)
	elseif l_15_1 <= 0.5 then
		l_15_0._meters_percent_texts[1]:set_font_size(tweak_data.machine.hud.text.TEXT_FONT_SIZE_SMALL)
		l_15_0._meters_percent_texts[2]:set_font_size(tweak_data.machine.hud.text.TEXT_FONT_SIZE_SMALL)
		l_15_0._meters_percent_texts[3]:set_font_size(tweak_data.machine.hud.text.TEXT_FONT_SIZE_NORMAL)
		l_15_0._meters_percent_texts[4]:set_font_size(tweak_data.machine.hud.text.TEXT_FONT_SIZE_NORMAL)
	else
		l_15_0._meters_percent_texts[1]:set_font_scale(tweak_data.machine.hud.text.TEXT_FONT_SCALE_NORMAL_SIZE)
		l_15_0._meters_percent_texts[2]:set_font_scale(tweak_data.machine.hud.text.TEXT_FONT_SCALE_NORMAL_SIZE)
		l_15_0._meters_percent_texts[3]:set_font_scale(tweak_data.machine.hud.text.TEXT_FONT_SCALE_BIG_SIZE)
		l_15_0._meters_percent_texts[4]:set_font_scale(tweak_data.machine.hud.text.TEXT_FONT_SCALE_BIG_SIZE)
	end
	l_15_0:set_alpha(0)
	if l_15_2 == 0 then
		local l_15_3 = l_15_0._parent_panel:height()
		if l_15_0._size_modifier <= 0.5 then
			l_15_0._overheat_panel:set_bottom(l_15_3 + 5)
		else
			l_15_0._overheat_panel:set_bottom(l_15_3 - 10)
		end
		if l_15_0._unit:name() == "player2_tank" then
			l_15_0._coop_player_2 = true
			l_15_0._y = 0
			l_15_0._meters_percent_texts[1]:set_top(34)
			l_15_0._meters_percent_texts[2]:set_top(34)
			l_15_0._meters_percent_texts[3]:set_top(8)
			l_15_0._meters_percent_texts[4]:set_top(8)
			l_15_0._overheat_panel:set_top(0)
		else
			l_15_0._y = l_15_0._overheat_panel:y()
		end
		l_15_0._overheat_panel:set_center_x(l_15_0._x)
		l_15_0._center_y = l_15_0._overheat_panel:center_y()
	else
		l_15_0._y = l_15_0._parent_panel:height() - tweak_data.machine.hud.TURRET_PANEL_HEIGHT * l_15_2 - l_15_0._height
		l_15_0._overheat_panel:set_center_x(l_15_0._x)
		l_15_0._overheat_panel:set_top(l_15_0._y)
		l_15_0._center_y = l_15_0._overheat_panel:center_y()
	end
	l_15_0:_set_up_meters()
	if not l_15_0._startup_done then
		l_15_0:set_alpha(0)
	else
		l_15_0:set_alpha(tweak_data.machine.hud.MAIN_ALPHA)
	end
end

OverHeatPanel.show = function(l_16_0)
	MachineHudPanel.show(l_16_0)
	l_16_0:set_alpha(tweak_data.machine.hud.MAIN_ALPHA)
end

OverHeatPanel.hide = function(l_17_0)
	MachineHudPanel.hide(l_17_0)
	l_17_0:set_alpha(0)
end


