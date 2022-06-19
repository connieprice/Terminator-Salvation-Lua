require("units/beings/player/camera/PlayerCameraState")
require("units/beings/player/camera/PlayerCameraLookAtDeadPlayer")
PlayerCameraEnterDead = PlayerCameraEnterDead or class(PlayerCameraState)
function PlayerCameraEnterDead.init(A0_0)
	PlayerCameraState.init(A0_0, PlayerCameraEnterDead)
	A0_0:_set_camera_name("enter_dead")
	A0_0._camera._unit:camera_data().enter_dead = true
	A0_0._documentary_camera = A0_0._camera:find_camera("enter_dead")
	assert(A0_0._documentary_camera)
	A0_0._damage_data = A0_0._camera._damage_data
end
function PlayerCameraEnterDead.exit(A0_1)
	A0_1._camera._unit:camera_data().enter_dead = false
end
function PlayerCameraEnterDead.transition(A0_2)
	if A0_2._damage_data:is_fully_damaged() then
		if A0_2:_death_animation_done() then
			return PlayerCameraLookAtDeadPlayer
		end
	else
		return PlayerCameraState.transition(A0_2)
	end
end
function PlayerCameraEnterDead._death_animation_done(A0_3)
	local L1_4
	L1_4 = A0_3._camera
	L1_4 = L1_4.find_camera
	L1_4 = L1_4(L1_4, "enter_dead")
	assert(L1_4)
	return L1_4.entering_dead_done
end
