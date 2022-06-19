require("projectile/InstantBulletSpawner")
require("units/weapons/GenericWeapon")
Mk19GrenadeLauncher = Mk19GrenadeLauncher or class(GenericWeapon)
function Mk19GrenadeLauncher.init(A0_0, A1_1)
	GenericWeapon.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._firing = false
	A0_0._enabled = false
	A0_0._wdata = A0_0._unit:weapon_data()
	A0_0._wdata._max_dispersion = A0_0._max_dispersion
	A0_0._wdata._min_dispersion = A0_0._min_dispersion
	if not managers.sensory_events:is_defined("T100WEAPON_SHOOT") then
		managers.sensory_events:define_event("T100WEAPON_SHOOT", managers.sensory_events.source_types.MACHINE_WEAPON_ID, A0_0._shoot_event_visible_range, A0_0._shoot_event_sound_level, A0_0._shoot_event_sound_level_reference_distance)
	end
	A0_0._is_rotating = false
	A0_0:_init_sounds()
	A0_0:_init_chute_offset()
end
function Mk19GrenadeLauncher._init_chute_offset(A0_2)
	local L1_3, L2_4
	L1_3 = A0_2._unit
	L2_4 = L1_3
	L1_3 = L1_3.material
	L1_3 = L1_3(L2_4, "mk19_grenadelauncher_chute_uvanim")
	A0_2._chute_material = L1_3
	A0_2._max_chute_offset_v = 0.042
	L1_3 = 0.25
	L2_4 = A0_2._max_chute_offset_v
	L2_4 = L2_4 / L1_3
	A0_2._chute_offset_velocity = Vector3(0, L2_4, 0)
end
function Mk19GrenadeLauncher._init_sounds(A0_5)
	local L1_6
	L1_6 = {}
	A0_5._sounds = L1_6
	L1_6 = A0_5._sounds
	L1_6.rotation = Sound:make_bank("weapon_m2_sound", "turret_slide_loop")
	L1_6 = A0_5._sounds
	L1_6 = L1_6.rotation
	L1_6 = L1_6.set_output
	L1_6(L1_6, A0_5._unit:get_object("rp_mk19_grenadelauncher_ring"))
end
function Mk19GrenadeLauncher._start_sounds(A0_7)
	if not A0_7._sounds.rotation:is_playing() then
		A0_7._sounds.rotation:set_control("gain_abs", 0)
		A0_7._sounds.rotation:play()
	end
end
function Mk19GrenadeLauncher.start_rotation(A0_8)
	if not A0_8._is_rotating then
		A0_8._sounds.rotation:set_control_ramp("gain_abs", 0, 1, tweak_data.rail.vehicle.sound.turret.fade_in_time)
		A0_8._is_rotating = true
	end
end
function Mk19GrenadeLauncher.end_rotation(A0_9)
	if A0_9._is_rotating then
		A0_9._sounds.rotation:set_control_ramp("gain_abs", 1, 0, tweak_data.rail.vehicle.sound.turret.fade_out_time)
		A0_9._is_rotating = false
	end
end
function Mk19GrenadeLauncher.report_damage(A0_10, A1_11, A2_12)
	local L3_13
	L3_13 = A0_10._unit
	L3_13 = L3_13.turret
	L3_13 = L3_13(L3_13)
	L3_13 = L3_13.get_vehicle
	L3_13 = L3_13(L3_13)
	if alive(L3_13) then
		L3_13:damage():damage_from_part(A1_11, A2_12)
	end
end
function Mk19GrenadeLauncher.destroy(A0_14)
	GenericWeapon.destroy(A0_14)
end
function Mk19GrenadeLauncher.update(A0_15, A1_16, A2_17, A3_18)
	A0_15:_update_chute_uv_offset(A3_18)
end
function Mk19GrenadeLauncher._update_chute_uv_offset(A0_19, A1_20)
	local L2_21, L3_22
	L2_21 = A0_19._chute_material
	L3_22 = L2_21
	L2_21 = L2_21.get_variable
	L2_21 = L2_21(L3_22, "uv_offset")
	L3_22 = A0_19._chute_offset_velocity
	L3_22 = A1_20 * L3_22
	L3_22 = L2_21 + L3_22
	if L3_22.y <= A0_19._max_chute_offset_v then
		A0_19._chute_material:set_variable("uv_offset", L3_22)
	end
end
function Mk19GrenadeLauncher.fire(A0_23, A1_24)
	local L2_25, L3_26, L4_27, L5_28, L6_29
	L2_25 = A0_23._unit
	L3_26 = L2_25
	L2_25 = L2_25.anim_set_time
	L4_27 = "fire"
	L5_28 = 0
	L2_25(L3_26, L4_27, L5_28)
	L2_25 = A0_23._unit
	L3_26 = L2_25
	L2_25 = L2_25.anim_play
	L4_27 = "fire"
	L2_25(L3_26, L4_27)
	L2_25 = A0_23._fire_effect
	if L2_25 then
		L2_25 = World
		L3_26 = L2_25
		L2_25 = L2_25.effect_manager
		L2_25 = L2_25(L3_26)
		L3_26 = L2_25
		L2_25 = L2_25.spawn
		L4_27 = {}
		L5_28 = A0_23._fire_effect
		L4_27.effect = L5_28
		L5_28 = A0_23._unit
		L6_29 = L5_28
		L5_28 = L5_28.get_object
		L5_28 = L5_28(L6_29, "sound")
		L4_27.parent = L5_28
		L5_28 = Vector3
		L6_29 = 0
		L5_28 = L5_28(L6_29, 1, 0)
		L4_27.normal = L5_28
		L4_27.force_synch = true
		L2_25(L3_26, L4_27)
	end
	L2_25, L3_26 = nil, nil
	A0_23.target_dir = nil
	A0_23._fire_time = A1_24
	L4_27 = A0_23._wdata
	L4_27 = L4_27.aim_target_position
	L5_28 = A0_23._obj_fire
	L6_29 = L5_28
	L5_28 = L5_28.position
	L5_28 = L5_28(L6_29)
	A0_23.source_pos = L5_28
	L5_28 = A0_23.source_pos
	L5_28 = L4_27 - L5_28
	L6_29 = L5_28
	L5_28 = L5_28.normalized
	L5_28 = L5_28(L6_29)
	L3_26 = L5_28
	L5_28 = VectorUtilities
	L5_28 = L5_28.angle_constraint_direction
	L6_29 = L3_26
	L5_28 = L5_28(L6_29, A0_23._obj_fire:rotation():y(), A0_23._max_fire_object_and_aim_angle_diff)
	L3_26 = L5_28
	L5_28 = A0_23._wdata
	L6_29 = A0_23.get_target_dir
	L6_29 = L6_29(A0_23, A0_23.source_pos, L3_26, L5_28)
	A0_23.target_dir = L6_29
	L6_29 = A0_23.source_pos
	L6_29 = L6_29 + A0_23.target_dir * 10
	A0_23.source_pos = L6_29
	L6_29 = Rotation
	L6_29 = L6_29(A0_23.target_dir, A0_23._obj_fire:rotation():z())
	A0_23._event_emitter:unit_weapon_fire_change(A0_23._unit, A0_23.source_pos, L6_29, A0_23._projectile_spawner)
	if A0_23._projectile_spawner then
		A0_23._projectile_spawner:base():spawn_projectile(A0_23._user_unit, A0_23.source_pos, L6_29)
	end
	A0_23._chute_material:set_variable("uv_offset", Vector3(0, 0, 0))
end
