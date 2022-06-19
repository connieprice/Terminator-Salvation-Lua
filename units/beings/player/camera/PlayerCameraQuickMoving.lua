require("units/beings/player/camera/PlayerCameraState")
PlayerCameraQuickMoving = PlayerCameraQuickMoving or class(PlayerCameraState)
function PlayerCameraQuickMoving.init(A0_0)
	PlayerCameraState.init(A0_0, PlayerCameraQuickMoving)
	A0_0._quick_move_camera = A0_0._camera:find_camera("quick_move")
	assert(A0_0._quick_move_camera)
	A0_0:_set_camera_name("quick_move")
end
function PlayerCameraQuickMoving.exit(A0_1)
	A0_1._camera:_switch_cover_camera_index()
end
function PlayerCameraQuickMoving.update(A0_2, A1_3)
	local L2_4, L3_5, L4_6, L5_7, L6_8, L7_9
	L2_4 = A0_2._player_data
	L3_5 = A0_2._quick_move_camera
	L4_6 = assert
	L5_7 = L3_5
	L4_6(L5_7)
	L4_6 = nil
	L5_7 = L2_4.quick_moving_from_onground
	if L5_7 then
		L4_6 = "onground"
	else
		L5_7 = L2_4.quick_moving_from_crouch_cover
		if L5_7 then
			L4_6 = "incover_crouch"
		else
			L4_6 = "incover_stand"
		end
		L5_7 = L2_4.quick_moving_from_facing_right
		if L5_7 then
			L5_7 = L4_6
			L6_8 = "_right"
			L4_6 = L5_7 .. L6_8
		else
			L5_7 = L4_6
			L6_8 = "_left"
			L4_6 = L5_7 .. L6_8
		end
	end
	L5_7 = A0_2._source_camera_name
	if L4_6 ~= L5_7 then
		A0_2._source_camera_name = L4_6
		L5_7 = nil
		L6_8 = L2_4.quick_moving_from_onground
		if not L6_8 then
			L6_8 = nil
			L7_9 = L2_4.quick_moving_from_facing_right
			if L7_9 then
				L7_9 = PlayerCamera
				L7_9 = L7_9._near_edge_modifiers
				L7_9 = L7_9(L2_4.distance_to_right_cover_edge, true)
				L6_8 = L7_9
			else
				L7_9 = PlayerCamera
				L7_9 = L7_9._near_edge_modifiers
				L7_9 = L7_9(L2_4.distance_to_left_cover_edge, false)
				L6_8 = L7_9
			end
			L7_9 = A0_2._camera
			L7_9 = L7_9._cover_camera_index
			L7_9 = L7_9(L7_9)
			L4_6 = L4_6 .. "_" .. L7_9
			L5_7 = A0_2._camera:find_camera(L4_6)
			A0_2._camera:_update_cover_edge_modifiers(L5_7, L6_8)
		else
			L6_8 = A0_2._camera
			L7_9 = L6_8
			L6_8 = L6_8.find_camera
			L6_8 = L6_8(L7_9, L4_6)
			L5_7 = L6_8
		end
		L6_8 = assert
		L7_9 = L5_7
		L6_8(L7_9, L4_6)
		L6_8 = cat_print
		L7_9 = "camera"
		L6_8(L7_9, "Selecting quick move source camera name: " .. L4_6)
		L7_9 = L3_5
		L6_8 = L3_5.set_source_camera
		L6_8(L7_9, L5_7)
	end
	L5_7 = A0_2._camera
	L6_8 = L5_7
	L5_7 = L5_7._quick_move_target_camera_name
	L5_7 = L5_7(L6_8)
	L6_8 = A0_2._target_camera_name
	if L5_7 ~= L6_8 then
		A0_2._target_camera_name = L5_7
		L6_8 = A0_2._camera
		L7_9 = L6_8
		L6_8 = L6_8._available_cover_camera_index
		L6_8 = L6_8(L7_9)
		L7_9 = L5_7
		L5_7 = L7_9 .. "_" .. L6_8
		L7_9 = A0_2._camera
		L7_9 = L7_9.find_camera
		L7_9 = L7_9(L7_9, L5_7)
		assert(L7_9, L5_7)
		cat_print("camera", "Selecting quick move target camera name: " .. L5_7)
		L3_5:set_target_camera(L7_9)
		A0_2._target_camera = L7_9
	end
	L6_8 = A0_2._camera
	L7_9 = L6_8
	L6_8 = L6_8._update_quickmove_cover_edge_modifiers
	L6_8(L7_9, A0_2._target_camera)
	L7_9 = L3_5
	L6_8 = L3_5.set_factor
	L6_8(L7_9, math.sin(270 + L2_4.quick_moving_relative_length * 180) * 0.5 + 0.5)
end
