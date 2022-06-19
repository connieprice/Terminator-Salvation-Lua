require("shared/camera/SharedCamera")
if not DirectAimCamera then
	DirectAimCamera = class(SharedCamera)
end
DirectAimCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
end

DirectAimCamera.parse_parameters = function(l_2_0, l_2_1)
	SharedCamera.parse_parameters(l_2_0, l_2_1)
	if l_2_1.yaw_limit then
		l_2_0._yaw_limit = tonumber(l_2_1.yaw_limit)
		l_2_0._constraints_yaw = l_2_0._yaw_limit
	end
	if l_2_1.pitch_limit then
		l_2_0._pitch_limit = tonumber(l_2_1.pitch_limit)
		l_2_0._constraints_pitch = l_2_0._pitch_limit
	end
	if l_2_1.root_rotation then
		l_2_0._root_rotation = toboolean(l_2_1.root_rotation)
	end
	l_2_0._rotation_offset = Rotation(0, 0, 0)
	if l_2_1.rotation then
		l_2_0._rotation_offset = math.string_to_rotation(l_2_1.rotation)
	end
end

DirectAimCamera.update = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
	local l_3_5 = nil
	if l_3_0._root_rotation then
		l_3_5 = l_3_0._root_unit:position()
	else
		l_3_5 = l_3_3
	end
	l_3_0:set_local_rotation(l_3_4:inverse() * Rotation(l_3_0._camera_data.eye_target_position - l_3_5, math.UP))
	if l_3_0._yaw_limit and l_3_0._pitch_limit then
		l_3_0._constraints_rot = l_3_4 * l_3_0._rotation_offset
	end
	SharedCamera.update(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
end


