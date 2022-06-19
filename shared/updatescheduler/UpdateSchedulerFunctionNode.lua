require("shared/updatescheduler/UpdateSchedulerNode")
UpdateSchedulerFunctionNode = UpdateSchedulerFunctionNode or class(UpdateSchedulerNode)
function UpdateSchedulerFunctionNode.init(A0_0, A1_1)
	UpdateSchedulerNode.init(A0_0)
	assert(A1_1)
	A0_0._callback = A1_1
	A0_0._alive = true
end
function UpdateSchedulerFunctionNode.update(A0_2, ...)
	assert(A0_2:alive())
	if A0_2._should_update then
		A0_2:disable_update()
		return A0_2._callback(...), true
	end
	return nil, false
end
function UpdateSchedulerFunctionNode.remove(A0_4)
	local L1_5
	A0_4._alive = false
end
function UpdateSchedulerFunctionNode.alive(A0_6)
	local L1_7
	L1_7 = A0_6._alive
	return L1_7
end
