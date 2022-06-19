if not AMRailCameraMode then
	AMRailCameraMode = class(CoreActionElement)
end
AMRailCameraMode.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMRailCameraMode.activate_now = function(l_2_0)
	local l_2_1 = nil
	if l_2_0.character == "character_slot_1" then
		l_2_1 = 1
	elseif l_2_0.character == "character_slot_2" then
		l_2_1 = 2
	else
		assert(false, "No character assigned to AMRailCameraMode")
	end
	local l_2_2 = nil
	if managers.player_slot:slot(l_2_1):spawned_unit() then
		local l_2_3 = nil
	if not managers.player_slot:slot(l_2_1):spawned_unit():player_data().rail_vehicle_permanent_camera then
		end
		managers.player_slot:slot(l_2_1):spawned_unit():player_data().rail_vehicle_permanent_camera = l_2_0.permanent
		managers.player_slot:slot(l_2_1):spawned_unit():player_data().rail_vehicle_camera = l_2_0.camera_mode
		managers.player_slot:slot(l_2_1):spawned_unit():player_data().rail_vehicle_camera_blend_time = l_2_0.switch_time
		managers.player_slot:slot(l_2_1):spawned_unit():player_data().player_has_controllable_camera = l_2_0.control
		managers.player_slot:slot(l_2_1):spawned_unit():player_data().named_camera_targets.enemy = nil
		l_2_3:rail():align_rotation_to_camera(l_2_0.control)
	if l_2_0.camera_target then
		end
	if l_2_0.camera_target.script_name then
		end
		l_2_0._camera_target_unit = managers.unit_scripting:get_unit_by_name(l_2_0.camera_target.script_name)
		if not alive(l_2_0._camera_target_unit) then
			l_2_0:deactivate_now()
			return 
		end
		managers.player_slot:slot(l_2_1):spawned_unit():player_data().named_camera_targets.enemy = l_2_0._camera_target_unit
	end
	l_2_0:deactivate_now()
end


