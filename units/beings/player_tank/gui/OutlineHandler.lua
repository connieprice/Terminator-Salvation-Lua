require("units/beings/player_tank/gui/MachineHudPanel")
if not OutlineHandler then
	OutlineHandler = class(MachineHudPanel)
end
OutlineHandler.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._outline_units = {}
	l_1_0._unit_highlighter = World:unit_manager():unit_highlighter()
	l_1_0._unit_highlighter:set_name_filter("g_*", "gfx_*")
	l_1_0._unit_highlighter:add_config("contour_highlight", "contour_highlight", "contour_highlight_skinned_2w", "contour_highlight_skinned_3w", "contour_highlight_skinned_4w", "contour_highlight")
	l_1_0._startup_time = Application:time() + 3
	l_1_0._viewport = managers.user_viewport:get_engine_viewport_for_unit(l_1_0._unit)
	l_1_0._dt_since_last_update = 0
	l_1_0._next_update_time = 0
end

OutlineHandler.shutdown = function(l_2_0, l_2_1, l_2_2)
	local l_2_6, l_2_7, l_2_8 = nil
	for i_0,i_1 in pairs(l_2_0._outline_units) do
		l_2_0:_deactivate_outline(i_0)
	end
end

OutlineHandler.startup_done = function(l_3_0, l_3_1)
	return l_3_0._startup_time < l_3_1
end

OutlineHandler.update = function(l_4_0, l_4_1, l_4_2)
	if not l_4_0:startup_done(l_4_1) then
		return 
	end
	if not l_4_0._last_unit_list_update or l_4_0._last_unit_list_update + 1 < l_4_1 then
		l_4_0:_update_units_outline_list()
		l_4_0._last_unit_list_update = l_4_1
	end
	l_4_0._dt_since_last_update = l_4_0._dt_since_last_update + l_4_2
	if l_4_0._next_update_time < l_4_1 then
		l_4_0:_update_outline_units(l_4_1, l_4_0._dt_since_last_update)
		l_4_0._next_update_time = l_4_1 + tweak_data.machine.hud.UPDATE_FREQUENCY
		l_4_0._dt_since_last_update = 0
	end
end

OutlineHandler._update_units_outline_list = function(l_5_0)
	l_5_0._outline_unit_list = {}
	local l_5_1 = l_5_0._unit:position()
	local l_5_6 = World:find_units_quick
	local l_5_7 = World
	l_5_6 = l_5_6(l_5_7, "sphere", l_5_1, tweak_data.machine.hud.outline.DETECTION_RANGE, managers.slot:get_mask("enemies", "vehicles"))
	local l_5_2 = nil
	l_5_7 = pairs
	l_5_2 = l_5_6
	l_5_7 = l_5_7(l_5_2)
	for i_0,i_1 in l_5_7 do
		if l_5_5:name() ~= "rail_vehicle_tank" then
			table.insert(l_5_0._outline_unit_list, l_5_5)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

OutlineHandler._update_outline_units = function(l_6_0, l_6_1, l_6_2)
	local l_6_8, l_6_9, l_6_10, l_6_11, l_6_12, l_6_13, l_6_16, l_6_17, l_6_18, l_6_19, l_6_20, l_6_21, l_6_22, l_6_23, l_6_24, l_6_25, l_6_26, l_6_27, l_6_28, l_6_29, l_6_30, l_6_31, l_6_32, l_6_33, l_6_34 = nil
	local l_6_3 = l_6_0._unit:position()
	local l_6_4 = tweak_data.machine.hud.outline.DETECTION_ANGLE
	for i_0,i_1 in pairs(l_6_0._outline_unit_list) do
		if alive(i_1) and math.abs(Rotation(i_1:position() - l_6_3, Vector3(0, 0, 1)):roll() - l_6_0._unit:rotation():roll()) < l_6_4 then
			l_6_0:_activate_outline(l_6_15)
		end
	end
	for i_0,i_1 in pairs(l_6_0._outline_units) do
		if i_1.state == "alive" and alive(i_0) and (i_1.total_time < l_6_1 or i_0:damage_data():is_fully_damaged()) then
			l_6_0:_kill_outline(i_0)
		elseif i_1.state == "alive" then
			l_6_0:_blink_outline(i_0, true, tweak_data.machine.hud.outline.BLINK_FREQUENCY_IN)
		elseif i_1.state == "dying" then
			l_6_0:_blink_outline(i_0, false, tweak_data.machine.hud.outline.BLINK_FREQUENCY_OUT)
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

OutlineHandler._activate_outline = function(l_7_0, l_7_1)
	if not l_7_0._outline_units[l_7_1] then
		l_7_0._outline_units[l_7_1] = {}
		l_7_0._outline_units[l_7_1].total_time = Application:time() + tweak_data.machine.hud.outline.UNIT_OUTLINE_DURATION
		l_7_0._unit_highlighter:add_unit(l_7_1, "contour_highlight", l_7_0._viewport)
		l_7_0._outline_units[l_7_1].state = "alive"
		l_7_0._outline_units[l_7_1].blinks = tweak_data.machine.hud.outline.UNIT_OUTLINE_BLINKS_IN
		l_7_0._outline_units[l_7_1].time = 0
		l_7_0._outline_units[l_7_1].blinking = true
	end
end

OutlineHandler._deactivate_outline = function(l_8_0, l_8_1)
	if alive(l_8_1) then
		l_8_0._unit_highlighter:remove_unit(l_8_1, l_8_0._viewport)
		l_8_0._outline_units[l_8_1].state = "dead"
	end
end

OutlineHandler._kill_outline = function(l_9_0, l_9_1)
	if alive(l_9_1) then
		l_9_0._outline_units[l_9_1].state = "dying"
		l_9_0._outline_units[l_9_1].blinking = true
		l_9_0._outline_units[l_9_1].blinks = tweak_data.machine.hud.outline.UNIT_OUTLINE_BLINKS_OUT
	end
end

OutlineHandler._blink_outline = function(l_10_0, l_10_1, l_10_2, l_10_3)
	if alive(l_10_1) then
		local l_10_4 = Application:time()
		if l_10_0._outline_units[l_10_1].time < l_10_4 and l_10_0._outline_units[l_10_1].blinks > 0 then
			if l_10_0._outline_units[l_10_1].blinking then
				l_10_0._unit_highlighter:add_unit(l_10_1, "contour_highlight", l_10_0._viewport)
			else
				l_10_0._unit_highlighter:remove_unit(l_10_1, l_10_0._viewport)
			end
			l_10_0._outline_units[l_10_1].blinks = l_10_0._outline_units[l_10_1].blinks - 1
			l_10_0._outline_units[l_10_1].time = l_10_4 + l_10_3
			l_10_0._outline_units[l_10_1].blinking = not l_10_0._outline_units[l_10_1].blinking
		end
		if l_10_0._outline_units[l_10_1].blinks <= 0 then
			if l_10_2 then
				l_10_0._unit_highlighter:add_unit(l_10_1, "contour_highlight", l_10_0._viewport)
			end
		end
	else
		l_10_0:_deactivate_outline(l_10_1)
	end
end

OutlineHandler.hide = function(l_11_0)
	local l_11_4, l_11_5, l_11_6, l_11_7 = nil
	for i_0,i_1 in pairs(l_11_0._outline_units) do
		if alive(i_0) then
			l_11_0._unit_highlighter:remove_unit(i_0, l_11_0._viewport)
		end
	end
end


