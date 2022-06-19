require("shared/camera/SharedCamera")
if not MovingCamera then
	MovingCamera = class(SharedCamera)
end
MovingCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
	l_1_0:reset()
end

MovingCamera.parse_parameters = function(l_2_0, l_2_1)
	local l_2_2 = l_2_1:parameter("move")
	if l_2_2 then
		l_2_0._move = math.string_to_vector(l_2_2)
	end
	local l_2_3 = l_2_1:parameter("max_offset")
	if l_2_3 then
		l_2_0._max_offset = math.string_to_vector(l_2_3)
	end
end

MovingCamera.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	SharedCamera.update(l_3_0, l_3_1, l_3_2, l_3_3)
	if l_3_0._active then
		l_3_0:_update_move(l_3_3)
	end
end

MovingCamera._update_move = function(l_4_0, l_4_1)
	local l_4_2 = l_4_0._unit:local_position()
	local l_4_3 = l_4_2 + Vector3(l_4_0._move.x * l_4_1, l_4_0._move.y * l_4_1, l_4_0._move.z * l_4_1)
	if l_4_0._max_offset then
		l_4_3 = Vector3(math.clamp(l_4_3.x, -l_4_0._max_offset.x, l_4_0._max_offset.x), math.clamp(l_4_3.y, -l_4_0._max_offset.y, l_4_0._max_offset.y), math.clamp(l_4_3.z, -l_4_0._max_offset.z, l_4_0._max_offset.z))
	end
	l_4_0._unit:set_local_position(l_4_3)
end

MovingCamera.reset = function(l_5_0)
	l_5_0._move = Vector3(0, 0, 0)
end


