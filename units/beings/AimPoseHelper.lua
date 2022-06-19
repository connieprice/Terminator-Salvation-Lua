if not AimPoseHelper then
	AimPoseHelper = class()
end
AimPoseHelper.delta_yaw_and_pitch = function(l_1_0, l_1_1, l_1_2)
	local l_1_3 = l_1_2 - l_1_0
	local l_1_4 = l_1_3:flat(l_1_1:z()):normalized()
	if l_1_4:dot(l_1_1:x()) < 0 then
		local l_1_5 = -math.acos(l_1_4:dot(l_1_1:y()))
	end
	local l_1_6 = nil
	if l_1_3:flat(l_1_1:x()):normalized():dot(l_1_1:z()) < 0 then
		local l_1_7 = nil
	end
	return l_1_6, -math.acos(l_1_3:flat(l_1_1:x()):normalized():dot(l_1_1:y()))
end

AimPoseHelper.update_yaw_and_pitch = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6)
	l_2_1 = math.clamp(l_2_1, -l_2_3, l_2_3) / l_2_3
	l_2_2 = math.clamp(l_2_2, -l_2_4, l_2_4) / l_2_4
	local l_2_7 = l_2_0:get_global(l_2_5)
	local l_2_8 = l_2_0:get_global(l_2_6)
	local l_2_9 = math.clamp(l_2_7 + l_2_1, -1, 1)
	local l_2_10 = math.clamp(l_2_8 + l_2_2, -1, 1)
	l_2_0:set_global(l_2_5, l_2_9)
	l_2_0:set_global(l_2_6, l_2_10)
end

AimPoseHelper.update = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7, l_3_8, l_3_9, l_3_10)
	local l_3_11 = l_3_0:get_global(l_3_5)
	local l_3_12 = l_3_0:get_global(l_3_4)
	local l_3_13 = l_3_2:x()
	local l_3_14 = l_3_2:y()
	local l_3_15 = l_3_2:z()
	local l_3_16 = l_3_3 - l_3_1
	local l_3_17 = math.UP
	local l_3_18 = l_3_16:cross(l_3_17):normalized()
	local l_3_19 = l_3_17:cross(l_3_18)
	local l_3_20 = l_3_14:with_z(0):normalized()
	local l_3_21 = l_3_19:dot(l_3_20)
	if l_3_18:dot(l_3_20) > 0 then
		local l_3_22, l_3_23 = -math.acos(l_3_21)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_3_24 = nil
	local l_3_25 = nil
	local l_3_26 = nil
	if l_3_26:dot(l_3_15) < 0 then
		local l_3_27 = nil
	end
	local l_3_28 = nil
	if l_3_16:flat(l_3_15):normalized():dot(l_3_13) < 0 then
		local l_3_29 = -math.acos(l_3_16:rotate_with(Rotation(l_3_17, l_3_22)):flat(l_3_13):normalized():dot(l_3_14))
	end
	local l_3_30 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_3_11 < 0 then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_3_31 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_3_12 < 0 then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_3_10 then
		local l_3_32 = nil
	if l_3_10 < math.sqrt(-math.acos(l_3_16:flat(l_3_15):normalized():dot(l_3_14)) * -math.acos(l_3_16:flat(l_3_15):normalized():dot(l_3_14)) + l_3_30 * l_3_30) then
		end
		local l_3_33 = nil
		 -- DECOMPILER ERROR: Confused about usage of registers!

	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_3_34 = nil + l_3_32
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_3_30 < 0 then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_3_35 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_3_34 < 0 then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_0:set_global(l_3_5, nil)
	l_3_0:set_global(l_3_4, nil)
end

