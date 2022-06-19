if not CameraData then
	CameraData = class()
end
CameraData.init = function(l_1_0, l_1_1)
	l_1_0.camera_rotation = Rotation(0, 0, 0)
	l_1_0.camera_position = Vector3(0, 0, 0)
	l_1_0.eye_target_position = Vector3(0, 0, 0)
end


