require("units/beings/player/states/PlayerMovementState.lua")
if not PlayerBoardingVehicle then
	PlayerBoardingVehicle = class(PlayerMovementState)
end
PlayerBoardingVehicle.init = function(l_1_0, l_1_1)
	PlayerMovementState.init(l_1_0, l_1_1, "PlayerBoardingVehicle")
	l_1_0._unit:anim_state_machine():play("weapon_pose/idle")
	l_1_0._base:activate_mover("stand")
	l_1_0._unit:set_driving("script")
	l_1_0._seat = l_1_0._unit:rail():get_vehicle():base():get_seat(l_1_0._unit)
end

PlayerBoardingVehicle.update = function(l_2_0, l_2_1, l_2_2)
	local l_2_3 = l_2_0._base:check_fully_damaged()
	if l_2_3 then
		return l_2_3
	end
	PlayerMovementState.update(l_2_0, l_2_1, l_2_2)
	if not l_2_0._unit:player_data().rail_boarding_vehicle then
		local l_2_6, l_2_7 = l_2_0._unit:rail():change_seat, l_2_0._unit:rail()
		l_2_6(l_2_7, l_2_0._seat:get_exit_to())
		l_2_6 = l_2_0._unit
		l_2_6, l_2_7 = l_2_6:rail, l_2_6
		l_2_6 = l_2_6(l_2_7)
		l_2_6, l_2_7 = l_2_6:get_rail_state, l_2_6
		local l_2_4, l_2_5 = nil
		return l_2_6(l_2_7)
	end
end

PlayerBoardingVehicle.enter = function(l_3_0)
	PlayerMovementState.enter(l_3_0)
	l_3_0._unit:play_redirect(l_3_0._seat:get_animation())
end


