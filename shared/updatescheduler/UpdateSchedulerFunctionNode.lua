require("shared/updatescheduler/UpdateSchedulerNode")
if not UpdateSchedulerFunctionNode then
	UpdateSchedulerFunctionNode = class(UpdateSchedulerNode)
end
UpdateSchedulerFunctionNode.init = function(l_1_0, l_1_1)
	UpdateSchedulerNode.init(l_1_0)
	assert(l_1_1)
	l_1_0._callback = l_1_1
	l_1_0._alive = true
end

UpdateSchedulerFunctionNode.update = function(l_2_0, ...)
	assert(l_2_0:alive())
	if l_2_0._should_update then
		l_2_0:disable_update()
		return l_2_0._callback(...), true
	end
	return nil, false
end

UpdateSchedulerFunctionNode.remove = function(l_3_0)
	l_3_0._alive = false
end

UpdateSchedulerFunctionNode.alive = function(l_4_0)
	return l_4_0._alive
end


