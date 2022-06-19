WeaponLogic = WeaponLogic or class()
function WeaponLogic.init(A0_0, A1_1, A2_2)
	A0_0._unit = A1_1
	A0_0._weapon = A2_2
	A0_0._weapon_data = A2_2:weapon_data()
	A0_0._fire_object = A2_2:get_object("fire")
	assert(A0_0._fire_object)
end
function WeaponLogic.update(A0_3, A1_4, A2_5, A3_6, A4_7, A5_8, A6_9)
end
function WeaponLogic._update_weapon_data(A0_10, A1_11, A2_12, A3_13, A4_14)
	local L5_15, L6_16
	L5_15 = A0_10._weapon_data
	L5_15.prepare_fire = A1_11
	L5_15.fire_input = A2_12
	L5_15.aim_target_position = A3_13
	L5_15.miss_dispersion = A4_14
	L6_16 = L5_15._reload_ready
	if L6_16 then
		L6_16 = L5_15._reload_required
		if L6_16 then
			L5_15._reload_request = true
		end
	end
end
function WeaponLogic._aiming_at_target(A0_17, A1_18, A2_19)
	local L3_20, L4_21, L5_22, L6_23
	if not A1_18 then
		L3_20 = false
		return L3_20
	end
	L3_20 = A0_17._fire_object
	L4_21 = assert
	L5_22 = L3_20
	L4_21(L5_22)
	L5_22 = L3_20
	L4_21 = L3_20.position
	L4_21 = L4_21(L5_22)
	L5_22 = mvector3
	L5_22 = L5_22.negate
	L6_23 = L4_21
	L5_22(L6_23)
	L5_22 = mvector3
	L5_22 = L5_22.add
	L6_23 = L4_21
	L5_22(L6_23, A1_18)
	L5_22 = mvector3
	L5_22 = L5_22.normalize
	L6_23 = L4_21
	L5_22 = L5_22(L6_23)
	if L5_22 > 0 then
		L6_23 = L3_20.rotation
		L6_23 = L6_23(L3_20)
		L6_23 = L6_23.y
		L6_23 = L6_23(L6_23)
		return A2_19 >= mvector3.angle(L4_21, L6_23)
	else
		L6_23 = false
		return L6_23
	end
end
