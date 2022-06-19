AMRailCameraMode = AMRailCameraMode or class(CoreActionElement)
function AMRailCameraMode.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMRailCameraMode.activate_now(A0_3)
	local L1_4
	if A0_3.character == "character_slot_1" then
		L1_4 = 1
	elseif A0_3.character == "character_slot_2" then
		L1_4 = 2
	else
		assert(false, "No character assigned to AMRailCameraMode")
	end
	if managers.player_slot:slot(L1_4):spawned_unit() and not managers.player_slot:slot(L1_4):spawned_unit():player_data().rail_vehicle_permanent_camera then
		managers.player_slot:slot(L1_4):spawned_unit():player_data().rail_vehicle_permanent_camera = A0_3.permanent
		managers.player_slot:slot(L1_4):spawned_unit():player_data().rail_vehicle_camera = A0_3.camera_mode
		managers.player_slot:slot(L1_4):spawned_unit():player_data().rail_vehicle_camera_blend_time = A0_3.switch_time
		managers.player_slot:slot(L1_4):spawned_unit():player_data().player_has_controllable_camera = A0_3.control
		managers.player_slot:slot(L1_4):spawned_unit():player_data().named_camera_targets.enemy = nil
		managers.player_slot:slot(L1_4):spawned_unit():rail():align_rotation_to_camera(A0_3.control)
		if A0_3.camera_target and A0_3.camera_target.script_name then
			A0_3._camera_target_unit = managers.unit_scripting:get_unit_by_name(A0_3.camera_target.script_name)
			if not alive(A0_3._camera_target_unit) then
				A0_3:deactivate_now()
				return
			end
			managers.player_slot:slot(L1_4):spawned_unit():player_data().named_camera_targets.enemy = A0_3._camera_target_unit
		end
	end
	A0_3:deactivate_now()
end
