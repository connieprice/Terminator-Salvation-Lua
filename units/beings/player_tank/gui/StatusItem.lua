require("units/beings/player_tank/gui/MachineText")
if not StatusItem then
	StatusItem = class()
end
StatusItem.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	l_1_0._item_text = l_1_1
	l_1_0._status = l_1_2
	l_1_0._current_status = l_1_2
	l_1_0._row = l_1_3
	l_1_0._page = l_1_4
	l_1_0._interpolator = Interpolator:new(l_1_0._status, tweak_data.machine.hud.STATUS_DECREASE_SPEED)
end

StatusItem.set_fluctuation = function(l_2_0, l_2_1, l_2_2, l_2_3)
	local l_2_4 = {}
	l_2_4.min = l_2_1
	l_2_4.max = l_2_2
	l_2_4.normal = l_2_3
	l_2_0._fluctuation = l_2_4
end

StatusItem.remove_fluctuation = function(l_3_0)
	l_3_0._fluctuation = nil
end

StatusItem.use_status_enums = function(l_4_0, l_4_1)
	l_4_0._status_enums = l_4_1
	l_4_0._interpolator = nil
end

StatusItem.get_item_string = function(l_5_0)
	return l_5_0:_pad(l_5_0._item_text, 30) .. "\n"
end

StatusItem.get_status_string = function(l_6_0, l_6_1)
	local l_6_2, l_6_3 = nil, nil
	if l_6_0._status_enums then
		l_6_3 = l_6_0._status_enums[l_6_0._status]
	elseif l_6_0._current_status < 100 then
		l_6_2 = string.format("%." .. 1 .. "f", l_6_0._current_status)
	else
		l_6_2 = l_6_0._current_status
	end
	l_6_3 = tostring(l_6_2) .. " %"
	if l_6_1 then
		l_6_3 = l_6_0:_front_pad(l_6_3, 15) .. "\n"
	else
		l_6_3 = l_6_0:_front_pad(l_6_3, 30) .. "\n"
	end
	return l_6_3
end

StatusItem.get_row = function(l_7_0)
	return l_7_0._row
end

StatusItem.get_page = function(l_8_0)
	return l_8_0._page
end

StatusItem.set_status_target = function(l_9_0, l_9_1)
	l_9_0._status = l_9_1
	if l_9_0._interpolator then
		l_9_0._interpolator:set_target(l_9_1)
	end
end

StatusItem.add_damage = function(l_10_0, l_10_1)
	l_10_0._status = l_10_0._status - l_10_1
	l_10_0._status = math.max(l_10_0._status, 0)
	if l_10_0._interpolator then
		l_10_0._interpolator:set_target(l_10_0._status)
	end
end

StatusItem.set_damage = function(l_11_0, l_11_1)
	l_11_0._status = 100 - l_11_1 * 100
	l_11_0._status = math.max(l_11_0._status, 0)
	l_11_0._damage = l_11_1
	if l_11_0._interpolator then
		l_11_0._interpolator:set_target(l_11_0._status)
	end
end

StatusItem.update = function(l_12_0, l_12_1)
	if l_12_0._fluctuation then
		l_12_0:_update_fluctuation()
	end
	if l_12_0._interpolator then
		l_12_0._interpolator:update(l_12_1)
		if not l_12_0._interpolator:has_reached_target() then
			l_12_0._current_status = l_12_0._interpolator:value()
		else
			l_12_0._current_status = l_12_0._status
		end
	else
		l_12_0._current_status = l_12_0._status
	end
end

StatusItem._update_fluctuation = function(l_13_0)
	local l_13_1 = math.rand(-l_13_0._fluctuation.normal, l_13_0._fluctuation.normal)
	l_13_0._status = l_13_0._status + l_13_1
	l_13_0._status = math.min(l_13_0._status, l_13_0._fluctuation.max)
	l_13_0._status = math.max(l_13_0._status, l_13_0._fluctuation.min)
	l_13_0._interpolator:set_target(l_13_0._status)
end

StatusItem._pad = function(l_14_0, l_14_1, l_14_2)
	local l_14_3 = string.rep(" ", l_14_2)
	local l_14_4 = utf8.sub
	local l_14_5 = l_14_1 .. l_14_3
	local l_14_6 = 1
	local l_14_7 = l_14_2
	return l_14_4(l_14_5, l_14_6, l_14_7)
end

StatusItem._front_pad = function(l_15_0, l_15_1, l_15_2)
	local l_15_3 = string.rep(" ", l_15_2)
	local l_15_4 = l_15_1:len()
	return utf8.sub(l_15_3 .. l_15_1, l_15_4, l_15_2 + l_15_4)
end


