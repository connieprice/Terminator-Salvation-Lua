require("shared/VectorUtilities")
GenericProjectileWeapon = GenericProjectileWeapon or class(BaseWeapon)
function GenericProjectileWeapon.init(A0_0, A1_1)
	BaseWeapon.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._last_fire_input = 0
	A0_0._obj_fire = A0_0._unit:orientation_object()
	A0_0._wdata = A0_0._unit:weapon_data()
	A0_0._wdata._fire_enabled = true
	A0_0._disabled_projectile_spawners = {}
	A0_0._event_emitter = managers.action_event:create_emitter(A1_1)
end
function GenericProjectileWeapon.setup(A0_2, A1_3, A2_4)
	local L3_5, L4_6, L5_7, L6_8, L7_9, L8_10
	L3_5(L4_6, L5_7)
	L3_5(L4_6)
	L4_6 = L4_6 > 0
	L3_5(L4_6)
	L6_8 = A1_3
	L6_8 = L5_7
	L6_8 = A0_2._unit
	L7_9 = A0_2._unit
	L8_10 = L7_9
	L7_9 = L7_9.orientation_object
	L7_9 = L7_9(L8_10)
	L8_10 = L7_9
	L7_9 = L7_9.name
	L8_10 = L7_9(L8_10)
	L3_5(L4_6, L5_7, L6_8, L7_9, L8_10, L7_9(L8_10))
	A0_2._projectile_spawners = L3_5
	for L6_8, L7_9 in L3_5(L4_6) do
		L8_10 = World
		L8_10 = L8_10.spawn_unit
		L8_10 = L8_10(L8_10, A0_2._projectile_spawner_class, A0_2._unit:position(), A0_2._unit:rotation())
		A1_3:link(L7_9, L8_10, L8_10:orientation_object():name())
		table.insert(A0_2._projectile_spawners, L8_10)
	end
end
function GenericProjectileWeapon.destroy(A0_11)
	if A0_11._wdata._firing then
		A0_11._event_emitter:unit_weapon_fire_stop(A0_11._unit)
	end
	A0_11._event_emitter:destroy()
	A0_11._unit = nil
	if alive(A0_11._projectile_spawner) then
		A0_11._projectile_spawner:set_slot(0)
	end
	A0_11._projectile_spawner = nil
end
function GenericProjectileWeapon.fire_start(A0_12, A1_13)
	A0_12._projectile_spawner_index = 1
	A0_12._event_emitter:unit_weapon_fire_start(A0_12._unit)
end
function GenericProjectileWeapon.fire_end(A0_14, A1_15)
	A0_14._event_emitter:unit_weapon_fire_stop(A0_14._unit)
end
function GenericProjectileWeapon.fire(A0_16, A1_17)
	local L2_18, L3_19, L4_20, L5_21, L6_22, L7_23
	L2_18 = A0_16._disabled_projectile_spawners
	L3_19 = A0_16._projectile_spawner_index
	L2_18 = L2_18[L3_19]
	if not L2_18 then
		L3_19 = A0_16._projectile_spawners
		L4_20 = A0_16._projectile_spawner_index
		L3_19 = L3_19[L4_20]
		L4_20 = A0_16._event_emitter
		L5_21 = L4_20
		L4_20 = L4_20.unit_weapon_fire_change
		L6_22 = A0_16._unit
		L7_23 = L3_19.position
		L7_23 = L7_23(L3_19)
		L4_20(L5_21, L6_22, L7_23, L3_19:rotation(), L3_19)
		L5_21 = L3_19
		L4_20 = L3_19.position
		L4_20 = L4_20(L5_21)
		L5_21 = A0_16._wdata
		L5_21 = L5_21.aim_target_position
		L6_22 = L5_21 - L4_20
		L7_23 = L6_22
		L6_22 = L6_22.normalized
		L6_22 = L6_22(L7_23)
		L7_23 = VectorUtilities
		L7_23 = L7_23.angle_constraint_direction
		L7_23 = L7_23(L6_22, A0_16._obj_fire:rotation():y(), A0_16._max_fire_object_and_aim_angle_diff)
		L6_22 = L7_23
		L7_23 = WeaponUtilities
		L7_23 = L7_23.dispersion
		L7_23 = L7_23(L6_22, A0_16._wdata.miss_dispersion, A0_16._wdata._dispersion)
		if A0_16._explosion_damage_at_center then
			L3_19:base():spawn_projectile(A0_16._user_unit, L4_20, Rotation(L7_23, math.UP)):base():set_explosion_damage_at_center(A0_16._explosion_damage_at_center)
		end
		if A0_16._explosion_radius then
			L3_19:base():spawn_projectile(A0_16._user_unit, L4_20, Rotation(L7_23, math.UP)):base():set_explosion_radius(A0_16._explosion_radius)
		end
		if A0_16._speed then
			L3_19:base():spawn_projectile(A0_16._user_unit, L4_20, Rotation(L7_23, math.UP)):base():set_speed(A0_16._speed)
		end
		if A0_16._initial_speed then
			L3_19:base():spawn_projectile(A0_16._user_unit, L4_20, Rotation(L7_23, math.UP)):base():set_initial_speed(A0_16._initial_speed)
		end
	end
	L3_19 = A0_16._projectile_spawner_index
	L3_19 = L3_19 + 1
	A0_16._projectile_spawner_index = L3_19
	L3_19 = A0_16._projectile_spawner_index
	L4_20 = A0_16._projectile_spawners
	L4_20 = #L4_20
	if L3_19 > L4_20 then
		A0_16._projectile_spawner_index = 1
	end
end
function GenericProjectileWeapon.set_explosion_damage_at_center(A0_24, A1_25)
	A0_24._explosion_damage_at_center = A1_25
end
function GenericProjectileWeapon.set_explosion_radius(A0_26, A1_27)
	A0_26._explosion_radius = A1_27
end
function GenericProjectileWeapon.set_velocity(A0_28, A1_29)
	A0_28._velocity = A1_29
end
function GenericProjectileWeapon.disable_projectile_spawner(A0_30, A1_31)
	A0_30._disabled_projectile_spawners[A1_31] = true
end
