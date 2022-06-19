require("units/beings/player/camera/PlayerCameraState")
PlayerCameraInCover = PlayerCameraInCover or class(PlayerCameraState)
function PlayerCameraInCover.init(A0_0)
	PlayerCameraState.init(A0_0, PlayerCameraInCover)
end
function PlayerCameraInCover.update(A0_1, A1_2)
	local L2_3, L3_4, L4_5, L5_6
	L2_3 = A0_1._player_data
	L3_4 = L2_3.cover
	if not L3_4 then
		return
	end
	L3_4 = nil
	L4_5 = L2_3.is_precision_aiming
	if L4_5 then
		L4_5 = L2_3.facing_right_in_cover
		if L4_5 then
			L3_4 = "zoom_aim_right"
		else
			L3_4 = "zoom_aim_left"
		end
	else
		L4_5 = managers
		L4_5 = L4_5.cover_util
		L5_6 = L4_5
		L4_5 = L4_5.high_cover
		L4_5 = L4_5(L5_6, L2_3.cover)
		if L4_5 then
			L3_4 = "incover_stand"
		else
			L3_4 = "incover_crouch"
		end
		L4_5 = nil
		L5_6 = L2_3.facing_right_in_cover
		if L5_6 then
			L5_6 = L3_4
			L3_4 = L5_6 .. "_right"
			L5_6 = PlayerCamera
			L5_6 = L5_6._near_edge_modifiers
			L5_6 = L5_6(L2_3.distance_to_right_cover_edge, true)
			L4_5 = L5_6
		else
			L5_6 = L3_4
			L3_4 = L5_6 .. "_left"
			L5_6 = PlayerCamera
			L5_6 = L5_6._near_edge_modifiers
			L5_6 = L5_6(L2_3.distance_to_left_cover_edge)
			L4_5 = L5_6
		end
		L5_6 = L3_4
		L3_4 = L5_6 .. "_" .. A0_1._camera:_cover_camera_index()
		L5_6 = A0_1._camera
		L5_6 = L5_6.find_camera
		L5_6 = L5_6(L5_6, L3_4)
		assert(L5_6)
		A0_1._camera:_update_cover_edge_modifiers(L5_6, L4_5)
	end
	L5_6 = A0_1
	L4_5 = A0_1._set_camera_name
	L4_5(L5_6, L3_4)
end
