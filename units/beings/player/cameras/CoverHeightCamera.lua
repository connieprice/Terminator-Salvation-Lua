require("shared/camera/SharedCamera")
require("shared/Interpolator")
CoverHeightCamera = CoverHeightCamera or class(SharedCamera)
function CoverHeightCamera.init(A0_0, A1_1)
	SharedCamera.init(A0_0, A1_1)
	A0_0.interpolation_speed = 4
	A0_0._target_fov = Interpolator:new(67, 4)
end
function CoverHeightCamera.activate(A0_2)
	if not A0_2._target_offset then
		A0_2._target_offset = Interpolator:new(0, A0_2.interpolation_speed)
	end
	A0_2._player_data = A0_2._root_unit:player_data()
	A0_2:switch_to_normal()
end
function CoverHeightCamera.update(A0_3, A1_4, A2_5, A3_6)
	local L4_7, L5_8, L6_9
	L4_7 = SharedCamera
	L4_7 = L4_7.update
	L5_8 = A0_3
	L6_9 = A1_4
	L4_7(L5_8, L6_9, A2_5, A3_6)
	L4_7 = A0_3._player_data
	L5_8 = L4_7.in_cover
	L5_8 = L5_8 or L4_7.entering_cover
	if L5_8 then
		L6_9 = A0_3.switch_to_low_cover
		L6_9(A0_3)
	else
		L6_9 = A0_3.switch_to_normal
		L6_9(A0_3)
	end
	L6_9 = A0_3._target_fov
	L6_9 = L6_9.update
	L6_9(L6_9, A3_6)
	L6_9 = A0_3._target_fov
	L6_9 = L6_9.value
	L6_9 = L6_9(L6_9)
	A0_3.fov = L6_9
	L6_9 = A0_3._target_offset
	L6_9 = L6_9.update
	L6_9(L6_9, A3_6)
	L6_9 = A0_3._target_offset
	L6_9 = L6_9.set_speed
	L6_9(L6_9, 4)
	L6_9 = Vector3
	L6_9 = L6_9(0, 0, A0_3._target_offset:value())
	A0_3._unit:set_local_position(L6_9)
end
function CoverHeightCamera.switch_to_low_cover(A0_10)
	A0_10._target_offset:set_target(A0_10.offset)
	A0_10._target_fov:set_target(60)
end
function CoverHeightCamera.switch_to_normal(A0_11)
	A0_11._target_offset:set_target(A0_11.normal_offset)
	A0_11._target_fov:set_target(67)
end
