require("projectile/InstantBulletSpawner")
require("units/weapons/GenericWeapon")
M2MachineGun = M2MachineGun or class(GenericWeapon)
function M2MachineGun.init(A0_0, A1_1)
	GenericWeapon.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._firing = false
	A0_0._enabled = false
	A0_0._wdata = A0_0._unit:weapon_data()
	A0_0._wdata._max_dispersion = A0_0._max_dispersion
	A0_0._wdata._min_dispersion = A0_0._min_dispersion
	A0_0._obj_fire = A0_0._unit:get_object("fire")
	A0_0._obj_sound = A0_0._unit:get_object("sound")
	A0_0._bullets_fired = 0
	A0_0._is_rotating = false
	A0_0:_init_sounds()
	A0_0._muzzleflash_rate = 2
	A0_0._bullet_trails = {}
end
function M2MachineGun.fire(A0_2, A1_3)
	local L2_4, L3_5, L4_6, L5_7, L6_8, L7_9, L8_10, L9_11
	L2_4 = A0_2._unit
	L3_5 = L2_4
	L2_4 = L2_4.anim_set_time
	L4_6 = "fire"
	L5_7 = 0
	L2_4(L3_5, L4_6, L5_7)
	L2_4 = A0_2._unit
	L3_5 = L2_4
	L2_4 = L2_4.anim_play
	L4_6 = "fire"
	L2_4(L3_5, L4_6)
	L2_4 = A0_2._fire_effect
	if L2_4 then
		L2_4 = A0_2._bullets_fired
		L3_5 = A0_2._muzzleflash_rate
		L2_4 = L2_4 % L3_5
		if L2_4 == 0 then
			L3_5 = World
			L4_6 = L3_5
			L3_5 = L3_5.effect_manager
			L3_5 = L3_5(L4_6)
			L4_6 = L3_5
			L3_5 = L3_5.spawn
			L5_7 = {}
			L6_8 = A0_2._fire_effect
			L5_7.effect = L6_8
			L6_8 = A0_2._obj_sound
			L5_7.parent = L6_8
			L6_8 = Vector3
			L7_9 = 0
			L8_10 = 1
			L9_11 = 0
			L6_8 = L6_8(L7_9, L8_10, L9_11)
			L5_7.normal = L6_8
			L5_7.force_synch = true
			L3_5(L4_6, L5_7)
		end
	end
	A0_2._fire_time = A1_3
	L2_4 = A0_2._wdata
	L3_5 = L2_4.aim_target_position
	L4_6 = A0_2._obj_fire
	L6_8 = L4_6
	L5_7 = L4_6.position
	L5_7 = L5_7(L6_8)
	L7_9 = L4_6
	L6_8 = L4_6.rotation
	L6_8 = L6_8(L7_9)
	L7_9 = L3_5 - L5_7
	L8_10 = L7_9
	L7_9 = L7_9.normalized
	L7_9 = L7_9(L8_10)
	L8_10 = VectorUtilities
	L8_10 = L8_10.angle_constraint_direction
	L9_11 = L7_9
	L8_10 = L8_10(L9_11, L6_8:y(), A0_2._max_fire_object_and_aim_angle_diff)
	L7_9 = L8_10
	L9_11 = A0_2
	L8_10 = A0_2.get_target_dir
	L8_10 = L8_10(L9_11, L5_7, L7_9, L2_4)
	L9_11 = Global
	L9_11 = L9_11.category_debug_render
	L9_11 = L9_11["player.dispersion"]
	if L9_11 then
		L9_11 = Draw
		L9_11 = L9_11.pen
		L9_11 = L9_11(L9_11, "permanent", "green")
		L9_11:sphere(L3_5, 50)
		Draw:pen("permanent", "blue"):sphere(L5_7, 10)
		L9_11:line(L5_7, L5_7 + L7_9 * 3000)
		Draw:pen("permanent", "red"):line(L5_7, L5_7 + L8_10 * 3000)
	end
	L9_11 = L8_10 * 10
	L5_7 = L5_7 + L9_11
	L9_11 = Rotation
	L9_11 = L9_11(L8_10, L6_8:y())
	A0_2._event_emitter:unit_weapon_fire_change(A0_2._unit, L5_7, L9_11, A0_2._projectile_spawner)
	if A0_2._projectile_spawner then
		A0_2._projectile_spawner:base():spawn_projectile(A0_2._user_unit, L5_7, L9_11)
	end
	A0_2._bullets_fired = A0_2._bullets_fired + 1
