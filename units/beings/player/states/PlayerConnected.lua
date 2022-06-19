require("units/beings/player/states/PlayerMovementState.lua")
require("shared/InterpolatorLinear")
require("shared/Angle")
PlayerConnected = PlayerConnected or class(PlayerMovementState)
function PlayerConnected.init(A0_0, A1_1)
	PlayerMovementState.init(A0_0, A1_1, "PlayerDead")
	A0_0._unit = A1_1
	A1_1:kill_mover()
	A0_0._unit:anim_state_machine():play("weapon_pose/idle")
	managers.drama_scene:stop_scene()
end
function PlayerConnected.update(A0_2, A1_3, A2_4)
	if A0_2._unit:player_data().kill then
		A0_2._unit:damage():set_fully_damaged()
		return PlayerDead:new(A0_2._unit)
	end
end
