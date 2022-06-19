require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderChargeState")
SpiderRotateToChargeState = SpiderRotateToChargeState or class(SpiderState)
function SpiderRotateToChargeState.init(A0_0, A1_1, A2_2)
	SpiderState.init(A0_0, A1_1)
	A0_0._target_direction = A2_2:normalized()
	A0_0._enemy_data = A0_0._unit:enemy_data()
	A0_0:_set_can_move(false)
	A0_0:_set_can_rotate(false)
end
function SpiderRotateToChargeState.update(A0_3, A1_4)
	local L2_5, L3_6, L4_7, L5_8, L6_9, L7_10, L8_11, L9_12
	L2_5 = A0_3._base
	L3_6 = L2_5
	L2_5 = L2_5.check_fully_damaged
	L2_5 = L2_5(L3_6)
	if L2_5 then
		return L2_5
	end
	L3_6 = A0_3._unit
	L4_7 = A0_3._enemy_data
	L4_7 = L4_7.charging
	if L4_7 then
		L4_7 = SpiderChargeState
		L5_8 = L4_7
		L4_7 = L4_7.new
		L6_9 = L3_6
		return L4_7(L5_8, L6_9)
	else
		L4_7 = A0_3._enemy_data
		L4_7 = L4_7.ending_charge
		if L4_7 then
			L4_7 = SpiderEndingChargeState
			L5_8 = L4_7
			L4_7 = L4_7.new
			L6_9 = L3_6
			return L4_7(L5_8, L6_9)
		end
	end
	L4_7 = A0_3._unit
	L5_8 = L4_7
	L4_7 = L4_7.input
	L4_7 = L4_7(L5_8)
	L5_8 = L4_7
	L4_7 = L4_7.charge_direction
	L4_7 = L4_7(L5_8)
	A0_3._target_direction = L4_7
	L4_7 = "end_charge_normal"
	L5_8 = A0_3._target_direction
	if L5_8 then
		L5_8 = 7
		L7_10 = L3_6
		L6_9 = L3_6.rotation
		L6_9 = L6_9(L7_10)
		L8_11 = L6_9
		L7_10 = L6_9.y
		L7_10 = L7_10(L8_11)
		L8_11 = A0_3._target_direction
		L9_12 = L8_11
		L8_11 = L8_11.flat
		L8_11 = L8_11(L9_12, L6_9:z())
		L9_12 = L8_11
		L8_11 = L8_11.normalized
		L8_11 = L8_11(L9_12)
		L9_12 = L6_9.x
		L9_12 = L9_12(L6_9)
		if L5_8 >= math.acos(math.dot(L7_10, L8_11)) then
			L4_7 = "charge"
		elseif math.dot(L9_12, L8_11) > 0 then
			L4_7 = "rotate_right"
		else
			L4_7 = "rotate_left"
		end
	end
	L6_9 = L3_6
	L5_8 = L3_6.play_redirect
	L7_10 = L4_7
	L5_8(L6_9, L7_10)
end
