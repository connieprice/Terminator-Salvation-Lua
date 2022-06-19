local L0_0
L0_0 = require
L0_0("units/weapons/PlayerBaseWeapon")
L0_0 = require
L0_0("shared/VectorUtilities")
L0_0 = MiniGun
if not L0_0 then
	L0_0 = class
	L0_0 = L0_0(PlayerBaseWeapon)
end
MiniGun = L0_0
L0_0 = MiniGun
function L0_0.init(A0_1, A1_2)
	local L2_3
	L2_3 = PlayerBaseWeapon
	L2_3 = L2_3.init
	L2_3(A0_1, A1_2)
	A0_1._unit = A1_2
	A0_1._enabled = false
	L2_3 = A0_1._unit
	L2_3 = L2_3.get_object
	L2_3 = L2_3(L2_3, "fire")
	A0_1._obj_fire = L2_3
	A0_1._fire_sound_instance = nil
	L2_3 = "fire"
	A0_1._fire_sound_instance = nil
	A0_1._fire_sound_object, A0_1._fire_end_sound_object = WeaponUtilities.sound_objects(A0_1._unit, A0_1._sound_prefix, A0_1._sound_variant, A0_1._sound_bank, A0_1._is_once_sound, L2_3)
	if A0_1._projectile_spawner_class and A0_1._projectile_spawner_class ~= "" then
		A0_1._projectile_spawner = World:spawn_unit(A0_1._projectile_spawner_class, A0_1._unit:position(), A0_1._unit:rotation())
		A0_1._unit:link("fire", A0_1._projectile_spawner, A0_1._projectile_spawner:orientation_object():name())
	end
	if A0_1._projectile_spawner_class_alt and A0_1._projectile_spawner_class_alt ~= "" then
		A0_1._projectile_spawner_alt = World:spawn_unit(A0_1._projectile_spawner_class_alt, A0_1._unit:position(), A0_1._unit:rotation())
		A0_1._unit:link("fire", A0_1._projectile_spawner_alt, A0_1._projectile_spawner_alt:orientation_object():name())
	end
	if not managers.sensory_events:is_defined("MINIGUN_SHOOT") then
		managers.sensory_events:define_event("MINIGUN_SHOOT", managers.sensory_events.source_types.MACHINE_WEAPON_ID, A0_1._shoot_event_visible_range, A0_1._shoot_event_sound_level, A0_1._shoot_event_sound_level_reference_distance)
	end
	A0_1._fire_sensory_event_handle = nil
	A0_1._rpm = 0
	A0_1._rpm_increase = 0
	A0_1._rpm_decrease = 0
	A0_1:_setup_sounds()
	A0_1._rotation_object = A0_1._unit:get_object(A0_1._rotation_object_name)
	assert(A0_1._rotation_object, A0_1._rotation_object_name)
	A0_1._rotation_object_initial_local_rotation = A0_1._rotation_object:new_local_rotation()
	A0_1._rotation_object_angle = 0
	A0_1._event_emitter = managers.action_event:create_emitter(A1_2)
end
L0_0 = MiniGun
function L0_0._setup_sounds(A0_4)
	local L1_5
	L1_5 = A0_4._unit
	L1_5 = L1_5.get_object
	L1_5 = L1_5(L1_5, A0_4._sound_output_object_name)
	assert(L1_5, A0_4._sound_output_object_name)
	if A0_4._rpm_up_sound_cue_name and A0_4._rpm_up_sound_cue_name ~= "" then
		A0_4._rpm_up_sound = Sound:make_bank(A0_4._soundbank_name, A0_4._rpm_up_sound_cue_name)
		assert(A0_4._rpm_up_sound, A0_4._rpm_up_sound_cue_name)
		A0_4._rpm_up_sound:set_output(L1_5)
	end
	if A0_4._rpm_down_sound_cue_name and A0_4._rpm_down_sound_cue_name ~= "" then
		A0_4._rpm_down_sound = Sound:make_bank(A0_4._soundbank_name, A0_4._rpm_down_sound_cue_name)
		assert(A0_4._rpm_down_sound, A0_4._rpm_down_sound_cue_name)
		A0_4._rpm_down_sound:set_output(L1_5)
	end
