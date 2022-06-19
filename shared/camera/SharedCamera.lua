local l_0_0 = mvector3.add
local l_0_1 = mvector3.subtract
local l_0_2 = mvector3.set
local l_0_3 = mvector3.rotate_with
local l_0_4 = mrotation.set_zero
local l_0_5 = mrotation.multiply
if not SharedCamera then
	SharedCamera = class()
end
SharedCamera.init = function(l_1_0, l_1_1)
	l_1_0._children = {}
	l_1_0._active_children = {}
	l_1_0._active_count = 0
	l_1_0._position = Vector3(0, 0, 0)
	l_1_0._rotation = Rotation()
	l_1_0._root_unit = l_1_1
	l_1_0._camera_data = l_1_1:camera_data()
	l_1_0._name = ""
	l_1_0._local_position = Vector3(0, 0, 0)
	l_1_0._local_rotation = Rotation()
	l_1_0._fov = 0
	l_1_0._constraints_rot = nil
	l_1_0._constraints_yaw = nil
	l_1_0._constraints_pitch = nil
end

SharedCamera.parse_parameters = function(l_2_0, l_2_1)
	if l_2_1.fov then
		l_2_0._fov = tonumber(l_2_1.fov)
	end
	if l_2_1.name then
		l_2_0._name = l_2_1.name
	end
end

SharedCamera.destroy = function(l_3_0)
	local l_3_4, l_3_5, l_3_6, l_3_7 = nil
	l_3_0._active_children = {}
	for i_0,i_1 in ipairs(l_3_0._children) do
		i_1:destroy()
	end
	l_3_0._children = {}
	l_3_0._parent_camera = {}
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SharedCamera.name = function(l_4_0)
	return l_4_0._name
end

SharedCamera.add_child_camera = function(l_5_0, l_5_1)
	table.insert(l_5_0._children, l_5_1)
	l_5_1:_set_parent_camera(l_5_0)
end

SharedCamera.children = function(l_6_0)
	return l_6_0._children
end

SharedCamera.is_active = function(l_7_0)
	return l_7_0._active_count > 0
end

SharedCamera.set_active = function(l_8_0, l_8_1)
	local l_8_8, l_8_9, l_8_10, l_8_11, l_8_12, l_8_13 = nil
	local l_8_2 = l_8_0
	do
		while 1 do
			local l_8_3 = false
			while l_8_2 do
				local l_8_4 = l_8_2:is_active()
				if l_8_1 then
					l_8_2._active_count = l_8_2._active_count + 1
				else
					l_8_2._active_count = math.max(0, l_8_2._active_count - 1)
				end
				if l_8_3 then
					l_8_2._active_children = {}
				if l_8_2:is_active() then
					end
					for i_0,i_1 in ipairs(l_8_2._children) do
						if i_1:is_active() then
							table.insert(l_8_2._active_children, i_1)
						end
					end
				end
				l_8_3 = l_8_4 ~= l_8_2:is_active()
				if l_8_3 then
					l_8_2:on_activate(l_8_2:is_active())
				end
				l_8_2 = l_8_2._parent_camera
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

SharedCamera.on_activate = function(l_9_0, l_9_1)
end

SharedCamera.set_camera_input = function(l_10_0, l_10_1)
	local l_10_5, l_10_6, l_10_7, l_10_8 = nil
	l_10_0._controller = l_10_1
	for i_0,i_1 in ipairs(l_10_0._children) do
		i_1:set_camera_input(l_10_1)
	end
end

SharedCamera.release_camera_input = function(l_11_0)
	local l_11_4, l_11_5, l_11_6, l_11_7 = nil
	l_11_0._controller = nil
	for i_0,i_1 in ipairs(l_11_0._children) do
		i_1:release_camera_input()
	end
end

SharedCamera.set_local_position = function(l_12_0, l_12_1)
	l_12_0._local_position = l_12_1
end

SharedCamera.set_local_rotation = function(l_13_0, l_13_1)
	l_13_0._local_rotation = l_13_1
end

