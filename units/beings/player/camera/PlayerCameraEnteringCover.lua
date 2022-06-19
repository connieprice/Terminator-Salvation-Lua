require("units/beings/player/camera/PlayerCameraState")
PlayerCameraEnteringCover = PlayerCameraEnteringCover or class(PlayerCameraState)
function PlayerCameraEnteringCover.init(A0_0)
	PlayerCameraState.init(A0_0, PlayerCameraEnteringCover)
end
function PlayerCameraEnteringCover.exit(A0_1)
	A0_1._camera:_switch_cover_camera_index()
end
function PlayerCameraEnteringCover.update(A0_2, A1_3)
	local L2_4, L3_5, L4_6
	L2_4 = A0_2._camera
	L3_5 = L2_4
	L2_4 = L2_4._quick_move_target_camera_name
	L2_4 = L2_4(L3_5)
	L3_5 = assert
	L4_6 = L2_4
	L3_5(L4_6)
	L3_5 = A0_2._cover_camera_name
	if L2_4 ~= L3_5 then
		A0_2._cover_camera_name = L2_4
		L3_5 = L2_4
		L4_6 = "_"
		L3_5 = L3_5 .. L4_6 .. A0_2._camera:_available_cover_camera_index()
		L4_6 = A0_2._camera
		L4_6 = L4_6.find_camera
		L4_6 = L4_6(L4_6, L3_5)
		assert(L4_6)
		A0_2._cover_camera = L4_6
		A0_2:_set_camera_name(L3_5)
	end
	L3_5 = A0_2._camera
	L4_6 = L3_5
	L3_5 = L3_5._update_quickmove_cover_edge_modifiers
	L3_5(L4_6, A0_2._cover_camera)
end
