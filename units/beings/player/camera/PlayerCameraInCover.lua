require("units/beings/player/camera/PlayerCameraState")
if not PlayerCameraInCover then
	PlayerCameraInCover = class(PlayerCameraState)
end
PlayerCameraInCover.init = function(l_1_0)
	PlayerCameraState.init(l_1_0, PlayerCameraInCover)
end

PlayerCameraInCover.update = function(l_2_0, l_2_1)
	local l_2_2 = l_2_0._player_data
	if not l_2_2.cover then
		return 
	end
	local l_2_3 = nil
	if l_2_2.is_precision_aiming then
		if l_2_2.facing_right_in_cover then
			l_2_3 = "zoom_aim_right"
		else
			l_2_3 = "zoom_aim_left"
		end
	else
		if managers.cover_util:high_cover(l_2_2.cover) then
			l_2_3 = "incover_stand"
		else
			l_2_3 = "incover_crouch"
		end
		local l_2_4 = nil
		if l_2_2.facing_right_in_cover then
			l_2_3 = l_2_3 .. "_right"
			l_2_4 = PlayerCamera._near_edge_modifiers(l_2_2.distance_to_right_cover_edge, true)
		else
			l_2_3 = l_2_3 .. "_left"
			l_2_4 = PlayerCamera._near_edge_modifiers(l_2_2.distance_to_left_cover_edge)
		end
		l_2_3 = l_2_3 .. "_" .. l_2_0._camera:_cover_camera_index()
		local l_2_5 = l_2_0._camera:find_camera(l_2_3)
		assert(l_2_5)
		l_2_0._camera:_update_cover_edge_modifiers(l_2_5, l_2_4)
	end
	l_2_0:_set_camera_name(l_2_3)
end


