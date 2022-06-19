UnitProjectile = UnitProjectile or class()
function UnitProjectile.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._spawning_unit = A1_1
	A0_0._detonation_time = 20
	A0_0._explode_when_dead = true
	A0_0._start_position = A0_0._unit:position()
	A0_0._min_detonation_time = 0
	A0_0._detonate_on_proximity = nil
	A0_0._detonate_on_collision = true
	A0_0._proximity_radius = 100
	A0_0._anti_gravity = 0
	A0_0._drop_down_distance = nil
	A0_0._drop_down_time = 0.5
	A0_0._drop_down_x_velocity_multiplier = 5
	A0_0._drop_down_y_velocity_multiplier = 5
	A0_0._drop_down_z_velocity_multiplier = 10
	A0_0._drop_down_z_gravity = 0
	A0_0._explosion_covers_slot_mask = managers.slot:get_mask("explosion_covers")
	if not A0_0._min_detonation_distance then
		A0_0._min_detonation_distance = 0
	end
	if not A0_0._explosion_effect then
		A0_0._explosion_effect = "weapon_m79_explosion"
	end
	A1_1:set_body_collision_callback(callback(A0_0, A0_0, "collision_callback"))
	A0_0._work_item_vector = {}
	A0_0._rays_per_frame = 6
	A0_0._explode_at_position = nil
	A0_0._blind_fire_velocity_forward = 500
	A0_0._blind_fire_velocity_up = 500
	A0_0._ignore_self = true
end
function UnitProjectile.set_blind_fire(A0_2, A1_3)
	A0_2._blind_fire = A1_3
end
function UnitProjectile.set_spawning_unit(A0_4, A1_5)
	A0_4._spawning_unit = A1_5
end
function UnitProjectile.update(A0_6, A1_7, A2_8, A3_9)
	local L4_10, L5_11, L6_12, L7_13
	L4_10 = A0_6._init_push
	if not L4_10 then
		L4_10 = A0_6._blind_fire
		if L4_10 then
			L5_11 = A1_7
			L4_10 = A1_7.push
			L7_13 = A1_7
			L6_12 = A1_7.mass
			L6_12 = L6_12(L7_13)
			L7_13 = A1_7.rotation
			L7_13 = L7_13(A1_7)
			L7_13 = L7_13.y
			L7_13 = L7_13(L7_13)
			L7_13 = L7_13 * A0_6._blind_fire_velocity_forward
			L4_10(L5_11, L6_12, L7_13)
			L5_11 = A1_7
			L4_10 = A1_7.push
			L7_13 = A1_7
			L6_12 = A1_7.mass
			L6_12 = L6_12(L7_13)
			L7_13 = math
			L7_13 = L7_13.UP
			L7_13 = L7_13 * A0_6._blind_fire_velocity_up
			L4_10(L5_11, L6_12, L7_13)
		else
			L5_11 = A1_7
			L4_10 = A1_7.push
			L7_13 = A1_7
			L6_12 = A1_7.mass
			L6_12 = L6_12(L7_13)
			L7_13 = A1_7.rotation
			L7_13 = L7_13(A1_7)
			L7_13 = L7_13.y
			L7_13 = L7_13(L7_13)
			L7_13 = L7_13 * A0_6._initial_velocity
			L4_10(L5_11, L6_12, L7_13)
		end
		A0_6._init_push = true
	end
	L4_10 = A0_6._detonation_time
	L4_10 = L4_10 - A3_9
	A0_6._detonation_time = L4_10
	L4_10 = A0_6._min_detonation_time
	L4_10 = L4_10 - A3_9
	A0_6._min_detonation_time = L4_10
	L5_11 = A0_6
	L4_10 = A0_6.distance_travelled
	L4_10 = L4_10(L5_11)
	L6_12 = A0_6
	L5_11 = A0_6._update_arc
	L7_13 = A1_7
	L5_11(L6_12, L7_13, A3_9, L4_10)
	L5_11 = nil
	L6_12 = A0_6._detonate_on_proximity
	L6_12 = L6_12 and L4_10 >= L6_12 and true
	L7_13 = nil
	L6_12 = L6_12 or A0_6._detonate_on_collision and A0_6._collided
	L6_12 = L6_12 or A0_6._detonation_time <= 0
	L6_12 = not L6_12 and A0_6._unit:damage_data() and A0_6._unit:damage_data():is_fully_damaged() and A0_6._explode_when_dead
	if L6_12 then
		A0_6:_detonate(L7_13)
	end
	if Global.category_debug_render.projectile_trace then
		A0_6:_draw_projectile_trace()
	end
end
function UnitProjectile.collision_callback(A0_14, A1_15, A2_16, A3_17, A4_18, A5_19, A6_20, A7_21, A8_22)
	local L9_23
	L9_23 = A0_14._ignore_self
	if L9_23 then
		L9_23 = A0_14._spawning_unit
		if A4_18 == L9_23 then
			return
		end
	end
	A0_14._collided = true
	A0_14._collision_normal = A7_21
	A0_14._collision_position = A6_20
