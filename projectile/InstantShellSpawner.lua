require("projectile/ProjectileSpawner")
require("projectile/InstantBullet")
InstantShellSpawner = InstantShellSpawner or class(ProjectileSpawner)
function InstantShellSpawner.init(A0_0, A1_1)
	ProjectileSpawner.init(A1_1)
	A0_0.slot_mask = managers.slot:get_mask(A0_0._slot_mask)
	A0_0._unit = A1_1
	A0_0._spread = 0
	A0_0._range = 0
	A0_0._near_damage_threshold = 0
	A0_0._near_damage = 0
	A0_0._far_damage_threshold = 0
	A0_0._far_damage = 0
	A0_0._slot_mask = nil
	A0_0._tracer_fx = nil
	A0_0._decal = nil
	A0_0._damage = nil
	A0_0._emitter = managers.action_event:create_emitter(A1_1)
	A0_0._unit_map = {}
end
function InstantShellSpawner.destroy(A0_2)
	A0_2._emitter:destroy()
end
function InstantShellSpawner.spawn_projectile(A0_3, A1_4, A2_5, A3_6)
	local L4_7, L5_8, L6_9, L7_10, L8_11, L9_12, L10_13, L11_14, L12_15, L13_16, L14_17, L15_18, L16_19, L17_20, L18_21, L19_22, L20_23, L21_24, L22_25, L23_26, L24_27, L25_28, L26_29, L27_30
	L4_7 = assert
	L5_8 = A0_3._damage
	L4_7(L5_8)
	A0_3._spawning_unit = A1_4
	L4_7 = A0_3._inflictor_type
	L5_8 = alive
	L6_9 = A1_4
	L5_8 = L5_8(L6_9)
	if L5_8 then
		L6_9 = A1_4
		L5_8 = A1_4.control
		L5_8 = L5_8(L6_9)
		L6_9 = L5_8
		L5_8 = L5_8.is_human_controlled
		L5_8 = L5_8(L6_9)
		if L5_8 then
			L5_8 = "player_"
			L6_9 = A0_3._inflictor_type
			L4_7 = L5_8 .. L6_9
		end
	end
	L5_8 = A2_5
	L7_10 = A3_6
	L6_9 = A3_6.y
	L6_9 = L6_9(L7_10)
	L7_10 = A0_3._range
	L6_9 = L6_9 * L7_10
	L6_9 = L5_8 + L6_9
	L7_10 = L6_9 - L5_8
	L9_12 = L7_10
	L8_11 = L7_10.dot
	L10_13 = L7_10
	L8_11 = L8_11(L9_12, L10_13)
	L9_12 = math
	L9_12 = L9_12.tan
	L10_13 = A0_3._spread
	L9_12 = L9_12(L10_13)
	L10_13 = A0_3._range
	L10_13 = L9_12 * L10_13
	L11_14 = World
	L11_14 = L11_14.find_bodies
	L16_19 = L6_9
	L27_30 = L18_21(L19_22, L20_23)
	L11_14 = L11_14(L12_15, L13_16, L14_17, L15_18, L16_19, L17_20, L18_21, L19_22, L20_23, L21_24, L22_25, L23_26, L24_27, L25_28, L26_29, L27_30, L18_21(L19_22, L20_23))
	for L15_18, L16_19 in L12_15(L13_16) do
		if L17_20 then
			if L17_20 then
				L22_25 = L16_19
				L21_24 = L16_19.position
				L21_24 = L21_24(L22_25)
				L22_25 = "passed"
				L23_26 = callback
				L24_27 = A0_3
				L25_28 = A0_3
				L26_29 = "add_body"
				L23_26 = L23_26(L24_27, L25_28, L26_29)
				L24_27 = "slot_mask"
				L25_28 = managers
				L25_28 = L25_28.slot
				L26_29 = L25_28
				L25_28 = L25_28.get_mask
				L27_30 = "shootable_wo_adr_shield"
				L27_30 = L25_28(L26_29, L27_30)
				if L17_20 then
					if L18_21 == L16_19 then
						L18_21(L19_22, L20_23)
					end
				end
			end
		end
	end
	for L15_18, L16_19 in L12_15(L13_16) do
		for L20_23, L21_24 in L17_20(L18_21) do
			L22_25 = L21_24.ray
			L22_25 = L22_25.body
			L21_24.damage_ratio = 0
			L24_27 = L22_25
			L23_26 = L22_25.extension
			L23_26 = L23_26(L24_27)
			if L23_26 then
				L24_27 = L22_25
				L23_26 = L22_25.extension
				L23_26 = L23_26(L24_27)
				L23_26 = L23_26.damage
				if L23_26 then
					L24_27 = L22_25
					L23_26 = L22_25.oobb
					L23_26 = L23_26(L24_27)
					L24_27 = math
					L24_27 = L24_27.clamp
					L26_29 = L7_10
					L25_28 = L7_10.dot
					L27_30 = L23_26.center
					L27_30 = L27_30(L23_26)
					L27_30 = L27_30 - L5_8
					L25_28 = L25_28(L26_29, L27_30)
					L25_28 = L25_28 / L8_11
					L26_29 = 0
					L27_30 = 1
					L24_27 = L24_27(L25_28, L26_29, L27_30)
					L25_28 = L7_10 * L24_27
					L25_28 = L5_8 + L25_28
					L26_29 = A0_3._range
					L26_29 = L9_12 * L26_29
					L26_29 = L26_29 * L24_27
					if L26_29 > 0 then
						L27_30 = L23_26.center
						L27_30 = L27_30(L23_26)
						if mvector3.distance(L25_28, L27_30) < (L23_26:size().x + L23_26:size().y + L23_26:size().z) / 3 + L26_29 then
							if L26_29 > (L23_26:size().x + L23_26:size().y + L23_26:size().z) / 3 then
								L21_24.damage_ratio = math.clamp((L26_29 + (L23_26:size().x + L23_26:size().y + L23_26:size().z) / 3 - mvector3.distance(L25_28, L27_30)) / (2 * ((L23_26:size().x + L23_26:size().y + L23_26:size().z) / 3)), 0, 1) * ((L23_26:size().x + L23_26:size().y + L23_26:size().z) / 3 / L26_29)
							else
								L21_24.damage_ratio = math.clamp((L26_29 + (L23_26:size().x + L23_26:size().y + L23_26:size().z) / 3 - mvector3.distance(L25_28, L27_30)) / (2 * L26_29), 0, 1)
							end
							L16_19.total_ratio = L16_19.total_ratio + L21_24.damage_ratio
						end
					end
				end
			end
		end
	end
	for L16_19, L17_20 in L13_16(L14_17) do
		for L21_24, L22_25 in L18_21(L19_22) do
			L23_26 = L22_25.ray
			L25_28 = A0_3
			L24_27 = A0_3.apply_damage
			L26_29 = L23_26.body
			L27_30 = L23_26
			L24_27 = L24_27(L25_28, L26_29, L27_30, L22_25.damage_ratio / math.max(1, L17_20.total_ratio))
			if L24_27 > 0 then
				L25_28 = A0_3
				L24_27 = A0_3.apply_push
				L26_29 = L17_20.unit
				L27_30 = L23_26.ray
				L24_27(L25_28, L26_29, L27_30)
			end
			if L12_15 > 0 then
				L25_28 = A0_3
				L24_27 = A0_3.play_effect
				L26_29 = L23_26
				L24_27(L25_28, L26_29)
			end
		end
	end
	while L12_15 > 0 do
		L16_19 = A2_5
		L21_24 = "shootable_wo_adr_shield"
		L21_24 = A1_4
		if L13_16 then
			L16_19 = L13_16
			L14_17(L15_18, L16_19)
		end
	end
	A0_3._unit_map = L13_16
	return L13_16
