require("shared/camera/BlendCamera")
if not SwitchCamera then
	SwitchCamera = class(BlendCamera)
end
SwitchCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
	l_1_0._interpolation_time = 0.1
end

SwitchCamera.update = function(l_2_0, l_2_1, l_2_2, l_2_3)
	BlendCamera.update(l_2_0, l_2_1, l_2_2, l_2_3)
	l_2_0._dt = l_2_3
end

SwitchCamera.post_update = function(l_3_0)
	if not l_3_0._target_camera then
		return 
	end
	l_3_0._factor = l_3_0._factor + l_3_0._dt / l_3_0._interpolation_time
	if l_3_0._factor > 1 then
		l_3_0._factor = 1
	if l_3_0._source_camera ~= l_3_0._target_camera then
		end
		l_3_0._source_camera:set_active(false)
		l_3_0._source_camera = l_3_0._target_camera
	end
	BlendCamera:post_update()
end

SwitchCamera.switch_to_camera = function(l_4_0, l_4_1)
end

SwitchCamera.set_interpolation_time = function(l_5_0, l_5_1)
	local l_5_2 = assert
	l_5_2(l_5_1 > 0)
	l_5_0._interpolation_time = l_5_1
end


