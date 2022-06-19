require("shared/FiniteStateMachineState")
PlayerCameraState = PlayerCameraState or class(FiniteStateMachineState)
function PlayerCameraState.init(A0_0, A1_1)
	A0_0._state_class = A1_1
	A0_0._player_data = A0_0._camera._player_data
	A0_0._camera_data = A0_0._camera._camera_data
	A0_0:_set_collision(A0_0._camera._update_player_collision)
end
function PlayerCameraState.pre_update_transition(A0_2)
	if A0_2._camera:_state_class() ~= A0_2._state_class then
		return (A0_2._camera:_state_class())
	end
end
function PlayerCameraState.transition(A0_3)
	local L1_4
	return L1_4
end
function PlayerCameraState._set_camera_name(A0_5, A1_6)
	A0_5._camera._camera_name = A1_6
end
function PlayerCameraState._set_collision(A0_7, A1_8)
	A0_7._camera._collision_function = A1_8
end
