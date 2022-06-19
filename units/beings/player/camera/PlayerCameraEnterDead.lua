require("units/beings/player/camera/PlayerCameraState")
require("units/beings/player/camera/PlayerCameraLookAtDeadPlayer")
if not PlayerCameraEnterDead then
	PlayerCameraEnterDead = class(PlayerCameraState)
end
PlayerCameraEnterDead.init = function(l_1_0)
	PlayerCameraState.init(l_1_0, PlayerCameraEnterDead)
	l_1_0:_set_camera_name("enter_dead")
	l_1_0._camera._unit:camera_data().enter_dead = true
	l_1_0._documentary_camera = l_1_0._camera:find_camera("enter_dead")
	assert(l_1_0._documentary_camera)
	l_1_0._damage_data = l_1_0._camera._damage_data
end

PlayerCameraEnterDead.exit = function(l_2_0)
	l_2_0._camera._unit:camera_data().enter_dead = false
end

PlayerCameraEnterDead.transition = function(l_3_0)
	if l_3_0._damage_data:is_fully_damaged() and l_3_0:_death_animation_done() then
		return PlayerCameraLookAtDeadPlayer
	end
	do return end
	local l_3_1 = PlayerCameraState.transition
	local l_3_2 = l_3_0
	return l_3_1(l_3_2)
end

PlayerCameraEnterDead._death_animation_done = function(l_4_0)
	local l_4_1 = l_4_0._camera:find_camera("enter_dead")
	assert(l_4_1)
	return l_4_1.entering_dead_done
end


