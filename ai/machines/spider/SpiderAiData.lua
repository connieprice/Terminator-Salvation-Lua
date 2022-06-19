require("ai/machines/MachineAiData")
if not SpiderAiData then
	SpiderAiData = class(MachineAiData)
end
SpiderAiData.init = function(l_1_0)
	MachineAiData.init(l_1_0)
	l_1_0:_setup_brain_data()
	local l_1_1 = {}
	local l_1_2 = {}
	l_1_2.name = "a_eye"
	l_1_2.half_fov = 90
	l_1_2.half_zfov = 60
	l_1_2.range = 10000
	local l_1_3 = {}
	l_1_3.name = "a_eye"
	l_1_3.half_fov = 180
	l_1_3.half_zfov = 60
	l_1_3.range = 500
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_1_4 = {}
	l_1_4.name = "a_eye"
	l_1_4.half_fov = 180
	l_1_4.half_zfov = 60
	l_1_4.range = 500
	l_1_3 = {name = "a_eye", half_fov = 6, half_zfov = tweak_data.enemy.spider.SCAN_Z_FOV / 2, range = tweak_data.enemy.spider.SCAN_RANGE}
	l_1_2 = {l_1_3, l_1_4}
	l_1_0.UNIT_EYES, l_1_3 = l_1_3, {PATROL = l_1_2, STANDARD = l_1_1}
	local l_1_5 = {}
	l_1_5.name = "gun_right"
	l_1_5.id = "right"
	l_1_5.enabled = true
	l_1_4 = {name = "gun_left", id = "left", enabled = true}
	l_1_0.UNIT_WEAPONS, l_1_3 = l_1_3, {l_1_4, l_1_5}
	l_1_0.SPEEDS, l_1_3 = l_1_3, {normal = 1}
	l_1_4 = {HAS_LOS_FACTOR = 1, NO_LOS_FACTOR = 0.6, HAS_LOF_FACTOR = 1, NO_LOF_FACTOR = 0.6, MIN_AGGRESSION_FACTOR = 0.1, MAX_AGGRESSION_FACTOR = 0.8, MIN_DAMAGE_FACTOR = 0.1, MAX_DAMAGE_FACTOR = 1, DAMAGE_SCALE = 40, PROXIMITY_OVERRIDE_RANGE = 700, HUMAN_PLAYER_FACTOR = 1, NON_HUMAN_PLAYER_FACTOR = 0.7, IN_COVER_FACTOR = 0.1, OUT_OF_COVER_FACTOR = 1, SAME_TARGET_FACTOR = 1, CHANGE_TARGET_FACTOR = 0.95}
	local l_1_6 = {}
	l_1_6.CENTER_ANGLE = 0
	l_1_6.HALF_FOV = 40
	l_1_6.HALF_ZFOV = 60
	l_1_5 = {l_1_6}
	l_1_4 = {HAS_LOS_FACTOR = 1, NO_LOS_FACTOR = 0.1, HAS_LOF_FACTOR = 1, NO_LOF_FACTOR = 0.1, MIN_AGGRESSION_FACTOR = 0.01, MAX_AGGRESSION_FACTOR = 0.2, MIN_DAMAGE_FACTOR = 0.01, MAX_DAMAGE_FACTOR = 1, DAMAGE_SCALE = 2, PROXIMITY_OVERRIDE_RANGE = 700, FIRING_ARC_ORIENTATION_OBJECT = "a_eye", FIRING_ARC_INFO = l_1_5, SAME_TARGET_FACTOR = 1, CHANGE_TARGET_FACTOR = 0.8}
	l_1_0.threat_constants, l_1_3 = l_1_3, {DAMAGE_DECLINATION_FACTOR = 0.05, LOS_DECLINATION_FACTOR = 2, LOF_DECLINATION_FACTOR = 0.5, primary_weights = l_1_4, secondary_weights = l_1_4}
	l_1_0.NUMBER_OF_SECONDARY_TARGETS = 1
	l_1_0.LINE_OF_FIRE_SLOT_MASK = "enemy_line_of_fire_blockers"
	l_1_0.FRIENDLY_UNITS_SLOT_MASK = "machines"
	l_1_3 = tweak_data
	l_1_3 = l_1_3.ai
	l_1_3 = l_1_3.machines
	l_1_3 = l_1_3.spider
	l_1_3 = l_1_3.WEAPONS_RANGE
	l_1_0.WEAPONS_RANGE = l_1_3
	l_1_0.SOUND_LEVEL_HEARING_THRESHOLD = 0
	l_1_0.TIME_TO_FORGET_THREATNING_UNIT = 40
	l_1_0.TIME_TO_FORGET_UNIDENTIFIED_THREAT = 10
	l_1_3 = tweak_data
	l_1_3 = l_1_3.ai
	l_1_3 = l_1_3.machines
	l_1_3 = l_1_3.spider
	l_1_3 = l_1_3.PATROL_MOVE_TIMERS
	l_1_0.PATROL_MOVE_TIMERS = l_1_3
	l_1_3 = tweak_data
	l_1_3 = l_1_3.ai
	l_1_3 = l_1_3.machines
	l_1_3 = l_1_3.spider
	l_1_3 = l_1_3.AGGRESIVE_MOVE_TIMERS
	l_1_0.AGGRESIVE_MOVE_TIMERS = l_1_3
	l_1_3 = tweak_data
	l_1_3 = l_1_3.ai
	l_1_3 = l_1_3.machines
	l_1_3 = l_1_3.spider
	l_1_3 = l_1_3.HIDE_TIMERS
	l_1_0.HIDE_TIMERS = l_1_3
	l_1_0.ROTATE_TO_WAYPOINT_DIRECTION_START_DISTANCE = 300
