require("shared/Angle")
require("shared/InterpolatorLinear")
SelfPropelledUnitProjectile = SelfPropelledUnitProjectile or class()
function SelfPropelledUnitProjectile.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._spawning_unit = A1_1
	A0_0._orientation_obj = A0_0._unit:orientation_object()
	A0_0._detonation_time = 10
	A0_0._start_position = A0_0._unit:position()
	A0_0._start_pitch = Rotation:look_at(A0_0._unit:rotation():y(), Vector3(0, 0, 1)):yaw()
	A0_0._start_yaw = Rotation:look_at(A0_0._unit:rotation():y(), Vector3(0, 0, 1)):roll()
	A0_0._start_rotation = A0_0._unit:rotation()
	A0_0._life_time = 10
	A0_0._lived_time = 0
	A0_0._rotation = A0_0._rotation_min + math:random((A0_0._rotation_max - A0_0._rotation_min) * 10000) / 10000
	A0_0._engine_init_time = 1
	A0_0._initial_speed = 2500
	A0_0._speed = 7000
	A0_0._radial_velocity = 0
	A0_0._velocity_dampening = 2
	A0_0._gravity = 0
	A0_0._current_velocity = Vector3(0, 0, 0)
	A0_0._dispersion = 0.1
	A0_0._blind_fire_dispersion = 1
	A0_0._gravity_velocity = Vector3(0, 0, 0)
	A0_0._radius = 0
	A0_0._dispersion_radius = 50
	A0_0._curr_angle = math.random(180)
	A0_0._acceleration_dampening = 6
	A0_0._inherited_velocity = Vector3(0, 0, 0)
	if Global.category_debug_render.projectile_trace then
		Draw:brush():set_persistance(60)
		Draw:brush():set_color(Color(1, 0, 0, 1), 1)
		Draw:brush():sphere(A0_0._start_position, 5)
		Draw:pen("permanent"):set("blue")
		Draw:pen("permanent"):line(A0_0._start_position, A0_0._start_position + A0_0._start_rotation:y() * 100)
	end
end
function SelfPropelledUnitProjectile.set_spawning_unit(A0_2, A1_3)
	A0_2._spawning_unit = A1_3
end
function SelfPropelledUnitProjectile.set_blind_fire(A0_4, A1_5)
	local L2_6
	if A1_5 then
		L2_6 = A0_4._blind_fire_dispersion
	else
		L2_6 = L2_6 or A0_4._dispersion
	end
	A0_4._dispersion = L2_6
end
function SelfPropelledUnitProjectile.set_precision_aiming(A0_7, A1_8)
	local L2_9
	if not A1_8 then
		L2_9 = A0_7._blind_fire_dispersion
	else
		L2_9 = L2_9 or A0_7._dispersion
	end
	A0_7._dispersion = L2_9
end
function SelfPropelledUnitProjectile.update(A0_10, A1_11, A2_12, A3_13)
	A0_10:_update_lifetime(A1_11, A2_12, A3_13)
	A0_10:_update_hit(A1_11, A2_12, A3_13)
	A0_10:_update_rotation(A1_11, A2_12, A3_13)
	A0_10:_update_position(A1_11, A2_12, A3_13)
	A0_10:_update_trail_effect(A1_11, A2_12, A3_13)
	A0_10:_update_projectile_effect(A1_11, A2_12, A3_13)
	A0_10._previous_position = A0_10._unit:position()
