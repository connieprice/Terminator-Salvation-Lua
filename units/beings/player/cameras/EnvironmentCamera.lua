local L0_0
L0_0 = require
L0_0("shared/camera/SharedCamera")
L0_0 = require
L0_0("shared/Interpolator")
L0_0 = mvector3
L0_0 = L0_0.set
EnvironmentCamera = EnvironmentCamera or class(SharedCamera)
function EnvironmentCamera.init(A0_1, A1_2)
	SharedCamera.init(A0_1, A1_2)
	A0_1._target_fov = Interpolator:new(0, 4)
	A0_1._target_shake_amount = Interpolator:new(0, 4)
	A0_1._disable_avoid = false
	A0_1._listener_id = nil
	A0_1._explosion_anim = "explosion"
	A0_1._amplitude = 0
	A0_1._frequency = 0
end
function EnvironmentCamera.parse_parameters(A0_3, A1_4)
	SharedCamera.parse_parameters(A0_3, A1_4)
	if A1_4.unit then
		A0_3._anim_unit_name = A1_4.unit
	end
	if A1_4.object then
		A0_3._object_name = A1_4.object
	end
	if A1_4.detail_unit then
		A0_3._anim_detail_unit_name = A1_4.detail_unit
	end
	if A1_4.detail_object then
		A0_3._detail_object_name = A1_4.detail_object
	end
	if A1_4.disable_avoid then
		A0_3._disable_avoid = true
	end
	if A1_4.explosion_anim then
		A0_3._explosion_anim = A1_4.explosion_anim
	end
end
function EnvironmentCamera.preload_units(A0_5)
	local L1_6, L2_7
	L1_6 = A0_5.unit
	if L1_6 then
		L2_7 = World
		L2_7 = L2_7.preload_unit
		L2_7(L2_7, L1_6)
	end
	L2_7 = A0_5.detail_unit
	if L2_7 then
		World:preload_unit(L2_7)
	end
end
function EnvironmentCamera.destroy(A0_8)
	SharedCamera.destroy(A0_8)
	if alive(A0_8._anim_unit) then
		A0_8._anim_unit:set_slot(0)
		A0_8._anim_unit = nil
		A0_8._object = nil
	end
	if alive(A0_8._anim_detail_unit) then
		A0_8._anim_detail_unit:set_slot(0)
		A0_8._anim_detail_unit = nil
		A0_8._detail_object = nil
	end
	if A0_8._action_event_registered then
		managers.action_event:unregister_listener(A0_8)
		managers.camera:destroy_listener(A0_8._listener_id)
	end
end
function EnvironmentCamera.on_activate(A0_9, A1_10)
	if A1_10 then
		assert(not A0_9._action_event_registered)
		managers.action_event:register_listener(A0_9, A0_9._anim_unit, A0_9._root_unit)
		A0_9._listener_id = managers.camera:create_listener()
		assert(A0_9._anim_unit == nil)
		A0_9._anim_unit = World:spawn_unit(A0_9._anim_unit_name, Vector3(0, 0, 0), Rotation())
		A0_9._anim_unit:set_driving("script")
		A0_9._anim_unit:set_visible(false)
		if A0_9._object_name then
			A0_9._object = A0_9._anim_unit:get_object(A0_9._object_name)
		else
			A0_9._object = A0_9._anim_unit:orientation_object()
		end
		A0_9._asm = A0_9._anim_unit:anim_state_machine()
		A0_9._anim_detail_unit = World:spawn_unit(A0_9._anim_detail_unit_name, Vector3(0, 0, 0), Rotation())
		A0_9._anim_detail_unit:set_driving("script")
		A0_9._anim_detail_unit:set_visible(false)
		if A0_9._detail_object_name then
			A0_9._detail_object = A0_9._anim_detail_unit:get_object(A0_9._object_name)
		else
			A0_9._detail_object = A0_9._anim_detail_unit:orientation_object()
		end
		A0_9._detail_asm = A0_9._anim_detail_unit:anim_state_machine()
		A0_9._amplitude = 0
		A0_9._frequency = 0
	else
		assert(A0_9._action_event_registered)
		managers.action_event:unregister_listener(A0_9)
		managers.camera:destroy_listener(A0_9._listener_id)
		A0_9._anim_unit:set_slot(0)
		A0_9._anim_unit = nil
		A0_9._object = nil
		A0_9._asm = nil
		A0_9._anim_detail_unit:set_slot(0)
		A0_9._anim_detail_unit = nil
		A0_9._detail_object = nil
		A0_9._detail_asm = nil
	end
	A0_9._action_event_registered = A1_10