end
L0_0 = MiniGun
function L0_0.destroy(A0_6)
	managers.sensory_events:destroy_continuous_event_handle(A0_6._fire_sensory_event_handle)
	A0_6._unit = nil
	if alive(A0_6._projectile_spawner) then
		A0_6._projectile_spawner:set_slot(0)
	end
	A0_6._projectile_spawner = nil
	if alive(A0_6._projectile_spawner_alt) then
		A0_6._projectile_spawner_alt:set_slot(0)
	end
	A0_6._projectile_spawner_alt = nil
	if A0_6._fire_sound_object and A0_6._fire_sound_object:is_playing() then
		A0_6._fire_sound_object:stop()
	end
	A0_6:_stop_sounds()
end
function L0_0(A0_7)
	if A0_7 and A0_7:is_playing() then
		A0_7:stop()
	end
end
function MiniGun._stop_sounds(A0_8)
	local L1_9, L2_10, L3_11, L4_12, L5_13, L6_14
	L1_9 = {
		L2_10,
		L3_11,
		L4_12
	}
	for L5_13, L6_14 in L2_10(L3_11) do
		_UPVALUE0_(L6_14)
	end
end
function MiniGun.setup(A0_15, A1_16)
	PlayerBaseWeapon.setup(A0_15, A1_16)
end
function MiniGun.enable(A0_17)
	A0_17:set_enabled(true)
end
function MiniGun.disable(A0_18)
	A0_18:set_enabled(false)
end
function MiniGun.update(A0_19, A1_20, A2_21, A3_22)
	local L4_23, L5_24
	L4_23 = A0_19._wdata
	L5_24 = L4_23.fire_input
	L5_24 = L5_24 >= L4_23.fire_trigger_threshold or L4_23.prepare_fire
	if L5_24 then
		if not A0_19._should_fire then
			A0_19:_start_rpm_increase()
		end
		A0_19._rpm_decrease = 0
		if A0_19._rpm < A0_19._fire_rpm then
			A0_19._rpm_increase = A0_19._rpm_increase + A3_22 * A0_19._rpm_acceleration
			A0_19._rpm = A0_19._rpm + A3_22 * A0_19._rpm_increase
		end
		if A0_19._rpm >= A0_19._fire_rpm then
			A0_19._rpm = A0_19._fire_rpm
			L4_23._fire_enabled = true
		else
			L4_23._fire_enabled = false
		end
	else
		if A0_19._should_fire then
			A0_19:_start_rpm_decrease()
		end
		L4_23._fire_enabled = false
		A0_19._rpm_increase = 0
		if 0 < A0_19._rpm then
			A0_19._rpm_decrease = A0_19._rpm_decrease + A3_22 * A0_19._rpm_decceleration
			A0_19._rpm = A0_19._rpm - A3_22 * A0_19._rpm_decrease
		end
		if 0 > A0_19._rpm then
			A0_19._rpm = 0
		end
	end
	A0_19:_update_weapon_rotation(A3_22)
	A0_19._should_fire = L5_24
	L4_23._dispersion = A0_19._max_dispersion + (A0_19._min_dispersion - A0_19._max_dispersion) * L4_23._dispersion_modifier
end
function MiniGun._update_weapon_rotation(A0_25, A1_26)
	local L2_27
	L2_27 = A0_25._rpm
	L2_27 = L2_27 / 60
	L2_27 = L2_27 * 360
	L2_27 = L2_27 * A1_26
	A0_25._rotation_object_angle = angle_constrain(A0_25._rotation_object_angle + L2_27)
	A0_25._rotation_object:new_set_local_rotation(A0_25._rotation_object_initial_local_rotation + Rotation(A0_25._rotation_object_initial_local_rotation:y(), A0_25._rotation_object_angle))
end
function MiniGun._start_rpm_increase(A0_28)
	local L1_29
	if A0_28._rpm > 0 and 0 < A0_28._fire_rpm then
		L1_29 = math.sqrt(A0_28._rpm / A0_28._fire_rpm) * 0.3
	else
		L1_29 = 0
	end
	if A0_28._rpm_up_sound then
		A0_28._rpm_up_sound_instance = _UPVALUE0_(A0_28._rpm_down_sound_instance, A0_28._rpm_up_sound_instance, A0_28._rpm_up_sound, L1_29)
	end
end
function MiniGun._start_rpm_decrease(A0_30)
	local L1_31
	if A0_30._rpm > 0 and 0 < A0_30._fire_rpm then
		L1_31 = (1 - A0_30._rpm / A0_30._fire_rpm) * 1.198
	else
		L1_31 = 0
	end
	if A0_30._rpm_down_sound then
		A0_30._rpm_down_sound_instance = _UPVALUE0_(A0_30._rpm_up_sound_instance, A0_30._rpm_down_sound_instance, A0_30._rpm_down_sound, L1_31)
	end
