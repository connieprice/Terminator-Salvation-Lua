if not FlyerAiData then
	FlyerAiData = class(MachineAiData)
end
FlyerAiData.init = function(l_1_0)
	MachineAiData.init(l_1_0)
	local l_1_1 = {}
	local l_1_2 = {}
	l_1_2.name = "e_fire_l"
	l_1_2.forward_axis = "z"
	l_1_2.half_zfov = 100
	l_1_2.half_fov = 100
	l_1_2.range = 4500
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_1_3 = {}
	l_1_3.name = "e_fire_l"
	l_1_3.forward_axis = "z"
	l_1_3.half_fov = 65
	l_1_3.half_zfov = 65
	l_1_3.range = 4500
	l_1_2 = {l_1_3}
	l_1_0.UNIT_EYES, l_1_3 = l_1_3, {PATROL = l_1_2, STANDARD = l_1_1}
	l_1_3 = l_1_0.UNIT_EYES
	l_1_3 = l_1_3.STANDARD
	l_1_0.current_unit_eyes = l_1_3
	local l_1_4 = {}
	l_1_4.name = "rp_flyer"
	l_1_4.id = ""
	l_1_4.enabled = true
	l_1_0.UNIT_WEAPONS, l_1_3 = l_1_3, {l_1_4}
	l_1_4 = {HAS_LOS_FACTOR = 1, NO_LOS_FACTOR = 0.2, HAS_LOF_FACTOR = 1, NO_LOF_FACTOR = 0.4, MIN_AGGRESSION_FACTOR = 0.01, MAX_AGGRESSION_FACTOR = 0.6, MIN_DAMAGE_FACTOR = 0.01, MAX_DAMAGE_FACTOR = 1, DAMAGE_SCALE = 2.5, PROXIMITY_OVERRIDE_RANGE = 700, HUMAN_PLAYER_FACTOR = 1, NON_HUMAN_PLAYER_FACTOR = 0.7, IN_COVER_FACTOR = 0.5, OUT_OF_COVER_FACTOR = 1, SAME_TARGET_FACTOR = 1, CHANGE_TARGET_FACTOR = 0.6}
	l_1_0.threat_constants, l_1_3 = l_1_3, {DAMAGE_DECLINATION_FACTOR = 0.01, LOS_DECLINATION_FACTOR = 1, LOF_DECLINATION_FACTOR = 1, primary_weights = l_1_4}
	l_1_0.LINE_OF_FIRE_SLOT_MASK = "enemy_line_of_fire_blockers"
	l_1_0.FRIENDLY_UNITS_SLOT_MASK = "machines"
	l_1_3 = tweak_data
	l_1_3 = l_1_3.ai
	l_1_3 = l_1_3.machines
	l_1_3 = l_1_3.flyer
	l_1_3 = l_1_3.WEAPONS_RANGE
	l_1_0.WEAPONS_RANGE = l_1_3
	l_1_0.SOUND_LEVEL_HEARING_THRESHOLD = 0
	l_1_0.TIME_TO_FORGET_THREATNING_UNIT = 20
	l_1_0.TIME_TO_FORGET_UNIDENTIFIED_THREAT = 7
	l_1_3 = tweak_data
	l_1_3 = l_1_3.ai
	l_1_3 = l_1_3.machines
	l_1_3 = l_1_3.flyer
	l_1_3 = l_1_3.PATROL_MOVE_TIMERS
	l_1_0.PATROL_MOVE_TIMERS = l_1_3
	l_1_3 = tweak_data
	l_1_3 = l_1_3.ai
	l_1_3 = l_1_3.machines
	l_1_3 = l_1_3.flyer
	l_1_3 = l_1_3.AGGRESIVE_MOVE_TIMERS
	l_1_0.AGGRESIVE_MOVE_TIMERS = l_1_3
	l_1_3 = tweak_data
	l_1_3 = l_1_3.ai
	l_1_3 = l_1_3.machines
	l_1_3 = l_1_3.flyer
	l_1_3 = l_1_3.HIDE_TIMERS
	l_1_0.HIDE_TIMERS = l_1_3
	l_1_0.radius = 60
	l_1_3 = tweak_data
	l_1_3 = l_1_3.ai
	l_1_3 = l_1_3.machines
	l_1_3 = l_1_3.flyer
	l_1_3 = l_1_3.DEFAULT_HEIGHT
	l_1_0.default_movement_height = l_1_3
	l_1_0.stay_on_ground = false
	l_1_0.arrived_radius = 100
	l_1_0.disc_arrived_radius = 400
	l_1_0.allowed_to_strafe = false
	l_1_0.no_max_fire_velocity = false
	l_1_3, l_1_4 = l_1_0:_setup_brain_data, l_1_0
	l_1_3(l_1_4)
	l_1_0.ROTATE_TO_WAYPOINT_DIRECTION_START_DISTANCE = 300
	l_1_0.STUCK_VELOCITY = 10
	l_1_0.STUCK_SELF_DESTROY_TIME = 5
	l_1_0.STUCK_RADIUS = 200
end

FlyerAiData._setup_brain_data = function(l_2_0)
	local l_2_1 = {}
	local l_2_2 = {}
	l_2_2.name = "flyer_brain"
	l_2_2.group = "normal"
	local l_2_3 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_2.init_functions, l_2_3 = l_2_3, {"flyer_threat_tracking".init_data, "flyer_targeting".init_data, "flyer_sensory".init_data, "flyer_behavior".init_data, "flyer_movement".init_data, "flyer_combat".init_data, "flyer_self_destroy".init_data}
	l_2_1.normal = l_2_2
	l_2_3 = {"flyer_threat_tracking", "flyer_sensory", "rail_flyer_move", "rail_flyer_combat"}
	l_2_3 = {}
	l_2_3 = {CommonAiThreatTracking.init_data, CommonAiSensoryEventsHandler.init_data, RailFlyerAiMove.init_data, RailFlyerAiCombat.init_data}
	l_2_1.rail, l_2_2 = l_2_2, {name = "rail_flyer_brain", group = "rail", auto_started_threads = l_2_3, lod_managed_threads = l_2_3, lod_distance = 0, init_functions = l_2_3}
	l_2_0.brain_infos = l_2_1
	l_2_1 = "air_flyer"
	l_2_2 = Search
	l_2_2, l_2_3 = l_2_2:nav, l_2_2
	l_2_2 = l_2_2(l_2_3, l_2_1)
	l_2_0.graph = l_2_2
	l_2_2 = assert
	l_2_3 = l_2_0.graph
	l_2_2(l_2_3, "AI graph " .. l_2_1 .. " not found!")
	l_2_0.default_speed = 1
	l_2_2 = l_2_0.output
	l_2_2.move_speed = 1
	l_2_2 = l_2_0.output
	l_2_2.allowed_to_fire = false
	l_2_2 = l_2_0.output
	l_2_2.firing_target = nil
	l_2_2 = l_2_0.output
	l_2_2.investigate_mode = false
	l_2_2 = l_2_0.output
	l_2_2.firing_target_position = nil
end

FlyerAiData.clear_output = function(l_3_0)
	MachineAiData.clear_output(l_3_0)
	l_3_0.output.move_speed = 1
	l_3_0.output.allowed_to_fire = false
	l_3_0.output.firing_target = nil
	l_3_0.output.investigate_mode = false
	l_3_0.output.firing_target_position = nil
end


