require("ai/machines/MachineAiData")
SpiderAiData = SpiderAiData or class(MachineAiData)
function SpiderAiData.init(A0_0)
	MachineAiData.init(A0_0)
	A0_0:_setup_brain_data()
	A0_0.UNIT_EYES = {
		PATROL = {
			{
				name = "a_eye",
				half_fov = 6,
				half_zfov = tweak_data.enemy.spider.SCAN_Z_FOV / 2,
				range = tweak_data.enemy.spider.SCAN_RANGE
			},
			{
				name = "a_eye",
				half_fov = 180,
				half_zfov = 60,
				range = 500
			}
		},
		STANDARD = {
			{
				name = "a_eye",
				half_fov = 90,
				half_zfov = 60,
				range = 10000
			},
			{
				name = "a_eye",
				half_fov = 180,
				half_zfov = 60,
				range = 500
			}
		}
	}
	A0_0.UNIT_WEAPONS = {
		{
			name = "gun_left",
			id = "left",
			enabled = true
		},
		{
			name = "gun_right",
			id = "right",
			enabled = true
		}
	}
	A0_0.SPEEDS = {normal = 1}
	A0_0.threat_constants = {
		DAMAGE_DECLINATION_FACTOR = 0.05,
		LOS_DECLINATION_FACTOR = 2,
		LOF_DECLINATION_FACTOR = 0.5,
		primary_weights = {
			HAS_LOS_FACTOR = 1,
			NO_LOS_FACTOR = 0.6,
			HAS_LOF_FACTOR = 1,
			NO_LOF_FACTOR = 0.6,
			MIN_AGGRESSION_FACTOR = 0.1,
			MAX_AGGRESSION_FACTOR = 0.8,
			MIN_DAMAGE_FACTOR = 0.1,
			MAX_DAMAGE_FACTOR = 1,
			DAMAGE_SCALE = 40,
			PROXIMITY_OVERRIDE_RANGE = 700,
			HUMAN_PLAYER_FACTOR = 1,
			NON_HUMAN_PLAYER_FACTOR = 0.7,
			IN_COVER_FACTOR = 0.1,
			OUT_OF_COVER_FACTOR = 1,
			SAME_TARGET_FACTOR = 1,
			CHANGE_TARGET_FACTOR = 0.95
		},
		secondary_weights = {
			HAS_LOS_FACTOR = 1,
			NO_LOS_FACTOR = 0.1,
			HAS_LOF_FACTOR = 1,
			NO_LOF_FACTOR = 0.1,
			MIN_AGGRESSION_FACTOR = 0.01,
			MAX_AGGRESSION_FACTOR = 0.2,
			MIN_DAMAGE_FACTOR = 0.01,
			MAX_DAMAGE_FACTOR = 1,
			DAMAGE_SCALE = 2,
			PROXIMITY_OVERRIDE_RANGE = 700,
			FIRING_ARC_ORIENTATION_OBJECT = "a_eye",
			FIRING_ARC_INFO = {
				{
					CENTER_ANGLE = 0,
					HALF_FOV = 40,
					HALF_ZFOV = 60
				}
			},
			SAME_TARGET_FACTOR = 1,
			CHANGE_TARGET_FACTOR = 0.8
		}
	}
	A0_0.NUMBER_OF_SECONDARY_TARGETS = 1
	A0_0.LINE_OF_FIRE_SLOT_MASK = "enemy_line_of_fire_blockers"
	A0_0.FRIENDLY_UNITS_SLOT_MASK = "machines"
	A0_0.WEAPONS_RANGE = tweak_data.ai.machines.spider.WEAPONS_RANGE
	A0_0.SOUND_LEVEL_HEARING_THRESHOLD = 0
	A0_0.TIME_TO_FORGET_THREATNING_UNIT = 40
	A0_0.TIME_TO_FORGET_UNIDENTIFIED_THREAT = 10
	A0_0.PATROL_MOVE_TIMERS = tweak_data.ai.machines.spider.PATROL_MOVE_TIMERS
	A0_0.AGGRESIVE_MOVE_TIMERS = tweak_data.ai.machines.spider.AGGRESIVE_MOVE_TIMERS
	A0_0.HIDE_TIMERS = tweak_data.ai.machines.spider.HIDE_TIMERS
	A0_0.ROTATE_TO_WAYPOINT_DIRECTION_START_DISTANCE = 300
end
function SpiderAiData._setup_brain_data(A0_1)
	local L1_2
	L1_2 = {}
	L1_2.normal = {
		name = "spider_brain",
		group = "normal",
		auto_started_threads = {
			"spider_threat_tracking",
			"spider_targeting",
			"spider_sensory",
			"spider_behavior",
			"spider_movement",
			"spider_combat"
		},
		lod_managed_threads = {},
		lod_distance = 0,
		init_functions = {
			SpiderAiThreatTracking.init_data,
			CommonAiTargeting.init_data,
			CommonAiSensoryEventsHandler.init_data,
			CommonAiBehavior.init_data,
			CommonAiCombat.init_data,
			CommonAiMovement.init_data
		},
		forced_targeting_threads = {
			"spider_threat_tracking",
			"spider_targeting",
			"spider_combat"
		}
	}
	L1_2.rail = {
		name = "spider_brain",
		group = "rail",
		auto_started_threads = {
			"spider_threat_tracking",
			"spider_targeting",
			"spider_sensory",
			"spider_behavior",
			"spider_movement",
			"spider_combat"
		},
		lod_managed_threads = {},
		lod_distance = 0,
		init_functions = {
			SpiderAiThreatTracking.init_data,
			CommonAiTargeting.init_data,
			CommonAiSensoryEventsHandler.init_data,
			CommonAiBehavior.init_data,
			CommonAiCombat.init_data,
			CommonAiMovement.init_data,
			MachineAiData.set_rail_target_slot,
			SpiderAiData.set_weapon_range_to_rail
		}
	}
	A0_1.brain_infos = L1_2
	L1_2 = "surface_spider"
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
function SpiderAiData.clear_output(A0_3)
	MachineAiData.clear_output(A0_3)
	A0_3.output.urgent = false
	A0_3.output.attack_mode = false
	A0_3.output.allowed_to_fire = false
	A0_3.output.firing_target = nil
	A0_3.output.investigate_mode = false
	A0_3.output.firing_target_position = nil
	A0_3.output.threat_arc_min = nil
	A0_3.output.threat_arc_max = nil
end
function SpiderAiData.set_weapon_range_to_rail(A0_4, A1_5)
	local L2_6
	L2_6 = tweak_data
	L2_6 = L2_6.ai
	L2_6 = L2_6.machines
	L2_6 = L2_6.spider
	L2_6 = L2_6.WEAPONS_RANGE_RAIL
	A1_5.WEAPONS_RANGE = L2_6
end
