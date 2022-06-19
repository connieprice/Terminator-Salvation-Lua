require("shared/camera/SharedCamera")
require("shared/Interpolator")
DocumentaryCamera = DocumentaryCamera or class(SharedCamera)
DocumentaryCamera.walk_dir_redirects = {}
DocumentaryCamera.walk_dir_redirects[1] = "walk_fwd"
DocumentaryCamera.walk_dir_redirects[2] = "walk_bwd"
DocumentaryCamera.walk_dir_redirects[3] = "walk_lt"
DocumentaryCamera.walk_dir_redirects[4] = "walk_rt"
DocumentaryCamera.run_dir_redirects = {}
DocumentaryCamera.run_dir_redirects[1] = "run_fwd"
DocumentaryCamera.run_dir_redirects[2] = "run_bwd"
DocumentaryCamera.run_dir_redirects[3] = "run_lt"
DocumentaryCamera.run_dir_redirects[4] = "run_rt"
function DocumentaryCamera.init(A0_0, A1_1)
	SharedCamera.init(A0_0, A1_1)
	A0_0._target_fov = Interpolator:new(0, 4)
	A0_0._target_shake_amount = Interpolator:new(0, 4)
	A0_0._player_data = A0_0._root_unit:player_data()
	A0_0._damage_data = A0_0._root_unit:damage_data()
	A0_0._shake_amount = 0
	A0_0._cam_settings = tweak_data.player.camera.documentary_camera
end
function DocumentaryCamera.destroy(A0_2)
	SharedCamera.destroy(A0_2)
	if alive(A0_2._anim_unit) then
		A0_2._anim_unit:set_slot(0)
		A0_2._anim_unit = nil
		A0_2._object = nil
	end
end
function DocumentaryCamera.on_activate(A0_3, A1_4)
	if A1_4 then
		assert(A0_3._anim_unit == nil)
		A0_3._anim_unit = World:spawn_unit(A0_3._anim_unit_name, Vector3(0, 0, 0), Rotation())
		A0_3._anim_unit:set_driving("script")
		A0_3._anim_unit:set_visible(false)
		if A0_3._object_name then
			A0_3._object = A0_3._anim_unit:get_object(A0_3._object_name)
		else
			A0_3._object = A0_3._anim_unit:orientation_object()
		end
		A0_3._unit_data = A0_3._anim_unit:unit_data()
		A0_3._asm = A0_3._anim_unit:anim_state_machine()
		A0_3._shake_amount = 0
	else
		assert(A0_3._anim_unit)
		A0_3._anim_unit:set_slot(0)
		A0_3._anim_unit = nil
		A0_3._object = nil
		A0_3._unit_data = nil
		A0_3._asm = nil
	end
end
function DocumentaryCamera.parse_parameters(A0_5, A1_6)
	SharedCamera.parse_parameters(A0_5, A1_6)
	if A1_6.unit then
		A0_5._anim_unit_name = A1_6.unit
	end
	if A1_6.object then
		A0_5._object_name = A1_6.object
	end
end
function DocumentaryCamera.preload_units(A0_7)
	local L1_8
	L1_8 = A0_7.unit
	if L1_8 then
		World:preload_unit(L1_8)
	end