end
function SelfPropelledUnitProjectile._update_position(A0_14, A1_15, A2_16, A3_17)
	local L4_18, L5_19, L6_20, L7_21, L8_22, L9_23, L10_24, L11_25
	L4_18 = A0_14._curr_speed
	if not L4_18 then
		L4_18 = A0_14._initial_speed
		A0_14._curr_speed = L4_18
	end
	L4_18 = A0_14._speed
	L5_19 = A0_14._lived_time
	L6_20 = A0_14._engine_init_time
	if L5_19 < L6_20 then
		L4_18 = A0_14._initial_speed
	end
	L5_19 = A0_14._curr_speed
	L6_20 = A0_14._curr_speed
	L6_20 = L4_18 - L6_20
	L7_21 = A0_14._acceleration_dampening
	L6_20 = L6_20 * L7_21
	L6_20 = L6_20 * A3_17
	L5_19 = L5_19 + L6_20
	A0_14._curr_speed = L5_19
	L5_19 = A0_14._gravity_velocity
	L6_20 = A0_14._gravity
	L7_21 = Vector3
	L8_22 = 0
	L9_23 = 0
	L10_24 = -1
	L7_21 = L7_21(L8_22, L9_23, L10_24)
	L6_20 = L6_20 * L7_21
	L6_20 = L6_20 * A3_17
	L5_19 = L5_19 + L6_20
	A0_14._gravity_velocity = L5_19
	L5_19 = A0_14._start_rotation
	L6_20 = L5_19
	L5_19 = L5_19.y
	L5_19 = L5_19(L6_20)
	L6_20 = L5_19
	L5_19 = L5_19.normalized
	L5_19 = L5_19(L6_20)
	L6_20 = A0_14._curr_speed
	L5_19 = L5_19 * L6_20
	L6_20 = A0_14._gravity_velocity
	L5_19 = L5_19 + L6_20
	L6_20 = A0_14._inherited_velocity
	L5_19 = L5_19 + L6_20
	L6_20 = A0_14._radial_velocity
	if L6_20 then
		L6_20 = A0_14._dispersion
		if L6_20 > 0 then
			L6_20 = A0_14._unit
			L7_21 = L6_20
			L6_20 = L6_20.position
			L6_20 = L6_20(L7_21)
			L7_21 = A0_14._start_position
			L6_20 = L6_20 - L7_21
			L7_21 = math
			L7_21 = L7_21.acos
			L8_22 = math
			L8_22 = L8_22.dot
			L9_23 = A0_14._start_rotation
			L10_24 = L9_23
			L9_23 = L9_23.y
			L9_23 = L9_23(L10_24)
			L10_24 = L9_23
			L9_23 = L9_23.normalized
			L9_23 = L9_23(L10_24)
			L11_25 = L6_20
			L10_24 = L6_20.normalized
			L11_25 = L10_24(L11_25)
			L11_25 = L8_22(L9_23, L10_24, L11_25, L10_24(L11_25))
			L7_21 = L7_21(L8_22, L9_23, L10_24, L11_25, L8_22(L9_23, L10_24, L11_25, L10_24(L11_25)))
			L9_23 = L6_20
			L8_22 = L6_20.length
			L8_22 = L8_22(L9_23)
			L9_23 = math
			L9_23 = L9_23.sin
			L10_24 = L7_21
			L9_23 = L9_23(L10_24)
			L8_22 = L8_22 * L9_23
			L9_23 = A0_14._dispersion_radius
			L10_24 = A0_14._dispersion
			L9_23 = L9_23 * L10_24
			L10_24 = A0_14._lived_time
			L11_25 = A0_14._life_time
			L10_24 = L10_24 / L11_25
			L10_24 = 1 - L10_24
			L9_23 = L9_23 * L10_24
			if L8_22 > L9_23 then
				L10_24 = 2 * L9_23
				L10_24 = L8_22 > L10_24
				L11_25 = A0_14._left_dispersion
				if not L11_25 or L10_24 then
					L11_25 = L6_20.flat
					L11_25 = L11_25(L6_20, A0_14._start_rotation:y())
					L11_25 = L11_25.normalized
					L11_25 = L11_25(L11_25)
					A0_14._curr_angle = ((math.acos(math.dot(L11_25, A0_14._start_rotation:x():normalized())) <= 90 and math.acos(math.dot(L11_25, A0_14._start_rotation:z():normalized())) or 360 - math.acos(math.dot(L11_25, A0_14._start_rotation:z():normalized()))) + (L10_24 and 180 or not A0_14._left_dispersion and math.random(135, 225) or 0)) % 360
					A0_14._left_dispersion = true
				end
			else
				A0_14._left_dispersion = false
			end
			L10_24 = A0_14._start_rotation
			L11_25 = L10_24
			L10_24 = L10_24.z
			L10_24 = L10_24(L11_25)
			L11_25 = L10_24
			L10_24 = L10_24.normalized
			L10_24 = L10_24(L11_25)
			L11_25 = math
			L11_25 = L11_25.cos
			L11_25 = L11_25(A0_14._curr_angle)
			L10_24 = L10_24 * L11_25
			L11_25 = A0_14._radial_velocity
			L10_24 = L10_24 * L11_25
			L11_25 = A0_14._start_rotation
			L11_25 = L11_25.x
			L11_25 = L11_25(L11_25)
			L11_25 = L11_25.normalized
			L11_25 = L11_25(L11_25)
			L11_25 = L11_25 * math.sin(A0_14._curr_angle)
			L11_25 = L11_25 * A0_14._radial_velocity
			L10_24 = L10_24 + L11_25
			L5_19 = L5_19 + L10_24
		end
	end
	L6_20 = A0_14._velocity_dampening
	if L6_20 then
		L6_20 = A0_14._velocity_dampening
		if L6_20 > 0 then
			L6_20 = A0_14._current_velocity
			L7_21 = A0_14._current_velocity
			L7_21 = L5_19 - L7_21
			L8_22 = A0_14._velocity_dampening
			L7_21 = L7_21 * L8_22
			L7_21 = L7_21 * A3_17
			L6_20 = L6_20 + L7_21
			A0_14._current_velocity = L6_20
		end
	else
		A0_14._current_velocity = L5_19
	end
	L6_20 = A0_14._unit
	L7_21 = L6_20
	L6_20 = L6_20.position
	L6_20 = L6_20(L7_21)
	L7_21 = A0_14._unit
	L8_22 = L7_21
	L7_21 = L7_21.set_position
	L9_23 = A0_14._current_velocity
	L9_23 = L9_23 * A3_17
	L9_23 = L6_20 + L9_23
	L7_21(L8_22, L9_23)
	L7_21 = Global
	L7_21 = L7_21.category_debug_render
	L7_21 = L7_21.projectile_trace
	if L7_21 then
		L7_21 = A0_14._previous_position
		if L7_21 then
			L7_21 = Draw
			L8_22 = L7_21
			L7_21 = L7_21.pen
			L9_23 = "permanent"
			L7_21 = L7_21(L8_22, L9_23)
			L9_23 = L7_21
			L8_22 = L7_21.set
			L10_24 = "green"
			L8_22(L9_23, L10_24)
			L9_23 = L7_21
			L8_22 = L7_21.line
			L10_24 = A0_14._previous_position
			L11_25 = A0_14._unit
			L11_25 = L11_25.position
			L11_25 = L11_25(L11_25)
			L8_22(L9_23, L10_24, L11_25, L11_25(L11_25))
		end
	end
