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
PlayerCamera = PlayerCamera or class(CameraRoot)
PlayerCamera.CAMERA_NAMESPACE = "player"
function PlayerCamera.init(A0_0, A1_1)
	local L2_2, L3_3
	L2_2 = CameraRoot
	L2_2 = L2_2.init
	L3_3 = A0_0
	L2_2(L3_3, A1_1)
	A0_0._camera_name = nil
	L3_3 = A1_1
	L2_2 = A1_1.player_data
	L2_2 = L2_2(L3_3)
	A0_0._player_data = L2_2
	L3_3 = A1_1
	L2_2 = A1_1.damage_data
	L2_2 = L2_2(L3_3)
	A0_0._damage_data = L2_2
	L2_2 = A0_0._unit
	L3_3 = L2_2
	L2_2 = L2_2.camera_data
	L2_2 = L2_2(L3_3)
	A0_0._unit_camera_data = L2_2
	L2_2 = FastSmootherPopController
	L2_2 = L2_2()
	L3_3 = L2_2.set_parameter
	L3_3(L2_2, "ignore_units", {A1_1})
	L3_3 = L2_2.set_parameter
	L3_3(L2_2, "smooth_radius", 30)
	L3_3 = L2_2.set_parameter
	L3_3(L2_2, "near_radius", 5)
	L3_3 = L2_2.set_parameter
	L3_3(L2_2, "precision", 0.005)
	A0_0._pop_controller = L2_2
	A0_0._zoom_camera_active = false
	A0_0._collision_function = nil
	L3_3 = A0_0._state_class
	L3_3 = L3_3(A0_0)
	A0_0._state_machine = FiniteStateMachine:new(A0_0, "_camera", L3_3)
	A0_0._head = A1_1:get_object("Head")
	A0_0._root_camera = nil
	A0_0._unit:set_extension_update_enabled("camera", false)
	A0_0._look_at_fov = Interpolator:new(0, 4)
	A0_0.__cover_camera_index = 1
	A0_0._camera_distance = 10000
	A0_0._camera_max_velocity = 250
end
function PlayerCamera._create_cover_camera_duplicates(A0_4)
	local L1_5, L2_6, L3_7, L4_8, L5_9, L6_10, L7_11, L8_12, L9_13, L10_14, L11_15
	L1_5 = {
		L2_6,
		L3_7,
		L4_8,
		L5_9
	}
	L2_6 = {}
	L2_6.base_name = "incover_crouch_left_1_base"
	L2_6.camera_name = "incover_crouch_left_1"
	L2_6.duplicate_camera_name = "incover_crouch_left_2"
	L3_7 = {}
	L3_7.base_name = "incover_crouch_right_1_base"
	L3_7.camera_name = "incover_crouch_right_1"
	L3_7.duplicate_camera_name = "incover_crouch_right_2"
	L4_8 = {}
	L4_8.base_name = "incover_stand_left_1_base"
	L4_8.camera_name = "incover_stand_left_1"
	L4_8.duplicate_camera_name = "incover_stand_left_2"
	L5_9.base_name = "incover_stand_right_1_base"
	L5_9.camera_name = "incover_stand_right_1"
	L5_9.duplicate_camera_name = "incover_stand_right_2"
	L2_6 = managers
	L2_6 = L2_6.camera
	L3_7 = A0_4._unit
	L4_8 = A0_4._root_camera
	for L8_12, L9_13 in L5_9(L6_10) do
		L11_15 = L2_6
		L10_14 = L2_6.create_cameras
		L10_14 = L10_14(L11_15, PlayerCamera.CAMERA_NAMESPACE, L3_7, L9_13.base_name)
		L11_15 = CameraRoot
		L11_15 = L11_15._find_camera_non_cached
		L11_15 = L11_15(A0_4, L10_14, L9_13.camera_name)
		assert(L11_15)
		L11_15._name = L9_13.duplicate_camera_name
		L4_8:add_child_camera(L10_14)
	end
end
function PlayerCamera.on_activate(A0_16, A1_17)
	A0_16._unit:set_extension_update_enabled("camera", A1_17)
	if A1_17 then
		assert(not A0_16._root_camera)
		A0_16._root_camera = managers.camera:create_cameras(PlayerCamera.CAMERA_NAMESPACE, A0_16._unit)
		A0_16:_create_cover_camera_duplicates()
		A0_16:build_camera_name_map()
	else
		assert(A0_16._root_camera)
		A0_16._root_camera:destroy()
		A0_16._root_camera = nil
		A0_16:destroy_camera_name_map()
	end
