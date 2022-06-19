require("projectile/InstantBulletSpawner")
require("units/weapons/GenericWeapon")
if not M2MachineGun then
	M2MachineGun = class(GenericWeapon)
end
M2MachineGun.init = function(l_1_0, l_1_1)
	GenericWeapon.init(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._firing = false
	l_1_0._enabled = false
	l_1_0._wdata = l_1_0._unit:weapon_data()
	l_1_0._wdata._max_dispersion = l_1_0._max_dispersion
	l_1_0._wdata._min_dispersion = l_1_0._min_dispersion
	l_1_0._obj_fire = l_1_0._unit:get_object("fire")
	l_1_0._obj_sound = l_1_0._unit:get_object("sound")
	l_1_0._bullets_fired = 0
	l_1_0._is_rotating = false
	l_1_0:_init_sounds()
	l_1_0._muzzleflash_rate = 2
	l_1_0._bullet_trails = {}
end

M2MachineGun.fire = function(l_2_0, l_2_1)
	l_2_0._unit:anim_set_time("fire", 0)
	l_2_0._unit:anim_play("fire")
	if l_2_0._fire_effect then
		local l_2_2 = l_2_0._bullets_fired % l_2_0._muzzleflash_rate
	if l_2_2 == 0 then
		end
		local l_2_3, l_2_4 = World:effect_manager():spawn, World:effect_manager()
		local l_2_5 = {}
		l_2_5.effect = l_2_0._fire_effect
		l_2_5.parent = l_2_0._obj_sound
		l_2_5.normal = Vector3(0, 1, 0)
		l_2_5.force_synch = true
		l_2_3(l_2_4, l_2_5)
	end
	l_2_0._fire_time = l_2_1
	local l_2_6 = l_2_0._wdata
	local l_2_7 = l_2_6.aim_target_position
	local l_2_8 = l_2_0._obj_fire
	local l_2_9 = l_2_8:position()
	local l_2_10 = l_2_8:rotation()
	local l_2_11 = l_2_7 - l_2_9:normalized()
	l_2_11 = VectorUtilities.angle_constraint_direction(l_2_11, l_2_10:y(), l_2_0._max_fire_object_and_aim_angle_diff)
	local l_2_12 = l_2_0:get_target_dir(l_2_9, l_2_11, l_2_6)
	if Global.category_debug_render["player.dispersion"] then
		local l_2_13 = Draw:pen("permanent", "green")
		local l_2_14 = Draw:pen("permanent", "red")
		local l_2_15 = Draw:pen("permanent", "blue")
		l_2_13:sphere(l_2_7, 50)
		l_2_15:sphere(l_2_9, 10)
		l_2_13:line(l_2_9, l_2_9 + l_2_11 * 3000)
		l_2_14:line(l_2_9, l_2_9 + l_2_12 * 3000)
	end
	l_2_9 = l_2_9 + l_2_12 * 10
	local l_2_16 = Rotation(l_2_12, l_2_10:y())
	l_2_0._event_emitter:unit_weapon_fire_change(l_2_0._unit, l_2_9, l_2_16, l_2_0._projectile_spawner)
	if l_2_0._projectile_spawner then
		l_2_0._projectile_spawner:base():spawn_projectile(l_2_0._user_unit, l_2_9, l_2_16)
	end
	l_2_0._bullets_fired = l_2_0._bullets_fired + 1
end

M2MachineGun.get_target_dir = function(l_3_0, l_3_1, l_3_2, l_3_3)
	local l_3_8, l_3_9, l_3_10, l_3_11, l_3_12, l_3_13, l_3_14, l_3_15, l_3_16, l_3_17 = nil
	if not tweak_data.rail.AUTO_AIM then
		local l_3_4 = GenericWeapon.get_target_dir
		local l_3_5 = l_3_0
		local l_3_6 = l_3_1
		local l_3_7 = l_3_2
		return l_3_4(l_3_5, l_3_6, l_3_7)
	end
	local l_3_18 = 15000
	local l_3_19 = managers.slot:get_mask("target_world")
	local l_3_20 = l_3_1 + l_3_2 * l_3_18
	local l_3_31 = World:raycast
	l_3_31 = l_3_31(World, "ray", l_3_1, l_3_20, "ray_type", "auto_aim", "slot_mask", l_3_19, "ignore_unit", l_3_0._unit)
	local l_3_21 = nil
	if l_3_31 then
		l_3_21 = l_3_31.body
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_3_22 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_3_23 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_3_24 = nil
		l_3_24 = l_3_31.distance
		l_3_24 = l_3_24 / 15000
		l_3_24 = l_3_24 * tweak_data.rail.AUTO_AIM_CORRECTION_150M
		local l_3_25 = nil
		l_3_25 = math
		l_3_25 = l_3_25.min
		l_3_25 = l_3_25(l_3_24, l_3_22)
		l_3_24 = l_3_25
		l_3_25 = l_3_31.position
		l_3_25 = l_3_25 + l_3_23 * l_3_24
		local l_3_26 = nil
		l_3_26 = l_3_25 - l_3_1
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_3_2 = l_3_26
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_3_27 = nil
		l_3_27 = l_3_2
		local l_3_28 = nil
		l_3_28 = l_3_3.miss_dispersion
		local l_3_29 = nil
		l_3_29 = l_3_3._dispersion
		local l_3_30 = nil
		return l_3_26(l_3_27, l_3_28, l_3_29)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	return l_3_21(l_3_22, l_3_23, l_3_2, l_3_3)
end

M2MachineGun._init_sounds = function(l_4_0)
end

M2MachineGun._start_sounds = function(l_5_0)
	if not l_5_0._sounds.rotation:is_playing() then
		l_5_0._sounds.rotation:set_control("gain_abs", 0)
		l_5_0._sounds.rotation:play()
	end
end

M2MachineGun.start_rotation = function(l_6_0)
end

M2MachineGun.end_rotation = function(l_7_0)
end

M2MachineGun.report_damage = function(l_8_0, l_8_1, l_8_2)
	local l_8_3 = l_8_0._unit:turret():get_vehicle()
	if alive(l_8_3) then
		l_8_3:damage():damage_from_part(l_8_1, l_8_2)
	end
end

M2MachineGun.destroy = function(l_9_0)
	GenericWeapon.destroy(l_9_0)
end


