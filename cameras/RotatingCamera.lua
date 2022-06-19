require("shared/camera/SharedCamera")
if not RotatingCamera then
	RotatingCamera = class(SharedCamera)
end
RotatingCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
	l_1_0:reset()
end

RotatingCamera.parse_parameters = function(l_2_0, l_2_1)
	local l_2_2 = l_2_1:parameter("rotate")
	if l_2_2 then
		l_2_0._rotate = math.string_to_vector(l_2_2)
	end
end

RotatingCamera.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	SharedCamera.update(l_3_0, l_3_1, l_3_2, l_3_3)
	if l_3_0._active then
		l_3_0:_update_rotate(l_3_3)
	end
end

RotatingCamera._update_rotate = function(l_4_0, l_4_1)
	local l_4_2 = l_4_0._unit:local_rotation()
	local l_4_3 = l_4_2 * Rotation(l_4_0._rotate.x * l_4_1, l_4_0._rotate.y * l_4_1, l_4_0._rotate.z * l_4_1)
	l_4_0._unit:set_local_rotation(l_4_3)
end

RotatingCamera.reset = function(l_5_0)
	l_5_0._rotate = Rotation(0, 0, 0)
end


