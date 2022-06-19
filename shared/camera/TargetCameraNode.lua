require("shared/camera/SharedCamera")
require("shared/TableSerializer")
if not TargetCameraNode then
	TargetCameraNode = class(SharedCamera)
end
TargetCameraNode.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
end

TargetCameraNode.parse_parameters = function(l_2_0, l_2_1)
	SharedCamera.parse_parameters(l_2_0, l_2_1)
	l_2_0._target_object_name = l_2_1.target_object_name
	local l_2_2 = l_2_1.target_position_offset
	if l_2_2 then
		l_2_0._target_position_offset = TableSerializer._load_vector(l_2_2)
	end
	local l_2_3 = l_2_1.interpolation_speed
	if l_2_3 then
		l_2_0._interpolation_speed = tonumber(l_2_3)
	end
	local l_2_4 = l_2_0._target_object_name
	if l_2_4 then
		l_2_0._target_object = l_2_0._root_unit:get_object(l_2_4)
	end
end

TargetCameraNode.update = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
	local l_3_5 = nil
	if l_3_0._target_object then
		l_3_5 = l_3_0._target_object:position()
	elseif l_3_0._target_position then
		l_3_5 = l_3_0._target_position
	else
		l_3_5 = l_3_0._root_unit:position()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_3_0._target_position_offset then
		l_3_5 = l_3_5 + l_3_0._target_position_offset
	end
	local l_3_6 = nil
	do
		local l_3_7 = nil
		if l_3_5 - l_3_3:length() > 0 then
			local l_3_8 = nil
			local l_3_9 = nil
			local l_3_10 = nil
			local l_3_11 = l_3_4:inverse() * Rotation(l_3_7 / l_3_5 - l_3_3:length(), math.UP)
			if l_3_0._interpolation_speed then
				local l_3_12 = nil
				local l_3_13 = l_3_0:local_rotation()
				l_3_12 = l_3_13:slerp(l_3_11, math.min(l_3_0._interpolation_speed * l_3_2, 1))
			else
				l_3_0:set_local_rotation(l_3_11)
			end
			SharedCamera.update(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 55 
end

TargetCameraNode.set_target_position = function(l_4_0, l_4_1)
	l_4_0._target_position = l_4_1
	l_4_0._target_object = nil
end


