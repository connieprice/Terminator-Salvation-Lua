require("units/beings/machines/flyer/states/FlyerState")
if not FlyerAttackingState then
	FlyerAttackingState = class(FlyerState)
end
FlyerAttackingState.init = function(l_1_0, l_1_1)
	FlyerState.init(l_1_0, l_1_1)
	l_1_0._enemy_data = l_1_1:enemy_data()
	l_1_0._input = l_1_1:input()
end

FlyerAttackingState.enter = function(l_2_0)
	l_2_0._enemy_data.is_firing = true
end

FlyerAttackingState.leave = function(l_3_0)
	l_3_0._enemy_data.is_firing = false
end

FlyerAttackingState.update = function(l_4_0, l_4_1)
	local l_4_2 = l_4_0._base:check_fully_damaged()
	if l_4_2 then
		return l_4_2
	end
	local l_4_3 = l_4_0._unit
	local l_4_4 = l_4_0._input
	local l_4_5 = l_4_0._enemy_data
	if l_4_5.is_stunned then
		local l_4_6, l_4_7 = FlyerStunState:new, FlyerStunState
		local l_4_8 = l_4_3
		local l_4_9, l_4_13, l_4_17 = "attack"
		return l_4_6(l_4_7, l_4_8, l_4_9)
	elseif l_4_5.self_destroying then
		local l_4_10, l_4_11 = FlyerSelfDestroyingState:new, FlyerSelfDestroyingState
		local l_4_12 = l_4_3
		return l_4_10(l_4_11, l_4_12)
	elseif not l_4_5.attacking then
		local l_4_14, l_4_15 = FlyerNormalState:new, FlyerNormalState
		local l_4_16 = l_4_3
		return l_4_14(l_4_15, l_4_16)
	end
	if l_4_5.stun_requested then
		l_4_3:play_redirect("stun")
	else
		if l_4_4:self_destroy() then
			l_4_3:play_redirect("self_destroy")
		end
	else
		l_4_3:play_redirect("offense")
	end
end


