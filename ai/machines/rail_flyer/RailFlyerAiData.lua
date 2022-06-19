if not RailFlyerAiData then
	RailFlyerAiData = class(MachineAiData)
end
RailFlyerAiData.init = function(l_1_0)
	MachineAiData.init(l_1_0)
	local l_1_1 = {}
	local l_1_2 = {}
	l_1_2.name = "rp_flyer"
	l_1_2.half_fov = tweak_data.ai.machines.flyer.HALF_FOV
	l_1_2.half_zfov = tweak_data.ai.machines.flyer.HALF_ZFOV
	l_1_2.range = 10000
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	l_1_0.UNIT_EYES = l_1_1
	l_1_2 = {name = "rp_flyer", id = "", enabled = true}
	l_1_0.UNIT_WEAPONS, l_1_1 = l_1_1, {l_1_2}
	l_1_0.LINE_OF_FIRE_SLOT_MASK = "enemy_line_of_fire_blockers"
	l_1_0.FRIENDLY_UNITS_SLOT_MASK = "machines"
	l_1_0.WEAPONS_RANGE = 1500
	l_1_0.SOUND_LEVEL_HEARING_THRESHOLD = 0
	l_1_0.TIME_TO_FORGET = 30
	l_1_0.stay_on_ground = false
	l_1_0.allowed_to_move_and_shoot = true
	l_1_0.arrived_radius = 100
	l_1_0.disc_arrived_radius = 400
	l_1_1, l_1_2 = l_1_0:_setup_brain_data, l_1_0
	l_1_1(l_1_2)
end

RailFlyerAiData._setup_brain_data = function(l_2_0)
	l_2_0.brain_name = "rail_flyer_brain"
	l_2_0.brain_group = "all"
	l_2_0.lod_distance = tweak_data.ai.machines.flyer.LOD_DISTANCE
	l_2_0.lod_managed_threads = {}
	local l_2_1 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	assert(l_2_0.graph, "AI graph " .. "rail_flyer_combat" .. " not found!")
	CommonAiThreatTracking:init_data(l_2_0)
	CommonAiSensoryEventsHandler:init_data(l_2_0)
	RailFlyerAiMove:init_data(l_2_0)
	RailFlyerAiCombat:init_data(l_2_0)
	l_2_0.default_speed = 1
	l_2_0.output.move_speed = 1
	l_2_0.output.allowed_to_fire = false
	l_2_0.output.firing_target = nil
	l_2_0.output.investigate_mode = false
	l_2_0.output.firing_target_position = nil
end

RailFlyerAiData.clear_output = function(l_3_0)
	MachineAiData.clear_output(l_3_0)
	l_3_0.output.move_speed = 1
	l_3_0.output.allowed_to_fire = false
	l_3_0.output.firing_target = nil
	l_3_0.output.investigate_mode = false
	l_3_0.output.firing_target_position = nil
end