AimPoseHelper.update2 = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5, l_4_6, l_4_7, l_4_8, l_4_9, l_4_10, l_4_11, l_4_12, l_4_13, l_4_14, l_4_15)
	local l_4_16 = l_4_4 - l_4_2
	local l_4_17 = l_4_16:to_polar_with_reference(l_4_3:y(), l_4_3:z())
	local l_4_18 = l_4_17.pitch
	local l_4_19 = -l_4_17.spin
	if l_4_11 then
		local l_4_20 = math.sqrt(l_4_19 * l_4_19 + l_4_18 * l_4_18)
		if l_4_11 < l_4_20 then
			local l_4_21 = l_4_11 / l_4_20
			l_4_19 = l_4_19 * l_4_21
			l_4_18 = l_4_18 * l_4_21
		end
	else
		local l_4_22, l_4_23, l_4_25, l_4_28, l_4_31, l_4_32 = 100 * l_4_0
		l_4_23 = math
		l_4_23 = l_4_23.clamp
		l_4_25 = l_4_18
		l_4_28 = -l_4_22
		l_4_31 = l_4_22
		l_4_23 = l_4_23(l_4_25, l_4_28, l_4_31)
		local l_4_24, l_4_26, l_4_29 = nil
		l_4_25 = math
		l_4_25 = l_4_25.clamp
		l_4_28 = l_4_19
		l_4_31 = -l_4_22
		l_4_32 = l_4_22
		l_4_25 = l_4_25(l_4_28, l_4_31, l_4_32)
		local l_4_27, l_4_30 = nil
	end
	local l_4_33 = l_4_1:get_global(l_4_6)
	local l_4_34 = l_4_1:get_global(l_4_5)
	local l_4_37 = iff(l_4_33 < 0, l_4_33 * l_4_9, l_4_33 * l_4_10)
	l_4_19 = iff(l_4_34 < 0, l_4_34 * l_4_7, l_4_34 * l_4_8) + l_4_19
	local l_4_40 = nil
	local l_4_41 = math.clamp
	do
		l_4_41 = l_4_41(l_4_19, l_4_12 or -180, l_4_13 or 180)
		l_4_19 = l_4_41
		l_4_41 = math
		l_4_41 = l_4_41.clamp
		l_4_41 = l_4_41(l_4_18, l_4_14 or -180, l_4_15 or 180)
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_4_41 = math
		l_4_41 = l_4_41.clamp
		l_4_41 = l_4_41((l_4_18) / iff(l_4_18 < 0, l_4_9, l_4_10), -1, 1)
		l_4_1:set_global(l_4_6, l_4_41)
		l_4_1:set_global(l_4_5, math.clamp(l_4_19 / iff(l_4_19 < 0, l_4_7, l_4_8), -1, 1))
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

if not TestAimPoseHelper then
	TestAimPoseHelper = class()
end
TestAimPoseHelper.test_sign = function(l_5_0)
	l_5_0:compare_results(0, 0, Vector3(0, 0, 0), Rotation(0, 0, 0), Vector3(1, 0, 0), 45, 45, 45, 45, 10)
	l_5_0:compare_results(0, 0, Vector3(0, 0, 0), Rotation(0, 0, 0), Vector3(0, 1, 0), 45, 45, 45, 45, 10)
	l_5_0:compare_results(0, 0, Vector3(0, 0, 0), Rotation(0, 0, 0), Vector3(1, 1, 0), 45, 45, 45, 45, 10)
	l_5_0:compare_results(0, 0, Vector3(0, 0, 0), Rotation(0, 0, 0), Vector3(1, 0, 1), 45, 45, 45, 45, 10)
	l_5_0:compare_results(0, 0, Vector3(0, 0, 0), Rotation(0, 0, 0), Vector3(0, 1, 1), 45, 45, 45, 45, 10)
	l_5_0:compare_results(0, 0, Vector3(0, 0, 0), Rotation(0, 0, 0), Vector3(1, 1, 1), 45, 45, 45, 45, 10)
end

TestAimPoseHelper.compare_results = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4, l_6_5, l_6_6, l_6_7, l_6_8, l_6_9, l_6_10)
	local l_6_11 = {}
	l_6_11.get_global = function(l_7_0, l_7_1)
		return l_7_0[l_7_1]
  end
	l_6_11.set_global = function(l_8_0, l_8_1, l_8_2)
		l_8_0[l_8_1] = l_8_2
  end
	l_6_11.pitch = l_6_1
	l_6_11.yaw = l_6_2
	local l_6_12 = TableAlgorithms.copy(l_6_11)
	AimPoseHelper.update(l_6_11, l_6_3, l_6_4, l_6_5, "yaw", "pitch", l_6_6, l_6_7, l_6_8, l_6_9, l_6_10)
	AimPoseHelper.update2(l_6_12, l_6_3, l_6_4, l_6_5, "yaw", "pitch", l_6_6, l_6_7, l_6_8, l_6_9, l_6_10)
	print("---")
	print(l_6_12.pitch .. " " .. l_6_11.pitch)
	print(l_6_12.yaw .. " " .. l_6_11.yaw)
end


