require("shared/Queue")
if not AverageOverTime then
	AverageOverTime = class()
end
AverageOverTime.init = function(l_1_0, l_1_1, l_1_2)
	local l_1_3 = assert
	l_1_3(l_1_1 > 0)
	l_1_0._max_sample_count = l_1_1
	l_1_3 = Queue
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._values = l_1_3
	if l_1_2 == nil then
		l_1_0._total = 0
	else
		l_1_0._total = l_1_2
	end
	l_1_0._time = 0
	l_1_0._time_since_debug = 0
end

AverageOverTime.add = function(l_2_0, l_2_1, l_2_2)
	if l_2_0._values:size() == l_2_0._max_sample_count then
		local l_2_3 = l_2_0._values:pop_first()
		l_2_0._total = l_2_0._total - l_2_3.value
		l_2_0._time = l_2_0._time - l_2_3.time
	end
	local l_2_4 = {}
	l_2_4.value = l_2_1
	l_2_4.time = l_2_2
	l_2_0._values:push_last(l_2_4)
	l_2_0._total = l_2_0._total + l_2_4.value
	l_2_0._time = l_2_0._time + l_2_4.time
	l_2_0._time_since_debug = l_2_0._time_since_debug + l_2_2
	if l_2_0._time_since_debug > 5 then
		l_2_0._time_since_debug = 0
	end
end

AverageOverTime.value = function(l_3_0)
	if l_3_0._time <= 0.1 then
		return 0
	end
	return l_3_0._total / l_3_0._time
end

AverageOverTime.clear = function(l_4_0)
	l_4_0._values:clear()
	l_4_0._total = 0
	l_4_0._time = 0
end

AverageOverTime.is_complete = function(l_5_0)
	return l_5_0._values:size() == l_5_0._max_sample_count
end

AverageOverTime.count = function(l_6_0)
	local l_6_1, l_6_2 = l_6_0._values:size, l_6_0._values
	return l_6_1(l_6_2)
end


