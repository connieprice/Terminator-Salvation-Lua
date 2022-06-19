require("shared/camera/CameraRoot")
require("shared/camera/DualSphereSmoothPopController")
require("TweakData")
require("units/beings/player/camera/PlayerCameraBlendTimes")
require("units/beings/player/camera/PlayerCameraDead")
require("units/beings/player/camera/PlayerCameraEnterDead")
require("units/beings/player/camera/PlayerCameraEnteringCover")
require("units/beings/player/camera/PlayerCameraInCover")
require("units/beings/player/camera/PlayerCameraInStationaryWeapon")
require("units/beings/player/camera/PlayerCameraLeavingCover")
require("units/beings/player/camera/PlayerCameraLookAtDeadPlayer")
require("units/beings/player/camera/PlayerCameraOnGround")
require("units/beings/player/camera/PlayerCameraOnRailVehicle")
require("units/beings/player/camera/PlayerCameraPeekingLeftInCover")
require("units/beings/player/camera/PlayerCameraPeekingRightInCover")
require("units/beings/player/camera/PlayerCameraPeekingUpInCover")
require("units/beings/player/camera/PlayerCameraQuickMoving")
require("units/beings/player/camera/PlayerCameraQuickMovingOverCover")
require("units/beings/player/camera/PlayerCameraStrangul")
require("units/beings/player/camera/PlayerCameraUnknownState")
require("units/beings/player/camera/PlayerCameraWounded")
if not PlayerCamera then
	PlayerCamera = class(CameraRoot)
end
PlayerCamera.CAMERA_NAMESPACE = "player"
PlayerCamera.init = function(l_1_0, l_1_1)
	CameraRoot.init(l_1_0, l_1_1)
	l_1_0._camera_name = nil
	l_1_0._player_data = l_1_1:player_data()
	l_1_0._damage_data = l_1_1:damage_data()
	l_1_0._unit_camera_data = l_1_0._unit:camera_data()
	local l_1_2 = FastSmootherPopController()
	local l_1_3, l_1_4 = l_1_2:set_parameter, l_1_2
	local l_1_5 = "ignore_units"
	local l_1_6 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	l_1_3(l_1_4, l_1_5, l_1_6)
	l_1_3(l_1_4, l_1_5, l_1_6)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_3(l_1_4, l_1_5, l_1_6)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_3(l_1_4, l_1_5, l_1_6)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._state_machine = l_1_4
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._head = l_1_4
	l_1_0._root_camera = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_4(l_1_5, l_1_6, false)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._look_at_fov = l_1_4
	l_1_0.__cover_camera_index = 1
	l_1_0._camera_distance = 10000
	l_1_0._camera_max_velocity = 250
end

PlayerCamera._create_cover_camera_duplicates = function(l_2_0)
	local l_2_8, l_2_9, l_2_10, l_2_11 = nil
	local l_2_1 = {}
	local l_2_2 = {}
	l_2_2.base_name = "incover_crouch_left_1_base"
	l_2_2.camera_name = "incover_crouch_left_1"
	l_2_2.duplicate_camera_name = "incover_crouch_left_2"
	local l_2_3 = {}
	l_2_3.base_name = "incover_crouch_right_1_base"
	l_2_3.camera_name = "incover_crouch_right_1"
	l_2_3.duplicate_camera_name = "incover_crouch_right_2"
	local l_2_4 = {}
	l_2_4.base_name = "incover_stand_left_1_base"
	l_2_4.camera_name = "incover_stand_left_1"
	l_2_4.duplicate_camera_name = "incover_stand_left_2"
	local l_2_5 = {}
	l_2_5.base_name = "incover_stand_right_1_base"
	l_2_5.camera_name = "incover_stand_right_1"
	l_2_5.duplicate_camera_name = "incover_stand_right_2"
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	l_2_2 = managers
	l_2_2 = l_2_2.camera
	l_2_3 = l_2_0._unit
	l_2_4 = l_2_0._root_camera
	l_2_5 = pairs
	l_2_5 = l_2_5(l_2_1)
	for i_0,i_1 in l_2_5 do
		assert(CameraRoot._find_camera_non_cached(l_2_0, l_2_2:create_cameras(PlayerCamera.CAMERA_NAMESPACE, l_2_3, i_1.base_name), i_1.camera_name))
		CameraRoot._find_camera_non_cached(l_2_0, l_2_2:create_cameras(PlayerCamera.CAMERA_NAMESPACE, l_2_3, i_1.base_name), i_1.camera_name)._name = l_2_13.duplicate_camera_name
		l_2_4:add_child_camera(l_2_2:create_cameras(PlayerCamera.CAMERA_NAMESPACE, l_2_3, i_1.base_name))
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

