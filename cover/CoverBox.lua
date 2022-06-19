if not CoverBox then
	CoverBox = class()
end
CoverBox.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._cover_planes = {}
	local l_1_4 = l_1_2:x()
	local l_1_5 = l_1_2:y()
	local l_1_6 = l_1_2:z()
	local l_1_7 = l_1_3.x
	local l_1_8 = l_1_3.y
	local l_1_9 = l_1_3.z
	local l_1_10 = math.dot(l_1_6, math.UP)
	local l_1_11 = 0.95
	if l_1_11 <= math.dot(l_1_4, math.UP) then
		Application:error("Not implemented yet")
	else
		if l_1_11 <= math.dot(l_1_5, math.UP) then
			Application:error("Not implemented yet")
		end
	else
		if l_1_11 <= math.dot(l_1_6, math.UP) then
			if tweak_data.cover.MIN_COVER_WIDTH <= l_1_8 * 2 then
				local l_1_12, l_1_13, l_1_15 = CoverPlane:new(l_1_1 + l_1_4 * l_1_7, l_1_4, l_1_8 * 2, l_1_9 * 2)
				l_1_13 = CoverPlane
				l_1_13, l_1_15 = l_1_13:new, l_1_13
				l_1_13 = l_1_13(l_1_15, l_1_1 - l_1_4 * l_1_7, -l_1_4, l_1_8 * 2, l_1_9 * 2)
				local l_1_14 = nil
			end
			local l_1_16 = l_1_7 * 2
		if tweak_data.cover.MIN_COVER_WIDTH <= l_1_16 then
			end
			l_1_16 = CoverPlane
			 -- DECOMPILER ERROR: Overwrote pending register.

			table.insert(l_1_0._cover_planes, l_1_16)
		end
	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		l_1_16:error("Not implemented yet")
	end
end

CoverBox.get_covers = function(l_2_0)
	return l_2_0._cover_planes
end

CoverBox.register = function(l_3_0, l_3_1, l_3_2)
	local l_3_6, l_3_7, l_3_8, l_3_9 = nil
	for i_0,i_1 in pairs(l_3_0._cover_planes) do
		l_3_1:register_cover(i_1, l_3_2)
	end
end

CoverBox.unregister = function(l_4_0, l_4_1)
	local l_4_5, l_4_6, l_4_7, l_4_8 = nil
	for i_0,i_1 in pairs(l_4_0._cover_planes) do
		l_4_1:unregister_cover(i_1)
	end
end


