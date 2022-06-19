AssignedMissionObjective = AssignedMissionObjective or class()
function AssignedMissionObjective.init(A0_0, A1_1)
	assert(A1_1)
	A0_0._objective = A1_1
	A0_0._is_completed = false
end
function AssignedMissionObjective.mark_as_completed(A0_2)
	local L1_3
	A0_2._is_completed = true
end
function AssignedMissionObjective.is_completed(A0_4)
	local L1_5
	L1_5 = A0_4._is_completed
	return L1_5
end
function AssignedMissionObjective.objective(A0_6)
	local L1_7
	L1_7 = A0_6._objective
	return L1_7
end
function AssignedMissionObjective.set_timer(A0_8, A1_9)
	A0_8._timer = A1_9
end
function AssignedMissionObjective.timer(A0_10)
	local L1_11
	L1_11 = A0_10._timer
	return L1_11
end