PlayerCamera.on_activate = function(l_3_0, l_3_1)
	l_3_0._unit:set_extension_update_enabled("camera", l_3_1)
	if l_3_1 then
		assert(not l_3_0._root_camera)
		l_3_0._root_camera = managers.camera:create_cameras(PlayerCamera.CAMERA_NAMESPACE, l_3_0._unit)
		l_3_0:_create_cover_camera_duplicates()
		l_3_0:build_camera_name_map()
	else
		assert(l_3_0._root_camera)
		l_3_0._root_camera:destroy()
		l_3_0._root_camera = nil
		l_3_0:destroy_camera_name_map()
	end
end

PlayerCamera.post_processing = function(l_4_0, l_4_1, l_4_2)
	l_4_0:_collision_function(l_4_1, l_4_2)
	local l_4_3 = RenderSettings.split_screen
	if l_4_3 then
		local l_4_4 = tweak_data.player.camera.split_screen_fov_multiplier
		local l_4_5 = l_4_0._camera_data.fov * l_4_4
		l_4_0._camera_data.fov = math.min(tweak_data.player.camera.split_screen_fov_max, l_4_5)
	end
end

PlayerCamera.update = function(l_5_0, l_5_1, l_5_2, l_5_3)
	if not l_5_0:is_active() then
		return 
	end
	assert(l_5_0._root_camera)
	l_5_0._state_machine:update(l_5_3)
	local l_5_4 = l_5_0._camera_name
	if not l_5_0._state_blend_time_override then
		local l_5_5, l_5_6, l_5_7, l_5_8 = l_5_0:_blend_time(l_5_4)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_5_0:view_camera(l_5_4, l_5_5)
	l_5_0:_update_look_at(l_5_3)
	CameraRoot.update(l_5_0, l_5_1, l_5_2, l_5_3)
end

PlayerCamera._update_look_at = function(l_6_0, l_6_1)
	local l_6_2 = l_6_0._unit_camera_data
	local l_6_3 = l_6_2.eye_position
	local l_6_4 = l_6_2.eye_target_position
	if not l_6_3 or not l_6_4 then
		return 
	end
	l_6_0:_update_look_at_position(l_6_1, l_6_3, l_6_4)
	l_6_0:_update_look_at_fov(l_6_1)
end

PlayerCamera._update_look_at_position = function(l_7_0, l_7_1, l_7_2, l_7_3)
	assert(l_7_2)
	assert(l_7_3)
	local l_7_4 = l_7_0._unit_camera_data
	local l_7_5 = l_7_4.look_at_position_override
	local l_7_6 = l_7_3 - l_7_2
	local l_7_7 = Rotation(l_7_3 - l_7_2, math.UP)
	local l_7_8 = l_7_3 - l_7_2:length()
	if l_7_5 then
		local l_7_9 = l_7_5 - l_7_2
		local l_7_10 = (Rotation(l_7_9, math.UP))
		local l_7_11 = nil
		if l_7_0._current_override_rotation then
			l_7_11 = l_7_0._current_override_rotation
		else
			l_7_11 = l_7_7
		end
		local l_7_12 = l_7_11:y():angle(l_7_9)
		local l_7_13 = l_7_11:slerp(l_7_10, l_7_1 * 10)
		l_7_0._current_override_rotation = l_7_13
		local l_7_14 = l_7_5 - l_7_2:length()
		local l_7_15 = l_7_12 / 180
		local l_7_16 = l_7_15 * l_7_8 + (1 - l_7_15) * l_7_14
		l_7_4.eye_target_position = l_7_2 + l_7_13:y() * l_7_16
		l_7_0._look_at_override_length = l_7_14
	elseif l_7_0._current_override_rotation then
		local l_7_17 = math.min(l_7_1 * 10, 1)
		local l_7_18 = l_7_0._current_override_rotation:slerp(l_7_7, l_7_17)
		local l_7_19 = l_7_0._look_at_override_length + (l_7_8 - l_7_0._look_at_override_length) * l_7_17
		l_7_4.eye_target_position = l_7_2 + l_7_18:y() * l_7_19
		if l_7_18:y():angle(l_7_6) < 0.1 and math.abs(l_7_19 - l_7_0._look_at_override_length) < 0.1 then
			l_7_0._current_override_rotation = nil
		end
	else
		l_7_0._look_at_override_length = l_7_19
		l_7_0._current_override_rotation = l_7_18
	end
end

