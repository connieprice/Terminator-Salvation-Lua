require("ai/machines/MachineAiData")
WalkerAiData = WalkerAiData or class(MachineAiData)
function WalkerAiData.init(A0_0)
	MachineAiData.init(A0_0)
	A0_0:_setup_brain_data()
	A0_0.UNIT_EYES = {
		PATROL = {
			{
				name = "Head",
				forward_axis = "z",
				half_fov = tweak_data.ai.humans.ai_player.HALF_FOV,
				half_zfov = tweak_data.ai.humans.ai_player.HALF_ZFOV,
				range = 10000
			},
			{
				name = "Head",
				forward_axis = "z",
				half_fov = 180,
				half_zfov = 60,
				range = 500
			}
		},
		STANDARD = {
			{
				name = "Head",
				forward_axis = "z",
				half_fov = tweak_data.ai.humans.ai_player.HALF_FOV,
				half_zfov = tweak_data.ai.humans.ai_player.HALF_ZFOV,
				range = 10000
			},
			{
				name = "Head",
				forward_axis = "z",
				half_fov = 180,
				half_zfov = 60,
				range = 500
			}
		}
	}
	A0_0.current_unit_eyes = A0_0.UNIT_EYES.STANDARD
	A0_0.UNIT_WEAPONS = {
		{
			name = "RightHand",
			id = "",
			enabled = true
		}
	}
	A0_0.SPEEDS = {walk = 1}
	A0_0.threat_constants = {
		DAMAGE_DECLINATION_FACTOR = 0.05,
		LOS_DECLINATION_FACTOR = 0.05,
		LOF_DECLINATION_FACTOR = 0.05,
		ENABLE_UNIT_CLUSTERING = true,
		primary_weights = {
			HAS_LOS_FACTOR = 1,
			NO_LOS_FACTOR = 0.9,
			HAS_LOF_FACTOR = 1,
			NO_LOF_FACTOR = 0.9,
			MIN_AGGRESSION_FACTOR = 0.5,
			MAX_AGGRESSION_FACTOR = 0.8,
			MIN_DAMAGE_FACTOR = 0.9,
			MAX_DAMAGE_FACTOR = 1,
			DAMAGE_SCALE = 5,
			PROXIMITY_OVERRIDE_RANGE = 800,
			UNIT_CLUSTERING_ALONE_FACTOR = 1,
			UNIT_CLUSTERING_MAX_RADIUS_FACTOR = 0.2,
			UNIT_CLUSTERING_MIN_RADIUS_FACTOR = 0.01,
			HUMAN_PLAYER_FACTOR = 1,
			NON_HUMAN_PLAYER_FACTOR = 0.9,
			IN_COVER_FACTOR = 0.5,
			OUT_OF_COVER_FACTOR = 1,
			SAME_TARGET_FACTOR = 1,
			CHANGE_TARGET_FACTOR = 0.5
		},
		secondary_weights = {
			HAS_LOS_FACTOR = 1,
			NO_LOS_FACTOR = 0.1,
			HAS_LOF_FACTOR = 1,
			NO_LOF_FACTOR = 0.1,
			MIN_AGGRESSION_FACTOR = 0.01,
			MAX_AGGRESSION_FACTOR = 0.2,
			MIN_DAMAGE_FACTOR = 0.9,
			MAX_DAMAGE_FACTOR = 1,
			DAMAGE_SCALE = 2,
			PROXIMITY_OVERRIDE_RANGE = 700,
			UNIT_CLUSTERING_ALONE_FACTOR = 0.8,
			UNIT_CLUSTERING_MAX_RADIUS_FACTOR = 0.9,
			UNIT_CLUSTERING_MIN_RADIUS_FACTOR = 1,
			HUMAN_PLAYER_FACTOR = 1,
			NON_HUMAN_PLAYER_FACTOR = 0.75,
			IN_COVER_FACTOR = 0.3,
			OUT_OF_COVER_FACTOR = 1,
			FIRING_ARC_ORIENTATION_OBJECT = "LeftShoulder",
			FIRING_ARC_ORIENTATION_OBJECT_AXIS = "z",
			FIRING_ARC_INFO = {
				{
					CENTER_ANGLE = -((90 - -45) / 2 + -45),
					HALF_FOV = (90 - -45) / 2,
					HALF_ZFOV = 60
				},
				{
					CENTER_ANGLE = (90 - -45) / 2 + -45,
					HALF_FOV = (90 - -45) / 2,
					HALF_ZFOV = 60
				}
			},
			SAME_TARGET_FACTOR = 1,
			CHANGE_TARGET_FACTOR = 0.95
		}
	}
	A0_0.LINE_OF_FIRE_SLOT_MASK = "enemy_line_of_fire_blockers"
	A0_0.FRIENDLY_UNITS_SLOT_MASK = "machines"
	A0_0.WEAPONS_RANGE = 2500
	A0_0.SOUND_LEVEL_HEARING_THRESHOLD = 0
	A0_0.TIME_TO_FORGET_THREATNING_UNIT = 40
	A0_0.TIME_TO_FORGET_UNIDENTIFIED_THREAT = 10
	A0_0.NUMBER_OF_SECONDARY_TARGETS = A0_0.number_of_secondary_weapons or 2
	A0_0.AGGRESIVE_MOVE_TIMERS = {0.1, 1}
	A0_0.hunt_and_hide = true
	A0_0.arrived_radius = 100
