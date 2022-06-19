if not BikerAiData then
	BikerAiData = class(MachineAiData)
end
BikerAiData.init = function(l_1_0)
	MachineAiData.init(l_1_0)
	l_1_0:_setup_brain_data()
end

BikerAiData._setup_brain_data = function(l_2_0)
	local l_2_1 = {}
	local l_2_2 = {}
	l_2_2.name = "biker_brain"
	l_2_2.group = "rail"
	local l_2_3 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_2.init_functions, l_2_3 = l_2_3, {"biker_combat":init_data(l_2_0), BikerAiMove:init_data(l_2_0)}
	l_2_1.rail = l_2_2
	l_2_0.brain_infos = l_2_1
	l_2_1 = l_2_0.output
	l_2_1.speed = 1
	l_2_1 = l_2_0.output
	l_2_1.closest_target = nil
	l_2_1 = l_2_0.output
	l_2_1.attack_type = nil
	l_2_1 = l_2_0.output
	l_2_1.allowed_to_fire = false
end

BikerAiData.clear_output = function(l_3_0)
	MachineAiData.clear_output(l_3_0)
	l_3_0.output.speed = 1
	l_3_0.output.closest_target = nil
	l_3_0.output.attack_type = nil
	l_3_0.output.allowed_to_fire = nil
end


