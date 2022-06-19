require("units/beings/player/camera/PlayerCameraState")
PlayerCameraQuickMovingOverCover = PlayerCameraQuickMovingOverCover or class(PlayerCameraState)
function PlayerCameraQuickMovingOverCover.init(A0_0)
	PlayerCameraState.init(A0_0, PlayerCameraQuickMovingOverCover)
end
function PlayerCameraQuickMovingOverCover.exit(A0_1)
	A0_1._camera:_switch_cover_camera_index()
end
function PlayerCameraQuickMovingOverCover.update(A0_2, A1_3)
	local L2_4, L3_5, L4_6
	L3_5 = A0_2._player_data
	L4_6 = L3_5.quick_moving_leap_stretch
	if not L4_6 then
		L4_6 = L3_5.quick_moving
	else
		if not L4_6 then
			L4_6 = A0_2._camera
			L4_6 = L4_6._quick_move_target_camera_name
			L4_6 = L4_6(L4_6)
			L2_4 = L4_6 .. "_" .. A0_2._camera:_available_cover_camera_index()
			L4_6 = A0_2._camera
			L4_6 = L4_6.find_camera
			L4_6 = L4_6(L4_6, L2_4)
			assert(L4_6, L2_4)
			A0_2._camera:_update_quickmove_cover_edge_modifiers(L4_6)
	end
	else
		L2_4 = "quick_move_over_cover"
	end
	L4_6 = A0_2._set_camera_name
	L4_6(A0_2, L2_4)
end