end
function DocumentaryCamera.update(A0_9, A1_10, A2_11, A3_12, A4_13)
	local L5_14, L6_15, L7_16, L8_17
	L5_14 = assert
	L6_15 = A0_9._anim_unit
	L5_14(L6_15)
	L5_14 = A0_9._anim_unit
	L6_15 = A0_9._player_data
	if L6_15 then
		L7_16 = A0_9._target_fov
		L8_17 = L6_15.is_precision_aiming
		if L8_17 then
			L8_17 = L7_16.set_target
			L8_17(L7_16, -10)
		else
			L8_17 = L7_16.set_target
			L8_17(L7_16, 0)
		end
		L8_17 = L7_16.update
		L8_17(L7_16, A2_11)
		L8_17 = A0_9._target_shake_amount
		L8_17 = L8_17.update
		L8_17(L8_17, A2_11)
		L8_17 = A0_9._target_shake_amount
		L8_17 = L8_17.value
		L8_17 = L8_17(L8_17)
		if A0_9._shake_amount ~= L8_17 then
			A0_9._asm:set_global("shake_amount", L8_17)
			A0_9._shake_amount = L8_17
		end
		A0_9._fov = L7_16:value()
		if L6_15.strangul then
			A0_9:strangul()
		elseif A0_9._camera_data.enter_dead then
			A0_9:enter_dead()
		elseif A0_9._camera_data.dead then
			A0_9:dead()
		elseif L6_15.rail_vehicle_shake then
			A0_9:on_vehicle(L6_15.rail_vehicle_shake)
		elseif L6_15.reviving then
			A0_9:reviving()
		elseif L6_15.running then
			A0_9:running(0, false)
		elseif L6_15.walking then
			A0_9:walking(0, false)
		else
			A0_9:idle(false)
		end
		A0_9._local_position = A0_9._object:local_position()
		A0_9._local_rotation = A0_9._object:local_rotation()
	end
	L7_16 = SharedCamera
	L7_16 = L7_16.update
	L8_17 = A0_9
	L7_16(L8_17, A1_10, A2_11, A3_12, A4_13)
	L8_17 = L5_14
	L7_16 = L5_14.set_position
	L7_16(L8_17, A0_9._position)
	L7_16 = A0_9._unit_data
	L7_16 = L7_16.entering_dead_done
	A0_9.entering_dead_done = L7_16
end
function DocumentaryCamera._set_shake_amount(A0_18, A1_19)
	A0_18._target_shake_amount:set_target(A1_19)
end
function DocumentaryCamera.idle(A0_20, A1_21)
	if A1_21 then
		A0_20._anim_unit:play_redirect("aim")
	else
		A0_20._anim_unit:play_redirect("idle")
	end
	A0_20:_set_shake_amount(0)
end
function DocumentaryCamera.walking(A0_22, A1_23, A2_24)
	local L3_25
	if A2_24 then
		L3_25 = A0_22._anim_unit
		L3_25 = L3_25.play_redirect
		L3_25(L3_25, "aim")
	else
		L3_25 = DocumentaryCamera
		L3_25 = L3_25.walk_dir_redirects
		L3_25 = L3_25[A0_22._player_data.move_dir]
		if L3_25 then
			A0_22._anim_unit:play_redirect(L3_25)
		end
	end
	L3_25 = A0_22._player_data
	L3_25 = L3_25.is_precision_aiming
	if L3_25 then
		L3_25 = A0_22._set_shake_amount
		L3_25(A0_22, A0_22._cam_settings.walk_aim_shake)
	else
		L3_25 = A0_22._set_shake_amount
		L3_25(A0_22, A0_22._cam_settings.walk_shake)
	end
end
function DocumentaryCamera.running(A0_26, A1_27, A2_28)
	local L3_29
	if A2_28 then
		L3_29 = A0_26._anim_unit
		L3_29 = L3_29.play_redirect
		L3_29(L3_29, "aim")
	else
		L3_29 = DocumentaryCamera
		L3_29 = L3_29.run_dir_redirects
		L3_29 = L3_29[A0_26._player_data.move_dir]
		if L3_29 then
			A0_26._anim_unit:play_redirect(L3_29)
		end
	end
	L3_29 = A0_26._set_shake_amount
	L3_29(A0_26, A0_26._cam_settings.run_shake)
end
function DocumentaryCamera.reviving(A0_30)
	A0_30._anim_unit:play_redirect("revive")
end
function DocumentaryCamera.wounded(A0_31)
	A0_31._anim_unit:play_redirect("wounded")
end
function DocumentaryCamera.enter_dead(A0_32)
	A0_32._anim_unit:play_redirect("enter_dead")
end
function DocumentaryCamera.dead(A0_33)
	A0_33._anim_unit:play_redirect("dead")
end
function DocumentaryCamera.strangul(A0_34)
	A0_34._anim_unit:play_redirect("strangul")
end
function DocumentaryCamera.on_vehicle(A0_35, A1_36)
	A0_35._anim_unit:play_redirect(A1_36)
end
function DocumentaryCamera.debug_render(A0_37, A1_38, A2_39)
	SharedCamera.debug_render(A0_37, A1_38, A2_39)
	Draw:brush(Color(0.5, 1, 0, 0)):sphere(A0_37:position(), 10)
end
