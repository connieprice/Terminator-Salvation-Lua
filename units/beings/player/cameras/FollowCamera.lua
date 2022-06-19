require("shared/camera/SharedCamera")
require("shared/Queue")
FollowCamera = FollowCamera or class(SharedCamera)
function FollowCamera.init(A0_0, A1_1)
	SharedCamera.init(A0_0, A1_1)
	A0_0._max_speed_factor = 0.3
	A0_0._speed_factor = 25
	A0_0:_reset()
end
function FollowCamera.parse_parameters(A0_2, A1_3)
	SharedCamera.parse_parameters(A0_2, A1_3)
	if A1_3.speed_factor then
		A0_2._speed_factor = tonumber(A1_3.speed_factor)
	end
	if A1_3.max_speed_factor then
		A0_2._max_speed_factor = tonumber(A1_3.max_speed_factor)
	end
end
function FollowCamera.update(A0_4, A1_5, A2_6, A3_7, A4_8)
	local L5_9, L6_10, L7_11, L8_12
	L6_10 = A3_7
	L7_11 = A3_7
	L8_12 = A0_4._prev_parent_position
	if L8_12 then
		L7_11 = A0_4._prev_parent_position
	end
	L8_12 = L6_10 - L7_11
	if L8_12:length() > 0 then
		if A0_4._velocity then
			A0_4._velocity = A0_4._velocity + L8_12 * A0_4._speed_factor * A2_6
			if 0 < (L8_12 * A0_4._max_speed_factor / A2_6).x then
				A0_4._velocity = A0_4._velocity:with_x(math.min(A0_4._velocity.x, (L8_12 * A0_4._max_speed_factor / A2_6).x))
			else
				A0_4._velocity = A0_4._velocity:with_x(math.max(A0_4._velocity.x, (L8_12 * A0_4._max_speed_factor / A2_6).x))
			end
			if 0 < (L8_12 * A0_4._max_speed_factor / A2_6).y then
				A0_4._velocity = A0_4._velocity:with_y(math.min(A0_4._velocity.y, (L8_12 * A0_4._max_speed_factor / A2_6).y))
			else
				A0_4._velocity = A0_4._velocity:with_y(math.max(A0_4._velocity.y, (L8_12 * A0_4._max_speed_factor / A2_6).y))
			end
			if 0 < (L8_12 * A0_4._max_speed_factor / A2_6).z then
				A0_4._velocity = A0_4._velocity:with_z(math.min(A0_4._velocity.z, (L8_12 * A0_4._max_speed_factor / A2_6).z))
			else
				A0_4._velocity = A0_4._velocity:with_z(math.max(A0_4._velocity.z, (L8_12 * A0_4._max_speed_factor / A2_6).z))
			end
		else
			A0_4._velocity = L8_12 / A2_6
		end
		L5_9 = L7_11 + A0_4._velocity * A2_6
	else
		L5_9 = L6_10
	end
	A0_4:set_local_position((L5_9 - A3_7):rotate_with(A4_8:inverse()))
	A0_4:set_local_rotation(Rotation())
	SharedCamera.update(A0_4, A1_5, A2_6, A3_7, A4_8)
	A0_4._prev_parent_position = A0_4:position()
end
function FollowCamera.on_activate(A0_13, A1_14)
	if A1_14 then
		A0_13:_reset()
	end
end
function FollowCamera._reset(A0_15)
	local L1_16, L2_17
	A0_15._velocity = nil
	A0_15._prev_parent_position = nil
	L2_17 = A0_15
	L1_16 = A0_15.set_local_position
	L1_16(L2_17, Vector3())
	L2_17 = A0_15
	L1_16 = A0_15.set_local_rotation
	L1_16(L2_17, Rotation())
end
function FollowCamera.debug_render(A0_18, A1_19, A2_20)
	local L3_21, L4_22, L5_23, L6_24, L7_25, L8_26, L9_27
	L3_21 = Draw
	L4_22 = L3_21
	L3_21 = L3_21.brush
	L3_21 = L3_21(L4_22)
	L4_22 = 5
	L5_23 = Color
	L6_24 = 0
	L7_25 = 0
	L8_26 = 1
	L5_23 = L5_23(L6_24, L7_25, L8_26)
	L6_24 = Color
	L7_25 = 1
	L8_26 = 0
	L9_27 = 0
	L6_24 = L6_24(L7_25, L8_26, L9_27)
	L7_25 = Color
	L8_26 = 1
	L9_27 = 1
	L7_25 = L7_25(L8_26, L9_27, 1)
	L9_27 = A0_18
	L8_26 = A0_18.position
	L8_26 = L8_26(L9_27)
	L9_27 = A0_18.position
	L9_27 = L9_27(A0_18)
	if A0_18._parent_camera then
		L9_27 = A0_18._parent_camera:position()
	end
	L3_21:set_color(L5_23)
	L3_21:sphere(L9_27, L4_22)
	L3_21:set_color(L7_25)
	L3_21:line(L8_26, L9_27)
	L3_21:set_color(L7_25)
	L3_21:set_color(L6_24)
	L3_21:sphere(L8_26, L4_22)
end
