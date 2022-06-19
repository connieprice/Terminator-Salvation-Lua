require("units/beings/player_tank/gui/MachineHudPanel")
require("units/beings/player_tank/gui/MachineText")
require("units/beings/player_tank/gui/CompassStates")
if not CompassPanel then
	CompassPanel = class(MachineHudPanel)
end
CompassPanel.init = function(l_1_0, l_1_1)
	MachineHudPanel.init(l_1_0, l_1_1)
	l_1_0._parent_panel = l_1_1
	l_1_0._size_modifier = 1
	l_1_0._x = l_1_0._parent_panel:width() / 2
	l_1_0._y = 0
	l_1_0._width = tweak_data.machine.hud.COMPASS_PANEL_WIDTH * l_1_0._size_modifier
	l_1_0._height = tweak_data.machine.hud.COMPASS_PANEL_HEIGHT
	l_1_0._center_y = l_1_0._height / 2
	l_1_0._color = tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK
	local l_1_2, l_1_3 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_4 = {}
	l_1_4.name = "compass_panel "
	l_1_4.width = l_1_0._width
	l_1_4.height = l_1_0._height
	l_1_4.layer = 100
	l_1_2 = l_1_2(l_1_3, l_1_4)
	l_1_0._compass_panel = l_1_2
	l_1_2 = l_1_0._compass_panel
	l_1_2, l_1_3 = l_1_2:set_center_x, l_1_2
	l_1_4 = l_1_0._x
	l_1_2(l_1_3, l_1_4)
	l_1_2 = l_1_0._compass_panel
	l_1_2, l_1_3 = l_1_2:set_top, l_1_2
	l_1_4 = l_1_0._y
	l_1_2(l_1_3, l_1_4)
	l_1_2, l_1_3 = l_1_0:_set_up_compass, l_1_0
	l_1_2(l_1_3)
	l_1_2 = FiniteStateMachine
	l_1_2, l_1_3 = l_1_2:new, l_1_2
	l_1_4 = l_1_0
	l_1_2 = l_1_2(l_1_3, l_1_4, "_compass_panel", CompassIdleState)
	l_1_0._state = l_1_2
	l_1_2 = l_1_0._state
	l_1_2, l_1_3 = l_1_2:set_debug, l_1_2
	l_1_4 = false
	l_1_2(l_1_3, l_1_4)
	l_1_0._current_bearing = 1
	l_1_0._last_direction, l_1_2 = l_1_2, {}
	l_1_2, l_1_3 = l_1_0:set_size_y, l_1_0
	l_1_4 = 0
	l_1_2(l_1_3, l_1_4)
end

CompassPanel.panel = function(l_2_0)
	return l_2_0._compass_panel
end

CompassPanel._set_up_compass = function(l_3_0)
	local l_3_1 = l_3_0._width / 2
	local l_3_2 = 10 * l_3_0._size_modifier
	local l_3_3 = math.round(l_3_0._width / l_3_2)
	local l_3_4 = math.round(l_3_3 / 2)
	local l_3_5 = 0
	l_3_0._lines = {}
	for l_3_9 = 1, 360 do
		if l_3_9 < l_3_4 then
			l_3_5 = 1 * l_3_9 / l_3_4
		else
			l_3_5 = 1 * (l_3_3 - l_3_9) / l_3_4
		end
		if l_3_9 % 5 == 0 then
			local l_3_10, l_3_11 = l_3_0._compass_panel:rect, l_3_0._compass_panel
			local l_3_12 = {}
			l_3_12.name = "line"
			l_3_12.y = 0
			l_3_12.width = 4 * l_3_0._size_modifier
			l_3_12.height = 25 * l_3_0._size_modifier
			l_3_10 = l_3_10(l_3_11, l_3_12)
			l_3_11, l_3_12 = l_3_10:set_center_x, l_3_10
			l_3_11(l_3_12, l_3_1)
			l_3_11 = MachineText
			l_3_11, l_3_12 = l_3_11:new, l_3_11
			l_3_11 = l_3_11(l_3_12, l_3_0._compass_panel, l_3_1, 30 * l_3_0._size_modifier)
			l_3_12(l_3_11, tostring(l_3_9))
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_3_12(l_3_11, "center", "top")
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_3_12(l_3_11, l_3_1)
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_3_12(l_3_11, 0)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_3_12 <= 0.5 then
				l_3_12(l_3_11)
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			local l_3_13 = {}
			l_3_13.line = l_3_10
			l_3_13.text = l_3_11
			l_3_12[l_3_9] = l_3_13
		else
			local l_3_14, l_3_15 = l_3_0._compass_panel:rect, l_3_0._compass_panel
			local l_3_16 = {}
			l_3_16.name = "line"
			l_3_16.x = l_3_1
			l_3_16.y = 0
			l_3_16.width = 2 * l_3_0._size_modifier
			l_3_16.height = 15 * l_3_0._size_modifier
			l_3_14 = l_3_14(l_3_15, l_3_16)
			l_3_15 = l_3_0._lines
			l_3_15[l_3_9], l_3_16 = l_3_16, {line = l_3_14}
		end
		l_3_1 = l_3_1 + l_3_2
	end
