HunterKillerAiData = HunterKillerAiData or class(MachineAiData)
function HunterKillerAiData.init(A0_0)
	MachineAiData.init(A0_0)
	A0_0:_setup_brain_data()
end
function HunterKillerAiData._setup_brain_data(A0_1)
	local L1_2, L2_3, L3_4
	L1_2 = {}
	L2_3 = {}
	L2_3.name = "hunter_killer_brain"
	L2_3.group = "rail"
	L3_4 = {"hk_combat", "hk_defence"}
	L2_3.auto_started_threads = L3_4
	L3_4 = {}
	L2_3.lod_managed_threads = L3_4
	L2_3.lod_distance = 0
	L3_4 = {
		HunterKillerAiCombat:init_data(A0_1),
		HunterKillerAiDefence:init_data(A0_1)
	}
	L2_3.init_functions = L3_4
	L1_2.rail = L2_3
	A0_1.brain_infos = L1_2
	L1_2 = A0_1.output
	L2_3 = {}
	L1_2.firing_target_unit = L2_3
	L1_2 = A0_1.output
	L2_3 = {}
	L1_2.firing_target_position = L2_3
	L1_2 = A0_1.output
	L2_3 = {}
	L1_2.allowed_to_fire = L2_3
	L1_2 = A0_1.output
	L1_2 = L1_2.allowed_to_fire
	L1_2[1] = false
	L1_2 = A0_1.output
	L1_2 = L1_2.allowed_to_fire
	L1_2[2] = false
	L1_2 = A0_1.output
	L1_2.allowed_to_release_flare = false
end
function HunterKillerAiData.clear_output(A0_5)
	MachineAiData.clear_output(A0_5)
	A0_5.output.firing_target_unit = {}
	A0_5.output.firing_target_position = {}
	A0_5.output.allowed_to_fire = {}
	A0_5.output.allowed_to_release_flare = nil
end