end
function UnitProjectile._detonate(A0_24, A1_25)
	local L2_26, L3_27, L4_28, L5_29
	if not A1_25 then
		L2_26 = A0_24._unit
		L3_27 = L2_26
		L2_26 = L2_26.position
		L2_26 = L2_26(L3_27)
		A1_25 = L2_26
	end
	L2_26 = A0_24._unit
	L3_27 = L2_26
	L2_26 = L2_26.set_slot
	L4_28 = 0
	L2_26(L3_27, L4_28)
	L2_26 = World
	L3_27 = L2_26
	L2_26 = L2_26.spawn_unit
	L4_28 = A0_24._explosion_unit
	L5_29 = A1_25
	L2_26 = L2_26(L3_27, L4_28, L5_29)
	L4_28 = L2_26
	L3_27 = L2_26.base
	L3_27 = L3_27(L4_28)
	L3_27 = L3_27.set_spawning_unit
	if L3_27 then
		L4_28 = L2_26
		L3_27 = L2_26.base
		L3_27 = L3_27(L4_28)
		L4_28 = L3_27
		L3_27 = L3_27.set_spawning_unit
		L5_29 = A0_24._spawning_unit
		L3_27(L4_28, L5_29)
	end
	L3_27 = Rotation
	L4_28 = math
	L4_28 = L4_28.UP
	L5_29 = 0
	L3_27 = L3_27(L4_28, L5_29)
	L4_28 = A0_24._detonate_on_collision
	if L4_28 then
		L4_28 = A0_24._unit
		L5_29 = L4_28
		L4_28 = L4_28.rotation
		L4_28 = L4_28(L5_29)
		L3_27 = L4_28
	end
	L4_28 = World
	L5_29 = L4_28
	L4_28 = L4_28.effect_manager
	L4_28 = L4_28(L5_29)
	L5_29 = L4_28
	L4_28 = L4_28.spawn
	L4_28(L5_29, {
		effect = A0_24._explosion_effect,
		position = A0_24._unit:position(),
		rotation = L3_27
	})
	L4_28 = A0_24._decal
	if L4_28 then
		L4_28 = A0_24._last_blocked_ray
		if L4_28 then
			L4_28 = A0_24._last_blocked_ray
			L5_29 = L4_28.ray
			L5_29 = L5_29 - L4_28.normal * L4_28.ray:dot(L4_28.normal) * 2
			if World:project_decal(A0_24._decal, L4_28.position, L4_28.ray, L5_29, L4_28.normal) and World:project_decal(A0_24._decal, L4_28.position, L4_28.ray, L5_29, L4_28.normal) ~= "" then
				World:effect_manager():spawn({
					effect = World:project_decal(A0_24._decal, L4_28.position, L4_28.ray, L5_29, L4_28.normal),
					position = A1_25,
					normal = L4_28.normal
				})
			end
			A0_24._last_blocked_ray = nil
		else
			L4_28 = World
			L5_29 = L4_28
			L4_28 = L4_28.project_decal
			L4_28 = L4_28(L5_29, A0_24._decal, A1_25, Vector3(0, 0, -1))
			if L4_28 and L4_28 ~= "" then
				L5_29 = World
				L5_29 = L5_29.effect_manager
				L5_29 = L5_29(L5_29)
				L5_29 = L5_29.spawn
				L5_29(L5_29, {
					effect = L4_28,
					position = A1_25,
					normal = Vector3(0, 0, 1)
				})
			end
		end
	end
end
function UnitProjectile._update_arc(A0_30, A1_31, A2_32, A3_33)
	local L4_34, L5_35, L6_36, L7_37, L8_38, L9_39
	L4_34 = A0_30._drop_down_distance
	if L4_34 then
		L4_34 = A0_30._drop_down_distance
		if A3_33 > L4_34 then
			L4_34 = A0_30._drop_down_time
			if L4_34 > 0 then
				L4_34 = A0_30._collided
				if not L4_34 then
					L4_34 = A0_30._drop_down_time
					L4_34 = L4_34 - A2_32
					A0_30._drop_down_time = L4_34
					L4_34 = A0_30._unit
					L6_36 = L4_34
					L5_35 = L4_34.velocity
					L5_35 = L5_35(L6_36)
					L6_36 = A0_30._drop_down_x_velocity_multiplier
					L6_36 = L6_36 * A2_32
					L7_37 = L5_35.x
					L7_37 = -L7_37
					L6_36 = L6_36 * L7_37
					L7_37 = A0_30._drop_down_y_velocity_multiplier
					L7_37 = L7_37 * A2_32
					L8_38 = L5_35.y
					L8_38 = -L8_38
					L7_37 = L7_37 * L8_38
					L8_38 = L5_35.z
					if L8_38 > 0 then
						L8_38 = A0_30._drop_down_z_velocity_multiplier
						L8_38 = L8_38 * A2_32
						L9_39 = L5_35.z
						L9_39 = -L9_39
						L8_38 = L8_38 * L9_39
					elseif not L8_38 then
						L8_38 = A0_30._drop_down_z_gravity
						L8_38 = L8_38 * A2_32
					end
					L9_39 = Vector3
					L9_39 = L9_39(L6_36, L7_37, L8_38)
					L4_34:push(L4_34:mass(), L9_39)
				end
			end
		end
	else
		L4_34 = A0_30._collided
		if not L4_34 then
			L4_34 = math
			L4_34 = L4_34.abs
			L5_35 = A0_30._anti_gravity
			L4_34 = L4_34(L5_35)
			if L4_34 > 0 then
				L4_34 = Vector3
				L5_35 = 0
				L6_36 = 0
				L7_37 = A0_30._anti_gravity
				L7_37 = L7_37 * A2_32
				L4_34 = L4_34(L5_35, L6_36, L7_37)
				L6_36 = A1_31
				L5_35 = A1_31.push
				L8_38 = A1_31
				L7_37 = A1_31.mass
				L7_37 = L7_37(L8_38)
				L8_38 = L4_34
				L5_35(L6_36, L7_37, L8_38)
			end
		end
	end
