require("shared/camera/SharedCamera")
if not DynamicLinkCamera then
	DynamicLinkCamera = class(SharedCamera)
end
DynamicLinkCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
	l_1_0._current_target = nil
	l_1_0._current_target_object = nil
end

DynamicLinkCamera.parse_parameters = function(l_2_0, l_2_1)
	SharedCamera.parse_parameters(l_2_0, l_2_1)
	if l_2_1.target_unit then
		l_2_0._target_name = l_2_1.target_unit
	end
	if l_2_1.target_link_object then
		l_2_0._target_link_object_name = l_2_1.target_link_object
	end
end

DynamicLinkCamera.update = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
	if alive(l_3_0._root_unit) then
		local l_3_5 = l_3_0._root_unit:player_data().named_camera_targets[l_3_0._target_name]
	if l_3_0._current_target ~= l_3_5 then
		end
		l_3_0._current_target = l_3_5
	if alive(l_3_0._current_target) then
		end
		if l_3_0._target_link_object_name == nil or l_3_0._target_link_object_name == "" then
			l_3_0._current_target_object = l_3_5:orientation_object()
		end
	else
		l_3_0._current_target_object = l_3_5:get_object(l_3_0._target_link_object_name)
	end
	if alive(l_3_0._current_target) then
		local l_3_6 = l_3_4:inverse()
		l_3_0:set_local_position(l_3_0._current_target_object:position() - l_3_3:rotate_with(l_3_6))
		l_3_0:set_local_rotation(l_3_6 * l_3_0._current_target_object:rotation())
	end
	SharedCamera.update(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
end


