require("units/weapons/GenericWeapon")
RPG7GrenadeLauncher = RPG7GrenadeLauncher or class(GenericWeapon)
function RPG7GrenadeLauncher.init(A0_0, A1_1)
	GenericWeapon.init(A0_0, A1_1)
	A0_0._grenade_align = A0_0._unit:get_object(A0_0._grenade_align_object_name)
	A0_0._grenade_position_name = A0_0._grenade_position_name or "fire"
	A0_0._grenade_align:set_position(A0_0._unit:get_object(A0_0._grenade_position_name):position())
	A0_0._weapon_root = A0_0._unit:orientation_object()
	A0_0._loaded_grenade = A0_0._unit:get_object(A0_0._grenade_object_name)
	A0_0._loaded_grenade:set_visibility(A0_0._wdata._bullets_in_clip > 0)
	A0_0._hand_align_name = A0_0._hand_align_name or "a_weapon_left_front"
	A0_0._movement_history = {}
	A0_0._velocity = Vector3(0, 0, 0)
	A0_0._time_sum = 0
	A0_0._movement_sum = Vector3(0, 0, 0)
	A0_0._relinked = false
	A0_0._attached_grenade_local_rotation = {}
	A0_0._attached_grenade_local_rotation.x = 0
	A0_0._attached_grenade_local_rotation.y = 0
	A0_0._attached_grenade_local_rotation.z = 0
	A0_0._play_fire_anim = false
end
function RPG7GrenadeLauncher.destroy(A0_2)
	GenericWeapon.destroy(A0_2)
end
function RPG7GrenadeLauncher.update(A0_3, A1_4, A2_5, A3_6)
	if not A0_3._user_unit or not A0_3._user_unit:player_data().reloading then
		A0_3._loaded_grenade:set_visibility(A0_3._wdata._bullets_in_clip > 0)
	end
	A0_3:_update_velocity(A3_6)
	if A0_3._extension_enabled and not A0_3._enabled then
		A0_3:_enable_extension(false)
	end
end
function RPG7GrenadeLauncher._enable_extension(A0_7, A1_8)
	A0_7._extension_enabled = A1_8
	A0_7._unit:set_extension_update_enabled("base", A1_8)
end
function RPG7GrenadeLauncher.attach_grenade_to_left_hand(A0_9)
	local L1_10, L2_11
	L1_10 = A0_9._relinked
	if not L1_10 then
		L1_10 = A0_9._user_unit
		L2_11 = L1_10
		L1_10 = L1_10.get_object
		L1_10 = L1_10(L2_11, A0_9._hand_align_name)
		L2_11 = A0_9._loaded_grenade
		L2_11 = L2_11.set_visibility
		L2_11(L2_11, true)
		L2_11 = A0_9._grenade_align
		L2_11 = L2_11.unlink
		L2_11(L2_11)
		L2_11 = A0_9._user_unit
		L2_11 = L2_11.link
		L2_11(L2_11, A0_9._hand_align_name, A0_9._unit, A0_9._grenade_align_object_name, true)
		L2_11 = A0_9._grenade_align
		L2_11 = L2_11.set_position
		L2_11(L2_11, L1_10:position())
		L2_11 = A0_9._grenade_align
		L2_11 = L2_11.new_set_rotation
		L2_11(L2_11, L1_10:rotation())
		L2_11 = Rotation
		L2_11 = L2_11(A0_9._attached_grenade_local_rotation.x, A0_9._attached_grenade_local_rotation.y, A0_9._attached_grenade_local_rotation.z)
		A0_9._grenade_align:set_local_rotation(L2_11)
		A0_9._relinked = true
	end
end
function RPG7GrenadeLauncher.on_extension_update_enabled(A0_12, A1_13)
	A0_12._enabled = A1_13
	if A1_13 then
		A0_12:_enable_extension(true)
	end
end
function RPG7GrenadeLauncher.detach_grenade_from_left_hand(A0_14)
	local L1_15
	L1_15 = A0_14._relinked
	if L1_15 then
		L1_15 = A0_14._unit
		L1_15 = L1_15.get_object
		L1_15 = L1_15(L1_15, A0_14._grenade_position_name)
		A0_14._grenade_align:unlink()
		A0_14._grenade_align:link(L1_15)
		A0_14._grenade_align:set_position(L1_15:position())
		A0_14._grenade_align:new_set_rotation(L1_15:rotation())
		A0_14._relinked = false
	end
end
function RPG7GrenadeLauncher.reload_release(A0_16)
	if not A0_16._relinked then
		A0_16:attach_grenade_to_left_hand()
		A0_16._relinked = true
	end
end
function RPG7GrenadeLauncher.reload_attach(A0_17)
	if A0_17._relinked then
		A0_17:detach_grenade_from_left_hand()
		managers.sequence:run_sequence_simple("reload_rpg7", A0_17._unit)
		A0_17._relinked = false
	end
