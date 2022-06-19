if not SkynetDefenceTurretAiData then
	SkynetDefenceTurretAiData = class(MachineAiData)
end
SkynetDefenceTurretAiData.init = function(l_1_0)
	MachineAiData.init(l_1_0)
	l_1_0:_setup_brain_data()
	local l_1_1 = {}
	local l_1_2 = {}
	l_1_2.name = SkynetDefenceTurretBase._CENTER_OBJECT_NAME
	l_1_2.id = ""
	l_1_2.enabled = true
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	l_1_0.UNIT_WEAPONS = l_1_1
	l_1_0.FRIENDLY_UNITS_SLOT_MASK = "machines"
	l_1_0.LINE_OF_FIRE_SLOT_MASK = "enemy_line_of_fire_blockers"
end

SkynetDefenceTurretAiData._setup_brain_data = function(l_2_0)
	local l_2_1 = {}
	local l_2_2 = {}
	l_2_2.name = "skynet_defence_turret_brain"
	l_2_2.group = "rail"
	local l_2_3 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_2.init_functions, l_2_3 = l_2_3, {"skynet_defence_turret_combat":init_data(l_2_0)}
	l_2_1.rail = l_2_2
	l_2_0.brain_infos = l_2_1
	l_2_1 = l_2_0.output
	l_2_1.firing_target = nil
	l_2_1 = l_2_0.output
	l_2_1.firing_target_position = nil
	l_2_1 = l_2_0.output
	l_2_1.allowed_to_fire = false
end

SkynetDefenceTurretAiData.clear_output = function(l_3_0)
	MachineAiData.clear_output(l_3_0)
	l_3_0.output.firing_target = nil
	l_3_0.output.firing_target_position = nil
	l_3_0.output.allowed_to_fire = false
end


