require("units/beings/machines/walker/states/WalkerState")
require("units/beings/machines/walker/states/WalkerOnGround")
require("units/beings/machines/walker/states/WalkerConnected")
WalkerIkTest = WalkerIkTest or class()
function WalkerIkTest.init(A0_0, A1_1)
	A0_0._ik = A1_1:anim_state_machine():get_modifier("ik_left_hand")
end
function WalkerIkTest.update(A0_2, A1_3, A2_4, A3_5)
	local L4_6, L5_7, L6_8, L7_9, L8_10, L9_11
	L4_6 = World
	L5_7 = L4_6
	L4_6 = L4_6.find_units_quick
	L6_8 = "all"
	L7_9 = managers
	L7_9 = L7_9.slot
	L8_10 = L7_9
	L7_9 = L7_9.get_mask
	L9_11 = "players"
	L9_11 = L7_9(L8_10, L9_11)
	L4_6 = L4_6(L5_7, L6_8, L7_9, L8_10, L9_11, L7_9(L8_10, L9_11))
	L5_7 = #L4_6
	if L5_7 == 0 then
		return
	end
	L5_7 = next
	L6_8 = L4_6
	L7_9 = nil
	L6_8 = L5_7(L6_8, L7_9)
	L8_10 = L6_8
	L7_9 = L6_8.get_object
	L9_11 = "a_neck_grip"
	L7_9 = L7_9(L8_10, L9_11)
	L8_10 = assert
	L9_11 = L7_9
	L8_10(L9_11)
	L9_11 = L7_9
	L8_10 = L7_9.position
	L8_10 = L8_10(L9_11)
	L9_11 = L7_9.rotation
	L9_11 = L9_11(L7_9)
	A0_2._ik:set_target_position(L8_10)
	Draw:brush():sphere(L8_10, 10)
	A0_2._ik:set_target_rotation(L9_11)
end
