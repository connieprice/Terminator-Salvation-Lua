FlyerAiData = FlyerAiData or class(MachineAiData)
function FlyerAiData.init(A0_0)
	MachineAiData.init(A0_0)
	A0_0.UNIT_EYES = {
		PATROL = {
			{
				name = "e_fire_l",
				forward_axis = "z",
				half_fov = 65,
				half_zfov = 65,
				range = 4500
			}
		},
		STANDARD = {
			{
				name = "e_fire_l",
				forward_axis = "z",
				half_zfov = 100,
				half_fov = 100,
				range = 4500
			}
		}
	}
	A0_0.current_unit_eyes = A0_0.UNIT_EYES.STANDARD
	A0_0.UNIT_WEAPONS = {
		{
			name = "rp_flyer",
			id = "",
			enabled = true
		}
	}
	A0_0.threat_constants = {
		DAMAGE_DECLINATION_FACTOR = 0.01,
		LOS_DECLINATION_FACTOR = 1,
		LOF_DECLINATION_FACTOR = 1,
		primary_weights = {
			HAS_LOS_FACTOR = 1,
			NO_LOS_FACTOR = 0.2,
			HAS_LOF_FACTOR = 1,
			NO_LOF_FACTOR = 0.4,
			MIN_AGGRESSION_FACTOR = 0.01,
			MAX_AGGRESSION_FACTOR = 0.6,
			MIN_DAMAGE_FACTOR = 0.01,
			MAX_DAMAGE_FACTOR = 1,
			DAMAGE_SCALE = 2.5,
			PROXIMITY_OVERRIDE_RANGE = 700,
			HUMAN_PLAYER_FACTOR = 1,
			NON_HUMAN_PLAYER_FACTOR = 0.7,
			IN_COVER_FACTOR = 0.5,
			OUT_OF_COVER_FACTOR = 1,
			SAME_TARGET_FACTOR = 1,
			CHANGE_TARGET_FACTOR = 0.6
		}
	}
	A0_0.LINE_OF_FIRE_SLOT_MASK = "enemy_line_of_fire_blockers"
	A0_0.FRIENDLY_UNITS_SLOT_MASK = "machines"
	A0_0.WEAPONS_RANGE = tweak_data.ai.machines.flyer.WEAPONS_RANGE
	A0_0.SOUND_LEVEL_HEARING_THRESHOLD = 0
	A0_0.TIME_TO_FORGET_THREATNING_UNIT = 20
	A0_0.TIME_TO_FORGET_UNIDENTIFIED_THREAT = 7
	A0_0.PATROL_MOVE_TIMERS = tweak_data.ai.machines.flyer.PATROL_MOVE_TIMERS
	A0_0.AGGRESIVE_MOVE_TIMERS = tweak_data.ai.machines.flyer.AGGRESIVE_MOVE_TIMERS
	A0_0.HIDE_TIMERS = tweak_data.ai.machines.flyer.HIDE_TIMERS
	A0_0.radius = 60
	A0_0.default_movement_height = tweak_data.ai.machines.flyer.DEFAULT_HEIGHT
	A0_0.stay_on_ground = false
	A0_0.arrived_radius = 100
	A0_0.disc_arrived_radius = 400
	A0_0.allowed_to_strafe = false
	A0_0.no_max_fire_velocity = false
	A0_0:_setup_brain_data()
	A0_0.ROTATE_TO_WAYPOINT_DIRECTION_START_DISTANCE = 300
	A0_0.STUCK_VELOCITY = 10
	A0_0.STUCK_SELF_DESTROY_TIME = 5
	A0_0.STUCK_RADIUS = 200
end
function FlyerAiData._setup_brain_data(A0_1)
	local L1_2
	L1_2 = {}
	L1_2.normal = {
		name = "flyer_brain",
		group = "normal",
		auto_started_threads = {
			"flyer_threat_tracking",
			"flyer_targeting",
			"flyer_sensory",
			"flyer_behavior",
			"flyer_movement",
			"flyer_combat",
			"flyer_self_destroy"
		},
		lod_managed_threads = {},
		lod_distance = 0,
		init_functions = {
			CommonAiThreatTracking.init_data,
			CommonAiTargeting.init_data,
			CommonAiSensoryEventsHandler.init_data,
			CommonAiBehavior.init_data,
			CommonAiMovement.init_data,
			CommonAiCombat.init_data,
			CommonAiSelfDestroy.init_data
		}
	}
	L1_2.rail = {
		name = "rail_flyer_brain",
		group = "rail",
		auto_started_threads = {
			"flyer_threat_tracking",
			"flyer_sensory",
			"rail_flyer_move",
			"rail_flyer_combat"
		},
		lod_managed_threads = {},
		lod_distance = 0,
		init_functions = {
			CommonAiThreatTracking.init_data,
			CommonAiSensoryEventsHandler.init_data,
			RailFlyerAiMove.init_data,
			RailFlyerAiCombat.init_data
		}
	}
	A0_1.brain_infos = L1_2
	L1_2 = "air_flyer"
	A0_1.graph = Search:nav(L1_2)
	assert(A0_1.graph, "AI graph " .. L1_2 .. " not found!")
	A0_1.default_speed = 1
	A0_1.output.move_speed = 1
	A0_1.output.allowed_to_fire = false
	A0_1.output.firing_target = nil
	A0_1.output.investigate_mode = false
	A0_1.output.firing_target_position = nil
end
function FlyerAiData.clear_output(A0_3)
	MachineAiData.clear_output(A0_3)
	A0_3.output.move_speed = 1
	A0_3.output.allowed_to_fire = false
	A0_3.output.firing_target = nil
	A0_3.output.investigate_mode = false
	A0_3.output.firing_target_position = nil
end