end
function M2MachineGun.get_target_dir(A0_12, A1_13, A2_14, A3_15)
	local L4_16, L5_17, L6_18, L7_19, L8_20, L9_21, L10_22, L11_23
	L4_16 = tweak_data
	L4_16 = L4_16.rail
	L4_16 = L4_16.AUTO_AIM
	if not L4_16 then
		L4_16 = GenericWeapon
		L4_16 = L4_16.get_target_dir
		L5_17 = A0_12
		L6_18 = A1_13
		L7_19 = A2_14
		return L4_16(L5_17, L6_18, L7_19)
	end
	L4_16 = 15000
	L5_17 = managers
	L5_17 = L5_17.slot
	L6_18 = L5_17
	L5_17 = L5_17.get_mask
	L7_19 = "target_world"
	L5_17 = L5_17(L6_18, L7_19)
	L6_18 = A2_14 * L4_16
	L6_18 = A1_13 + L6_18
	L7_19 = World
	L8_20 = L7_19
	L7_19 = L7_19.raycast
	L9_21 = "ray"
	L10_22 = A1_13
	L11_23 = L6_18
	L7_19 = L7_19(L8_20, L9_21, L10_22, L11_23, "ray_type", "auto_aim", "slot_mask", L5_17, "ignore_unit", A0_12._unit)
	if L7_19 then
		L8_20 = L7_19.body
		L9_21 = L8_20
		L8_20 = L8_20.position
		L8_20 = L8_20(L9_21)
		L9_21 = L7_19.position
		L8_20 = L8_20 - L9_21
		L10_22 = L8_20
		L9_21 = L8_20.length
		L9_21 = L9_21(L10_22)
		L11_23 = L8_20
		L10_22 = L8_20.normalized
		L10_22 = L10_22(L11_23)
		L11_23 = L7_19.distance
		L11_23 = L11_23 / 15000
		L11_23 = L11_23 * tweak_data.rail.AUTO_AIM_CORRECTION_150M
		L11_23 = math.min(L11_23, L9_21)
		A2_14 = (L7_19.position + L10_22 * L11_23 - A1_13):normalized()
		return WeaponUtilities.dispersion(A2_14, A3_15.miss_dispersion, A3_15._dispersion)
	end
	L8_20 = GenericWeapon
	L8_20 = L8_20.get_target_dir
	L9_21 = A0_12
	L10_22 = A1_13
	L11_23 = A2_14
	return L8_20(L9_21, L10_22, L11_23, A3_15)
end
function M2MachineGun._init_sounds(A0_24)
	local L1_25
end
function M2MachineGun._start_sounds(A0_26)
	if not A0_26._sounds.rotation:is_playing() then
		A0_26._sounds.rotation:set_control("gain_abs", 0)
		A0_26._sounds.rotation:play()
	end
end
function M2MachineGun.start_rotation(A0_27)
	local L1_28
end
function M2MachineGun.end_rotation(A0_29)
	local L1_30
end
function M2MachineGun.report_damage(A0_31, A1_32, A2_33)
	local L3_34
	L3_34 = A0_31._unit
	L3_34 = L3_34.turret
	L3_34 = L3_34(L3_34)
	L3_34 = L3_34.get_vehicle
	L3_34 = L3_34(L3_34)
	if alive(L3_34) then
		L3_34:damage():damage_from_part(A1_32, A2_33)
	end
end
function M2MachineGun.destroy(A0_35)
	GenericWeapon.destroy(A0_35)
end
