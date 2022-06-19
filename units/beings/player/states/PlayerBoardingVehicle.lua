require("units/beings/player/states/PlayerMovementState.lua")
PlayerBoardingVehicle = PlayerBoardingVehicle or class(PlayerMovementState)
function PlayerBoardingVehicle.init(A0_0, A1_1)
	PlayerMovementState.init(A0_0, A1_1, "PlayerBoardingVehicle")
	A0_0._unit:anim_state_machine():play("weapon_pose/idle")
	A0_0._base:activate_mover("stand")
	A0_0._unit:set_driving("script")
	A0_0._seat = A0_0._unit:rail():get_vehicle():base():get_seat(A0_0._unit)
end
function PlayerBoardingVehicle.update(A0_2, A1_3, A2_4)
	if A0_2._base:check_fully_damaged() then
		return (A0_2._base:check_fully_damaged())
	end
	PlayerMovementState.update(A0_2, A1_3, A2_4)
	if not A0_2._unit:player_data().rail_boarding_vehicle then
		A0_2._unit:rail():change_seat(A0_2._seat:get_exit_to())
		return A0_2._unit:rail():get_rail_state()
	end
end
function PlayerBoardingVehicle.enter(A0_5)
	PlayerMovementState.enter(A0_5)
	A0_5._unit:play_redirect(A0_5._seat:get_animation())
end