SharedCamera.set_local_position_from_world_position = function(l_14_0, l_14_1)
	-- upvalues: l_0_2 , l_0_1 , l_0_3
	local l_14_2 = l_14_0._parent_camera
	if l_14_2 then
		local l_14_3 = l_14_2:position()
		local l_14_4 = l_14_2:rotation()
		l_0_2(l_14_0._local_position, l_14_1)
		l_0_1(l_14_0._local_position, l_14_2:position())
		l_0_3(l_14_0._local_position, l_14_2:rotation():inverse())
	else
		l_0_2(l_14_0._local_position, l_14_1)
	end
end

SharedCamera.set_local_rotation_from_world_rotation = function(l_15_0, l_15_1)
	local l_15_2 = l_15_0._parent_camera
	if l_15_2 then
		local l_15_3 = l_15_2:rotation()
		l_15_0._local_rotation = l_15_3:inverse() * l_15_1
	else
		l_15_0._local_rotation = l_15_1
	end
end

SharedCamera.position = function(l_16_0)
	return l_16_0._position
end

SharedCamera.rotation = function(l_17_0)
	return l_17_0._rotation
end

SharedCamera.local_position = function(l_18_0)
	return l_18_0._local_position
end

SharedCamera.local_rotation = function(l_19_0)
	return l_19_0._local_rotation
end

SharedCamera.update = function(l_20_0, l_20_1, l_20_2, l_20_3, l_20_4)
	-- upvalues: l_0_2 , l_0_3 , l_0_0 , l_0_4 , l_0_5
	l_0_2(l_20_0._position, l_20_0._local_position)
	l_0_3(l_20_0._position, l_20_4)
	l_0_0(l_20_0._position, l_20_3)
	l_0_4(l_20_0._rotation)
	l_0_5(l_20_0._rotation, l_20_4)
	l_0_5(l_20_0._rotation, l_20_0._local_rotation)
end

SharedCamera.debug_render = function(l_21_0, l_21_1, l_21_2)
	local l_21_3 = Draw:pen(Color(0.3, 1, 0, 0))
	local l_21_4 = Draw:pen(Color(0.3, 0, 1, 0))
	local l_21_5 = Draw:pen(Color(0.3, 0, 0, 1))
	local l_21_6 = l_21_0:position()
	local l_21_7 = l_21_0:rotation()
	l_21_3:line(l_21_6, l_21_6 + l_21_7:x() * 10)
	l_21_4:line(l_21_6, l_21_6 + l_21_7:y() * 10)
	l_21_5:line(l_21_6, l_21_6 + l_21_7:z() * 10)
	if l_21_0._parent_camera then
		local l_21_8 = Draw:pen(Color(0.3, 1, 1, 1))
		local l_21_9 = l_21_0._parent_camera:position()
		local l_21_10 = Draw:pen(Color(0.3, 1, 1, 1))
		l_21_10:line(l_21_9, l_21_6)
	end
end

SharedCamera.camera_fov = function(l_22_0)
	local l_22_1 = 0
	do
		while 1 do
			local l_22_2 = l_22_0
			while l_22_2 do
				l_22_1 = l_22_1 + l_22_2._fov
				l_22_2 = l_22_2._parent_camera
			end
			return l_22_1
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

SharedCamera.camera_dof = function(l_23_0)
	do
		while 1 do
			local l_23_1 = l_23_0
			while l_23_1 do
				local l_23_2 = l_23_1.dof
				if l_23_2 then
					return l_23_2
				end
				l_23_1 = l_23_1._parent_camera
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

SharedCamera.camera_constraints = function(l_24_0)
	do
		while 1 do
			local l_24_1 = l_24_0
			while l_24_1 do
				if l_24_1._constraints_rot then
					return l_24_1._constraints_rot, l_24_1._constraints_yaw, l_24_1._constraints_pitch
				end
				l_24_1 = l_24_1._parent_camera
			end
			return nil, nil, nil
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

SharedCamera.parent_camera = function(l_25_0)
	return l_25_0._parent_camera
end

SharedCamera._set_parent_camera = function(l_26_0, l_26_1)
	l_26_0._parent_camera = l_26_1
end


