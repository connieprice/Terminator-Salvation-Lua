require("units/beings/player/camera/PlayerCameraState")
require("units/beings/player/camera/PlayerCameraDead")
PlayerCameraLookAtDeadPlayer = PlayerCameraLookAtDeadPlayer or class(PlayerCameraState)
function PlayerCameraLookAtDeadPlayer.init(A0_0)
	PlayerCameraState.init(A0_0, PlayerCameraEnterDead)
	A0_0:_set_camera_name("look_at_dead_player")
	A0_0._timeout = 1.5
	A0_0._damage_data = A0_0._camera._damage_data
end
function PlayerCameraLookAtDeadPlayer.update(A0_1, A1_2)
	local L2_3
	L2_3 = A0_1._timeout
	L2_3 = L2_3 - A1_2
	A0_1._timeout = L2_3
end
function PlayerCameraLookAtDeadPlayer.transition(A0_4)
	if A0_4._damage_data:is_fully_damaged() then
		if A0_4:_done() then
			return PlayerCameraDead
		end
	else
		return PlayerCameraState.transition(A0_4)
	end
end
function PlayerCameraLookAtDeadPlayer._done(A0_5)
	return A0_5._timeout <= 0
end
