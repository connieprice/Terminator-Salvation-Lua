LocalUserStats = LocalUserStats or class()
function LocalUserStats.init(A0_0)
	local L1_1
end
function LocalUserStats.destroy(A0_2)
	local L1_3
end
function LocalUserStats.set_assigned_unit_and_stats(A0_4, A1_5, A2_6)
	assert(A2_6)
	if A0_4._listener then
		managers.action_event:unregister_listener(A0_4)
	end
	A0_4._listener = managers.action_event:register_listener(A0_4, nil, nil)
	A0_4._stats = A2_6
	A0_4._unit = A1_5
end
