WorldCameraMover = WorldCameraMover or class()
function WorldCameraMover.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._timer = 0
	A0_0._delay_timer = 0
	A0_0._unit:set_driving("script")
end
function WorldCameraMover.activate(A0_2, A1_3, A2_4, A3_5)
	A0_2._camera_name = A1_3
	A0_2._camera_type = A3_5
	if A2_4 == "character_slot_1" then
		A0_2.player_slot = 1
	elseif A2_4 == "character_slot_2" then
		A0_2.player_slot = 2
	else
		assert(false, "No character assigned to WorldCameraMover")
	end
	A0_2._core_camera = managers.worldcamera:world_camera(A1_3)
	assert(A0_2._core_camera, "Cannot find camera with name: " .. A1_3)
	A0_2._duration = A0_2._core_camera:duration()
	A0_2._delay = A0_2._core_camera:delay()
	A0_2._in_acc = A0_2._core_camera:in_acc()
	A0_2._out_acc = A0_2._core_camera:out_acc()
	A0_2._positions = A0_2._core_camera:positions()
	A0_2._target_positions = A0_2._core_camera:target_positions()
	assert(A0_2.player_slot, "No slot specified in WorldCameraMover")
	A0_2._old_unit = A0_2:_get_viewport_from_slot(A0_2.player_slot):viewed_unit()
	A0_2._old_camera = A0_2._old_unit:camera():active_camera():name()
	A0_2:_get_viewport_from_slot(A0_2.player_slot):view_unit(A0_2._unit)
	A0_2._unit:camera():view_camera(A0_2._camera_type)
end
function WorldCameraMover.update(A0_6, A1_7, A2_8, A3_9)
	local L4_10, L5_11, L6_12, L7_13, L8_14, L9_15, L10_16
	L4_10 = A0_6._timer
	if L4_10 < 1 then
		L4_10 = A0_6._timer
		L5_11 = A0_6._duration
		L5_11 = A3_9 / L5_11
		L4_10 = L4_10 + L5_11
		A0_6._timer = L4_10
		L4_10 = math
		L4_10 = L4_10.bezier
		L5_11 = {
			L6_12,
			L7_13,
			L8_14,
			L9_15
		}
		L9_15 = 1
		L4_10 = L4_10(L5_11, L6_12)
		L5_11 = nil
		if L6_12 == 2 then
			L5_11 = L6_12.linear_bezier
		elseif L6_12 == 3 then
			L5_11 = L6_12.quadratic_bezier
		elseif L6_12 == 4 then
			L5_11 = L6_12.bezier
		end
		if L5_11 then
			L9_15 = L4_10
			L9_15 = L8_14
			L10_16 = L6_12
			L8_14(L9_15, L10_16)
			L9_15 = Rotation
			L10_16 = L8_14
			L9_15 = L9_15(L10_16, math.UP)
			L10_16 = A0_6._unit
			L10_16 = L10_16.set_rotation
			L10_16(L10_16, L9_15)
		end
	else
		L4_10 = A0_6._delay
		if L4_10 > 0 then
			L4_10 = A0_6._delay_timer
			if L4_10 < 1 then
				L4_10 = A0_6._delay_timer
				L5_11 = A0_6._delay
				L5_11 = A3_9 / L5_11
				L4_10 = L4_10 + L5_11
				A0_6._delay_timer = L4_10
			end
		else
			L5_11 = A0_6
			L4_10 = A0_6._get_viewport_from_slot
			L4_10 = L4_10(L5_11, L6_12)
			L5_11 = L4_10.view_unit
			L5_11(L6_12, L7_13)
			L5_11 = A0_6._old_unit
			L5_11 = L5_11.camera
			L5_11 = L5_11(L6_12)
			L5_11 = L5_11.view_camera
			L5_11(L6_12, L7_13)
			L5_11 = A0_6._unit
			L5_11 = L5_11.set_slot
			L5_11(L6_12, L7_13)
			L5_11 = managers
			L5_11 = L5_11.worldcamera
			if L6_12 then
				for L9_15, L10_16 in L6_12(L7_13) do
					L5_11:remove_world_camera_done_callback(A0_6._camera_name, L9_15)
					L10_16(A0_6._core_camera, L9_15)
				end
			end
		end
	end
end
function WorldCameraMover._get_viewport_from_slot(A0_17, A1_18)
	local L2_19, L3_20
	L2_19 = managers
	L2_19 = L2_19.player_slot
	L3_20 = L2_19
	L2_19 = L2_19.slot
	L2_19 = L2_19(L3_20, A1_18)
	if L2_19 then
		L3_20 = L2_19.user
		L3_20 = L3_20(L2_19)
		if L3_20 then
			return (managers.user_viewport:viewport(L3_20))
		end
	end
end