end
function RPG7GrenadeLauncher._update_velocity(A0_18, A1_19)
	if A0_18._prev_position then
		A0_18._time_sum = A0_18._time_sum + A1_19
		A0_18._movement_sum = A0_18._movement_sum + (A0_18._obj_fire:position() - A0_18._prev_position)
		A0_18._velocity = A0_18._movement_sum / A0_18._time_sum
		table.insert(A0_18._movement_history, {
			delta_move = A0_18._obj_fire:position() - A0_18._prev_position,
			dt = A1_19
		})
	end
	if #A0_18._movement_history >= 20 then
		A0_18._time_sum = A0_18._time_sum - A0_18._movement_history[1].dt
		A0_18._movement_sum = A0_18._movement_sum - A0_18._movement_history[1].delta_move
		table.remove(A0_18._movement_history, 1)
	end
	A0_18._prev_position = A0_18._obj_fire:position()
end
function RPG7GrenadeLauncher.fire(A0_20, A1_21)
	local L2_22, L3_23, L4_24, L5_25, L6_26, L7_27, L8_28, L9_29
	L2_22 = A0_20._play_fire_anim
	if L2_22 then
		L2_22 = A0_20._unit
		L3_23 = L2_22
		L2_22 = L2_22.anim_set_time
		L4_24 = "fire"
		L5_25 = 0
		L2_22(L3_23, L4_24, L5_25)
		L2_22 = A0_20._unit
		L3_23 = L2_22
		L2_22 = L2_22.anim_play
		L4_24 = "fire"
		L2_22(L3_23, L4_24)
	end
	L2_22 = Rotation
	L3_23 = Vector3
	L4_24 = 0
	L5_25 = 0
	L6_26 = 1
	L3_23 = L3_23(L4_24, L5_25, L6_26)
	L4_24 = 0
	L2_22 = L2_22(L3_23, L4_24)
	L3_23 = A0_20._fire_effect
	if L3_23 then
		L3_23 = World
		L4_24 = L3_23
		L3_23 = L3_23.effect_manager
		L3_23 = L3_23(L4_24)
		L4_24 = L3_23
		L3_23 = L3_23.spawn
		L5_25 = {}
		L6_26 = A0_20._fire_effect
		L5_25.effect = L6_26
		L6_26 = A0_20._unit
		L7_27 = L6_26
		L6_26 = L6_26.get_object
		L8_28 = A0_20._fire_effect_object
		L6_26 = L6_26(L7_27, L8_28)
		L5_25.parent = L6_26
		L6_26 = Vector3
		L7_27 = 0
		L8_28 = 1
		L9_29 = 0
		L6_26 = L6_26(L7_27, L8_28, L9_29)
		L5_25.normal = L6_26
		L5_25.force_synch = true
		L3_23(L4_24, L5_25)
	end
	L3_23 = A0_20._projectile_spawner
	L4_24, L5_25 = nil, nil
	A0_20.target_dir = nil
	A0_20._fire_time = A1_21
	L6_26 = A0_20._wdata
	L6_26 = L6_26.aim_target_position
	L7_27 = L3_23
	L9_29 = L7_27
	L8_28 = L7_27.position
	L8_28 = L8_28(L9_29)
	A0_20.source_pos = L8_28
	L8_28 = A0_20.source_pos
	L8_28 = L6_26 - L8_28
	L9_29 = L8_28
	L8_28 = L8_28.normalized
	L8_28 = L8_28(L9_29)
	L5_25 = L8_28
	L8_28 = VectorUtilities
	L8_28 = L8_28.angle_constraint_direction
	L9_29 = L5_25
	L8_28 = L8_28(L9_29, L7_27:rotation():y(), A0_20._max_fire_object_and_aim_angle_diff)
	L5_25 = L8_28
	L8_28 = A0_20._wdata
	L9_29 = A0_20.get_target_dir
	L9_29 = L9_29(A0_20, A0_20.source_pos, L5_25, L8_28)
	A0_20.target_dir = L9_29
	L9_29 = Rotation
	L9_29 = L9_29(A0_20.target_dir, L7_27:rotation():z())
	A0_20._event_emitter:unit_weapon_fire_change(A0_20._unit, A0_20.source_pos, L9_29, A0_20._projectile_spawner)
	A0_20._projectile_spawner:base():spawn_projectile(A0_20._user_unit, A0_20.source_pos, L9_29):base()._inherited_velocity = A0_20._velocity
	A0_20._loaded_grenade:set_visibility(false)
end
function RPG7GrenadeLauncher.weapon_stocked(A0_30, A1_31)
	PlayerBaseWeapon.weapon_stocked(A0_30, A1_31)
end
