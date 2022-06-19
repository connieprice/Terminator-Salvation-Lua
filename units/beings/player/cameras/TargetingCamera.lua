if not TargetingCamera then
	TargetingCamera = class(SharedCamera)
end
TargetingCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
	l_1_0._target = "enemy"
end

TargetingCamera.parse_parameters = function(l_2_0, l_2_1)
	SharedCamera.parse_parameters(l_2_0, l_2_1)
	if l_2_1.target then
		l_2_0._target = l_2_1.target
	end
end

TargetingCamera.update = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
	local l_3_5 = l_3_0._root_unit:player_data().named_camera_targets[l_3_0._target]
	if alive(l_3_5) then
		local l_3_6 = l_3_5:position() - l_3_3
		l_3_0:set_local_rotation(l_3_4:inverse() * Rotation(l_3_6, math.UP))
	end
	SharedCamera.update(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
end


