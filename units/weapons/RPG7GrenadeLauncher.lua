require("units/weapons/GenericWeapon")
if not RPG7GrenadeLauncher then
	RPG7GrenadeLauncher = class(GenericWeapon)
end
RPG7GrenadeLauncher.init = function(l_1_0, l_1_1)
	GenericWeapon.init(l_1_0, l_1_1)
	l_1_0._grenade_align = l_1_0._unit:get_object(l_1_0._grenade_align_object_name)
	l_1_0._grenade_position_name = l_1_0._grenade_position_name or "fire"
	l_1_0._grenade_align:set_position(l_1_0._unit:get_object(l_1_0._grenade_position_name):position())
	l_1_0._weapon_root = l_1_0._unit:orientation_object()
	l_1_0._loaded_grenade = l_1_0._unit:get_object(l_1_0._grenade_object_name)
	local l_1_2, l_1_3 = l_1_0._loaded_grenade:set_visibility, l_1_0._loaded_grenade
	l_1_2(l_1_3, l_1_0._wdata._bullets_in_clip > 0)
	l_1_2 = l_1_0._hand_align_name
	if not l_1_2 then
		l_1_2 = "a_weapon_left_front"
	end
	l_1_0._hand_align_name = l_1_2
	l_1_0._movement_history, l_1_2 = l_1_2, {}
	l_1_2 = Vector3
	l_1_3 = 0
	l_1_2 = l_1_2(l_1_3, 0, 0)
	l_1_0._velocity = l_1_2
	l_1_0._time_sum = 0
	l_1_2 = Vector3
	l_1_3 = 0
	l_1_2 = l_1_2(l_1_3, 0, 0)
	l_1_0._movement_sum = l_1_2
	l_1_0._relinked = false
	l_1_0._attached_grenade_local_rotation, l_1_2 = l_1_2, {}
	l_1_2 = l_1_0._attached_grenade_local_rotation
	l_1_2.x = 0
	l_1_2 = l_1_0._attached_grenade_local_rotation
	l_1_2.y = 0
	l_1_2 = l_1_0._attached_grenade_local_rotation
	l_1_2.z = 0
	l_1_0._play_fire_anim = false
end

RPG7GrenadeLauncher.destroy = function(l_2_0)
	GenericWeapon.destroy(l_2_0)
end

RPG7GrenadeLauncher.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	if not l_3_0._user_unit or not l_3_0._user_unit:player_data().reloading then
		local l_3_4, l_3_5 = l_3_0._loaded_grenade:set_visibility, l_3_0._loaded_grenade
		l_3_4(l_3_5, l_3_0._wdata._bullets_in_clip > 0)
	end
	l_3_0:_update_velocity(l_3_3)
	if l_3_0._extension_enabled and not l_3_0._enabled then
		l_3_0:_enable_extension(false)
	end
end

RPG7GrenadeLauncher._enable_extension = function(l_4_0, l_4_1)
	l_4_0._extension_enabled = l_4_1
	l_4_0._unit:set_extension_update_enabled("base", l_4_1)
end

RPG7GrenadeLauncher.attach_grenade_to_left_hand = function(l_5_0)
	if not l_5_0._relinked then
		local l_5_1 = l_5_0._user_unit:get_object(l_5_0._hand_align_name)
		l_5_0._loaded_grenade:set_visibility(true)
		l_5_0._grenade_align:unlink()
		l_5_0._user_unit:link(l_5_0._hand_align_name, l_5_0._unit, l_5_0._grenade_align_object_name, true)
		l_5_0._grenade_align:set_position(l_5_1:position())
		l_5_0._grenade_align:new_set_rotation(l_5_1:rotation())
		local l_5_2 = Rotation(l_5_0._attached_grenade_local_rotation.x, l_5_0._attached_grenade_local_rotation.y, l_5_0._attached_grenade_local_rotation.z)
		l_5_0._grenade_align:set_local_rotation(l_5_2)
		l_5_0._relinked = true
	end
end

RPG7GrenadeLauncher.on_extension_update_enabled = function(l_6_0, l_6_1)
	l_6_0._enabled = l_6_1
	if l_6_1 then
		l_6_0:_enable_extension(true)
	end
end

