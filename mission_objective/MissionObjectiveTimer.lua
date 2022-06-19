if not MissionObjectiveTimer then
	MissionObjectiveTimer = class()
end
MissionObjectiveTimer.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._callback_object = l_1_1
	local l_1_3 = assert
	l_1_3(l_1_2 >= 0)
	l_1_0._time = l_1_2
	l_1_0._start_time = l_1_2
	l_1_0._timed_out = false
end

MissionObjectiveTimer.update = function(l_2_0, l_2_1)
	if l_2_0._timed_out then
		return 
	end
	l_2_0._time = l_2_0._time - l_2_1
	if l_2_0._time > 0 then
		return 
	end
	if l_2_0._callback_object then
		l_2_0._callback_object:timed_out()
	end
	l_2_0._timed_out = true
end

MissionObjectiveTimer.time_left = function(l_3_0)
	return l_3_0._time + 1
end

MissionObjectiveTimer.set_callback_object = function(l_4_0, l_4_1)
	local l_4_2 = assert
	l_4_2(l_4_0._callback_object == nil)
	l_4_0._callback_object = l_4_1
end


