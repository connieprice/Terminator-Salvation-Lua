require("units/beings/machines/walker/states/WalkerState")
require("units/beings/machines/walker/states/WalkerOnGround")
WalkerConnected = WalkerConnected or class(WalkerState)
function WalkerConnected.init(A0_0)
	local L1_1, L2_2, L3_3, L4_4
	L1_1 = WalkerState
	L1_1 = L1_1.init
	L2_2 = A0_0
	L1_1(L2_2)
	L1_1 = A0_0._base
	L2_2 = L1_1._enemy_data
	A0_0._enemy_data = L2_2
	L2_2 = L1_1._special_kill_target
	L3_3 = L1_1._special_kill_setup
	L4_4 = L3_3.target_object_name
	L2_2:base():dynamic_link(L4_4, A0_0._unit, WalkerBase._CONNECT_ALIGN_NAME)
	A0_0._target_unit = L2_2
	A0_0._enemy_data.connected_to_target = true
	L1_1:_set_override_transform(L1_1._special_kill_position, L1_1._special_kill_rotation)
end
function WalkerConnected.exit(A0_5)
	local L1_6, L2_7
	L1_6 = A0_5._enemy_data
	L1_6.connected_to_target = false
	L2_7 = A0_5._target_unit
	if alive(L2_7) then
		L2_7:base():unlink()
	end
	A0_5._base:_set_override_transform(nil, nil)
end
function WalkerConnected.transition(A0_8)
	if not A0_8._enemy_data.connected then
		return WalkerOnGround
	end
end