end
function SelfPropelledUnitProjectile._update_rotation(A0_26, A1_27, A2_28, A3_29)
	local L4_30
	L4_30 = A0_26._lived_time
	if L4_30 > A0_26._engine_init_time then
		L4_30 = A0_26._previous_position
		if L4_30 then
			L4_30 = Rotation
			L4_30 = L4_30(A0_26._unit:rotation():x(), A0_26._unit:position() - A0_26._previous_position, A0_26._unit:rotation():z())
			L4_30 = L4_30 * Rotation(Vector3(0, 1, 0), A0_26._rotation * A3_29)
			A0_26._unit:set_rotation(L4_30)
		end
	end
end
function SelfPropelledUnitProjectile._update_lifetime(A0_31, A1_32, A2_33, A3_34)
	if A0_31._lived_time >= A0_31._life_time then
		A0_31:destroy(A1_32)
	end
	A0_31._lived_time = A0_31._lived_time + A3_34
end
function SelfPropelledUnitProjectile._update_trail_effect(A0_35, A1_36, A2_37, A3_38)
	local L4_39, L5_40, L6_41, L7_42
	L4_39 = A0_35._trail_effect
	if L4_39 then
		L5_40 = A0_35
		L4_39 = A0_35.distance_travelled
		L4_39 = L4_39(L5_40)
		L5_40 = A0_35._trail_effect_init_distance
		if L4_39 >= L5_40 then
			L4_39 = A0_35._unit
			L5_40 = L4_39
			L4_39 = L4_39.get_object
			L6_41 = A0_35._trail_effect_object
			L4_39 = L4_39(L5_40, L6_41)
			L5_40 = A0_35._prev_trail_spawn_pos
			if not L5_40 then
				L6_41 = L4_39
				L5_40 = L4_39.position
				L5_40 = L5_40(L6_41)
				A0_35._prev_trail_spawn_pos = L5_40
				return
			end
			L6_41 = L4_39
			L5_40 = L4_39.position
			L5_40 = L5_40(L6_41)
			L6_41 = A0_35._prev_trail_spawn_pos
			L5_40 = L5_40 - L6_41
			L6_41 = L5_40
			L5_40 = L5_40.length
			L5_40 = L5_40(L6_41)
			L7_42 = L4_39
			L6_41 = L4_39.position
			L6_41 = L6_41(L7_42)
			L7_42 = A0_35._prev_trail_spawn_pos
			L6_41 = L6_41 - L7_42
			L7_42 = L6_41
			L6_41 = L6_41.normalized
			L6_41 = L6_41(L7_42)
			while true do
				L7_42 = A0_35._trail_effect_spawn_space
				if L5_40 > L7_42 then
					L7_42 = A0_35._prev_trail_spawn_pos
					L7_42 = L7_42 + L6_41 * A0_35._trail_effect_spawn_space
					L5_40 = L5_40 - A0_35._trail_effect_spawn_space
					A0_35._prev_trail_spawn_pos = L7_42
					if Global.category_debug_render.projectile_trace then
						Draw:brush():set_persistance(60)
						Draw:brush():set_color(Color(1, 0, 0, 1), 1)
						Draw:brush():sphere(L7_42, 5)
					end
				end
			end
		end
	end
