require("units/beings/machines/flyer/states/FlyerState")
require("units/beings/machines/flyer/states/FlyerFullyDamagedState")
require("units/beings/machines/flyer/states/FlyerStunState")
require("units/beings/machines/flyer/states/FlyerAttackingState")
require("units/beings/machines/flyer/states/FlyerSelfDestroyingState")
FlyerNormalState = FlyerNormalState or class(FlyerState)
function FlyerNormalState.init(A0_0, A1_1)
	FlyerState.init(A0_0, A1_1)
	A0_0._enemy_data = A0_0._unit:enemy_data()
	A0_0._input = A1_1:input()
end
function FlyerNormalState.update(A0_2, A1_3)
	local L2_4, L3_5
	L2_4 = A0_2._base
	L3_5 = L2_4
	L2_4 = L2_4.check_fully_damaged
	L2_4 = L2_4(L3_5)
	if L2_4 then
		return L2_4
	end
	L3_5 = A0_2._unit
	if A0_2._enemy_data.is_stunned then
		return FlyerStunState:new(L3_5, "patrol")
	elseif A0_2._enemy_data.attacking then
		return FlyerAttackingState:new(L3_5)
	elseif A0_2._enemy_data.self_destroying then
		return FlyerSelfDestroyingState:new(L3_5)
	end
	if A0_2._enemy_data.stun_requested then
		L3_5:play_redirect("stun")
	elseif A0_2._input:fire() and A0_2._enemy_data.can_shoot then
		L3_5:play_redirect("enter_attack")
	elseif A0_2._input:self_destroy() or A0_2._enemy_data.debug_force_self_destroy then
		L3_5:play_redirect("self_destroy")
	end
end
