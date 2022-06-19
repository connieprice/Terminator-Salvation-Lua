Angle = Angle or class()
function angle_constrain(A0_0)
	return A0_0 % 360
end
function angle_diff(A0_1, A1_2)
	return angle_constrain(A0_1) - angle_constrain(A1_2) + 360
end
function angle_to_signed(A0_3)
	local L1_4
	if A0_3 > 180 then
		A0_3 = A0_3 - 360
	end
	return A0_3
end
function angle_from_signed(A0_5)
	local L1_6
	if A0_5 < 0 then
		A0_5 = A0_5 + 360
	end
	return A0_5
end
