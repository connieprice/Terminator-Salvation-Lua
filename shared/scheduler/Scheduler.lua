if not Scheduler then
	Scheduler = class()
end
Scheduler.init = function(l_1_0)
	l_1_0._operation_infos = {}
end

Scheduler.insert_operation = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4)
	local l_2_5 = {}
	l_2_5.operation = l_2_1
	l_2_5.done_callback = l_2_4
	l_2_0._operation_infos[l_2_1] = l_2_5
	local l_2_6 = assert
	l_2_6(TableAlgorithms.count(l_2_0._operation_infos) < 100)
end

Scheduler.remove_operation = function(l_3_0, l_3_1)
	local l_3_2 = l_3_0._operation_infos[l_3_1]
	if l_3_2 then
		l_3_2.removed = true
	end
end

Scheduler.update = function(l_4_0, l_4_1)
	local l_4_2 = l_4_0:_operation_info()
	if l_4_2 then
		local l_4_3 = l_4_2.operation
		if not l_4_2.started then
			l_4_3:start()
			l_4_2.started = true
		end
		l_4_3:update(l_4_1)
	if l_4_3:done() then
		end
		local l_4_4 = l_4_2.done_callback
		if l_4_4 then
			l_4_4(l_4_3)
		end
		l_4_0:remove_operation(l_4_3)
	end
	TableAlgorithms.remove_if(l_4_0._operation_infos, function(l_5_0)
		return l_5_0.removed
  end)
end

Scheduler._operation_info = function(l_5_0)
	if l_5_0._current_operation_info == nil or l_5_0._current_operation_info.removed then
		local l_5_1, l_5_2 = nil, nil
		repeat
			l_5_1 = next(l_5_0._operation_infos, l_5_1)
		until l_5_2 == nil or not l_5_2.removed
		l_5_0._current_operation_info = l_5_2
	end
	return l_5_0._current_operation_info
end


