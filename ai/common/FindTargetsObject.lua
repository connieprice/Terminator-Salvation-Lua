local L0_0
L0_0 = FindTargetObject
if not L0_0 then
	L0_0 = class
	L0_0 = L0_0()
end
FindTargetObject = L0_0
L0_0 = FindTargetObject
function L0_0.init(A0_1, A1_2)
	A0_1._ai_data = A1_2:ai_data()
	A0_1._unit = A1_2
	IntelUtilities.ai_update_eyes(A1_2)
	A0_1:_setup_eyes()
	A0_1._world_slot_mask = managers.slot:get_mask("visibility_blockers")
	A0_1._enemy_slot_mask = managers.slot:get_mask(A1_2:ai_data().input.enemy_slot_mask)
	A0_1._unit_visibility_query = A1_2:visibility_query()
	A0_1._hit_callback = callback(A0_1, A0_1, "hit_callback")
	A0_1._passed_callback = callback(A0_1, A0_1, "passed_callback")
	A0_1:reset_query()
end
L0_0 = false
function FindTargetObject.start_query(A0_3, A1_4)
	local L2_5, L3_6, L4_7, L5_8, L6_9, L7_10, L8_11, L9_12, L10_13, L11_14, L12_15, L13_16, L14_17, L15_18, L16_19, L17_20, L18_21, L19_22
	L3_6 = A0_3
	L2_5 = A0_3.reset_query
	L2_5(L3_6)
	L3_6 = A0_3
	L2_5 = A0_3._setup_eyes
	L2_5(L3_6)
	L2_5 = World
	L3_6 = L2_5
	L2_5 = L2_5.find_units_quick
	L4_7 = "sphere"
	L5_8 = A1_4
	L6_9 = A0_3._max_range
	L7_10 = A0_3._enemy_slot_mask
	L2_5 = L2_5(L3_6, L4_7, L5_8, L6_9, L7_10)
	L3_6, L4_7, L5_8, L6_9, L7_10 = nil, nil, nil, nil, nil
	L8_11 = math
	L8_11 = L8_11.UP
	for L12_15, L13_16 in L9_12(L10_13) do
		L4_7 = L14_17
		if L4_7 then
		elseif L14_17 then
			L3_6 = L14_17
			if L14_17 then
			elseif L14_17 then
				L5_8 = L14_17
				for L17_20, L18_21 in L14_17(L15_18) do
					L19_22 = A0_3._unit_eyes
					L19_22 = #L19_22
					if L19_22 ~= 1 then
						L19_22 = mvector3
						L19_22 = L19_22.distance
						L19_22 = L19_22(L3_6, L18_21.position)
					else
						if L19_22 < L18_21.range then
							L19_22 = L18_21.position
							L6_9 = L3_6 - L19_22
							L19_22 = L6_9.to_polar_with_reference
							L19_22 = L19_22(L6_9, L18_21.forward, L8_11)
							L7_10 = L19_22
							L19_22 = math
							L19_22 = L19_22.abs
							L19_22 = L19_22(L7_10.spin)
							if L19_22 < L18_21.half_fov then
								L19_22 = math
								L19_22 = L19_22.abs
								L19_22 = L19_22(L7_10.pitch)
								if L19_22 < L18_21.half_zfov then
									if L5_8 then
										L19_22 = L5_8.primary_target_position
										L19_22 = L19_22(L5_8)
										L3_6 = L19_22
									else
										L19_22 = L13_16.oobb
										L19_22 = L19_22(L13_16)
										L19_22 = L19_22.center
										L19_22 = L19_22(L19_22)
										L3_6 = L19_22
									end
									L19_22 = _UPVALUE0_
									if L19_22 then
										L19_22 = World
										L19_22 = L19_22.issue_raycast
										L19_22 = L19_22(L19_22, A0_3._hit_callback, "ray", L18_21.position, L3_6, "passed", A0_3._passed_callback, "slot_mask", A0_3._world_slot_mask, "ignore_unit", A0_3._unit)
										A0_3._ray_targets[L19_22] = L13_16
										A0_3._waiting_for_ray_casts = A0_3._waiting_for_ray_casts + 1
									else
										L19_22 = A0_3._ray_targets
										L19_22[1] = L13_16
										A0_3._waiting_for_ray_casts = 1
										L19_22 = World
										L19_22 = L19_22.raycast
										L19_22 = L19_22(L19_22, "ray", L18_21.position, L3_6, "slot_mask", A0_3._world_slot_mask)
										A0_3._hit_callback(1, L19_22)
									end
								end
							end
					end
					else
					end
				end
			end
		end
	end
	if L9_12 then
		L9_12(L10_13, L11_14)
	end
end
function FindTargetObject.is_query_done(A0_23)
	return A0_23._waiting_for_ray_casts == 0
end
function FindTargetObject.reset_query(A0_24)
	local L1_25
	L1_25 = {}
	A0_24._targets = L1_25
	L1_25 = {}
	A0_24._ray_targets = L1_25
	A0_24._waiting_for_ray_casts = 0
end
function FindTargetObject.get_result(A0_26)
	local L1_27
	L1_27 = A0_26._targets
	return L1_27
end
function FindTargetObject.hit_callback(A0_28, A1_29, A2_30)
	local L3_31
	L3_31 = A0_28._waiting_for_ray_casts
	if L3_31 == 0 then
		return
	end
	L3_31 = A0_28._waiting_for_ray_casts
	L3_31 = L3_31 - 1
	A0_28._waiting_for_ray_casts = L3_31
	if not A2_30 then
		L3_31 = A0_28._ray_targets
		L3_31 = L3_31[A1_29]
		assert(L3_31)
		if alive(L3_31) then
			A0_28._targets[L3_31:key()] = L3_31
		end
	end
end
function FindTargetObject.passed_callback(A0_32, A1_33, A2_34)
end
function FindTargetObject._setup_eyes(A0_35)
	assert(A0_35._ai_data.current_unit_eyes)
	if A0_35._unit_eyes ~= A0_35._ai_data.current_unit_eyes then
		A0_35._unit_eyes = A0_35._ai_data.current_unit_eyes
		for 