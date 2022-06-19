require("shared/camera/SharedCamera")
if not TransformCamera then
	TransformCamera = class(SharedCamera)
end
TransformCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
end

TransformCamera.parse_parameters = function(l_2_0, l_2_1)
	SharedCamera.parse_parameters(l_2_0, l_2_1)
	local l_2_2 = Vector3(0, 0, 0)
	if l_2_1.position then
		l_2_2 = TableSerializer._load_vector(l_2_1.position)
	end
	local l_2_3 = Rotation()
	if l_2_1.rotation then
		l_2_3 = math.string_to_rotation(l_2_1.rotation)
	end
	l_2_0:set_local_rotation(l_2_3)
	l_2_0:set_local_position(l_2_2)
end


