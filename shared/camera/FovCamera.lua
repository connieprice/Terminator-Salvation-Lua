require("shared/camera/SharedCamera")
if not FovCamera then
	FovCamera = class(SharedCamera)
end
FovCamera.parse_parameters = function(l_1_0, l_1_1)
	SharedCamera.parse_parameters(l_1_0, l_1_1)
	local l_1_2 = l_1_1.fov
	assert(l_1_2)
	l_1_0:set_fov(l_1_2)
end

FovCamera.set_fov = function(l_2_0, l_2_1)
	l_2_0._fov = l_2_1
end

FovCamera.fov = function(l_3_0)
	return l_3_0._fov
end


