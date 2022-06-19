WalkerAiBehavior = WalkerAiBehavior or class(CommonAiBehavior)
function WalkerAiBehavior.init_data(A0_0, A1_1)
	CommonAiBehavior.init_data(A0_0, A1_1)
end
function WalkerAiBehavior.logic_walker_behavior_aggressive_enter(A0_2, A1_3, A2_4, A3_5)
	A2_4:ai_data()._behavior.allowed_to_execute = true
	if CommonAiBehavior.logic_common_behavior_aggressive_enter then
		return CommonAiBehavior:logic_common_behavior_aggressive_enter(A1_3, A2_4, A3_5)
	end
end
function WalkerAiBehavior.logic_walker_behavior_aggressive(A0_6, A1_7, A2_8, A3_9, A4_10, A5_11, A6_12, A7_13)
	return CommonAiBehavior.logic_common_behavior_aggressive(A0_6, A1_7, A2_8, A3_9, A4_10, A5_11, A6_12, A7_13)
end
function WalkerAiBehavior.logic_walker_behavior_aggressive_exit(A0_14, A1_15, A2_16, A3_17)
	A2_16:ai_data()._behavior.allowed_to_execute = false
	if CommonAiBehavior.logic_common_behavior_aggressive_exit then
		return CommonAiBehavior:logic_common_behavior_aggressive_exit(A1_15, A2_16, A3_17)
	end
end
