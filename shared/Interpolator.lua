require("shared/TableAlgorithms")
if not Interpolator then
	Interpolator = class()
end
Interpolator.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._value = l_1_1
	l_1_0._target = l_1_1
	l_1_0._speed = l_1_2
	l_1_0._reached_target = false
end

Interpolator.save = function(l_2_0, l_2_1)
	TableAlgorithms.merge_except_functions(l_2_1, l_2_0)
end

Interpolator.load = function(l_3_0, l_3_1)
	TableAlgorithms.merge_except_functions(l_3_0, l_3_1)
end

Interpolator.update = function(l_4_0, l_4_1)
	local l_4_2 = l_4_0._target - l_4_0._value
	local l_4_3 = math.min(l_4_0._speed * l_4_1, 1)
	l_4_0._value = l_4_0._value + l_4_3 * l_4_2
	if math.abs(l_4_0._value - l_4_0._target) < 0.0001 then
		l_4_0._value = l_4_0._target
	end
end

Interpolator.set_target = function(l_5_0, l_5_1)
	l_5_0._target = l_5_1
end

Interpolator.set_speed = function(l_6_0, l_6_1)
	l_6_0._speed = l_6_1
end

Interpolator.set_value = function(l_7_0, l_7_1)
	l_7_0._value = l_7_1
	l_7_0._target = l_7_1
end

Interpolator.value = function(l_8_0)
	return l_8_0._value
end

Interpolator.target = function(l_9_0)
	return l_9_0._target
end

Interpolator.has_reached_target = function(l_10_0)
	return l_10_0._value == l_10_0._target
end

Interpolator.has_reached_target_vec = function(l_11_0)
	return l_11_0._target - l_11_0._value:length() < 0.01
end