RPG7GrenadeLauncher.detach_grenade_from_left_hand = function(l_7_0)
	if l_7_0._relinked then
		local l_7_1 = l_7_0._unit:get_object(l_7_0._grenade_position_name)
		l_7_0._grenade_align:unlink()
		l_7_0._grenade_align:link(l_7_1)
		l_7_0._grenade_align:set_position(l_7_1:position())
		l_7_0._grenade_align:new_set_rotation(l_7_1:rotation())
		l_7_0._relinked = false
	end
end

RPG7GrenadeLauncher.reload_release = function(l_8_0)
	if not l_8_0._relinked then
		l_8_0:attach_grenade_to_left_hand()
		l_8_0._relinked = true
	end
end

RPG7GrenadeLauncher.reload_attach = function(l_9_0)
	if l_9_0._relinked then
		l_9_0:detach_grenade_from_left_hand()
		managers.sequence:run_sequence_simple("reload_rpg7", l_9_0._unit)
		l_9_0._relinked = false
	end
end

RPG7GrenadeLauncher._update_velocity = function(l_10_0, l_10_1)
	if l_10_0._prev_position then
		local l_10_2 = l_10_0._obj_fire:position() - l_10_0._prev_position
		l_10_0._time_sum = l_10_0._time_sum + l_10_1
		l_10_0._movement_sum = l_10_0._movement_sum + l_10_2
		l_10_0._velocity = l_10_0._movement_sum / l_10_0._time_sum
		local l_10_3 = table.insert
		local l_10_4 = l_10_0._movement_history
		local l_10_5 = {}
		l_10_5.delta_move = l_10_2
		l_10_5.dt = l_10_1
		l_10_3(l_10_4, l_10_5)
	end
	if #l_10_0._movement_history >= 20 then
		l_10_0._time_sum = l_10_0._time_sum - l_10_0._movement_history[1].dt
		l_10_0._movement_sum = l_10_0._movement_sum - l_10_0._movement_history[1].delta_move
		table.remove(l_10_0._movement_history, 1)
	end
	l_10_0._prev_position = l_10_0._obj_fire:position()
end

RPG7GrenadeLauncher.fire = function(l_11_0, l_11_1)
	if l_11_0._play_fire_anim then
		l_11_0._unit:anim_set_time("fire", 0)
		l_11_0._unit:anim_play("fire")
	end
	local l_11_2 = Rotation(Vector3(0, 0, 1), 0)
	if l_11_0._fire_effect then
		local l_11_3, l_11_4 = World:effect_manager():spawn, World:effect_manager()
		local l_11_5 = {}
		l_11_5.effect = l_11_0._fire_effect
		l_11_5.parent = l_11_0._unit:get_object(l_11_0._fire_effect_object)
		l_11_5.normal = Vector3(0, 1, 0)
		l_11_5.force_synch = true
		l_11_3(l_11_4, l_11_5)
	end
	local l_11_6 = l_11_0._projectile_spawner
	local l_11_7, l_11_8 = nil, nil
	l_11_0.target_dir = nil
	l_11_0._fire_time = l_11_1
	local l_11_9 = l_11_0._wdata.aim_target_position
	local l_11_10 = l_11_6
	l_11_0.source_pos = l_11_10:position()
	l_11_8 = l_11_9 - l_11_0.source_pos:normalized()
	l_11_8 = VectorUtilities.angle_constraint_direction(l_11_8, l_11_10:rotation():y(), l_11_0._max_fire_object_and_aim_angle_diff)
	local l_11_11 = l_11_0._wdata
	l_11_0.target_dir = l_11_0:get_target_dir(l_11_0.source_pos, l_11_8, l_11_11)
	local l_11_12 = Rotation(l_11_0.target_dir, l_11_10:rotation():z())
	l_11_0._event_emitter:unit_weapon_fire_change(l_11_0._unit, l_11_0.source_pos, l_11_12, l_11_0._projectile_spawner)
	local l_11_13 = l_11_0._projectile_spawner:base():spawn_projectile(l_11_0._user_unit, l_11_0.source_pos, l_11_12)
	l_11_13:base()._inherited_velocity = l_11_0._velocity
	l_11_0._loaded_grenade:set_visibility(false)
end

RPG7GrenadeLauncher.weapon_stocked = function(l_12_0, l_12_1)
	PlayerBaseWeapon.weapon_stocked(l_12_0, l_12_1)
end


