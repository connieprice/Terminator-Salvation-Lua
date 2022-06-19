if not DualSphereSmoothPopController then
	DualSphereSmoothPopController = class()
end
DualSphereSmoothPopController.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._min_r = l_1_1
	l_1_0._indent = l_1_2
	l_1_0._ignore_unit = l_1_3
end

DualSphereSmoothPopController.wanted_position = function(l_2_0, l_2_1, l_2_2, l_2_3)
	local l_2_4 = 0.01
	local l_2_5, l_2_6 = nil, nil
	local l_2_7 = l_2_2 - l_2_1
	local l_2_8 = l_2_7:length()
	if l_2_8 <= l_2_4 then
		return l_2_1
	end
	local l_2_9 = 20
	local l_2_10 = 40
	local l_2_11 = l_2_7 / l_2_8
	local l_2_12 = 0
	local l_2_13 = l_2_1 - l_2_11 * l_2_12
	local l_2_14 = l_2_2
	local l_2_15 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if "ray" then
		table.insert(l_2_13, l_2_14)
		table.insert(l_2_15, l_2_0._ignore_unit)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_2_16 = World:raycast(unpack("ray_type"))
	local l_2_17 = 0
	local l_2_18 = l_2_1 - l_2_11 * l_2_17
	local l_2_19 = l_2_2
	local l_2_20 = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if "sphere_cast_radius" then
		table.insert(l_2_9, l_2_19)
		table.insert(l_2_20, l_2_0._ignore_unit)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_2_21 = World:raycast(unpack("ray_type"))
	if l_2_21 then
		local l_2_22 = nil
		if l_2_16 then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_2_23 = l_2_21.hit_position - l_2_21.position
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_2_24 = l_2_7:angle("sphere_cast_radius")
		local l_2_25 = assert
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_25(l_2_24 >= 0 and l_2_24 <= 90, l_2_10)
		l_2_25 = l_2_21.distance
		l_2_25 = l_2_25 - l_2_17
		l_2_25 = l_2_25 + l_2_10
		local l_2_28 = l_2_24 / 90
		local l_2_29 = l_2_28 * l_2_8 + (1 - l_2_28) * (l_2_25)
		l_2_29 = math.clamp(l_2_29, 0, l_2_22)
		l_2_6 = l_2_1 + l_2_29 * l_2_11
	else
		l_2_6 = l_2_2
	end
	l_2_0._last_distance = l_2_5
	return l_2_6
end


