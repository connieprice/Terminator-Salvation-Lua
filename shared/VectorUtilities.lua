VectorUtilities = VectorUtilities or class()
function VectorUtilities.angle_constraint_direction(A0_0, A1_1, A2_2)
	local L3_3, L4_4, L5_5, L6_6
	L4_4 = mvector3
	L4_4 = L4_4.angle
	L5_5 = A0_0
	L6_6 = A1_1
	L4_4 = L4_4(L5_5, L6_6)
	if A2_2 < L4_4 then
		L6_6 = A1_1
		L5_5 = A1_1.cross
		L5_5 = L5_5(L6_6, A0_0)
		L6_6 = Rotation
		L6_6 = L6_6(L5_5, A2_2)
		L3_3 = A1_1:rotate_with(L6_6)
	else
		L3_3 = A0_0
	end
	return L3_3
end
