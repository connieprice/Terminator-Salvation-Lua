require("units/beings/player/camera/PlayerCameraState")
PlayerCameraDead = PlayerCameraDead or class(PlayerCameraState)
function PlayerCameraDead.init(A0_0)
	PlayerCameraState.init(A0_0, PlayerCameraEnterDead)
	A0_0:_set_camera_name("dead")
	A0_0._camera._unit:camera_data().dead = true
	A0_0._damage_data = A0_0._camera._damage_data
end
function PlayerCameraDead.exit(A0_1)
	A0_1._camera._unit:camera_data().dead = false
end
function PlayerCameraDead.transition(A0_2)
	if not A0_2._damage_data:is_fully_damaged() then
		return PlayerCameraState.transition(A0_2)
	end
end
