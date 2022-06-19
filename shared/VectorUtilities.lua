if not VectorUtilities then
	VectorUtilities = class()
end
VectorUtilities.angle_constraint_direction = function(l_1_0, l_1_1, l_1_2)
	local l_1_3 = nil
	if l_1_2 < mvector3.angle(l_1_0, l_1_1) then
		local l_1_4 = nil
		local l_1_5 = nil
		l_1_3 = l_1_1:rotate_with(Rotation(l_1_1:cross(l_1_0), l_1_2))
	else
		l_1_3 = l_1_0
	end
	return l_1_3
end