end
function MiniGun.on_zoom_aim(A0_32, A1_33)
	if A1_33 then
		A0_32._unit:play("aiming_on")
	else
		A0_32._unit:play("aiming_off")
	end
end
function MiniGun.fire_start(A0_34, A1_35)
	A0_34._fire_sensory_event_handle = managers.sensory_events:begin_continuous_event(managers.sensory_events.event_types.MINIGUN_SHOOT_ID, A0_34._unit)
	A0_34._fire_sound_instance = A0_34._fire_sound_object:play("offset", 0)
	A0_34._event_emitter:unit_weapon_fire_start(A0_34._unit)
end
function MiniGun.fire_end(A0_36, A1_37)
	managers.sensory_events:end_continuous_event(A0_36._fire_sensory_event_handle)
	if A0_36._is_once_sound == false and A0_36._fire_end_sound_object and A0_36._fire_sound_instance then
		A0_36._fire_end_sound_object:play("crossfade_with", A0_36._fire_sound_instance, "crossfade_time", 0)
	end
	A0_36._event_emitter:unit_weapon_fire_stop(A0_36._unit)
end
function MiniGun.fire(A0_38, A1_39)
	local L2_40, L3_41, L4_42, L5_43, L6_44, L7_45, L8_46
	L2_40 = A0_38._obj_fire
	L3_41 = L2_40
	L2_40 = L2_40.rotation
	L2_40 = L2_40(L3_41)
	L3_41 = Rotation
	L4_42 = Vector3
	L5_43 = 1
	L6_44 = 0
	L7_45 = 0
	L4_42 = L4_42(L5_43, L6_44, L7_45)
	L5_43 = -90
	L3_41 = L3_41(L4_42, L5_43)
	L2_40 = L2_40 * L3_41
	L3_41 = World
	L4_42 = L3_41
	L3_41 = L3_41.effect_manager
	L3_41 = L3_41(L4_42)
	L4_42 = L3_41
	L3_41 = L3_41.spawn
	L5_43 = {}
	L6_44 = A0_38._fire_effect_name
	L5_43.effect = L6_44
	L6_44 = A0_38._obj_fire
	L7_45 = L6_44
	L6_44 = L6_44.position
	L6_44 = L6_44(L7_45)
	L5_43.position = L6_44
	L5_43.rotation = L2_40
	L3_41(L4_42, L5_43)
	L3_41, L4_42, L5_43 = nil, nil, nil
	A0_38._fire_time = A1_39
	L6_44 = A0_38._wdata
	L6_44 = L6_44.aim_target_position
	L7_45 = A0_38._obj_fire
	L8_46 = L7_45
	L7_45 = L7_45.position
	L7_45 = L7_45(L8_46)
	L8_46 = L6_44 - L7_45
	L8_46 = L8_46.normalized
	L8_46 = L8_46(L8_46)
	L4_42 = L8_46
	L8_46 = VectorUtilities
	L8_46 = L8_46.angle_constraint_direction
	L8_46 = L8_46(L4_42, A0_38._obj_fire:rotation():y(), A0_38._max_fire_object_and_aim_angle_diff)
	L4_42 = L8_46
	L8_46 = WeaponUtilities
	L8_46 = L8_46.dispersion
	L8_46 = L8_46(L4_42, A0_38._wdata.miss_dispersion, A0_38._wdata._dispersion)
	L5_43 = L8_46
	L8_46 = L5_43 * 10
	L7_45 = L7_45 + L8_46
	L8_46 = A0_38._wdata
	L8_46 = L8_46._dispersion_modifier
	if L8_46 >= 1 then
		L8_46 = A0_38._projectile_spawner_alt
		if L8_46 then
			L8_46 = Rotation
			L8_46 = L8_46(L5_43, A0_38._obj_fire:rotation():z())
			A0_38._projectile_spawner_alt:base():spawn_projectile(A0_38._user_unit, L7_45, L8_46)
			A0_38._event_emitter:unit_weapon_fire_change(A0_38._unit, L7_45, L8_46, A0_38._projectile_spawner_alt)
		end
	else
		L8_46 = A0_38._projectile_spawner
		if L8_46 then
			L8_46 = Rotation
			L8_46 = L8_46(L5_43, A0_38._obj_fire:rotation():z())
			A0_38._projectile_spawner:base():spawn_projectile(A0_38._user_unit, L7_45, L8_46)
			A0_38._event_emitter:unit_weapon_fire_change(A0_38._unit, L7_45, L8_46, A0_38._projectile_spawner)
		end
	end
end
