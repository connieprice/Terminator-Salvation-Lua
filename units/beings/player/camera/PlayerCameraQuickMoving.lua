require("units/beings/player/camera/PlayerCameraState")
if not PlayerCameraQuickMoving then
	PlayerCameraQuickMoving = class(PlayerCameraState)
end
PlayerCameraQuickMoving.init = function(l_1_0)
	PlayerCameraState.init(l_1_0, PlayerCameraQuickMoving)
	l_1_0._quick_move_camera = l_1_0._camera:find_camera("quick_move")
	assert(l_1_0._quick_move_camera)
	l_1_0:_set_camera_name("quick_move")
end

PlayerCameraQuickMoving.exit = function(l_2_0)
	l_2_0._camera:_switch_cover_camera_index()
end

PlayerCameraQuickMoving.update = function(l_3_0, l_3_1)
	local l_3_2 = l_3_0._player_data
	local l_3_3 = l_3_0._quick_move_camera
	assert(l_3_3)
	local l_3_4 = nil
	if l_3_2.quick_moving_from_onground then
		l_3_4 = "onground"
	elseif l_3_2.quick_moving_from_crouch_cover then
		l_3_4 = "incover_crouch"
	else
		l_3_4 = "incover_stand"
	end
	if l_3_2.quick_moving_from_facing_right then
		l_3_4 = l_3_4 .. "_right"
	else
		l_3_4 = l_3_4 .. "_left"
	end
	if l_3_4 ~= l_3_0._source_camera_name then
		l_3_0._source_camera_name = l_3_4
		local l_3_5 = nil
		if not l_3_2.quick_moving_from_onground then
			local l_3_6 = nil
			if l_3_2.quick_moving_from_facing_right then
				l_3_6 = PlayerCamera._near_edge_modifiers(l_3_2.distance_to_right_cover_edge, true)
			else
				l_3_6 = PlayerCamera._near_edge_modifiers(l_3_2.distance_to_left_cover_edge, false)
			end
			local l_3_7 = l_3_0._camera:_cover_camera_index()
			l_3_4 = l_3_4 .. "_" .. l_3_7
			l_3_5 = l_3_0._camera:find_camera(l_3_4)
			l_3_0._camera:_update_cover_edge_modifiers(l_3_5, l_3_6)
		else
			l_3_5 = l_3_0._camera:find_camera(l_3_4)
		end
		assert(l_3_5, l_3_4)
		cat_print("camera", "Selecting quick move source camera name: " .. l_3_4)
		l_3_3:set_source_camera(l_3_5)
	end
	local l_3_8 = l_3_0._camera:_quick_move_target_camera_name()
	if l_3_8 ~= l_3_0._target_camera_name then
		l_3_0._target_camera_name = l_3_8
		local l_3_9 = l_3_0._camera:_available_cover_camera_index()
		l_3_8 = l_3_8 .. "_" .. l_3_9
		local l_3_10 = l_3_0._camera:find_camera(l_3_8)
		assert(l_3_10, l_3_8)
		cat_print("camera", "Selecting quick move target camera name: " .. l_3_8)
		l_3_3:set_target_camera(l_3_10)
		l_3_0._target_camera = l_3_10
	end
	l_3_0._camera:_update_quickmove_cover_edge_modifiers(l_3_0._target_camera)
	l_3_3:set_factor(math.sin(270 + l_3_2.quick_moving_relative_length * 180) * 0.5 + 0.5)
end


