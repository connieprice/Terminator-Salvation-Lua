FootstepSound = FootstepSound or class()
function FootstepSound.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	local L5_5, L6_6, L7_7, L8_8, L9_9
	A0_0._unit = A1_1
	A0_0._feet = A2_2
	A0_0._feet_objects = L5_5
	for L8_8, L9_9 in L5_5(L6_6) do
		A0_0._feet_objects[L8_8] = A0_0._unit:get_object(L9_9)
	end
	L5_5 = A3_3 or "footstep_sound"
	A0_0._decal = L5_5
end
function FootstepSound.destroy(A0_10)
	local L1_11
end
function FootstepSound.footstep(A0_12, A1_13, A2_14)
	local L3_15, L4_16, L5_17, L6_18, L7_19, L8_20, L9_21, L10_22
	L3_15 = A0_12._unit
	L4_16 = L3_15
	L3_15 = L3_15.mover
	L3_15 = L3_15(L4_16)
	if L3_15 then
		L3_15 = A0_12._unit
		L4_16 = L3_15
		L3_15 = L3_15.mover
		L3_15 = L3_15(L4_16)
		L4_16 = L3_15
		L3_15 = L3_15.standing
		L3_15 = L3_15(L4_16)
		if not L3_15 then
			return
		end
	end
	L3_15 = assert
	L4_16 = A1_13 and A2_14
	L3_15(L4_16)
	L3_15 = A0_12._feet_objects
	L3_15 = L3_15[A1_13]
	L5_17 = L3_15
	L4_16 = L3_15.position
	L4_16 = L4_16(L5_17)
	L5_17 = 70
	L6_18 = math
	L6_18 = L6_18.UP
	L6_18 = L6_18 * L5_17
	L6_18 = L4_16 - L6_18
	L7_19 = World
	L8_20 = L7_19
	L7_19 = L7_19.pick_decal_effect
	L9_21 = A0_12._decal
	L10_22 = L4_16
	L9_21 = L7_19(L8_20, L9_21, L10_22, L6_18, managers.slot:get_mask("footstep_decals"))
	if L7_19 and L7_19 ~= "" then
		L10_22 = "footstep_"
		L10_22 = L10_22 .. L7_19 .. "_" .. A2_14
		A0_12._unit:play(L10_22)
	end
end