end
function InstantShellSpawner.apply_damage(A0_31, A1_32, A2_33, A3_34)
	if alive(A1_32) and A1_32:extension() and A1_32:extension().damage then
		assert(A0_31:calculate_damage(A2_33.distance, A2_33.body) >= 0)
		assert(A0_31._damage)
		A0_31._damage.damage_factor = A0_31:calculate_damage(A2_33.distance, A2_33.body) * A3_34
		A0_31._damage.inflictor_type = A0_31._inflictor_type
		return A1_32:extension().damage:faith_damage(A0_31._spawning_unit, A2_33.normal, A2_33.position, A2_33.ray, A0_31._damage)
	end
	return 0
end
function InstantShellSpawner.apply_push(A0_35, A1_36, A2_37)
	if A1_36:physics() then
		A1_36:physics():push(0.01, 10000 * A2_37)
	end
end
function InstantShellSpawner.calculate_damage(A0_38, A1_39, A2_40)
	local L3_41
	L3_41 = A0_38._far_damage_threshold
	if A1_39 > L3_41 then
		L3_41 = A0_38._far_damage
		return L3_41
	else
		L3_41 = A0_38._near_damage_threshold
		if A1_39 > L3_41 then
			L3_41 = A0_38._far_damage
			L3_41 = 1 - L3_41
			assert(L3_41 >= 0)
			assert(A0_38._far_damage_threshold - A0_38._near_damage_threshold >= 0)
			return 1 - L3_41 * ((A1_39 - A0_38._near_damage_threshold) / (A0_38._far_damage_threshold - A0_38._near_damage_threshold))
		else
			L3_41 = 1
			return L3_41
		end
	end
end
function InstantShellSpawner.play_effect(A0_42, A1_43)
	local L2_44
	L2_44 = A1_43.ray
	L2_44 = L2_44 - A1_43.normal * A1_43.ray:dot(A1_43.normal) * 2
	if World:project_decal(A0_42._decal, A1_43.position, A1_43.ray, L2_44, A1_43.normal) and World:project_decal(A0_42._decal, A1_43.position, A1_43.ray, L2_44, A1_43.normal) ~= "" and script_debug.draw_gunfx then
		World:effect_manager():spawn({
			effect = World:project_decal(A0_42._decal, A1_43.position, A1_43.ray, L2_44, A1_43.normal),
			position = A1_43.position,
			normal = A1_43.normal,
			force_sync = true
		})
	end
end
function InstantShellSpawner.add_body(A0_45, A1_46)
	local L2_47
	L2_47 = A0_45._unit_map
	L2_47 = L2_47[A1_46.body:unit():key()]
	if L2_47 == nil then
		L2_47 = {
			bodies = {},
			hit = false,
			total_ratio = 0,
			unit = A1_46.body:unit()
		}
		A0_45._unit_map[A1_46.body:unit():key()] = L2_47
	end
	if L2_47.bodies[A1_46.body:key()] == nil then
		L2_47.bodies[A1_46.body:key()] = {ray = A1_46}
	end
end
