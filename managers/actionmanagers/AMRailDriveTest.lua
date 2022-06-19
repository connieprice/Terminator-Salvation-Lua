if not AMRailDriveTest then
	AMRailDriveTest = class(CoreActionElement)
end
AMRailDriveTest.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
	if l_1_0.unit_name ~= "none" then
		World:preload_unit("rail_drive_test")
	end
end

AMRailDriveTest.activate_now = function(l_2_0)
	if l_2_0.unit_name ~= "none" then
		local l_2_1, l_2_2, l_2_4 = World:spawn_unit("rail_drive_test", l_2_0.position, l_2_0.rotation)
		l_2_2, l_2_4 = l_2_1:base, l_2_1
		l_2_2 = l_2_2(l_2_4)
		l_2_4 = managers
		l_2_4 = l_2_4.unit_scripting
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_2._playback_unit = l_2_4
		l_2_2 = 0
		local l_2_3, l_2_5 = nil
	end
	l_2_0:deactivate_now()
end


