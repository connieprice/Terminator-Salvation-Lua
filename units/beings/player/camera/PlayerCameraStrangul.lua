require("units/beings/player/camera/PlayerCameraState")
PlayerCameraStrangul = PlayerCameraStrangul or class(PlayerCameraState)
function PlayerCameraStrangul.init(A0_0)
	PlayerCameraState.init(A0_0, PlayerCameraStrangul)
	A0_0:_set_camera_name("strangul")
end
function PlayerCameraStrangul.transition(A0_1)
	local L1_2
	L1_2 = A0_1._camera
	L1_2 = L1_2._damage_data
	if L1_2:is_fully_damaged() then
		return PlayerCameraLookAtDeadPlayer
	end
	return PlayerCameraState.transition(A0_1)
end
