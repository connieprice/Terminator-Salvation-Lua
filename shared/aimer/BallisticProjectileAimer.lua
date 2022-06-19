require("shared/aimer/Aimer")
BallisticProjectileAimer = BallisticProjectileAimer or class(Aimer)
function BallisticProjectileAimer.init(A0_0, A1_1)
	local L2_2
	L2_2 = assert
	L2_2(A1_1)
	L2_2 = A1_1.initial_speed
	assert(L2_2)
	A0_0._initial_speed = L2_2
	A0_0._squared_initial_speed = L2_2 * L2_2
	A0_0._gravity = math.abs(World:gravity().z)
end
function BallisticProjectileAimer.aim_position(A0_3, A1_4, A2_5)
	local L3_6, L4_7, L5_8, L6_9, L7_10, L8_11, L9_12
	L3_6 = A2_5 - A1_4
	L5_8 = L3_6
	L4_7 = L3_6.flat
	L6_9 = math
	L6_9 = L6_9.UP
	L4_7 = L4_7(L5_8, L6_9)
	L6_9 = L3_6
	L5_8 = L3_6.length
	L5_8 = L5_8(L6_9)
	L6_9 = math
	L6_9 = L6_9.asin
	L7_10 = A0_3._gravity
	L7_10 = L7_10 * L5_8
	L8_11 = A0_3._squared_initial_speed
	L7_10 = L7_10 / L8_11
	L6_9 = L6_9(L7_10)
	L6_9 = L6_9 / 2
	L7_10 = math
	L7_10 = L7_10.acos
	L8_11 = math
	L8_11 = L8_11.dot
	L9_12 = L3_6.normalized
	L9_12 = L9_12(L3_6)
	L9_12 = L8_11(L9_12, L4_7:normalized())
	L7_10 = L7_10(L8_11, L9_12, L8_11(L9_12, L4_7:normalized()))
	L8_11 = L3_6.z
	if L8_11 < 0 then
		L7_10 = -L7_10
	end
	L6_9 = L6_9 + L7_10
	L8_11 = math
	L8_11 = L8_11.cross
	L9_12 = L4_7
	L8_11 = L8_11(L9_12, math.UP)
	L9_12 = L8_11
	L8_11 = L8_11.normalized
	L8_11 = L8_11(L9_12)
	L9_12 = Rotation
	L9_12 = L9_12(L8_11, L6_9)
	return A1_4 + L4_7:rotate_with(L9_12)
end