end
function SelfPropelledUnitProjectile._update_projectile_effect(A0_43, A1_44, A2_45, A3_46)
	if A0_43._projectile_effect and not A0_43._projectile_effect_id and A0_43:distance_travelled() >= A0_43._projectile_effect_init_distance then
		A0_43._projectile_effect_id = World:effect_manager():spawn({
			effect = A0_43._projectile_effect,
			parent = A0_43._unit:get_object(A0_43._projectile_effect_object),
			normal = Vector3(0, 1, 0),
			force_synch = true
		})
	end
end
function SelfPropelledUnitProjectile._update_hit(A0_47, A1_48, A2_49, A3_50)
	local L4_51, L5_52, L6_53, L7_54
	L4_51 = A0_47._previous_position
	if L4_51 then
		L5_52 = A0_47
		L4_51 = A0_47.distance_travelled
		L4_51 = L4_51(L5_52)
		L5_52 = A0_47._safety_distance
		if L4_51 >= L5_52 then
			L4_51 = A0_47._unit
			L5_52 = L4_51
			L4_51 = L4_51.position
			L4_51 = L4_51(L5_52)
			L5_52 = A0_47._previous_position
			L6_53 = nil
			L7_54 = A0_47._radius
			if L7_54 > 0 then
				L7_54 = managers
				L7_54 = L7_54.slot
				L7_54 = L7_54.get_mask
				L7_54 = L7_54(L7_54, "target_world")
				L7_54 = L7_54 - SlotMask(A0_47._ignore_unit_slot)
				L6_53 = A0_47._unit:raycast("ray", L5_52, L4_51, "ray_type", "body", "sphere_cast_radius", A0_47._radius, "slot_mask", L7_54, "ignore_unit", A0_47._unit, "bundle", 5)
			else
				L7_54 = managers
				L7_54 = L7_54.slot
				L7_54 = L7_54.get_mask
				L7_54 = L7_54(L7_54, "solid_objects")
				L7_54 = L7_54 - SlotMask(A0_47._ignore_unit_slot)
				L6_53 = A0_47._unit:raycast("ray", L5_52, L4_51, "slot_mask", L7_54, "ignore_unit", A0_47._unit)
			end
			if L6_53 then
				L7_54 = L6_53.position
				L7_54 = L7_54 + L6_53.normal * 20
				A0_47:hit(L7_54, L6_53)
				if Global.category_debug_render.projectile_trace then
					Draw:brush():set_persistance(60)
					Draw:brush():set_color(Color(1, 1, 0, 0), 1)
					Draw:brush():sphere(L7_54, 5)
					Draw:pen("permanent"):set("green")
					Draw:pen("permanent"):line(L7_54, L7_54 + L6_53.normal * 100)
				end
			end
		end
	end
