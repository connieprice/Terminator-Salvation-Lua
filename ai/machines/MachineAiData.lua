require("units/data/AiData")
if not MachineAiData then
	MachineAiData = class(AiData)
end
MachineAiData.init = function(l_1_0)
	AiData.init(l_1_0)
	if not l_1_0.default_enemy_slot_mask then
		l_1_0.default_enemy_slot_mask = "players"
	end
	l_1_0.hunt_and_hide = false
	do
		local l_1_1 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

	end
	 -- WARNING: undefined locals caused missing assignments!
end

MachineAiData.request_scan = function(l_2_0)
	l_2_0._scan_requested = true
end

MachineAiData.cancel_scan_request = function(l_3_0)
	l_3_0._scan_requested = false
end

MachineAiData.is_scan_requested = function(l_4_0)
	return l_4_0._scan_requested
end

MachineAiData.set_is_scanning = function(l_5_0, l_5_1)
	l_5_0._is_scanning = l_5_1
end

MachineAiData.is_scanning = function(l_6_0)
	return l_6_0._is_scanning
end

MachineAiData.clear_output = function(l_7_0)
	AiData.clear_output(l_7_0)
end

MachineAiData.set_rail_target_slot = function(l_8_0, l_8_1)
	l_8_1.input.enemy_slot_mask = "rail_vehicles"
end


