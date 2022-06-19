if not WorldCameraMover then
	WorldCameraMover = class()
end
WorldCameraMover.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._timer = 0
	l_1_0._delay_timer = 0
	l_1_0._unit:set_driving("script")
end

WorldCameraMover.activate = function(l_2_0, l_2_1, l_2_2, l_2_3)
	l_2_0._camera_name = l_2_1
	l_2_0._camera_type = l_2_3
	if l_2_2 == "character_slot_1" then
		l_2_0.player_slot = 1
	elseif l_2_2 == "character_slot_2" then
		l_2_0.player_slot = 2
	else
		assert(false, "No character assigned to WorldCameraMover")
	end
	l_2_0._core_camera = managers.worldcamera:world_camera(l_2_1)
	assert(l_2_0._core_camera, "Cannot find camera with name: " .. l_2_1)
	l_2_0._duration = l_2_0._core_camera:duration()
	l_2_0._delay = l_2_0._core_camera:delay()
	l_2_0._in_acc = l_2_0._core_camera:in_acc()
	l_2_0._out_acc = l_2_0._core_camera:out_acc()
	l_2_0._positions = l_2_0._core_camera:positions()
	l_2_0._target_positions = l_2_0._core_camera:target_positions()
	assert(l_2_0.player_slot, "No slot specified in WorldCameraMover")
	local l_2_4 = l_2_0:_get_viewport_from_slot(l_2_0.player_slot)
	l_2_0._old_unit = l_2_4:viewed_unit()
	l_2_0._old_camera = l_2_0._old_unit:camera():active_camera():name()
	l_2_4:view_unit(l_2_0._unit)
	l_2_0._unit:camera():view_camera(l_2_0._camera_type)
end

WorldCameraMover.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	if l_3_0._timer < 1 then
		l_3_0._timer = l_3_0._timer + l_3_3 / l_3_0._duration
		local l_3_4 = math.bezier
		local l_3_5 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if #l_3_0._positions == 2 then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		if #l_3_0._positions == 3 then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if #l_3_0._positions ~= 4 or l_3_5 then
			local l_3_6 = l_3_5(l_3_0._in_acc, l_3_0._out_acc)
			 -- DECOMPILER ERROR: Overwrote pending register.

			local l_3_7 = l_3_5(l_3_0._target_positions, 1)
			l_3_0._unit:set_position(l_3_6)
			local l_3_8 = l_3_7 - l_3_6
			local l_3_9, l_3_15, l_3_16, l_3_18, l_3_20, l_3_21 = Rotation(l_3_8, math.UP)
			l_3_15 = l_3_0._unit
			l_3_15, l_3_16 = l_3_15:set_rotation, l_3_15
			local l_3_17, l_3_19, l_3_22 = nil
			l_3_18 = l_3_9
			l_3_15(l_3_16, l_3_18)
		end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	elseif l_3_4 > 0 and l_3_0._delay_timer < 1 then
		l_3_0._delay_timer = l_3_0._delay_timer + l_3_3 / l_3_5
	else
		local l_3_10 = l_3_0:_get_viewport_from_slot(l_3_0.player_slot)
		l_3_10:view_unit(l_3_0._old_unit)
		l_3_0._old_unit:camera():view_camera(l_3_0._old_camera)
		l_3_0._unit:set_slot(0)
		local l_3_11 = managers.worldcamera
	if l_3_11._world_camera_done_callback_list[l_3_0._camera_name] then
		end
		for i_0,i_1 in pairs(l_3_11._world_camera_done_callback_list[l_3_0._camera_name]) do
			l_3_11:remove_world_camera_done_callback(l_3_0._camera_name, i_0)
			i_1(l_3_0._core_camera, i_0)
		end
	end
end

WorldCameraMover._get_viewport_from_slot = function(l_4_0, l_4_1)
	local l_4_2 = managers.player_slot:slot(l_4_1)
	if l_4_2 then
		local l_4_3 = l_4_2:user()
	if l_4_3 then
		end
		return managers.user_viewport:viewport(l_4_3)
	end
end


