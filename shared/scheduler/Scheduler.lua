Scheduler = Scheduler or class()
function Scheduler.init(A0_0)
	A0_0._operation_infos = {}
end
function Scheduler.insert_operation(A0_1, A1_2, A2_3, A3_4, A4_5)
	local L5_6
	L5_6 = {}
	L5_6.operation = A1_2
	L5_6.done_callback = A4_5
	A0_1._operation_infos[A1_2] = L5_6
	assert(TableAlgorithms.count(A0_1._operation_infos) < 100)
end
function Scheduler.remove_operation(A0_7, A1_8)
	local L2_9
	L2_9 = A0_7._operation_infos
	L2_9 = L2_9[A1_8]
	if L2_9 then
		L2_9.removed = true
	end
end
function Scheduler.update(A0_10, A1_11)
	local L2_12, L3_13, L4_14
	L3_13 = A0_10
	L2_12 = A0_10._operation_info
	L2_12 = L2_12(L3_13)
	if L2_12 then
		L3_13 = L2_12.operation
		L4_14 = L2_12.started
		if not L4_14 then
			L4_14 = L3_13.start
			L4_14(L3_13)
			L2_12.started = true
		end
		L4_14 = L3_13.update
		L4_14(L3_13, A1_11)
		L4_14 = L3_13.done
		L4_14 = L4_14(L3_13)
		if L4_14 then
			L4_14 = L2_12.done_callback
			if L4_14 then
				L4_14(L3_13)
			end
			A0_10:remove_operation(L3_13)
		end
	end
	L3_13 = TableAlgorithms
	L3_13 = L3_13.remove_if
	L4_14 = A0_10._operation_infos
	L3_13(L4_14, function(A0_15)
		local L1_16
		L1_16 = A0_15.removed
		return L1_16
	end)
end
function Scheduler._operation_info(A0_17)
	local L1_18, L2_19
	L1_18 = A0_17._current_operation_info
	if L1_18 ~= nil then
		L1_18 = A0_17._current_operation_info
		L1_18 = L1_18.removed
	elseif L1_18 then
		L1_18, L2_19 = nil, nil
		repeat
			L1_18, L2_19 = next(A0_17._operation_infos, L1_18)
		until L2_19 == nil or not L2_19.removed
		A0_17._current_operation_info = L2_19
	end
	L1_18 = A0_17._current_operation_info
	return L1_18
end
