local L0_0
L0_0 = require
L0_0("units/beings/machines/walker/effects/WalkerEffects")
L0_0 = MetalWalkerEffects
if not L0_0 then
	L0_0 = class
	L0_0 = L0_0(WalkerEffects)
end
MetalWalkerEffects = L0_0
L0_0 = "Head"
function MetalWalkerEffects.init(A0_1, A1_2)
	WalkerEffects.init(A0_1, A1_2)
	A0_1._damage_data = A1_2:damage_data()
	A0_1._head_body = A1_2:get_object(_UPVALUE0_)
	assert(A0_1._head_body, _UPVALUE0_)
	A0_1._chest_body = A1_2:get_object(_UPVALUE1_)
	assert(A0_1._chest_body, _UPVALUE1_)
end
function MetalWalkerEffects.unit_explode(A0_3, A1_4, A2_5, A3_6)
	local L4_7, L5_8, L6_9, L7_10, L8_11, L9_12
	L5_8 = A1_4
	L4_7 = A1_4.position
	L4_7 = L4_7(L5_8)
	L4_7 = L4_7 - A2_5
	L5_8 = A0_3._damage_data
	L6_9 = L5_8.damage
	L7_10 = L5_8.health
	L6_9 = L6_9 / L7_10
	if L6_9 > 0.5 then
		L7_10 = A0_3._head_body
		L8_11 = L7_10
		L7_10 = L7_10.position
		L7_10 = L7_10(L8_11)
		L7_10 = A2_5 - L7_10
		L8_11 = L7_10
		L7_10 = L7_10.length
		L7_10 = L7_10(L8_11)
		L8_11 = A0_3._chest_body
		L9_12 = L8_11
		L8_11 = L8_11.position
		L8_11 = L8_11(L9_12)
		L8_11 = A2_5 - L8_11
		L9_12 = L8_11
		L8_11 = L8_11.length
		L8_11 = L8_11(L9_12)
		L7_10 = L7_10 < L8_11
		if L7_10 then
			L8_11 = A0_3._head_damaged
			if not L8_11 then
				A0_3._head_damaged = true
				L8_11 = math
				L8_11 = L8_11.random
				L9_12 = 1
				L8_11 = L8_11(L9_12, #_UPVALUE0_)
				L9_12 = _UPVALUE0_
				L9_12 = L9_12[L8_11]
				assert(L9_12)
				A0_3:_play_effect(L9_12)
			end
		else
			L8_11 = A0_3._chest_damaged
			if not L8_11 then
				A0_3._chest_damaged = true
				L9_12 = A1_4
				L8_11 = A1_4.rotation
				L8_11 = L8_11(L9_12)
				L9_12 = L8_11
				L8_11 = L8_11.y
				L8_11 = L8_11(L9_12)
				L9_12 = mvector3
				L9_12 = L9_12.dot
				L9_12 = L9_12(L4_7, L8_11)
				L9_12 = L9_12 < 0
				if L9_12 then
					A0_3:_play_effect(_UPVALUE1_)
				else
					A0_3:_play_effect(_UPVALUE2_)
				end
			end
		end
	end
end
