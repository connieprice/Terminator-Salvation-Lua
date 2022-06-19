require("units/beings/player/camera/PlayerCameraState")
if not PlayerCameraStrangul then
	PlayerCameraStrangul = class(PlayerCameraState)
end
PlayerCameraStrangul.init = function(l_1_0)
	PlayerCameraState.init(l_1_0, PlayerCameraStrangul)
	l_1_0:_set_camera_name("strangul")
end

PlayerCameraStrangul.transition = function(l_2_0)
	local l_2_1 = l_2_0._camera._damage_data
	if l_2_1:is_fully_damaged() then
		return PlayerCameraLookAtDeadPlayer
	end
	local l_2_2 = PlayerCameraState.transition
	local l_2_3 = l_2_0
	return l_2_2(l_2_3)
end


