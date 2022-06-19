UpdateSchedulerDtMethod = UpdateSchedulerDtMethod or class()
function UpdateSchedulerDtMethod.init(A0_0, A1_1)
	assert(A1_1)
	assert(A1_1.update)
	A0_0._scheduler_node = A1_1
	A0_0._dt = 0
end
function UpdateSchedulerDtMethod.remove(A0_2)
	assert(A0_2._scheduler_node)
	A0_2._scheduler_node:remove()
	A0_2._scheduler_node = nil
end
function UpdateSchedulerDtMethod.update(A0_3, A1_4, A2_5, ...)
	local L4_7, L5_8, L6_9
	L4_7 = assert
	L5_8 = A0_3._scheduler_node
	L4_7(L5_8)
	L4_7 = assert
	L5_8 = math
	L5_8 = L5_8.nice
	L6_9 = A2_5
	L6_9 = L5_8(L6_9)
	L4_7(L5_8, L6_9, L5_8(L6_9))
	L4_7 = assert
	L5_8 = math
	L5_8 = L5_8.nice
	L6_9 = A0_3._dt
	L6_9 = L5_8(L6_9)
	L4_7(L5_8, L6_9, L5_8(L6_9))
	L4_7 = A0_3._dt
	L4_7 = L4_7 + A2_5
	L5_8 = assert
	L6_9 = math
	L6_9 = L6_9.nice
	L6_9 = L6_9(L4_7)
	L5_8(L6_9, L6_9(L4_7))
	L5_8 = A0_3._scheduler_node
	L6_9 = L5_8
	L5_8 = L5_8.update
	L6_9 = L5_8(L6_9, A1_4, L4_7, ...)
	if L6_9 then
		A0_3._dt = 0
	else
		A0_3._dt = L4_7
	end
	return L5_8, L6_9
end
function UpdateSchedulerDtMethod.will_update(A0_10)
	return A0_10._scheduler_node:will_update()
end
