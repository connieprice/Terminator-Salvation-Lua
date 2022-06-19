require("shared/camera/SharedCamera")
require("shared/Queue")
if not FollowCamera then
	FollowCamera = class(SharedCamera)
end
FollowCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
	l_1_0._max_speed_factor = 0.3
	l_1_0._speed_factor = 25
	l_1_0:_reset()
end

FollowCamera.parse_parameters = function(l_2_0, l_2_1)
	SharedCamera.parse_parameters(l_2_0, l_2_1)
	if l_2_1.speed_factor then
		l_2_0._speed_factor = tonumber(l_2_1.speed_factor)
	end
	if l_2_1.max_speed_factor then
		l_2_0._max_speed_factor = tonumber(l_2_1.max_speed_factor)
	end
end

FollowCamera.update = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
	local l_3_5 = nil
	local l_3_6 = l_3_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_3_0._prev_parent_position then
		local l_3_7 = nil
	end
	local l_3_8 = nil
	if l_3_6 - l_3_3:length() > 0 then
		local l_3_9 = nil
		local l_3_10 = l_3_8 / l_3_6 - l_3_3:length()
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_3_0._velocity then
			if l_3_8 * l_3_0._max_speed_factor / l_3_2.x > 0 then
				l_3_0._velocity = l_3_0._velocity:with_x(math.min(l_3_0._velocity.x, l_3_8 * l_3_0._max_speed_factor / l_3_2.x))
			 -- DECOMPILER ERROR: Confused about usage of registers!

			else
				l_3_0._velocity = l_3_0._velocity:with_x(math.max(l_3_0._velocity.x, l_3_8 * l_3_0._max_speed_factor / l_3_2.x))
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_3_8 * l_3_0._max_speed_factor / l_3_2.y > 0 then
				l_3_0._velocity = l_3_0._velocity:with_y(math.min(l_3_0._velocity.y, l_3_8 * l_3_0._max_speed_factor / l_3_2.y))
			 -- DECOMPILER ERROR: Confused about usage of registers!

			else
				l_3_0._velocity = l_3_0._velocity:with_y(math.max(l_3_0._velocity.y, l_3_8 * l_3_0._max_speed_factor / l_3_2.y))
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_3_8 * l_3_0._max_speed_factor / l_3_2.z > 0 then
				l_3_0._velocity = l_3_0._velocity:with_z(math.min(l_3_0._velocity.z, l_3_8 * l_3_0._max_speed_factor / l_3_2.z))
			 -- DECOMPILER ERROR: Confused about usage of registers!

			else
				l_3_0._velocity = l_3_0._velocity:with_z(math.max(l_3_0._velocity.z, l_3_8 * l_3_0._max_speed_factor / l_3_2.z))
			end
		else
			l_3_0._velocity = l_3_8 / l_3_2
		end
		l_3_5 = l_3_7 + l_3_0._velocity * l_3_2
	else
		l_3_5 = l_3_6
	end
	l_3_0:set_local_position(l_3_5 - l_3_3:rotate_with(l_3_4:inverse()))
	l_3_0:set_local_rotation(Rotation())
	SharedCamera.update(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
	l_3_0._prev_parent_position = l_3_0:position()
end

FollowCamera.on_activate = function(l_4_0, l_4_1)
	if l_4_1 then
		l_4_0:_reset()
	end
end

FollowCamera._reset = function(l_5_0)
	l_5_0._velocity = nil
	l_5_0._prev_parent_position = nil
	l_5_0:set_local_position(Vector3())
	l_5_0:set_local_rotation(Rotation())
end

FollowCamera.debug_render = function(l_6_0, l_6_1, l_6_2)
	local l_6_3 = Draw:brush()
	local l_6_4 = 5
	local l_6_5 = Color(0, 0, 1)
	local l_6_6 = Color(1, 0, 0)
	local l_6_7 = Color(1, 1, 1)
	local l_6_8 = l_6_0:position()
	local l_6_9 = l_6_0:position()
	if l_6_0._parent_camera then
		l_6_9 = l_6_0._parent_camera:position()
	end
	l_6_3:set_color(l_6_5)
	l_6_3:sphere(l_6_9, l_6_4)
	l_6_3:set_color(l_6_7)
	l_6_3:line(l_6_8, l_6_9)
	l_6_3:set_color(l_6_7)
	l_6_3:set_color(l_6_6)
	l_6_3:sphere(l_6_8, l_6_4)
end


