require("units/beings/machines/flyer/states/FlyerState")
FlyerAttackingState = FlyerAttackingState or class(FlyerState)
function FlyerAttackingState.init(A0_0, A1_1)
	FlyerState.init(A0_0, A1_1)
	A0_0._enemy_data = A1_1:enemy_data()
	A0_0._input = A1_1:input()
end
function FlyerAttackingState.enter(A0_2)
	A0_2._enemy_data.is_firing = true
end
function FlyerAttackingState.leave(A0_3)
	A0_3._enemy_data.is_firing = false
end
function FlyerAttackingState.update(A0_4, A1_5)
	local L2_6, L3_7
	L2_6 = A0_4._base
	L3_7 = L2_6
	L2_6 = L2_6.check_fully_damaged
	L2_6 = L2_6(L3_7)
	if L2_6 then
		return L2_6
	end
	L3_7 = A0_4._unit
	if A0_4._enemy_data.is_stunned then
		return FlyerStunState:new(L3_7, "attack")
	elseif A0_4._enemy_data.self_destroying then
		return FlyerSelfDestroyingState:new(L3_7)
	elseif not A0_4._enemy_data.attacking then
		return FlyerNormalState:new(L3_7)
	end
	if A0_4._enemy_data.stun_requested then
		L3_7:play_redirect("stun")
	elseif A0_4._input:self_destroy() then
		L3_7:play_redirect("self_destroy")
	else
		L3_7:play_redirect("offense")
	end
end
