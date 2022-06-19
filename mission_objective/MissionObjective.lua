MissionObjective = MissionObjective or class()
function MissionObjective.init(A0_0, A1_1, A2_2)
	A0_0._objective_id = A1_1
	assert(A2_2)
	A0_0._assigned_to = A2_2
end
function MissionObjective.assigned_to(A0_3)
	local L1_4
	L1_4 = A0_3._assigned_to
	return L1_4
end
function MissionObjective.name(A0_5)
	local L1_6
	L1_6 = A0_5._objective_id
	return L1_6
end
function MissionObjective.set_text_id(A0_7, A1_8)
	A0_7._text_id = A1_8
end
function MissionObjective.text_id(A0_9)
	local L1_10
	L1_10 = A0_9._text_id
	return L1_10
end
function MissionObjective.id(A0_11)
	local L1_12
	L1_12 = A0_11._objective_id
	return L1_12
end
function MissionObjective.set_time(A0_13, A1_14)
	A0_13._time = A1_14
end
function MissionObjective.time(A0_15)
	local L1_16
	L1_16 = A0_15._time
	return L1_16
end
