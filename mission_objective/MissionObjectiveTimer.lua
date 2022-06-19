MissionObjectiveTimer = MissionObjectiveTimer or class()
function MissionObjectiveTimer.init(A0_0, A1_1, A2_2)
	A0_0._callback_object = A1_1
	assert(A2_2 >= 0)
	A0_0._time = A2_2
	A0_0._start_time = A2_2
	A0_0._timed_out = false
end
function MissionObjectiveTimer.update(A0_3, A1_4)
	if A0_3._timed_out then
		return
	end
	A0_3._time = A0_3._time - A1_4
	if A0_3._time > 0 then
		return
	end
	if A0_3._callback_object then
		A0_3._callback_object:timed_out()
	end
	A0_3._timed_out = true
end
function MissionObjectiveTimer.time_left(A0_5)
	return A0_5._time + 1
end
function MissionObjectiveTimer.set_callback_object(A0_6, A1_7)
	assert(A0_6._callback_object == nil)
	A0_6._callback_object = A1_7
end
