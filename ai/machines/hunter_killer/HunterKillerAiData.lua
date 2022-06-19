if not HunterKillerAiData then
	HunterKillerAiData = class(MachineAiData)
end
HunterKillerAiData.init = function(l_1_0)
	MachineAiData.init(l_1_0)
	l_1_0:_setup_brain_data()
end

HunterKillerAiData._setup_brain_data = function(l_2_0)
	local l_2_1 = {}
	local l_2_2 = {}
	l_2_2.name = "hunter_killer_brain"
	l_2_2.group = "rail"
	local l_2_3 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_2.init_functions, l_2_3 = l_2_3, {"hk_combat":init_data(l_2_0), HunterKillerAiDefence:init_data(l_2_0)}
	l_2_1.rail = l_2_2
	l_2_0.brain_infos = l_2_1
	l_2_1 = l_2_0.output
	l_2_1.firing_target_unit, l_2_2 = l_2_2, {}
	l_2_1 = l_2_0.output
	l_2_1.firing_target_position, l_2_2 = l_2_2, {}
	l_2_1 = l_2_0.output
	l_2_1.allowed_to_fire, l_2_2 = l_2_2, {}
	l_2_1 = l_2_0.output
	l_2_1 = l_2_1.allowed_to_fire
	l_2_1[1] = false
	l_2_1 = l_2_0.output
	l_2_1 = l_2_1.allowed_to_fire
	l_2_1[2] = false
	l_2_1 = l_2_0.output
	l_2_1.allowed_to_release_flare = false
end

HunterKillerAiData.clear_output = function(l_3_0)
	MachineAiData.clear_output(l_3_0)
	l_3_0.output.firing_target_unit = {}
	l_3_0.output.firing_target_position = {}
	l_3_0.output.allowed_to_fire = {}
	l_3_0.output.allowed_to_release_flare = nil
end