end
function SelfPropelledUnitProjectile.set_explosion_damage_at_center(A0_55, A1_56)
	A0_55._explosion_damage_at_center = A1_56
end
function SelfPropelledUnitProjectile.set_explosion_radius(A0_57, A1_58)
	A0_57._explosion_radius = A1_58
end
function SelfPropelledUnitProjectile.set_speed(A0_59, A1_60)
	A0_59._speed = A1_60
end
function SelfPropelledUnitProjectile.set_initial_speed(A0_61, A1_62)
	A0_61._initial_speed = A1_62
end
function SelfPropelledUnitProjectile.hit(A0_63, A1_64, A2_65)
	local L3_66, L4_67
	L3_66 = World
	L4_67 = L3_66
	L3_66 = L3_66.spawn_unit
	L3_66 = L3_66(L4_67, A0_63._explosion_unit, A1_64)
	L4_67 = A0_63._explosion_damage_at_center
	if L4_67 then
		L4_67 = L3_66.base
		L4_67 = L4_67(L3_66)
		L4_67 = L4_67.set_damage_at_center
		L4_67(L4_67, A0_63._explosion_damage_at_center)
	end
	L4_67 = L3_66.base
	L4_67 = L4_67(L3_66)
	L4_67 = L4_67.set_spawning_unit
	if L4_67 then
		L4_67 = L3_66.base
		L4_67 = L4_67(L3_66)
		L4_67 = L4_67.set_spawning_unit
		L4_67(L4_67, A0_63._spawning_unit)
	end
	L4_67 = A0_63._decal
	if L4_67 then
		L4_67 = A2_65.ray
		L4_67 = L4_67 - A2_65.normal * A2_65.ray:dot(A2_65.normal) * 2
		if World:project_decal(A0_63._decal, A1_64, A2_65.ray, L4_67, A2_65.normal) and World:project_decal(A0_63._decal, A1_64, A2_65.ray, L4_67, A2_65.normal) ~= "" then
			World:effect_manager():spawn({
				effect = World:project_decal(A0_63._decal, A1_64, A2_65.ray, L4_67, A2_65.normal),
				position = A1_64,
				normal = A2_65.normal
			})
		end
	end
	L4_67 = World
	L4_67 = L4_67.effect_manager
	L4_67 = L4_67(L4_67)
	L4_67 = L4_67.spawn
	L4_67(L4_67, {
		effect = A0_63._explosion_effect,
		position = A1_64,
		normal = A2_65.normal
	})
	L4_67 = A0_63._unit
	L4_67 = L4_67.set_slot
	L4_67(L4_67, 0)
	L4_67 = A0_63._projectile_effect_kill_delay
	if L4_67 then
		L4_67 = World
		L4_67 = L4_67.effect_manager
		L4_67 = L4_67(L4_67)
		L4_67 = L4_67.set_remaining_lifetime
		L4_67(L4_67, A0_63._projectile_effect_id, A0_63._projectile_effect_kill_delay)
	else
		L4_67 = World
		L4_67 = L4_67.effect_manager
		L4_67 = L4_67(L4_67)
		L4_67 = L4_67.fade_kill
		L4_67(L4_67, A0_63._projectile_effect_id)
	end
end
function SelfPropelledUnitProjectile.distance_travelled(A0_68)
	return (A0_68._unit:position() - A0_68._start_position):length()
end
function SelfPropelledUnitProjectile.destroy(A0_69, A1_70)
	A0_69._unit:set_slot(0)
	if A0_69._projectile_effect_kill_delay then
		World:effect_manager():set_remaining_lifetime(A0_69._projectile_effect_id, A0_69._projectile_effect_kill_delay)
	else
		World:effect_manager():fade_kill(A0_69._projectile_effect_id)
	end
end