end
function PlayerCamera.post_processing(A0_18, A1_19, A2_20)
	local L3_21, L4_22, L5_23
	L4_22 = A0_18
	L3_21 = A0_18._collision_function
	L5_23 = A1_19
	L3_21(L4_22, L5_23, A2_20)
	L3_21 = RenderSettings
	L3_21 = L3_21.split_screen
	if L3_21 then
		L4_22 = tweak_data
		L4_22 = L4_22.player
		L4_22 = L4_22.camera
		L4_22 = L4_22.split_screen_fov_multiplier
		L5_23 = A0_18._camera_data
		L5_23 = L5_23.fov
		L5_23 = L5_23 * L4_22
		A0_18._camera_data.fov = math.min(tweak_data.player.camera.split_screen_fov_max, L5_23)
	end
end
function PlayerCamera.update(A0_24, A1_25, A2_26, A3_27)
	local L4_28, L5_29
	L5_29 = A0_24
	L4_28 = A0_24.is_active
	L4_28 = L4_28(L5_29)
	if not L4_28 then
		return
	end
	L4_28 = assert
	L5_29 = A0_24._root_camera
	L4_28(L5_29)
	L4_28 = A0_24._state_machine
	L5_29 = L4_28
	L4_28 = L4_28.update
	L4_28(L5_29, A3_27)
	L4_28 = A0_24._camera_name
	L5_29 = A0_24._state_blend_time_override
	L5_29 = L5_29 or A0_24:_blend_time(L4_28)
	A0_24:view_camera(L4_28, L5_29)
	A0_24:_update_look_at(A3_27)
	CameraRoot.update(A0_24, A1_25, A2_26, A3_27)
end
function PlayerCamera._update_look_at(A0_30, A1_31)
	local L2_32, L3_33, L4_34
	L2_32 = A0_30._unit_camera_data
	L3_33 = L2_32.eye_position
	L4_34 = L2_32.eye_target_position
	if not L3_33 or not L4_34 then
		return
	end
	A0_30:_update_look_at_position(A1_31, L3_33, L4_34)
	A0_30:_update_look_at_fov(A1_31)
end
function PlayerCamera._update_look_at_position(A0_35, A1_36, A2_37, A3_38)
	local L4_39, L5_40, L6_41, L7_42, L8_43, L9_44, L10_45
	L4_39 = assert
	L5_40 = A2_37
	L4_39(L5_40)
	L4_39 = assert
	L5_40 = A3_38
	L4_39(L5_40)
	L4_39 = A0_35._unit_camera_data
	L5_40 = L4_39.look_at_position_override
	L6_41 = A3_38 - A2_37
	L7_42 = Rotation
	L8_43 = A3_38 - A2_37
	L9_44 = math
	L9_44 = L9_44.UP
	L7_42 = L7_42(L8_43, L9_44)
	L8_43 = A3_38 - A2_37
	L9_44 = L8_43
	L8_43 = L8_43.length
	L8_43 = L8_43(L9_44)
	if L5_40 then
		L9_44 = L5_40 - A2_37
		L10_45 = Rotation
		L10_45 = L10_45(L9_44, math.UP)
		if A0_35._current_override_rotation then
		else
		end
		A0_35._current_override_rotation = L7_42:slerp(L10_45, A1_36 * 10)
		A0_35._look_at_override_length, L4_39.eye_target_position = (L5_40 - A2_37):length(), A2_37 + L7_42:slerp(L10_45, A1_36 * 10):y() * (L7_42:y():angle(L9_44) / 180 * L8_43 + (1 - L7_42:y():angle(L9_44) / 180) * (L5_40 - A2_37):length())
	else
		L9_44 = A0_35._current_override_rotation
		if L9_44 then
			L9_44 = math
			L9_44 = L9_44.min
			L10_45 = A1_36 * 10
			L9_44 = L9_44(L10_45, 1)
			L10_45 = A0_35._current_override_rotation
			L10_45 = L10_45.slerp
			L10_45 = L10_45(L10_45, L7_42, L9_44)
			L4_39.eye_target_position = A2_37 + L10_45:y() * (A0_35._look_at_override_length + (L8_43 - A0_35._look_at_override_length) * L9_44)
			if L10_45:y():angle(L6_41) < 0.1 and math.abs(A0_35._look_at_override_length + (L8_43 - A0_35._look_at_override_length) * L9_44 - A0_35._look_at_override_length) < 0.1 then
				A0_35._current_override_rotation = nil
			else
				A0_35._look_at_override_length = A0_35._look_at_override_length + (L8_43 - A0_35._look_at_override_length) * L9_44
				A0_35._current_override_rotation = L10_45
			end
		end
	end
