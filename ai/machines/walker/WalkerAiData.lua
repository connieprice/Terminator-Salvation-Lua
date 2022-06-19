require("ai/machines/MachineAiData")
if not WalkerAiData then
	WalkerAiData = class(MachineAiData)
end
WalkerAiData.init = function(l_1_0)
	MachineAiData.init(l_1_0)
	l_1_0:_setup_brain_data()
	local l_1_1 = {}
	local l_1_2 = {}
	l_1_2.name = "Head"
	l_1_2.forward_axis = "z"
	l_1_2.half_fov = tweak_data.ai.humans.ai_player.HALF_FOV
	l_1_2.half_zfov = tweak_data.ai.humans.ai_player.HALF_ZFOV
	l_1_2.range = 10000
	local l_1_3 = {}
	l_1_3.name = "Head"
	l_1_3.forward_axis = "z"
	l_1_3.half_fov = 180
	l_1_3.half_zfov = 60
	l_1_3.range = 500
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	l_1_0.UNIT_EYES, l_1_2 = l_1_2, {PATROL = l_1_1, STANDARD = l_1_1}
	l_1_2 = l_1_0.UNIT_EYES
	l_1_2 = l_1_2.STANDARD
	l_1_0.current_unit_eyes = l_1_2
	l_1_3 = {name = "RightHand", id = "", enabled = true}
	l_1_0.UNIT_WEAPONS, l_1_2 = l_1_2, {l_1_3}
	l_1_0.SPEEDS, l_1_2 = l_1_2, {walk = 1}
	l_1_2 = -45
	l_1_3 = 90
	local l_1_4 = (l_1_3 - l_1_2) / 2 + l_1_2
	local l_1_5 = (l_1_3 - l_1_2) / 2
	local l_1_6 = {}
	l_1_6.DAMAGE_DECLINATION_FACTOR = 0.05
	l_1_6.LOS_DECLINATION_FACTOR = 0.05
	l_1_6.LOF_DECLINATION_FACTOR = 0.05
	l_1_6.ENABLE_UNIT_CLUSTERING = true
	local l_1_7 = {}
	l_1_7.HAS_LOS_FACTOR = 1
	l_1_7.NO_LOS_FACTOR = 0.9
	l_1_7.HAS_LOF_FACTOR = 1
	l_1_7.NO_LOF_FACTOR = 0.9
	l_1_7.MIN_AGGRESSION_FACTOR = 0.5
	l_1_7.MAX_AGGRESSION_FACTOR = 0.8
	l_1_7.MIN_DAMAGE_FACTOR = 0.9
	l_1_7.MAX_DAMAGE_FACTOR = 1
	l_1_7.DAMAGE_SCALE = 5
	l_1_7.PROXIMITY_OVERRIDE_RANGE = 800
	l_1_7.UNIT_CLUSTERING_ALONE_FACTOR = 1
	l_1_7.UNIT_CLUSTERING_MAX_RADIUS_FACTOR = 0.2
	l_1_7.UNIT_CLUSTERING_MIN_RADIUS_FACTOR = 0.01
	l_1_7.HUMAN_PLAYER_FACTOR = 1
	l_1_7.NON_HUMAN_PLAYER_FACTOR = 0.9
	l_1_7.IN_COVER_FACTOR = 0.5
	l_1_7.OUT_OF_COVER_FACTOR = 1
	l_1_7.SAME_TARGET_FACTOR = 1
	l_1_7.CHANGE_TARGET_FACTOR = 0.5
	l_1_6.primary_weights = l_1_7
	local l_1_8 = {}
	local l_1_9 = {}
	l_1_9.CENTER_ANGLE = -l_1_4
	l_1_9.HALF_FOV = l_1_5
	l_1_9.HALF_ZFOV = 60
	local l_1_10 = {}
	l_1_10.CENTER_ANGLE = l_1_4
	l_1_10.HALF_FOV = l_1_5
	l_1_10.HALF_ZFOV = 60
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	l_1_6.secondary_weights, l_1_7 = l_1_7, {HAS_LOS_FACTOR = 1, NO_LOS_FACTOR = 0.1, HAS_LOF_FACTOR = 1, NO_LOF_FACTOR = 0.1, MIN_AGGRESSION_FACTOR = 0.01, MAX_AGGRESSION_FACTOR = 0.2, MIN_DAMAGE_FACTOR = 0.9, MAX_DAMAGE_FACTOR = 1, DAMAGE_SCALE = 2, PROXIMITY_OVERRIDE_RANGE = 700, UNIT_CLUSTERING_ALONE_FACTOR = 0.8, UNIT_CLUSTERING_MAX_RADIUS_FACTOR = 0.9, UNIT_CLUSTERING_MIN_RADIUS_FACTOR = 1, HUMAN_PLAYER_FACTOR = 1, NON_HUMAN_PLAYER_FACTOR = 0.75, IN_COVER_FACTOR = 0.3, OUT_OF_COVER_FACTOR = 1, FIRING_ARC_ORIENTATION_OBJECT = "LeftShoulder", FIRING_ARC_ORIENTATION_OBJECT_AXIS = "z", FIRING_ARC_INFO = l_1_8, SAME_TARGET_FACTOR = 1, CHANGE_TARGET_FACTOR = 0.95}
	l_1_0.threat_constants = l_1_6
	l_1_0.LINE_OF_FIRE_SLOT_MASK = "enemy_line_of_fire_blockers"
	l_1_0.FRIENDLY_UNITS_SLOT_MASK = "machines"
	l_1_0.WEAPONS_RANGE = 2500
	l_1_0.SOUND_LEVEL_HEARING_THRESHOLD = 0
	l_1_0.TIME_TO_FORGET_THREATNING_UNIT = 40
	l_1_0.TIME_TO_FORGET_UNIDENTIFIED_THREAT = 10
	l_1_6 = l_1_0.number_of_secondary_weapons
	if not l_1_6 then
		l_1_6 = 2
	end
	l_1_0.NUMBER_OF_SECONDARY_TARGETS = l_1_6
	l_1_7 = 0.1
	l_1_8 = 1
	l_1_0.AGGRESIVE_MOVE_TIMERS, l_1_6 = l_1_6, {l_1_7, l_1_8}
	l_1_0.hunt_and_hide = true
	l_1_0.arrived_radius = 100