end
function UnitProjectile.distance_travelled(A0_40)
	return (A0_40._unit:position() - A0_40._start_position):length()
end
function UnitProjectile._check_proximity(A0_41)
	local L1_42, L2_43, L3_44, L4_45, L5_46, L6_47, L7_48, L8_49, L9_50, L10_51, L11_52, L12_53, L13_54, L14_55, L15_56, L16_57
	L1_42 = assert
	L2_43 = A0_41._detonate_on_proximity
	L1_42(L2_43)
	L1_42 = A0_41._unit
	L2_43 = World
	L3_44 = L2_43
	L2_43 = L2_43.find_units
	L4_45 = "sphere"
	L8_49 = L7_48
	L9_50 = "enemies"
	L16_57 = L7_48(L8_49, L9_50)
	L2_43 = L2_43(L3_44, L4_45, L5_46, L6_47, L7_48, L8_49, L9_50, L10_51, L11_52, L12_53, L13_54, L14_55, L15_56, L16_57, L7_48(L8_49, L9_50))
	L3_44 = {}
	L4_45 = L1_42.position
	L4_45 = L4_45(L5_46)
	for L8_49, L9_50 in L5_46(L6_47) do
		L10_51 = {}
		L11_52 = {}
		L11_52.unit = L9_50
		L11_52.body_queue = L10_51
		L11_52.position = L4_45
		L12_53 = table
		L12_53 = L12_53.insert
		L12_53(L13_54, L14_55)
		L12_53 = L9_50.num_bodies
		L12_53 = L12_53(L13_54)
		for L16_57 = 0, L12_53 - 1 do
			if L9_50:body(L16_57):enabled() then
				table.insert(L10_51, {
					body = L9_50:body(L16_57)
				})
			end
		end
	end
	if L5_46 > 0 then
		L5_46(L6_47, L7_48)
	end
	while L5_46 > 0 do
		if L6_47 > 0 then
			L8_49 = assert
			L9_50 = L7_48
			L8_49(L9_50)
			L9_50 = A0_41
			L8_49 = A0_41.raycast_for_work_item
			L10_51 = L1_42
			L11_52 = L7_48
			L8_49 = L8_49(L9_50, L10_51, L11_52)
			if L8_49 then
				L9_50 = L7_48.position
				L10_51 = true
				L11_52 = L9_50
				return L10_51, L11_52
			else
				L9_50 = table
				L9_50 = L9_50.remove
				L10_51 = L6_47
				L11_52 = 1
				L9_50(L10_51, L11_52)
				L9_50 = #L6_47
				if L9_50 <= 0 then
					L9_50 = table
					L9_50 = L9_50.remove
					L10_51 = A0_41._work_item_vector
					L11_52 = 1
					L9_50(L10_51, L11_52)
				end
			end
		end
	end
	return L6_47
end
function UnitProjectile.is_all_work_done(A0_58)
	local L1_59
	L1_59 = A0_58._work_item_vector
	L1_59 = #L1_59
	L1_59 = L1_59 > 0
	return L1_59
end
function UnitProjectile.raycast_for_work_item(A0_60, A1_61, A2_62)
	if not alive(A2_62.unit) or #A2_62.body_queue == 0 then
		return false
	end
	A0_60._last_blocked_ray = A1_61:raycast("ray", A2_62.position, table.remove(A2_62.body_queue, 1).body:center_of_mass(), "slot_mask", A0_60._explosion_covers_slot_mask, "ignore_unit", A2_62.unit)
	return not A1_61:raycast("ray", A2_62.position, table.remove(A2_62.body_queue, 1).body:center_of_mass(), "slot_mask", A0_60._explosion_covers_slot_mask, "ignore_unit", A2_62.unit)
end
function UnitProjectile._draw_projectile_trace(A0_63)
	local L1_64
	L1_64 = A0_63._unit
	L1_64 = L1_64.position
	L1_64 = L1_64(L1_64)
	if A0_63._prev_pos then
		Draw:pen("one_second"):set("green")
		Draw:pen("one_second"):line(A0_63._prev_pos, L1_64)
	end
	A0_63._prev_pos = A0_63._unit:position()
end