end

CompassPanel.get_current_bearing = function(l_4_0)
	return l_4_0._current_bearing
end

CompassPanel.get_target_bearing = function(l_5_0)
	return l_5_0._target_bearing
end

CompassPanel.set_current_spin_speed = function(l_6_0, l_6_1)
	l_6_0._current_spin_speed = l_6_1
end

CompassPanel.get_current_spin_speed = function(l_7_0, l_7_1)
	return l_7_0._current_spin_speed
end

CompassPanel.spin_to_bearing = function(l_8_0, l_8_1)
	l_8_0._target_bearing = l_8_1
	local l_8_2 = false
	local l_8_3 = false
	if l_8_0._target_bearing - l_8_0._current_bearing > 3000 then
		l_8_2 = true
	end
	if l_8_0._target_bearing - l_8_0._current_bearing < -3000 then
		l_8_3 = true
	end
	if l_8_2 or l_8_0._target_bearing - l_8_0._current_bearing < 0 and not l_8_3 then
		l_8_0._wants_to_spin_left = true
		l_8_0._wants_to_spin_right = false
		l_8_0._wants_to_slowdown_spin_left = false
		l_8_0._wants_to_slowdown_spin_right = false
	else
		l_8_0._wants_to_spin_right = true
		l_8_0._wants_to_spin_left = false
		l_8_0._wants_to_slowdown_spin_left = false
		l_8_0._wants_to_slowdown_spin_right = false
	end
	l_8_0._wants_to_idle = false
end

CompassPanel.slow_down_spin_to_bearing = function(l_9_0, l_9_1)
	l_9_0._target_bearing = l_9_1
	local l_9_2 = false
	local l_9_3 = false
	if l_9_0._target_bearing - l_9_0._current_bearing > 3000 then
		l_9_2 = true
	end
	if l_9_0._target_bearing - l_9_0._current_bearing < -3000 then
		l_9_3 = true
	end
	if l_9_2 or l_9_0._target_bearing - l_9_0._current_bearing < 0 and not l_9_3 then
		l_9_0._wants_to_spin_left = false
		l_9_0._wants_to_spin_right = false
		l_9_0._wants_to_slowdown_spin_left = true
		l_9_0._wants_to_slowdown_spin_right = false
		Application:debug("slow_spin_left", l_9_0._current_bearing, l_9_0._target_bearing)
	else
		l_9_0._wants_to_spin_right = false
		l_9_0._wants_to_spin_left = false
		l_9_0._wants_to_slowdown_spin_left = false
		l_9_0._wants_to_slowdown_spin_right = true
		Application:debug("slow_spin_right", l_9_0._current_bearing, l_9_0._target_bearing)
	end
	l_9_0._wants_to_idle = false
end

CompassPanel.wants_to_spin_right = function(l_10_0)
	return l_10_0._wants_to_spin_right
end

CompassPanel.wants_to_spin_left = function(l_11_0)
	return l_11_0._wants_to_spin_left
end

CompassPanel.wants_to_slowdown_spin_right = function(l_12_0)
	return l_12_0._wants_to_slowdown_spin_right
end

CompassPanel.wants_to_slowdown_spin_left = function(l_13_0)
	return l_13_0._wants_to_slowdown_spin_left
end

CompassPanel.wants_to_idle = function(l_14_0)
	return l_14_0._wants_to_idle
end

