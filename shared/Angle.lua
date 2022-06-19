if not Angle then
	Angle = class()
end
angle_constrain = function(l_1_0)
		return l_1_0 % 360
  end
angle_diff = function(l_2_0, l_2_1)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if angle_constrain(l_2_0) - angle_constrain(l_2_1) < 0 then
		local l_2_2 = angle_constrain(l_2_0) - angle_constrain(l_2_1) + 360
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_2_2
end

angle_to_signed = function(l_3_0)
	if l_3_0 > 180 then
		l_3_0 = l_3_0 - 360
	end
	return l_3_0
end

angle_from_signed = function(l_4_0)
	if l_4_0 < 0 then
		l_4_0 = l_4_0 + 360
	end
	return l_4_0
end


