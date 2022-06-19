if not UpdateSchedulerDtMethod then
	UpdateSchedulerDtMethod = class()
end
UpdateSchedulerDtMethod.init = function(l_1_0, l_1_1)
	assert(l_1_1)
	assert(l_1_1.update)
	l_1_0._scheduler_node = l_1_1
	l_1_0._dt = 0
end

UpdateSchedulerDtMethod.remove = function(l_2_0)
	assert(l_2_0._scheduler_node)
	l_2_0._scheduler_node:remove()
	l_2_0._scheduler_node = nil
end

UpdateSchedulerDtMethod.update = function(l_3_0, l_3_1, l_3_2, ...)
	assert(l_3_0._scheduler_node)
	assert(math.nice(l_3_2))
	assert(math.nice(l_3_0._dt))
	assert(math.nice(l_3_0._dt + l_3_2))
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_3_4, l_3_5 = , l_3_0._scheduler_node:update(l_3_1, l_3_0._dt + l_3_2, ...)
	if l_3_0._scheduler_node then
		l_3_0._dt = 0
	else
		l_3_0._dt = l_3_4
	end
	return l_3_5, R8_PC36
end

UpdateSchedulerDtMethod.will_update = function(l_4_0)
	local l_4_1, l_4_2 = l_4_0._scheduler_node:will_update, l_4_0._scheduler_node
	return l_4_1(l_4_2)
end