end

SpiderAiData._setup_brain_data = function(l_2_0)
	local l_2_1 = {}
	local l_2_2 = {}
	l_2_2.name = "spider_brain"
	l_2_2.group = "normal"
	local l_2_3 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_2.init_functions, l_2_3 = l_2_3, {"spider_threat_tracking".init_data, "spider_targeting".init_data, "spider_sensory".init_data, "spider_behavior".init_data, "spider_movement".init_data, "spider_combat".init_data}
	l_2_2.forced_targeting_threads, l_2_3 = l_2_3, {"spider_threat_tracking", "spider_targeting", "spider_combat"}
	l_2_1.normal = l_2_2
	l_2_3 = {"spider_threat_tracking", "spider_targeting", "spider_sensory", "spider_behavior", "spider_movement", "spider_combat"}
	l_2_3 = {}
	l_2_3 = {SpiderAiThreatTracking.init_data, CommonAiTargeting.init_data, CommonAiSensoryEventsHandler.init_data, CommonAiBehavior.init_data, CommonAiCombat.init_data, CommonAiMovement.init_data, MachineAiData.set_rail_target_slot, SpiderAiData.set_weapon_range_to_rail}
	l_2_1.rail, l_2_2 = l_2_2, {name = "spider_brain", group = "rail", auto_started_threads = l_2_3, lod_managed_threads = l_2_3, lod_distance = 0, init_functions = l_2_3}
	l_2_0.brain_infos = l_2_1
	l_2_1 = "surface_spider"
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

SpiderAiData.clear_output = function(l_3_0)
	MachineAiData.clear_output(l_3_0)
	l_3_0.output.urgent = false
	l_3_0.output.attack_mode = false
	l_3_0.output.allowed_to_fire = false
	l_3_0.output.firing_target = nil
	l_3_0.output.investigate_mode = false
	l_3_0.output.firing_target_position = nil
	l_3_0.output.threat_arc_min = nil
	l_3_0.output.threat_arc_max = nil
end

SpiderAiData.set_weapon_range_to_rail = function(l_4_0, l_4_1)
	l_4_1.WEAPONS_RANGE = tweak_data.ai.machines.spider.WEAPONS_RANGE_RAIL
end


