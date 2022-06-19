User = User or class()
function User.init(A0_0, A1_1)
	A0_0._local_user_index = A1_1
end
function User.local_user_index(A0_2)
	local L1_3
	L1_3 = A0_2._local_user_index
	return L1_3
end
function User.set_assigned_unit(A0_4, A1_5)
	A0_4._assigned_unit = A1_5
end
function User.release_assigned_unit(A0_6)
	local L1_7
	A0_6._assigned_unit = nil
end
function User.assigned_unit(A0_8)
	if not alive(A0_8._assigned_unit) then
		A0_8:release_assigned_unit()
		assert(not A0_8._assigned_unit)
	end
	return A0_8._assigned_unit
end
function User.update(A0_9, A1_10)
	if not alive(A0_9._assigned_unit) then
		A0_9:release_assigned_unit()
	end
end
