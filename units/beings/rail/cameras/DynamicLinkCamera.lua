require("shared/camera/SharedCamera")
DynamicLinkCamera = DynamicLinkCamera or class(SharedCamera)
function DynamicLinkCamera.init(A0_0, A1_1)
	SharedCamera.init(A0_0, A1_1)
	A0_0._current_target = nil
	A0_0._current_target_object = nil
end
function DynamicLinkCamera.parse_parameters(A0_2, A1_3)
	SharedCamera.parse_parameters(A0_2, A1_3)
	if A1_3.target_unit then
		A0_2._target_name = A1_3.target_unit
	end
	if A1_3.target_link_object then
		A0_2._target_link_object_name = A1_3.target_link_object
	end
end
function DynamicLinkCamera.update(A0_4, A1_5, A2_6, A3_7, A4_8)
	local L5_9
	L5_9 = alive
	L5_9 = L5_9(A0_4._root_unit)
	if L5_9 then
		L5_9 = A0_4._root_unit
		L5_9 = L5_9.player_data
		L5_9 = L5_9(L5_9)
		L5_9 = L5_9.named_camera_targets
		L5_9 = L5_9[A0_4._target_name]
		if A0_4._current_target ~= L5_9 then
			A0_4._current_target = L5_9
			if alive(A0_4._current_target) then
				if A0_4._target_link_object_name == nil or A0_4._target_link_object_name == "" then
					A0_4._current_target_object = L5_9:orientation_object()
				else
					A0_4._current_target_object = L5_9:get_object(A0_4._target_link_object_name)
				end
			end
		end
	end
	L5_9 = alive
	L5_9 = L5_9(A0_4._current_target)
	if L5_9 then
		L5_9 = A4_8.inverse
		L5_9 = L5_9(A4_8)
		A0_4:set_local_position((A0_4._current_target_object:position() - A3_7):rotate_with(L5_9))
		A0_4:set_local_rotation(L5_9 * A0_4._current_target_object:rotation())
	end
	L5_9 = SharedCamera
	L5_9 = L5_9.update
	L5_9(A0_4, A1_5, A2_6, A3_7, A4_8)
end
