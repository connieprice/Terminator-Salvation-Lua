if not WalkerAiBehavior then
	WalkerAiBehavior = class(CommonAiBehavior)
end
WalkerAiBehavior.init_data = function(l_1_0, l_1_1)
	CommonAiBehavior.init_data(l_1_0, l_1_1)
end

WalkerAiBehavior.logic_walker_behavior_aggressive_enter = function(l_2_0, l_2_1, l_2_2, l_2_3)
	local l_2_4 = l_2_2:ai_data()
	l_2_4._behavior.allowed_to_execute = true
	if CommonAiBehavior.logic_common_behavior_aggressive_enter then
		local l_2_5, l_2_6 = CommonAiBehavior:logic_common_behavior_aggressive_enter, CommonAiBehavior
		local l_2_7 = l_2_1
		local l_2_8 = l_2_2
		local l_2_9 = l_2_3
		return l_2_5(l_2_6, l_2_7, l_2_8, l_2_9)
	end
end

WalkerAiBehavior.logic_walker_behavior_aggressive = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7)
	local l_3_8 = CommonAiBehavior.logic_common_behavior_aggressive
	local l_3_9 = l_3_0
	local l_3_10 = l_3_1
	local l_3_11 = l_3_2
	local l_3_12 = l_3_3
	local l_3_13 = l_3_4
	local l_3_14 = l_3_5
	local l_3_15 = l_3_6
	local l_3_16 = l_3_7
	return l_3_8(l_3_9, l_3_10, l_3_11, l_3_12, l_3_13, l_3_14, l_3_15, l_3_16)
end

WalkerAiBehavior.logic_walker_behavior_aggressive_exit = function(l_4_0, l_4_1, l_4_2, l_4_3)
	local l_4_4 = l_4_2:ai_data()
	l_4_4._behavior.allowed_to_execute = false
	if CommonAiBehavior.logic_common_behavior_aggressive_exit then
		local l_4_5, l_4_6 = CommonAiBehavior:logic_common_behavior_aggressive_exit, CommonAiBehavior
		local l_4_7 = l_4_1
		local l_4_8 = l_4_2
		local l_4_9 = l_4_3
		return l_4_5(l_4_6, l_4_7, l_4_8, l_4_9)
	end
end