end
function PlayerCamera._update_look_at_fov(A0_46, A1_47)
	local L2_48, L3_49, L4_50, L5_51
	L3_49 = A0_46._unit_camera_data
	L4_50 = L3_49.look_at_relative_fov_override
	if L4_50 then
		L4_50 = L3_49.look_at_relative_fov_override
		if L4_50 then
			L2_48 = L3_49.look_at_relative_fov_override
		end
	else
		L2_48 = 0
	end
	L4_50 = A0_46._look_at_fov
	L5_51 = L4_50
	L4_50 = L4_50.set_target
	L4_50(L5_51, L2_48)
	L4_50 = A0_46._look_at_fov
	L5_51 = L4_50
	L4_50 = L4_50.update
	L4_50(L5_51, A1_47)
	L4_50 = A0_46._look_at_fov
	L5_51 = L4_50
	L4_50 = L4_50.value
	L4_50 = L4_50(L5_51)
	L5_51 = A0_46.active_camera
	L5_51 = L5_51(A0_46)
	if L5_51 and A0_46:find_parent(L5_51, "look_at_fov") then
		A0_46:find_parent(L5_51, "look_at_fov"):set_fov(L4_50)
	end
end
function PlayerCamera._near_edge_modifiers(A0_52, A1_53)
	local L2_54, L3_55
	if A0_52 then
		L2_54 = (1 - math.clamp(A0_52 / tweak_data.player.camera.cover.EDGE_OFFSET_START_DISTANCE, 0, 1)) * (1 - math.clamp(A0_52 / tweak_data.player.camera.cover.EDGE_OFFSET_START_DISTANCE, 0, 1)) * tweak_data.player.camera.cover.EDGE_OFFSET
		if not A1_53 then
			L2_54 = -L2_54
		end
		L3_55 = (1 - math.clamp(A0_52 / tweak_data.player.camera.cover.EDGE_OFFSET_START_DISTANCE, 0, 1)) * (1 - math.clamp(A0_52 / tweak_data.player.camera.cover.EDGE_OFFSET_START_DISTANCE, 0, 1)) * tweak_data.player.camera.cover.EDGE_FOV
	else
		L2_54 = 0
		L3_55 = 0
	end
	return {x_offset = L2_54, fov = L3_55}
end
function PlayerCamera._update_cover_edge_modifiers(A0_56, A1_57, A2_58)
	if A0_56:find_parent(A1_57, "cover_edge_offset") then
		A0_56:find_parent(A1_57, "cover_edge_offset"):set_local_position(Vector3(A2_58.x_offset, 0, 0))
	end
	if A0_56:find_parent(A1_57, "cover_edge_fov") then
		A0_56:find_parent(A1_57, "cover_edge_fov"):set_fov(A2_58.fov)
	end
end
function PlayerCamera._blend_time(A0_59, A1_60)
	local L2_61, L3_62, L4_63, L5_64
	L3_62 = A0_59
	L2_61 = A0_59.active_camera
	L2_61 = L2_61(L3_62)
	L3_62 = nil
	if L2_61 then
		L4_63 = PlayerCameraBlendTimes
		L4_63 = L4_63.blend_times
		L5_64 = L2_61.name
		L5_64 = L5_64(L2_61)
		if L4_63[L5_64] then
			L3_62 = L4_63[L5_64][A1_60]
			if not L3_62 then
				L3_62 = L4_63[L5_64].DEFAULT_BLEND_TIME
				L3_62 = L3_62 or L4_63.DEFAULT_BLEND_TIME
			end
		else
			L3_62 = L4_63.DEFAULT_BLEND_TIME
			assert(L3_62, "No default blend time set for cameras")
		end
		if L5_64 ~= A1_60 then
			cat_debug("camera", "Switching camera from " .. L5_64 .. " to " .. A1_60 .. ", blend time: " .. L3_62)
		end
	else
		L3_62 = 0
	end
	return L3_62
end
function PlayerCamera._update_quickmove_cover_edge_modifiers(A0_65, A1_66)
	local L2_67, L3_68
	L3_68 = A0_65._player_data
	if L3_68.quick_moving_to_facing_right then
		L2_67 = PlayerCamera._near_edge_modifiers(L3_68.quick_move_target_distance_to_right_cover_edge, true)
	else
		L2_67 = PlayerCamera._near_edge_modifiers(L3_68.quick_move_target_distance_to_left_cover_edge)
	end
	A0_65:_update_cover_edge_modifiers(A1_66, L2_67)
end
function PlayerCamera._quick_move_target_camera_name(A0_69)
	local L1_70, L2_71, L3_72
	L1_70 = A0_69._player_data
	L2_71 = nil
	L3_72 = L1_70.quick_move_target_cover
	if L3_72 then
		L2_71 = "incover"
		if managers.cover_util:high_cover(L3_72) then
			L2_71 = L2_71 .. "_stand"
		else
			L2_71 = L2_71 .. "_crouch"
		end
		if L1_70.quick_moving_to_facing_right then
			L2_71 = L2_71 .. "_right"
		else
			L2_71 = L2_71 .. "_left"
		end
	else
		L2_71 = "onground"
	end
	return L2_71