PlayerCamera._update_look_at_fov = function(l_8_0, l_8_1)
	local l_8_2 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_8_0._unit_camera_data.look_at_relative_fov_override and l_8_0._unit_camera_data.look_at_relative_fov_override then
		l_8_2 = l_8_0._unit_camera_data.look_at_relative_fov_override
	else
		l_8_2 = 0
	end
	l_8_0._look_at_fov:set_target(l_8_2)
	l_8_0._look_at_fov:update(l_8_1)
	local l_8_3 = nil
	local l_8_4 = l_8_0._look_at_fov:value()
	if l_8_0:active_camera() then
		local l_8_5 = nil
	if l_8_0:find_parent(l_8_0:active_camera(), "look_at_fov") then
		end
		l_8_0:find_parent(l_8_0:active_camera(), "look_at_fov"):set_fov(l_8_4)
	end
end

PlayerCamera._near_edge_modifiers = function(l_9_0, l_9_1)
	local l_9_2, l_9_3 = nil
	if l_9_0 then
		local l_9_4 = nil
		 -- DECOMPILER ERROR: Confused about usage of registers!

		local l_9_5 = nil
		l_9_4 = (1 - math.clamp(l_9_0 / tweak_data.player.camera.cover.EDGE_OFFSET_START_DISTANCE, 0, 1)) * (1 - math.clamp(l_9_0 / tweak_data.player.camera.cover.EDGE_OFFSET_START_DISTANCE, 0, 1)) * tweak_data.player.camera.cover.EDGE_OFFSET
		if not l_9_1 then
			l_9_4 = -(l_9_4)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_9_5 = (1 - math.clamp(l_9_0 / tweak_data.player.camera.cover.EDGE_OFFSET_START_DISTANCE, 0, 1)) * (1 - math.clamp(l_9_0 / tweak_data.player.camera.cover.EDGE_OFFSET_START_DISTANCE, 0, 1)) * tweak_data.player.camera.cover.EDGE_FOV
	else
		local l_9_6, l_9_8 = 0
		l_9_8 = 0
		local l_9_7, l_9_9 = nil
	end
	local l_9_10 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return {x_offset = l_9_10, fov = l_9_8}
end

PlayerCamera._update_cover_edge_modifiers = function(l_10_0, l_10_1, l_10_2)
	local l_10_3 = l_10_0:find_parent(l_10_1, "cover_edge_offset")
	if l_10_3 then
		l_10_3:set_local_position(Vector3(l_10_2.x_offset, 0, 0))
	end
	local l_10_4 = l_10_0:find_parent(l_10_1, "cover_edge_fov")
	if l_10_4 then
		l_10_4:set_fov(l_10_2.fov)
	end
end

PlayerCamera._blend_time = function(l_11_0, l_11_1)
	local l_11_2 = (l_11_0:active_camera())
	local l_11_3 = nil
	if l_11_2 then
		local l_11_4 = PlayerCameraBlendTimes.blend_times
		local l_11_5 = l_11_2:name()
		local l_11_6 = l_11_4[l_11_5]
		if l_11_6 then
			l_11_3 = l_11_6[l_11_1]
			if not l_11_3 then
				l_11_3 = l_11_6.DEFAULT_BLEND_TIME
			if not l_11_3 then
				end
				l_11_3 = l_11_4.DEFAULT_BLEND_TIME
			end
		else
			l_11_3 = l_11_4.DEFAULT_BLEND_TIME
			assert(l_11_3, "No default blend time set for cameras")
		end
		if l_11_5 ~= l_11_1 then
			cat_debug("camera", "Switching camera from " .. l_11_5 .. " to " .. l_11_1 .. ", blend time: " .. l_11_3)
		end
	else
		l_11_3 = 0
	end
	return l_11_3
end

PlayerCamera._update_quickmove_cover_edge_modifiers = function(l_12_0, l_12_1)
	local l_12_2 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_12_0._player_data.quick_moving_to_facing_right then
		l_12_2 = PlayerCamera._near_edge_modifiers(l_12_0._player_data.quick_move_target_distance_to_right_cover_edge, true)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	else
		l_12_2 = PlayerCamera._near_edge_modifiers(l_12_0._player_data.quick_move_target_distance_to_left_cover_edge)
	end
	l_12_0:_update_cover_edge_modifiers(l_12_1, l_12_2)
end

PlayerCamera._quick_move_target_camera_name = function(l_13_0)
	local l_13_1 = l_13_0._player_data
	local l_13_2 = nil
	local l_13_3 = l_13_1.quick_move_target_cover
	if l_13_3 then
		l_13_2 = "incover"
		if managers.cover_util:high_cover(l_13_3) then
			l_13_2 = l_13_2 .. "_stand"
		else
			l_13_2 = l_13_2 .. "_crouch"
		end
		if l_13_1.quick_moving_to_facing_right then
			l_13_2 = l_13_2 .. "_right"
		else
			l_13_2 = l_13_2 .. "_left"
		end
	else
		l_13_2 = "onground"
	end
	return l_13_2
