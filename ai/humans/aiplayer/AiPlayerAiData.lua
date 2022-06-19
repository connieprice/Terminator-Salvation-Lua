require("ai/humans/squadmember/SquadMemberAiData")
if not AiPlayerAiData then
	AiPlayerAiData = class(SquadMemberAiData)
end
AiPlayerAiData.init = function(l_1_0)
	SquadMemberAiData.init(l_1_0)
	local l_1_1 = {}
	local l_1_2 = {}
	l_1_2.name = "eyelids_dummy"
	l_1_2.forward_axis = "z"
	l_1_2.half_fov = tweak_data.ai.humans.ai_player.HALF_FOV
	l_1_2.half_zfov = tweak_data.ai.humans.ai_player.HALF_ZFOV
	l_1_2.range = 10000
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	l_1_0.UNIT_EYES, l_1_2 = l_1_2, {STANDARD = l_1_1, COMBAT = l_1_1}
	l_1_2 = l_1_0.UNIT_EYES
	l_1_2 = l_1_2.STANDARD
	l_1_0.current_unit_eyes = l_1_2
	local l_1_3 = {}
	l_1_3.name = "a_weapon_left_front"
	l_1_3.id = ""
	l_1_3.enabled = true
	l_1_0.UNIT_WEAPONS, l_1_2 = l_1_2, {l_1_3}
	l_1_0.SPEEDS, l_1_2 = l_1_2, {walk = 0.5, run = 1}
	l_1_0.LINE_OF_FIRE_SLOT_MASK = "player_line_of_fire_blockers"
	l_1_0.FRIENDLY_UNITS_SLOT_MASK = "players"
	l_1_0.WEAPONS_RANGE = 2500
	l_1_0.SOUND_LEVEL_HEARING_THRESHOLD = 0
	l_1_0.TIME_TO_FORGET_THREATNING_UNIT = 300
	l_1_0.TIME_TO_FORGET_UNIDENTIFIED_THREAT = 10
	l_1_0.ROTATE_TO_WAYPOINT_DIRECTION_START_DISTANCE = 600
	l_1_0.arrived_radius = 50
	l_1_0.radius = 69
	l_1_2 = l_1_0.input
	l_1_2.exiting_wounded = false
	l_1_3 = 10
	l_1_0.AGGRESIVE_MOVE_TIMERS, l_1_2 = l_1_2, {l_1_3, 20}
end


