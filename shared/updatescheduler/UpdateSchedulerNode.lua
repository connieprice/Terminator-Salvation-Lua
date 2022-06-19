if not UpdateSchedulerNode then
	UpdateSchedulerNode = class()
end
UpdateSchedulerNode.init = function(l_1_0, l_1_1)
	l_1_0._debug_name = l_1_1
	l_1_0:disable_update()
end

UpdateSchedulerNode.enable_update = function(l_2_0)
	l_2_0._should_update = true
end

UpdateSchedulerNode.disable_update = function(l_3_0)
	l_3_0._should_update = false
end

UpdateSchedulerNode.will_update = function(l_4_0)
	return l_4_0._should_update
end


