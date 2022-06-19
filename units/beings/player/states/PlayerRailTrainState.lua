require("units/beings/player/states/PlayerMovementState.lua")
PlayerRailTrainState = PlayerRailTrainState or class(PlayerMovementState)
function PlayerRailTrainState.init(A0_0, A1_1)
	PlayerMovementState.init(A0_0, A1_1, "PlayerOnRailTrain")
	A0_0._unit:anim_state_machine():play("weapon_pose/idle")
	A0_0._vehicle = A0_0._unit:rail():get_vehicle()
	A0_0._unit:base():activate_mover("stand")
	A0_0._unit:set_driving("script")
	A0_0._unit:anim_state_machine():play("weapon_pose/idle_rpg")
	A0_0._shaking = false
	A0_0._camera_shake = "train"
	A0_0._player_data = A0_0._unit:player_data()
end
function PlayerRailTrainState.update(A0_2, A1_3, A2_4)
	if A0_2._base:check_fully_damaged() then
		return (A0_2._base:check_fully_damaged())
	end
	if not alive(A0_2._vehicle) or A0_2._vehicle:vehicle_data().destroyed then
		A0_2._unit:rail():exit_vehicle()
		if tweak_data.rail.USE_RAGDOLLS then
			A0_2._unit:base():ragdoll()
		else
			A0_2._unit:set_visible(false)
		end
		A0_2._player_data.rail_vehicle_camera = A0_2._vehicle:vehicle_data().death_camera
		A0_2._player_data.rail_vehicle_permanent_camera = true
		A0_2._player_data.rail_vehicle_camera_blend_time = 0
		A0_2._unit:set_extension_update_enabled("base", false)
		A0_2._player_data.on_destroyed_rail_vehicle = true
		return
	end
	PlayerMovementState.update(A0_2, A1_3, A2_4)
	A0_2._current_animation = A0_2._vehicle:base():get_seat(A0_2._unit):get_animation()
	PlayerMovementState._update_aim_parameters(A0_2, A2_4)
	A0_2:_update_shake()
	if A0_2._player_data.reloading then
		A0_2._unit:play_redirect("stop_shake_for_reload")
	end
end
function PlayerRailTrainState._update_shake(A0_5)
	if A0_5._vehicle:base():get_speed_vector():length() > tweak_data.rail.vehicle.rail_subway_train.SHAKE_START_SPEED then
		A0_5._player_data.rail_vehicle_shake = A0_5._camera_shake
	else
		A0_5._player_data.rail_vehicle_shake = nil
	end
end
function PlayerRailTrainState.destroy(A0_6)
	PlayerMovementState.destroy(A0_6)
	A0_6._player_data.rail_vehicle_shake = nil
end
function PlayerRailTrainState.enter(A0_7)
	local L1_8
	L1_8 = PlayerMovementState
	L1_8 = L1_8.enter
	L1_8(A0_7)
	L1_8 = A0_7._unit
	L1_8 = L1_8.kill_mover
	L1_8(L1_8)
	L1_8 = World
	L1_8 = L1_8.spawn_unit
	L1_8 = L1_8(L1_8, "subway_rpg_launcher", A0_7._unit:position(), A0_7._unit:rotation())
	A0_7._unit:base():force_equip_weapon(L1_8, "a_weapon_right_back")
	A0_7._unit:base():set_unequiped_weapon_visiblity(false, true)
	A0_7._current_animation = A0_7._vehicle:base():get_seat(A0_7._unit):get_animation()
	A0_7._unit:play_redirect(A0_7._current_animation)
	A0_7._player_data.named_camera_targets.weapon = L1_8
	A0_7._unit:look():set_eye_target_distance(100000)
end
function PlayerRailTrainState.leave(A0_9)
	A0_9._player_data.named_camera_targets.weapon = nil
	A0_9._unit:base():set_unequiped_weapon_visiblity(true)
	PlayerMovementState.leave(A0_9)
	A0_9._unit:look():reset_eye_target_distance()
	A0_9._player_data.rail_vehicle_shake = nil
end