end
function PlayerCamera._update_collision(A0_73, A1_74, A2_75, A3_76)
	local L4_77, L5_78, L6_79, L7_80, L8_81
	L4_77 = A0_73._camera_data
	L4_77 = L4_77.position
	L5_78 = L4_77 - A3_76
	L7_80 = L5_78
	L6_79 = L5_78.length
	L6_79 = L6_79(L7_80)
	if L6_79 > 0 then
		L7_80 = 1 / L6_79
		L5_78 = L5_78 * L7_80
		L7_80 = A0_73._pop_controller
		L8_81 = L7_80
		L7_80 = L7_80.wanted_position
		L7_80 = L7_80(L8_81, A3_76, L4_77)
		L8_81 = L7_80 * L6_79
		if L8_81 < A0_73._camera_distance then
		else
		end
		A0_73._camera_distance = A0_73._camera_distance + math.clamp(L8_81 - A0_73._camera_distance, 0, A0_73._camera_max_velocity * A2_75)
		A0_73._camera_data.position = A3_76 + (L4_77 - A3_76):normalized() * (A0_73._camera_distance + math.clamp(L8_81 - A0_73._camera_distance, 0, A0_73._camera_max_velocity * A2_75))
	end
end
function PlayerCamera.debug_render(A0_82, A1_83, A2_84, A3_85)
	CameraRoot.debug_render(A0_82, A1_83, A2_84, A3_85)
	Draw:brush(Color(0.3, 1, 1, 1)):sphere(A0_82:_safe_position(), 5)
	Draw:brush(Color(0.3, 1, 0, 0)):sphere(A0_82._camera_data.position, 15)
end
function PlayerCamera._safe_position(A0_86)
	local L1_87, L2_88, L3_89
	L2_88 = A0_86._player_data
	L3_89 = A0_86._unit
	if L2_88.on_ground and L3_89:mover() or L2_88.is_down then
		L1_87 = L3_89:position() + 190 * math.UP
	else
		L1_87 = A0_86._head:position() + 30 * math.UP
	end
	return L1_87
end
function PlayerCamera._update_player_collision(A0_90, A1_91, A2_92)
	local L3_93
	L3_93 = A0_90._safe_position
	L3_93 = L3_93(A0_90)
	A0_90:_update_collision(A1_91, A2_92, L3_93)
end
function PlayerCamera._update_vehicle_collision(A0_94, A1_95, A2_96)
	local L3_97
	L3_97 = A0_94._player_data
	L3_97 = L3_97.named_camera_targets
	L3_97 = L3_97.vehicle
	L3_97 = L3_97.position
	L3_97 = L3_97(L3_97)
	L3_97 = L3_97 + 250 * math.UP
	A0_94:_update_collision(L3_97)
end
function PlayerCamera._update_no_collision(A0_98, A1_99, A2_100)
end
function PlayerCamera._state_class(A0_101)
	local L1_102
	L1_102 = A0_101._player_data
	if L1_102.on_rail_vehicle or L1_102.on_destroyed_rail_vehicle then
		return PlayerCameraOnRailVehicle
	elseif L1_102._in_stationary_weapon then
		return PlayerCameraInStationaryWeapon
	elseif A0_101._damage_data and A0_101._damage_data:is_fully_damaged() then
		if L1_102.is_down then
			return PlayerCameraWounded
		else
			return PlayerCameraEnterDead
		end
	elseif L1_102.quick_moving then
		if L1_102.quick_moving_from_onground then
			return PlayerCameraEnteringCover
		elseif L1_102.quick_moving_over_cover then
			return PlayerCameraQuickMovingOverCover
		else
			return PlayerCameraQuickMoving
		end
	elseif L1_102.in_cover then
		if L1_102.peeking_up then
			return PlayerCameraPeekingUpInCover
		elseif L1_102.peeking_side then
			if L1_102.facing_right_in_cover then
				return PlayerCameraPeekingRightInCover
			else
				return PlayerCameraPeekingLeftInCover
			end
		elseif L1_102.leaving_cover then
			return PlayerCameraLeavingCover
		else
			return PlayerCameraInCover
		end
	elseif L1_102.on_ground then
		return PlayerCameraOnGround
	elseif L1_102.strangul then
		return PlayerCameraStrangul
	end
	return PlayerCameraUnknownState
end
function PlayerCamera._cover_camera_index(A0_103)
	local L1_104
	L1_104 = A0_103.__cover_camera_index
	return L1_104
end
function PlayerCamera._switch_cover_camera_index(A0_105)
	A0_105.__cover_camera_index = A0_105:_available_cover_camera_index()
end
function PlayerCamera._available_cover_camera_index(A0_106)
	return (iff(A0_106.__cover_camera_index == 1, 2, 1))
end
