require("shared/FiniteStateMachineState")
if not PlayerCameraState then
	PlayerCameraState = class(FiniteStateMachineState)
end
PlayerCameraState.init = function(l_1_0, l_1_1)
	l_1_0._state_class = l_1_1
	l_1_0._player_data = l_1_0._camera._player_data
	l_1_0._camera_data = l_1_0._camera._camera_data
	l_1_0:_set_collision(l_1_0._camera._update_player_collision)
end

PlayerCameraState.pre_update_transition = function(l_2_0)
	local l_2_1 = l_2_0._camera:_state_class()
	if l_2_1 ~= l_2_0._state_class then
		return l_2_1
	end
end

PlayerCameraState.transition = function(l_3_0)
	local l_3_1 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_3_1
end

PlayerCameraState._set_camera_name = function(l_4_0, l_4_1)
	l_4_0._camera._camera_name = l_4_1
end

PlayerCameraState._set_collision = function(l_5_0, l_5_1)
	l_5_0._camera._collision_function = l_5_1
end


