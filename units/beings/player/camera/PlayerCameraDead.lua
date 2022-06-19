require("units/beings/player/camera/PlayerCameraState")
if not PlayerCameraDead then
	PlayerCameraDead = class(PlayerCameraState)
end
PlayerCameraDead.init = function(l_1_0)
	PlayerCameraState.init(l_1_0, PlayerCameraEnterDead)
	l_1_0:_set_camera_name("dead")
	l_1_0._camera._unit:camera_data().dead = true
	l_1_0._damage_data = l_1_0._camera._damage_data
end

PlayerCameraDead.exit = function(l_2_0)
	l_2_0._camera._unit:camera_data().dead = false
end

PlayerCameraDead.transition = function(l_3_0)
	if not l_3_0._damage_data:is_fully_damaged() then
		local l_3_1 = PlayerCameraState.transition
		local l_3_2 = l_3_0
		return l_3_1(l_3_2)
	end
end