CompassPanel.idle = function(l_15_0)
	l_15_0._wants_to_idle = true
	l_15_0._wants_to_spin_left = false
	l_15_0._wants_to_spin_right = false
end

CompassPanel.set_bearing = function(l_16_0, l_16_1)
	local l_16_2 = 10
	local l_16_3 = l_16_0._width / 2
	local l_16_4 = math.round(l_16_0._width / l_16_2)
	local l_16_5 = math.round(l_16_4 / 2)
	local l_16_6 = 180
	do
		local l_16_7 = l_16_1 % 10
		if l_16_1 < 1 then
			l_16_1 = l_16_1 + 3600
		elseif l_16_1 > 3600 then
			l_16_1 = l_16_1 - 3600
		end
		l_16_1 = math.floor((l_16_1) / 10)
		l_16_0._current_bearing = l_16_1 * 10 + l_16_7
		if l_16_1 < 1 then
			l_16_1 = 1
			l_16_7 = 0
		end
		for l_16_11 = l_16_1 - 180, l_16_1 do
			if l_16_11 < 1 then
				local l_16_12 = l_16_11 + 360
			end
			local l_16_13 = nil
			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_16_6 < l_16_5 then
				local l_16_14 = 0
				l_16_0._lines[l_16_13].line:set_center_x(l_16_3 - l_16_6 * l_16_2 - l_16_7)
				l_16_0._lines[l_16_13].line:set_color(l_16_0._color:with_alpha(l_16_14 * tweak_data.machine.hud.MAIN_ALPHA))
				 -- DECOMPILER ERROR: Confused about usage of registers!

				if l_16_0._lines[l_16_13].text then
					l_16_0._lines[l_16_13].text._machine_text:set_center_x(l_16_3 - l_16_6 * l_16_2 - l_16_7)
					if l_16_0.startup_done then
						l_16_0._lines[l_16_13].text:set_text_alpha(l_16_14)
					end
				else
					l_16_0._lines[l_16_13].text:set_text_alpha(0)
				end
				l_16_6 = l_16_6 - 1
			end
			l_16_6 = 180
			for l_16_18 = l_16_1 + 180, l_16_1, -1 do
				if l_16_18 > 360 then
					local l_16_19 = l_16_18 - 360
				end
				local l_16_20 = nil
				 -- DECOMPILER ERROR: Overwrote pending register.

				if l_16_6 < l_16_5 then
					local l_16_21 = 0
					l_16_0._lines[l_16_20].line:set_center_x(l_16_3 + l_16_6 * l_16_2 - l_16_7)
					l_16_0._lines[l_16_20].line:set_color(l_16_0._color:with_alpha(l_16_21 * tweak_data.machine.hud.MAIN_ALPHA))
					 -- DECOMPILER ERROR: Confused about usage of registers!

					if l_16_0._lines[l_16_20].text then
						l_16_0._lines[l_16_20].text._machine_text:set_center_x(l_16_3 + l_16_6 * l_16_2 - l_16_7)
						if l_16_0.startup_done then
							l_16_0._lines[l_16_20].text:set_text_alpha(l_16_21)
						end
					else
						l_16_0._lines[l_16_20].text:set_text_alpha(0)
					end
					l_16_6 = l_16_6 - 1
				end
			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 47 113 
end

CompassPanel.update = function(l_17_0, l_17_1, l_17_2, l_17_3)
	MachineHudPanel.update(l_17_0, l_17_2)
	if l_17_0._disabled or l_17_0._shuting_down then
		return 
	end
	local l_17_4 = math.round(l_17_3)
	l_17_0:spin_to_bearing(l_17_4)
	l_17_0._current_direction_time = 0
	l_17_0._slow_down_initated = false
	l_17_0._state:update(l_17_2)
end

CompassPanel.get_target_size = function(l_18_0)
	return l_18_0._width, l_18_0._height
end