end

PlayerCamera._update_collision = function(l_14_0, l_14_1, l_14_2, l_14_3)
	local l_14_4 = l_14_0._camera_data.position
	local l_14_5 = l_14_4 - l_14_3
	local l_14_6 = l_14_5:length()
	if l_14_6 > 0 then
		l_14_5 = l_14_5 * (1 / l_14_6)
		local l_14_7 = l_14_0._pop_controller:wanted_position(l_14_3, l_14_4)
		local l_14_8 = l_14_7 * l_14_6
		local l_14_9 = nil
		if l_14_8 < l_14_0._camera_distance then
			l_14_9 = l_14_8
		else
			l_14_9 = l_14_0._camera_distance + math.clamp(l_14_8 - l_14_0._camera_distance, 0, l_14_0._camera_max_velocity * l_14_2)
		end
		local l_14_10 = l_14_3 + l_14_4 - l_14_3:normalized() * (l_14_9)
		l_14_0._camera_distance = l_14_9
		l_14_0._camera_data.position = l_14_10
	end
end

PlayerCamera.debug_render = function(l_15_0, l_15_1, l_15_2, l_15_3)
	CameraRoot.debug_render(l_15_0, l_15_1, l_15_2, l_15_3)
	local l_15_4 = Draw:brush(Color(0.3, 1, 1, 1))
	l_15_4:sphere(l_15_0:_safe_position(), 5)
	local l_15_5 = Draw:brush(Color(0.3, 1, 0, 0))
	l_15_5:sphere(l_15_0._camera_data.position, 15)
end

PlayerCamera._safe_position = function(l_16_0)
	local l_16_1 = nil
	local l_16_2 = l_16_0._player_data
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if (l_16_2.on_ground and l_16_0._unit:mover()) or l_16_2.is_down then
		l_16_1 = l_16_0._unit:position() + 190 * math.UP
	else
		l_16_1 = l_16_0._head:position() + 30 * math.UP
	end
	return l_16_1
end

PlayerCamera._update_player_collision = function(l_17_0, l_17_1, l_17_2)
	local l_17_3 = l_17_0:_safe_position()
	l_17_0:_update_collision(l_17_1, l_17_2, l_17_3)
end

PlayerCamera._update_vehicle_collision = function(l_18_0, l_18_1, l_18_2)
	local l_18_3 = l_18_0._player_data.named_camera_targets.vehicle:position() + 250 * math.UP
	l_18_0:_update_collision(l_18_3)
end

PlayerCamera._update_no_collision = function(l_19_0, l_19_1, l_19_2)
end

PlayerCamera._state_class = function(l_20_0)
	local l_20_1 = l_20_0._player_data
	local l_20_2 = l_20_0._unit:camera_data()
	local l_20_3 = l_20_0._damage_data
	if l_20_1.on_rail_vehicle or l_20_1.on_destroyed_rail_vehicle then
		return PlayerCameraOnRailVehicle
	elseif l_20_1._in_stationary_weapon then
		return PlayerCameraInStationaryWeapon
	elseif l_20_3 and l_20_3:is_fully_damaged() then
		if l_20_1.is_down then
			return PlayerCameraWounded
		else
			return PlayerCameraEnterDead
		end
	elseif l_20_1.quick_moving then
		if l_20_1.quick_moving_from_onground then
			return PlayerCameraEnteringCover
		elseif l_20_1.quick_moving_over_cover then
			return PlayerCameraQuickMovingOverCover
		else
			return PlayerCameraQuickMoving
		end
	elseif l_20_1.in_cover then
		if l_20_1.peeking_up then
			return PlayerCameraPeekingUpInCover
		elseif l_20_1.peeking_side then
			if l_20_1.facing_right_in_cover then
				return PlayerCameraPeekingRightInCover
			else
				return PlayerCameraPeekingLeftInCover
			end
		elseif l_20_1.leaving_cover then
			return PlayerCameraLeavingCover
		else
			return PlayerCameraInCover
		end
	elseif l_20_1.on_ground then
		return PlayerCameraOnGround
	elseif l_20_1.strangul then
		return PlayerCameraStrangul
	end
	return PlayerCameraUnknownState
end

PlayerCamera._cover_camera_index = function(l_21_0)
	return l_21_0.__cover_camera_index
end

PlayerCamera._switch_cover_camera_index = function(l_22_0)
	l_22_0.__cover_camera_index = l_22_0:_available_cover_camera_index()
end

PlayerCamera._available_cover_camera_index = function(l_23_0)
	local l_23_1 = iff
	l_23_1 = l_23_1(l_23_0.__cover_camera_index == 1, 2, 1)
	return l_23_1
end