end

WalkerAiData._setup_brain_data = function(l_2_0)
	local l_2_1 = {}
	local l_2_2 = {}
	l_2_2.name = "walker_brain"
	l_2_2.group = "normal"
	local l_2_3 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_2.init_functions, l_2_3 = l_2_3, {"walker_threat_tracking".init_data, "walker_targeting".init_data, "walker_sensory".init_data, "walker_behavior".init_data, "walker_movement".init_data, "walker_combat".init_data}
	l_2_2.forced_targeting_threads, l_2_3 = l_2_3, {"walker_threat_tracking", "walker_targeting", "walker_combat"}
	l_2_1.normal = l_2_2
	l_2_3 = {"walker_threat_tracking", "walker_targeting", "walker_sensory", "walker_behavior", "walker_movement", "walker_combat"}
	l_2_3 = {}
	l_2_3 = {CommonAiThreatTracking.init_data, CommonAiTargeting.init_data, CommonAiSensoryEventsHandler.init_data, WalkerAiBehavior.init_data, WalkerAiMovement.init_data, WalkerAiCombat.init_data, MachineAiData.set_rail_target_slot, WalkerAiData.set_weapon_range_to_rail}
	l_2_1.rail, l_2_2 = l_2_2, {name = "walker_brain", group = "rail", auto_started_threads = l_2_3, lod_managed_threads = l_2_3, lod_distance = 0, init_functions = l_2_3}
	l_2_0.brain_infos = l_2_1
	l_2_1 = "surface_human"
	l_2_2 = Search
	l_2_2, l_2_3 = l_2_2:nav, l_2_2
	l_2_2 = l_2_2(l_2_3, l_2_1)
	l_2_0.graph = l_2_2
	l_2_2 = assert
	l_2_3 = l_2_0.graph
	l_2_2(l_2_3, "AI graph " .. l_2_1 .. " not found!")
	l_2_2 = l_2_0.input
	l_2_2.is_firing = false
	l_2_2 = l_2_0.input
	l_2_2.is_charging = false
	l_2_2 = l_2_0.output
	l_2_2.urgent = false
	l_2_2 = l_2_0.output
	l_2_2.attack_mode = false
	l_2_2 = l_2_0.output
	l_2_2.allowed_to_fire = false
	l_2_2 = l_2_0.output
	l_2_2.firing_target = nil
	l_2_2 = l_2_0.output
	l_2_2.investigate_mode = false
	l_2_2 = l_2_0.output
	l_2_2.firing_target_position = nil
	l_2_2 = l_2_0.output
	l_2_2.threat_arc_min = nil
	l_2_2 = l_2_0.output
	l_2_2.threat_arc_max = nil
end

WalkerAiData.set_weapon_range_to_rail = function(l_3_0, l_3_1)
	l_3_1.WEAPONS_RANGE = tweak_data.ai.machines.walker.WEAPONS_RANGE_RAIL
end


