require("shared/camera/SharedCamera")
KeepActivationPositionCamera = KeepActivationPositionCamera or class(SharedCamera)
function KeepActivationPositionCamera.init(A0_0, A1_1)
	SharedCamera.init(A0_0, A1_1)
	A0_0._activation_position = Vector3()
end
function KeepActivationPositionCamera.on_activate(A0_2, A1_3)
	SharedCamera.on_activate(A0_2, A1_3)
	if A1_3 then
		A0_2._activation_position = A0_2._root_unit:camera()._camera_data.position
	end
end
function KeepActivationPositionCamera.update(A0_4, A1_5, A2_6, A3_7, A4_8)
	A0_4:set_local_position_from_world_position(A0_4._activation_position)
	SharedCamera.update(A0_4, A1_5, A2_6, A3_7, A4_8)
end