end
function EnvironmentCamera.update(A0_11, A1_12, A2_13, A3_14, A4_15)
	local L5_16, L6_17, L7_18, L8_19, L9_20, L10_21
	L5_16 = A0_11._anim_unit
	L6_17 = A0_11._anim_detail_unit
	L7_18 = assert
	L8_19 = A0_11._anim_unit
	L7_18(L8_19)
	L7_18 = A0_11._object
	L8_19 = A0_11._detail_object
	L9_20 = _UPVALUE0_
	L10_21 = A0_11._local_position
	L9_20(L10_21, L7_18:local_position() + L8_19:local_position():rotate_with(L7_18:local_rotation()))
	L10_21 = L7_18
	L9_20 = L7_18.local_rotation
	L9_20 = L9_20(L10_21)
	A0_11._local_rotation = L9_20
	L9_20 = SharedCamera
	L9_20 = L9_20.update
	L10_21 = A0_11
	L9_20(L10_21, A1_12, A2_13, A3_14, A4_15)
	L10_21 = L5_16
	L9_20 = L5_16.set_position
	L9_20(L10_21, A0_11._root_unit:position())
	L10_21 = L6_17
	L9_20 = L6_17.set_position
	L9_20(L10_21, A0_11._root_unit:position())
	L9_20 = managers
	L9_20 = L9_20.camera
	L10_21 = A0_11._listener_id
	L9_20:set_listener_position(L10_21, A0_11._position)
	L9_20:set_listener_rotation(L10_21, A0_11._rotation)
	if A0_11._amplitude ~= L9_20:listener_data(L10_21).amplitude then
		A0_11._asm:set_global("g_ground_shake_amplitude", L9_20:listener_data(L10_21).amplitude)
		A0_11._amplitude = L9_20:listener_data(L10_21).amplitude
	end
	if A0_11._frequency ~= L9_20:listener_data(L10_21).frequency then
		A0_11._asm:set_global("g_ground_shake_frequency", L9_20:listener_data(L10_21).frequency)
		A0_11._frequency = L9_20:listener_data(L10_21).frequency
	end
end
function EnvironmentCamera.unit_explode(A0_22, A1_23, A2_24, A3_25)
	A0_22:unit_explosion(A1_23, A2_24)
end
function EnvironmentCamera.unit_explosion(A0_26, A1_27, A2_28)
	local L3_29, L4_30, L5_31, L6_32, L7_33
	L3_29 = managers
	L3_29 = L3_29.environment
	L4_30 = L3_29
	L3_29 = L3_29.create_blur
	L5_31 = "explosion_medium"
	L6_32 = A0_26._anim_unit
	L7_33 = L6_32
	L6_32 = L6_32.position
	L7_33 = L6_32(L7_33)
	L3_29(L4_30, L5_31, L6_32, L7_33, L6_32(L7_33))
	L3_29 = A0_26._root_unit
	L4_30 = L3_29
	L3_29 = L3_29.position
	L3_29 = L3_29(L4_30)
	L4_30 = A2_28 - L3_29
	L5_31 = L4_30
	L4_30 = L4_30.length
	L4_30 = L4_30(L5_31)
	L5_31 = math
	L5_31 = L5_31.clamp
	L6_32 = L4_30
	L7_33 = 0
	L5_31 = L5_31(L6_32, L7_33, 1500)
	L5_31 = L5_31 / 1500
	L5_31 = 1 - L5_31
	L6_32 = math
	L6_32 = L6_32.random
	L6_32 = L6_32()
	L7_33 = math
	L7_33 = L7_33.random
	L7_33 = L7_33()
	A0_26._detail_asm:set_global("g_scale", L5_31)
	A0_26._detail_asm:set_global("g_u", L6_32)
	A0_26._detail_asm:set_global("g_v", L7_33)
	A0_26._anim_detail_unit:play_redirect(A0_26._explosion_anim)
end
function EnvironmentCamera.unit_afro_hit(A0_34, A1_35, A2_36, A3_37, A4_38, A5_39)
	if not A0_34._disable_avoid then
		A0_34._anim_detail_unit:play_redirect("avoid_bullet")
	end
	managers.environment:create_blur("whizbyblur", A4_38)
end
function EnvironmentCamera.unit_player_damage(A0_40, A1_41, A2_42, A3_43, A4_44, A5_45, A6_46)
	A0_40._anim_detail_unit:play_redirect("hit")
end
function EnvironmentCamera._calculate_amount(A0_47, A1_48, A2_49)
	return 0
end
function EnvironmentCamera.unit_spawn_projectile(A0_50, A1_51, A2_52, A3_53, A4_54)
	A0_50:_trigger_radial_blur(A3_53, A2_52)
end
function EnvironmentCamera._trigger_radial_blur(A0_55, A1_56, A2_57)
	local L3_58
	L3_58 = A0_55.is_active
	L3_58 = L3_58(A0_55)
	if not L3_58 then
		return
	end
	L3_58 = nil
	if A2_57 == "InstantBullet" then
		L3_58 = "spawn_instant_bullet"
	else
		L3_58 = "spawn_projectile"
	end
	managers.environment:create_blur(L3_58, A1_56)
end
function EnvironmentCamera.unit_weapon_shake_start(A0_59, A1_60, A2_61, A3_62)
	A0_59._anim_unit:play_redirect(A3_62)
end
function EnvironmentCamera.unit_weapon_shake_stop(A0_63, A1_64)
	A0_63._anim_unit:play_redirect("stop_shake")
end
function EnvironmentCamera.debug_render(A0_65, A1_66, A2_67)
	SharedCamera.debug_render(A0_65, A1_66, A2_67)
	Draw:brush(Color(0.5, 0, 0, 1)):sphere(A0_65:position(), 3)
end
