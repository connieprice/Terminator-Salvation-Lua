require("units/data/AiData")
MachineAiData = MachineAiData or class(AiData)
function MachineAiData.init(A0_0)
	AiData.init(A0_0)
	if not A0_0.default_enemy_slot_mask then
		A0_0.default_enemy_slot_mask = "players"
	end
	A0_0.hunt_and_hide = false
	A0_0.EVENT_SOURCE_TYPES = {
		managers.sensory_events.source_types.HUMAN_ID,
		managers.sensory_events.source_types.HUMAN_WEAPON_ID,
		managers.sensory_events.source_types.GENERIC_WEAPON_ID
	}
	A0_0.THREATENING_EVENT_SOURCE_TYPES = {}
	A0_0.THREATENING_EVENT_SOURCE_TYPES[managers.sensory_events.source_types.HUMAN_ID] = true
	A0_0.THREATENING_EVENT_SOURCE_TYPES[managers.sensory_events.source_types.HUMAN_WEAPON_ID] = true
	A0_0.output.firing_target_position = nil
	A0_0._scan_requested = false
	A0_0._is_scanning = false
end
function MachineAiData.request_scan(A0_1)
	local L1_2
	A0_1._scan_requested = true
end
function MachineAiData.cancel_scan_request(A0_3)
	local L1_4
	A0_3._scan_requested = false
end
function MachineAiData.is_scan_requested(A0_5)
	local L1_6
	L1_6 = A0_5._scan_requested
	return L1_6
end
function MachineAiData.set_is_scanning(A0_7, A1_8)
	A0_7._is_scanning = A1_8
end
function MachineAiData.is_scanning(A0_9)
	local L1_10
	L1_10 = A0_9._is_scanning
	return L1_10
end
function MachineAiData.clear_output(A0_11)
	AiData.clear_output(A0_11)
end
function MachineAiData.set_rail_target_slot(A0_12, A1_13)
	A1_13.input.enemy_slot_mask = "rail_vehicles"
end