CompassPanel.shutdown = function(l_19_0, l_19_1, l_19_2)
	local l_19_6, l_19_7, l_19_8, l_19_9, l_19_10, l_19_11 = nil
	for i_0,i_1 in pairs(l_19_0._lines) do
		if i_1.text then
			i_1.text:set_text_alpha(0)
		end
	end
	l_19_0._shuting_down = true
	MachineHudPanel.shutdown(l_19_0, l_19_1, l_19_2)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CompassPanel.set_size_y = function(l_20_0, l_20_1)
	local l_20_7, l_20_8, l_20_9, l_20_10, l_20_11, l_20_12, l_20_13, l_20_14, l_20_15, l_20_16, l_20_17, l_20_18, l_20_19, l_20_20, l_20_21, l_20_22, l_20_23, l_20_24, l_20_25, l_20_26, l_20_27, l_20_28, l_20_29, l_20_30, l_20_31 = nil
	local l_20_2 = l_20_1 / 2
	local l_20_3 = l_20_0._height / 2 - l_20_2
	for i_0,i_1 in pairs(l_20_0._lines) do
		if i_0 % 5 == 0 then
			if 25 * l_20_0._size_modifier - l_20_3 > 0 then
				i_1.line:set_height(25 * l_20_0._size_modifier - l_20_3)
				i_1.line:set_bottom(25 * l_20_0._size_modifier)
			else
				i_1.line:set_height(0)
			end
		else
			if 15 * l_20_0._size_modifier - l_20_3 > 0 then
				i_1.line:set_height(15 * l_20_0._size_modifier - l_20_3)
				i_1.line:set_bottom(15 * l_20_0._size_modifier)
			end
		else
			i_1.line:set_height(0)
		end
	end
end

CompassPanel.set_startup_done = function(l_21_0)
	if not l_21_0._startup_done then
		l_21_0:set_size_y(l_21_0._height)
	end
	MachineHudPanel.set_startup_done(l_21_0)
end

CompassPanel.disable = function(l_22_0)
	local l_22_4, l_22_5, l_22_6, l_22_7, l_22_8, l_22_9, l_22_10, l_22_11, l_22_12, l_22_13 = nil
	for i_0,i_1 in pairs(l_22_0._lines) do
		i_1.line:set_color(l_22_0._color:with_alpha(0))
		if i_1.text then
			i_1.text:set_text_alpha(0)
		end
	end
	l_22_0._disabled = true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CompassPanel.enable = function(l_23_0, l_23_1)
	local l_23_6, l_23_7, l_23_8, l_23_9, l_23_10 = nil
	l_23_0._size_modifier = l_23_1 or 1
	l_23_0._width = tweak_data.machine.hud.COMPASS_PANEL_WIDTH * l_23_0._size_modifier
	l_23_0._height = tweak_data.machine.hud.COMPASS_PANEL_HEIGHT * l_23_0._size_modifier
	l_23_0._compass_panel:set_width(l_23_0._width)
	local l_23_5 = l_23_0._compass_panel:set_center_x
	l_23_5(l_23_0._compass_panel, l_23_0._parent_panel:width() / 2)
	l_23_0._disabled = false
	l_23_5 = pairs
	l_23_5 = l_23_5(l_23_0._lines)
	for i_0,i_1 in l_23_5 do
		i_1.line:set_color(l_23_0._color:with_alpha(0))
		if i_1.text then
			i_1.text:set_text_alpha(0)
		end
	end
	l_23_0:_set_up_compass()
	if not l_23_0._startup_done then
		l_23_0:set_size_y(0)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CompassPanel.show = function(l_24_0)
	local l_24_4, l_24_5, l_24_6, l_24_7, l_24_8, l_24_9, l_24_10, l_24_11, l_24_12, l_24_13 = nil
	if l_24_0._disabled then
		return 
	end
	MachineHudPanel.show(l_24_0)
	for i_0,i_1 in pairs(l_24_0._lines) do
		i_1.line:set_color(l_24_0._color:with_alpha(l_24_0._color:with_alpha(tweak_data.machine.hud.MAIN_ALPHA)))
		if i_1.text then
			i_1.text:set_text_alpha(1)
		end
	end
end

CompassPanel.hide = function(l_25_0)
	local l_25_4, l_25_5, l_25_6, l_25_7, l_25_8, l_25_9, l_25_10, l_25_11, l_25_12, l_25_13 = nil
	MachineHudPanel.hide(l_25_0)
	for i_0,i_1 in pairs(l_25_0._lines) do
		i_1.line:set_color(l_25_0._color:with_alpha(0))
		if i_1.text then
			i_1.text:set_text_alpha(0)
		end
	end
end


