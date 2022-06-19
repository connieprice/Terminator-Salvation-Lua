require("units/beings/player/states/PlayerMovementState.lua")
if not PlayerRailTrainState then
	PlayerRailTrainState = class(PlayerMovementState)
end
PlayerRailTrainState.init = function(l_1_0, l_1_1)
	PlayerMovementState.init(l_1_0, l_1_1, "PlayerOnRailTrain")
	l_1_0._unit:anim_state_machine():play("weapon_pose/idle")
	l_1_0._vehicle = l_1_0._unit:rail():get_vehicle()
	l_1_0._unit:base():activate_mover("stand")
	l_1_0._unit:set_driving("script")
	l_1_0._unit:anim_state_machine():play("weapon_pose/idle_rpg")
	l_1_0._shaking = false
	l_1_0._camera_shake = "train"
	l_1_0._player_data = l_1_0._unit:player_data()
end

PlayerRailTrainState.update = function(l_2_0, l_2_1, l_2_2)
	local l_2_3 = l_2_0._base:check_fully_damaged()
	if l_2_3 then
		return l_2_3
	end
	if not alive(l_2_0._vehicle) or l_2_0._vehicle:vehicle_data().destroyed then
		local l_2_4 = l_2_0._unit
		local l_2_5 = l_2_0._player_data
		l_2_4:rail():exit_vehicle()
		if tweak_data.rail.USE_RAGDOLLS then
			l_2_4:base():ragdoll()
		else
			l_2_4:set_visible(false)
		end
		l_2_5.rail_vehicle_camera = l_2_0._vehicle:vehicle_data().death_camera
		l_2_5.rail_vehicle_permanent_camera = true
		l_2_5.rail_vehicle_camera_blend_time = 0
		l_2_4:set_extension_update_enabled("base", false)
		l_2_5.on_destroyed_rail_vehicle = true
		return 
	end
	PlayerMovementState.update(l_2_0, l_2_1, l_2_2)
	l_2_0._current_animation = l_2_0._vehicle:base():get_seat(l_2_0._unit):get_animation()
	PlayerMovementState._update_aim_parameters(l_2_0, l_2_2)
	l_2_0:_update_shake()
	if l_2_0._player_data.reloading then
		l_2_0._unit:play_redirect("stop_shake_for_reload")
	end
end

PlayerRailTrainState._update_shake = function(l_3_0)
	if tweak_data.rail.vehicle.rail_subway_train.SHAKE_START_SPEED < l_3_0._vehicle:base():get_speed_vector():length() then
		l_3_0._player_data.rail_vehicle_shake = l_3_0._camera_shake
	else
		l_3_0._player_data.rail_vehicle_shake = nil
	end
end

PlayerRailTrainState.destroy = function(l_4_0)
	PlayerMovementState.destroy(l_4_0)
	l_4_0._player_data.rail_vehicle_shake = nil
end

PlayerRailTrainState.enter = function(l_5_0)
	PlayerMovementState.enter(l_5_0)
	l_5_0._unit:kill_mover()
	local l_5_1 = World:spawn_unit("subway_rpg_launcher", l_5_0._unit:position(), l_5_0._unit:rotation())
	l_5_0._unit:base():force_equip_weapon(l_5_1, "a_weapon_right_back")
	l_5_0._unit:base():set_unequiped_weapon_visiblity(false, true)
	l_5_0._current_animation = l_5_0._vehicle:base():get_seat(l_5_0._unit):get_animation()
	l_5_0._unit:play_redirect(l_5_0._current_animation)
	l_5_0._player_data.named_camera_targets.weapon = l_5_1
	l_5_0._unit:look():set_eye_target_distance(100000)
end

PlayerRailTrainState.leave = function(l_6_0)
	l_6_0._player_data.named_camera_targets.weapon = nil
	l_6_0._unit:base():set_unequiped_weapon_visiblity(true)
	PlayerMovementState.leave(l_6_0)
	l_6_0._unit:look():reset_eye_target_distance()
	l_6_0._player_data.rail_vehicle_shake = nil
end


