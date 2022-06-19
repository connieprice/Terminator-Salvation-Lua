require("units/beings/machines/walker/states/WalkerState")
require("units/beings/machines/walker/states/WalkerReachingForTarget")
require("units/beings/machines/walker/states/WalkerRequestingStun")
require("units/beings/machines/walker/states/WalkerStrikeOfDeath")
require("units/beings/machines/states/StunState")
WalkerOnGround = WalkerOnGround or class(WalkerState)
function WalkerOnGround.init(A0_0)
	WalkerState.init(A0_0)
	A0_0._enemy_data = A0_0._unit:enemy_data()
	A0_0._input = A0_0._unit:input()
end
function WalkerOnGround.update(A0_1, A1_2)
	local L2_3, L3_4, L4_5, L5_6
	L2_3 = A0_1._input
	L3_4 = A0_1._base
	L5_6 = L2_3
	L4_5 = L2_3.special_kill_target
	L4_5 = L4_5(L5_6)
	if L4_5 then
		L5_6 = L2_3.special_kill_id
		L5_6 = L5_6(L2_3)
		L3_4:special_kill(L5_6, L4_5, L2_3:special_kill_position(), L2_3:special_kill_rotation())
		return
	end
	L5_6 = L2_3.strike_of_death_direction
	L5_6 = L5_6(L2_3)
	if L5_6 then
		A0_1._unit:play_redirect(A0_1:_strike_of_death_setup(L5_6).redirect)
		L3_4._strike_of_death_target, L3_4._strike_of_death_setup = L2_3:strike_of_death_target(), A0_1:_strike_of_death_setup(L5_6)
	end
end
function WalkerOnGround.transition(A0_7)
	if A0_7._base:check_fully_damaged() then
		return (A0_7._base:check_fully_damaged())
	end
	if A0_7._enemy_data.reaching_for_target or A0_7._enemy_data.reached_target then
		assert(A0_7._base._special_kill_target)
		assert(A0_7._base._special_kill_setup)
		return WalkerReachingForTarget
	elseif A0_7._enemy_data.stun_requested then
		return WalkerRequestingStun
	elseif A0_7._enemy_data.strike_of_death then
		return WalkerStrikeOfDeath
	end
end
function WalkerOnGround._strike_of_death_setup(A0_8, A1_9)
	local L2_10, L3_11, L4_12
	L3_11 = A1_9
	L2_10 = A1_9.to_polar_with_reference
	L4_12 = A0_8._unit
	L4_12 = L4_12.rotation
	L4_12 = L4_12(L4_12)
	L4_12 = L4_12.y
	L4_12 = L4_12(L4_12)
	L2_10 = L2_10(L3_11, L4_12, math.UP)
	L3_11, L4_12 = nil, nil
	for 