end
function WalkerAiData._setup_brain_data(A0_1)
	local L1_2
	L1_2 = {}
	L1_2.normal = {
		name = "walker_brain",
		group = "normal",
		auto_started_threads = {
			"walker_threat_tracking",
			"walker_targeting",
			"walker_sensory",
			"walker_behavior",
			"walker_movement",
			"walker_combat"
		},
		lod_managed_threads = {},
		lod_distance = 0,
		init_functions = {
			CommonAiThreatTracking.init_data,
			CommonAiTargeting.init_data,
			CommonAiSensoryEventsHandler.init_data,
			WalkerAiBehavior.init_data,
			WalkerAiMovement.init_data,
			WalkerAiCombat.init_data
		},
		forced_targeting_threads = {
			"walker_threat_tracking",
			"walker_targeting",
			"walker_combat"
		}
	}
	L1_2.rail = {
		name = "walker_brain",
		group = "rail",
		auto_started_threads = {
			"walker_threat_tracking",
			"walker_targeting",
			"walker_sensory",
			"walker_behavior",
			"walker_movement",
			"walker_combat"
		},
		lod_managed_threads = {},
		lod_distance = 0,
		init_functions = {
			CommonAiThreatTracking.init_data,
			CommonAiTargeting.init_data,
			CommonAiSensoryEventsHandler.init_data,
			WalkerAiBehavior.init_data,
			WalkerAiMovement.init_data,
			WalkerAiCombat.init_data,
			MachineAiData.set_rail_target_slot,
			WalkerAiData.set_weapon_range_to_rail
		}
	}
	A0_1.brain_infos = L1_2
	L1_2 = "surface_human"
	A0_1.graph = Search:nav(L1_2)
	assert(A0_1.graph, "AI graph " .. L1_2 .. " not found!")
	A0_1.input.is_firing = false
	A0_1.input.is_charging = false
	A0_1.output.urgent = false
	A0_1.output.attack_mode = false
	A0_1.output.allowed_to_fire = false
	A0_1.output.firing_target = nil
	A0_1.output.investigate_mode = false
	A0_1.output.firing_target_position = nil
	A0_1.output.threat_arc_min = nil
	A0_1.output.threat_arc_max = nil
end
function WalkerAiData.set_weapon_range_to_rail(A0_3, A1_4)
	local L2_5
	L2_5 = tweak_data
	L2_5 = L2_5.ai
	L2_5 = L2_5.machines
	L2_5 = L2_5.walker
	L2_5 = L2_5.WEAPONS_RANGE_RAIL
	A1_4.WEAPONS_RANGE = L2_5
end
