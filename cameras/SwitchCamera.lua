require("shared/camera/BlendCamera")
SwitchCamera = SwitchCamera or class(BlendCamera)
function SwitchCamera.init(A0_0, A1_1)
	SharedCamera.init(A0_0, A1_1)
	A0_0._interpolation_time = 0.1
end
function SwitchCamera.update(A0_2, A1_3, A2_4, A3_5)
	BlendCamera.update(A0_2, A1_3, A2_4, A3_5)
	A0_2._dt = A3_5
end
function SwitchCamera.post_update(A0_6)
	if not A0_6._target_camera then
		return
	end
	A0_6._factor = A0_6._factor + A0_6._dt / A0_6._interpolation_time
	if A0_6._factor > 1 then
		A0_6._factor = 1
		if A0_6._source_camera ~= A0_6._target_camera then
			A0_6._source_camera:set_active(false)
			A0_6._source_camera = A0_6._target_camera
		end
	end
	BlendCamera:post_update()
end
function SwitchCamera.switch_to_camera(A0_7, A1_8)
end
function SwitchCamera.set_interpolation_time(A0_9, A1_10)
	assert(A1_10 > 0)
	A0_9._interpolation_time = A1_10
end
