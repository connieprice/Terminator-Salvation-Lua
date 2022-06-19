SkynetDefenceTurretAiData = SkynetDefenceTurretAiData or class(MachineAiData)
function SkynetDefenceTurretAiData.init(A0_0)
	MachineAiData.init(A0_0)
	A0_0:_setup_brain_data()
	A0_0.UNIT_WEAPONS = {
		{
			name = SkynetDefenceTurretBase._CENTER_OBJECT_NAME,
			id = "",
			enabled = true
		}
	}
	A0_0.FRIENDLY_UNITS_SLOT_MASK = "machines"
	A0_0.LINE_OF_FIRE_SLOT_MASK = "enemy_line_of_fire_blockers"
end
function SkynetDefenceTurretAiData._setup_brain_data(A0_1)
	local L1_2, L2_3, L3_4
	L1_2 = {}
	L2_3 = {}
	L2_3.name = "skynet_defence_turret_brain"
	L2_3.group = "rail"
	L3_4 = {
		"skynet_defence_turret_combat"
	}
	L2_3.auto_started_threads = L3_4
	L3_4 = {}
	L2_3.lod_managed_threads = L3_4
	L2_3.lod_distance = 0
	L3_4 = {
		SkynetDefenceTurretAiCombat:init_data(A0_1)
	}
	L2_3.init_functions = L3_4
	L1_2.rail = L2_3
	A0_1.brain_infos = L1_2
	L1_2 = A0_1.output
	L1_2.firing_target = nil
	L1_2 = A0_1.output
	L1_2.firing_target_position = nil
	L1_2 = A0_1.output
	L1_2.allowed_to_fire = false
end
function SkynetDefenceTurretAiData.clear_output(A0_5)
	MachineAiData.clear_output(A0_5)
	A0_5.output.firing_target = nil
	A0_5.output.firing_target_position = nil
	A0_5.output.allowed_to_fire = false
end
