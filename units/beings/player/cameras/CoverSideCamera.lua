require("shared/camera/SharedCamera")
require("shared/Interpolator")
CoverSideCamera = CoverSideCamera or class(SharedCamera)
function CoverSideCamera.init(A0_0, A1_1)
	SharedCamera.init(A0_0, A1_1)
	A0_0.interpolation_speed = 1
end
function CoverSideCamera.activate(A0_2)
	if not A0_2._target_offset then
		A0_2._target_offset = Interpolator:new(0, A0_2.interpolation_speed)
	end
	A0_2._player_data = A0_2._root_unit:player_data()
	A0_2._peek_offset = 0
	A0_2:switch_to_right()
end
function CoverSideCamera.update(A0_3, A1_4, A2_5, A3_6)
	local L4_7, L5_8, L6_9, L7_10
	L4_7 = SharedCamera
	L4_7 = L4_7.update
	L5_8 = A0_3
	L6_9 = A1_4
	L7_10 = A2_5
	L4_7(L5_8, L6_9, L7_10, A3_6)
	L4_7 = A0_3._player_data
	L5_8 = L4_7.in_cover
	if L5_8 then
		L5_8 = L4_7.facing_right_in_cover
	L5_8 = not L5_8 or L4_7.entering_cover_from_slide_facing_left
	L6_9 = L4_7.peeking_left
	if not L6_9 then
		L6_9 = L4_7.peeking_right
	else
		if L6_9 then
			A0_3._peek_offset = 50
	end
	else
		A0_3._peek_offset = 0
	end
	if L5_8 then
		L7_10 = A0_3
		L6_9 = A0_3.switch_to_left
		L6_9(L7_10)
	else
		L7_10 = A0_3
		L6_9 = A0_3.switch_to_right
		L6_9(L7_10)
	end
	L6_9 = L4_7.peekin
	L7_10 = A0_3._target_offset
	L7_10 = L7_10.update
	L7_10(L7_10, A3_6)
	L7_10 = A0_3._target_offset
	L7_10 = L7_10.set_speed
	L7_10(L7_10, 2)
	L7_10 = Vector3
	L7_10 = L7_10(A0_3._target_offset:value(), 0, 0)
	A0_3._unit:set_local_position(L7_10)
end
function CoverSideCamera.switch_to_right(A0_11)
	A0_11._target_offset:set_target(A0_11.right_offset + A0_11._peek_offset)
end
function CoverSideCamera.switch_to_left(A0_12)
	A0_12._target_offset:set_target(-A0_12.left_offset - A0_12._peek_offset)
end
