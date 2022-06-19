BikerAiData = BikerAiData or class(MachineAiData)
function BikerAiData.init(A0_0)
	MachineAiData.init(A0_0)
	A0_0:_setup_brain_data()
end
function BikerAiData._setup_brain_data(A0_1)
	local L1_2, L2_3, L3_4
	L1_2 = {}
	L2_3 = {}
	L2_3.name = "biker_brain"
	L2_3.group = "rail"
	L3_4 = {
		"biker_combat",
		"biker_move"
	}
	L2_3.auto_started_threads = L3_4
	L3_4 = {}
	L2_3.lod_managed_threads = L3_4
	L2_3.lod_distance = 0
	L3_4 = {
		BikerAiCombat:init_data(A0_1),
		BikerAiMove:init_data(A0_1)
	}
	L2_3.init_functions = L3_4
	L1_2.rail = L2_3
	A0_1.brain_infos = L1_2
	L1_2 = A0_1.output
	L1_2.speed = 1
	L1_2 = A0_1.output
	L1_2.closest_target = nil
	L1_2 = A0_1.output
	L1_2.attack_type = nil
	L1_2 = A0_1.output
	L1_2.allowed_to_fire = false
end
function BikerAiData.clear_output(A0_5)
	MachineAiData.clear_output(A0_5)
	A0_5.output.speed = 1
	A0_5.output.closest_target = nil
	A0_5.output.attack_type = nil
	A0_5.output.allowed_to_fire = nil
end
