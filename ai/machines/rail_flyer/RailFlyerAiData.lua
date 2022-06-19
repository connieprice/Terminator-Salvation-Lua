RailFlyerAiData = RailFlyerAiData or class(MachineAiData)
function RailFlyerAiData.init(A0_0)
	MachineAiData.init(A0_0)
	A0_0.UNIT_EYES = {
		{
			name = "rp_flyer",
			half_fov = tweak_data.ai.machines.flyer.HALF_FOV,
			half_zfov = tweak_data.ai.machines.flyer.HALF_ZFOV,
			range = 10000
		}
	}
	A0_0.UNIT_WEAPONS = {
		{
			name = "rp_flyer",
			id = "",
			enabled = true
		}
	}
	A0_0.LINE_OF_FIRE_SLOT_MASK = "enemy_line_of_fire_blockers"
	A0_0.FRIENDLY_UNITS_SLOT_MASK = "machines"
	A0_0.WEAPONS_RANGE = 1500
	A0_0.SOUND_LEVEL_HEARING_THRESHOLD = 0
	A0_0.TIME_TO_FORGET = 30
	A0_0.stay_on_ground = false
	A0_0.allowed_to_move_and_shoot = true
	A0_0.arrived_radius = 100
	A0_0.disc_arrived_radius = 400
	A0_0:_setup_brain_data()
end
function RailFlyerAiData._setup_brain_data(A0_1)
	local L1_2
	A0_1.brain_name = "rail_flyer_brain"
	A0_1.brain_group = "all"
	L1_2 = tweak_data
	L1_2 = L1_2.ai
	L1_2 = L1_2.machines
	L1_2 = L1_2.flyer
	L1_2 = L1_2.LOD_DISTANCE
	A0_1.lod_distance = L1_2
	L1_2 = {}
	A0_1.lod_managed_threads = L1_2
	L1_2 = {
		"flyer_threat_tracking",
		"flyer_sensory",
		"rail_flyer_move",
		"rail_flyer_combat"
	}
	A0_1.auto_started_threads = L1_2
	L1_2 = "air_flyer"
	A0_1.graph = Search:nav(L1_2)
	assert(A0_1.graph, "AI graph " .. L1_2 .. " not found!")
	CommonAiThreatTracking:init_data(A0_1)
	CommonAiSensoryEventsHandler:init_data(A0_1)
	RailFlyerAiMove:init_data(A0_1)
	RailFlyerAiCombat:init_data(A0_1)
	A0_1.default_speed = 1
	A0_1.output.move_speed = 1
	A0_1.output.allowed_to_fire = false
	A0_1.output.firing_target = nil
	A0_1.output.investigate_mode = false
	A0_1.output.firing_target_position = nil
end
function RailFlyerAiData.clear_output(A0_3)
	MachineAiData.clear_output(A0_3)
	A0_3.output.move_speed = 1
	A0_3.output.allowed_to_fire = false
	A0_3.output.firing_target = nil
	A0_3.output.investigate_mode = false
	A0_3.output.firing_target_position = nil
end
