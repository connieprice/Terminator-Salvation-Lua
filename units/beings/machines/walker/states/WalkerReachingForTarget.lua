require("units/beings/machines/walker/states/WalkerState")
require("units/beings/machines/walker/states/WalkerOnGround")
require("units/beings/machines/walker/states/WalkerConnected")
WalkerReachingForTarget = WalkerReachingForTarget or class(WalkerState)
function WalkerReachingForTarget.init(A0_0)
	local L1_1, L2_2, L3_3, L4_4, L5_5, L6_6
	L1_1 = WalkerState
	L1_1 = L1_1.init
	L2_2 = A0_0
	L1_1(L2_2)
	L1_1 = A0_0._unit
	L2_2 = A0_0._base
	L3_3 = L2_2._special_kill_target
	L4_4 = L2_2._special_kill_setup
	A0_0._target_unit = L3_3
	A0_0._special_kill_setup = L4_4
	L6_6 = L1_1
	L5_5 = L1_1.anim_state_machine
	L5_5 = L5_5(L6_6)
	L6_6 = L5_5.get_modifier
	L6_6 = L6_6(L5_5, "ik_left_hand")
	A0_0._ik_left_hand = L6_6
	L6_6 = L4_4.target_object_name
	A0_0._target_object = L3_3:get_object(L6_6)
	assert(A0_0._target_object)
	A0_0._enemy_data, L1_1:enemy_data().reaching_for_target = L1_1:enemy_data(), true
	L2_2:_set_override_transform(L2_2._special_kill_position, L2_2._special_kill_rotation)
end
function WalkerReachingForTarget.update(A0_7, A1_8)
	local L2_9, L3_10, L4_11, L5_12, L6_13
	L2_9 = A0_7._unit
	L3_10 = A0_7._enemy_data
	L4_11 = L3_10.reached_target
	if L4_11 then
		L4_11 = A0_7._special_kill_setup
		L5_12 = A0_7._target_unit
		L6_13 = L5_12
		L5_12 = L5_12.play_redirect
		L5_12 = L5_12(L6_13, L4_11.target_redirect)
		if L5_12 == "" or L5_12 == nil then
			L6_13 = L2_9.play_redirect
			L6_13(L2_9, "abort_reach")
		else
			L6_13 = L2_9.play_redirect
			L6_13(L2_9, L4_11.redirect)
		end
	else
		L4_11 = alive
		L5_12 = A0_7._target_unit
		L4_11 = L4_11(L5_12)
		if L4_11 then
			L4_11 = L3_10.reaching_for_target
			L4_11 = L4_11 or L3_10.reached_target
		elseif not L4_11 then
			L5_12 = L2_9
			L4_11 = L2_9.play_redirect
			L6_13 = "abort_reach"
			L4_11(L5_12, L6_13)
		end
	end
	L4_11 = A0_7._target_object
	L5_12 = assert
	L6_13 = L4_11
	L5_12(L6_13)
	L6_13 = L4_11
	L5_12 = L4_11.position
	L5_12 = L5_12(L6_13)
	L6_13 = L4_11.rotation
	L6_13 = L6_13(L4_11)
	A0_7._ik_left_hand:set_target_position(L5_12)
	A0_7._ik_left_hand:set_target_rotation(L6_13)
end
function WalkerReachingForTarget.exit(A0_14)
	A0_14._enemy_data.reaching_for_target = false
	A0_14._base:_set_override_transform(nil, nil)
end
function WalkerReachingForTarget.transition(A0_15)
	if A0_15._base:check_fully_damaged() then
		return (A0_15._base:check_fully_damaged())
	end
	if A0_15._enemy_data.connected then
		return WalkerConnected
	elseif not A0_15._enemy_data.special_kill then
		return WalkerOnGround
	end
end
