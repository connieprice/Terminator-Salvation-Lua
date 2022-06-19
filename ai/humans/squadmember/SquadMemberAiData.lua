require("ai/machines/MachineAiData")
SquadMemberAiData = SquadMemberAiData or class(AiData)
function SquadMemberAiData.init(A0_0)
	AiData.init(A0_0)
	A0_0:_setup_brain_data()
	A0_0.EVENT_SOURCE_TYPES = {
		managers.sensory_events.source_types.MACHINE_WEAPON_ID,
		managers.sensory_events.source_types.MACHINE_ID,
		managers.sensory_events.source_types.GENERIC_WEAPON_ID
	}
	A0_0.THREATENING_EVENT_SOURCE_TYPES = {}
	A0_0.THREATENING_EVENT_SOURCE_TYPES[managers.sensory_events.source_types.MACHINE_WEAPON_ID] = true
	A0_0.THREATENING_EVENT_SOURCE_TYPES[managers.sensory_events.source_types.MACHINE_ID] = true
	A0_0.default_enemy_slot_mask = "machines"
	A0_0.use_covers = true
end
function SquadMemberAiData._setup_brain_data(A0_1)
	local L1_2
	L1_2 = {}
	L1_2.normal = {
		name = "squad_member_brain",
		group = "normal",
		auto_started_threads = {
			"squad_member_sensory",
			"squad_member_threat_tracking",
			"squad_member_targeting",
			"squad_member_find_cover",
			"squad_member_behavior",
			"squad_member_movement",
			"squad_member_combat"
		},
		lod_managed_threads = {},
		lod_distance = 0,
		init_functions = {
			CommonAiThreatTracking.init_data,
			CommonAiTargeting.init_data,
			CommonAiSensoryEventsHandler.init_data,
			CommonAiFindCover.init_data,
			CommonAiBehavior.init_data,
			CommonAiMovement.init_data,
			CommonAiCombat.init_data
		},
		forced_targeting_threads = {
			"squad_member_threat_tracking",
			"squad_member_targeting",
			"squad_member_combat"
		}
	}
	L1_2.rail = {
		name = "squad_member_brain",
		group = "rail",
		auto_started_threads = {
			"squad_member_sensory",
			"squad_member_threat_tracking",
			"squad_member_targeting",
			"squad_member_find_cover",
			"squad_member_behavior",
			"squad_member_movement",
			"squad_member_combat"
		},
		lod_managed_threads = {},
		lod_distance = 0,
		init_functions = {
			CommonAiThreatTracking.init_data,
			CommonAiTargeting.init_data,
			CommonAiSensoryEventsHandler.init_data,
			CommonAiFindCover.init_data,
			CommonAiBehavior.init_data,
			CommonAiMovement.init_data,
			CommonAiCombat.init_data,
			AiData.set_weapon_range_to_rail,
			AiData.set_default_enemy_slot_mask_to_enemies
		}
	}
	A0_1.brain_infos = L1_2
	L1_2 = {}
	L1_2.DAMAGE_DECLINATION_FACTOR = 0.05
	L1_2.LOS_DECLINATION_FACTOR = 0.5
	L1_2.LOF_DECLINATION_FACTOR = 0.5
	L1_2.primary_weights = {
		HAS_LOS_FACTOR = 1,
		NO_LOS_FACTOR = 0.5,
		HAS_LOF_FACTOR = 1,
		NO_LOF_FACTOR = 0.5,
		MIN_AGGRESSION_FACTOR = 0.01,
		MAX_AGGRESSION_FACTOR = 0.2,
		MIN_DAMAGE_FACTOR = 0.01,
		MAX_DAMAGE_FACTOR = 1,
		DAMAGE_SCALE = 2,
		PROXIMITY_OVERRIDE_RANGE = 500,
		SAME_TARGET_FACTOR = 1,
		CHANGE_TARGET_FACTOR = 0.5
	}
	A0_1.threat_constants = L1_2
	L1_2 = "surface_human"
	A0_1.graph = Search:nav(L1_2)
	assert(A0_1.graph, "AI graph " .. L1_2 .. " not found!")
	A0_1.input.in_target_cover = false
	A0_1.input.time_since_incoming_fire = 9999
	A0_1.input.time_under_incoming_fire = 0
	A0_1.output.allowed_to_fire = false
	A0_1.output.firing_target = nil
	A0_1.output.firing_target_position = nil
	A0_1.output.target_cover_info = nil
	A0_1.output.hide_in_cover = false
	A0_1.output.move_speed = 1
end
