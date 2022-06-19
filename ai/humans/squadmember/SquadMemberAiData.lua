require("ai/machines/MachineAiData")
if not SquadMemberAiData then
	SquadMemberAiData = class(AiData)
end
SquadMemberAiData.init = function(l_1_0)
	AiData.init(l_1_0)
	l_1_0:_setup_brain_data()
	do
		local l_1_1 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

	end
	 -- WARNING: undefined locals caused missing assignments!
end

SquadMemberAiData._setup_brain_data = function(l_2_0)
	local l_2_1 = {}
	local l_2_2 = {}
	l_2_2.name = "squad_member_brain"
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

	l_2_2.init_functions, l_2_3 = l_2_3, {"squad_member_sensory".init_data, "squad_member_threat_tracking".init_data, "squad_member_targeting".init_data, "squad_member_find_cover".init_data, "squad_member_behavior".init_data, "squad_member_movement".init_data, "squad_member_combat".init_data}
	l_2_2.forced_targeting_threads, l_2_3 = l_2_3, {"squad_member_threat_tracking", "squad_member_targeting", "squad_member_combat"}
	l_2_1.normal = l_2_2
	l_2_3 = {"squad_member_sensory", "squad_member_threat_tracking", "squad_member_targeting", "squad_member_find_cover", "squad_member_behavior", "squad_member_movement", "squad_member_combat"}
	l_2_3 = {}
	l_2_3 = {CommonAiThreatTracking.init_data, CommonAiTargeting.init_data, CommonAiSensoryEventsHandler.init_data, CommonAiFindCover.init_data, CommonAiBehavior.init_data, CommonAiMovement.init_data, CommonAiCombat.init_data, AiData.set_weapon_range_to_rail, AiData.set_default_enemy_slot_mask_to_enemies}
	l_2_1.rail, l_2_2 = l_2_2, {name = "squad_member_brain", group = "rail", auto_started_threads = l_2_3, lod_managed_threads = l_2_3, lod_distance = 0, init_functions = l_2_3}
	l_2_0.brain_infos = l_2_1
	l_2_2 = {HAS_LOS_FACTOR = 1, NO_LOS_FACTOR = 0.5, HAS_LOF_FACTOR = 1, NO_LOF_FACTOR = 0.5, MIN_AGGRESSION_FACTOR = 0.01, MAX_AGGRESSION_FACTOR = 0.2, MIN_DAMAGE_FACTOR = 0.01, MAX_DAMAGE_FACTOR = 1, DAMAGE_SCALE = 2, PROXIMITY_OVERRIDE_RANGE = 500, SAME_TARGET_FACTOR = 1, CHANGE_TARGET_FACTOR = 0.5}
	l_2_0.threat_constants, l_2_1 = l_2_1, {DAMAGE_DECLINATION_FACTOR = 0.05, LOS_DECLINATION_FACTOR = 0.5, LOF_DECLINATION_FACTOR = 0.5, primary_weights = l_2_2}
	l_2_1 = "surface_human"
	l_2_2 = Search
	l_2_2, l_2_3 = l_2_2:nav, l_2_2
	l_2_2 = l_2_2(l_2_3, l_2_1)
	l_2_0.graph = l_2_2
	l_2_2 = assert
	l_2_3 = l_2_0.graph
	l_2_2(l_2_3, "AI graph " .. l_2_1 .. " not found!")
	l_2_2 = l_2_0.input
	l_2_2.in_target_cover = false
	l_2_2 = l_2_0.input
	l_2_2.time_since_incoming_fire = 9999
	l_2_2 = l_2_0.input
	l_2_2.time_under_incoming_fire = 0
	l_2_2 = l_2_0.output
	l_2_2.allowed_to_fire = false
	l_2_2 = l_2_0.output
	l_2_2.firing_target = nil
	l_2_2 = l_2_0.output
	l_2_2.firing_target_position = nil
	l_2_2 = l_2_0.output
	l_2_2.target_cover_info = nil
	l_2_2 = l_2_0.output
	l_2_2.hide_in_cover = false
	l_2_2 = l_2_0.output
	l_2_2.move_speed = 1
end


