require("shared/camera/SharedCamera")
if not KeepActivationPositionCamera then
	KeepActivationPositionCamera = class(SharedCamera)
end
KeepActivationPositionCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
	l_1_0._activation_position = Vector3()
end

KeepActivationPositionCamera.on_activate = function(l_2_0, l_2_1)
	SharedCamera.on_activate(l_2_0, l_2_1)
	if l_2_1 then
		l_2_0._activation_position = l_2_0._root_unit:camera()._camera_data.position
	end
end

KeepActivationPositionCamera.update = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
	l_3_0:set_local_position_from_world_position(l_3_0._activation_position)
	SharedCamera.update(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
end


