require("units/beings/machines/flyer/states/FlyerState")
require("units/beings/machines/flyer/states/FlyerFullyDamagedState")
require("units/beings/machines/flyer/states/FlyerStunState")
require("units/beings/machines/flyer/states/FlyerAttackingState")
require("units/beings/machines/flyer/states/FlyerSelfDestroyingState")
if not FlyerNormalState then
	FlyerNormalState = class(FlyerState)
end
FlyerNormalState.init = function(l_1_0, l_1_1)
	FlyerState.init(l_1_0, l_1_1)
	l_1_0._enemy_data = l_1_0._unit:enemy_data()
	l_1_0._input = l_1_1:input()
end

FlyerNormalState.update = function(l_2_0, l_2_1)
	local l_2_2 = l_2_0._base:check_fully_damaged()
	if l_2_2 then
		return l_2_2
	end
	local l_2_3 = l_2_0._unit
	local l_2_4 = l_2_0._enemy_data
	if l_2_4.is_stunned then
		local l_2_5, l_2_6 = FlyerStunState:new, FlyerStunState
		local l_2_7 = l_2_3
		local l_2_8, l_2_12, l_2_16 = "patrol"
		return l_2_5(l_2_6, l_2_7, l_2_8)
	elseif l_2_4.attacking then
		local l_2_9, l_2_10 = FlyerAttackingState:new, FlyerAttackingState
		local l_2_11 = l_2_3
		return l_2_9(l_2_10, l_2_11)
	elseif l_2_4.self_destroying then
		local l_2_13, l_2_14 = FlyerSelfDestroyingState:new, FlyerSelfDestroyingState
		local l_2_15 = l_2_3
		return l_2_13(l_2_14, l_2_15)
	end
	local l_2_17 = l_2_0._input
	if l_2_4.stun_requested then
		l_2_3:play_redirect("stun")
	else
		if l_2_17:fire() and l_2_4.can_shoot then
			l_2_3:play_redirect("enter_attack")
		end
	else
		if l_2_17:self_destroy() or l_2_4.debug_force_self_destroy then
			l_2_3:play_redirect("self_destroy")
		end
	end
end


