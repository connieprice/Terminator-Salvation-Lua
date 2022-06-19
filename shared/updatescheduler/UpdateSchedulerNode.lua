UpdateSchedulerNode = UpdateSchedulerNode or class()
function UpdateSchedulerNode.init(A0_0, A1_1)
	A0_0._debug_name = A1_1
	A0_0:disable_update()
end
function UpdateSchedulerNode.enable_update(A0_2)
	local L1_3
	A0_2._should_update = true
end
function UpdateSchedulerNode.disable_update(A0_4)
	local L1_5
	A0_4._should_update = false
end
function UpdateSchedulerNode.will_update(A0_6)
	local L1_7
	L1_7 = A0_6._should_update
	return L1_7
end
