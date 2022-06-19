require("units/beings/player/camera/PlayerCameraState")
require("units/beings/player/camera/PlayerCameraDead")
if not PlayerCameraLookAtDeadPlayer then
	PlayerCameraLookAtDeadPlayer = class(PlayerCameraState)
end
PlayerCameraLookAtDeadPlayer.init = function(l_1_0)
	PlayerCameraState.init(l_1_0, PlayerCameraEnterDead)
	l_1_0:_set_camera_name("look_at_dead_player")
	l_1_0._timeout = 1.5
	l_1_0._damage_data = l_1_0._camera._damage_data
end

PlayerCameraLookAtDeadPlayer.update = function(l_2_0, l_2_1)
	l_2_0._timeout = l_2_0._timeout - l_2_1
end

PlayerCameraLookAtDeadPlayer.transition = function(l_3_0)
	if l_3_0._damage_data:is_fully_damaged() and l_3_0:_done() then
		return PlayerCameraDead
	end
	do return end
	local l_3_1 = PlayerCameraState.transition
	local l_3_2 = l_3_0
	return l_3_1(l_3_2)
end

PlayerCameraLookAtDeadPlayer._done = function(l_4_0)
	return l_4_0._timeout <= 0
end


