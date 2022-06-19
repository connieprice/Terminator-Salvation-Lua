require("shared/camera/CameraRoot")
if not UnitCamera then
	UnitCamera = class(CameraRoot)
end
UnitCamera.activate = function(l_1_0)
	CameraRoot.activate(l_1_0)
	l_1_0._root_camera = managers.camera:create_cameras("generic_unit", l_1_0._unit)
	l_1_0:build_camera_name_map()
	l_1_0:view_camera("unit")
	if l_1_0.height then
		local l_1_1 = l_1_0:find_camera("unit_offset")
		assert(l_1_1)
		l_1_1:set_local_position(Vector3(0, 0, l_1_0.height))
	end
end


