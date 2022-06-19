AMRailDriveTest = AMRailDriveTest or class(CoreActionElement)
function AMRailDriveTest.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
	if A0_0.unit_name ~= "none" then
		World:preload_unit("rail_drive_test")
	end
end
function AMRailDriveTest.activate_now(A0_3)
	if A0_3.unit_name ~= "none" then
		World:spawn_unit("rail_drive_test", A0_3.position, A0_3.rotation):base()._playback_unit = managers.unit_scripting:get_unit_by_name(A0_3.playback_unit.script_name)
	end
	A0_3:deactivate_now()
end
