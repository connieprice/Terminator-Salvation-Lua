require("ai/humans/squadmember/SquadMemberAiData")
AiPlayerAiData = AiPlayerAiData or class(SquadMemberAiData)
function AiPlayerAiData.init(A0_0)
	SquadMemberAiData.init(A0_0)
	A0_0.UNIT_EYES = {
		STANDARD = {
			{
				name = "eyelids_dummy",
				forward_axis = "z",
				half_fov = tweak_data.ai.humans.ai_player.HALF_FOV,
				half_zfov = tweak_data.ai.humans.ai_player.HALF_ZFOV,
				range = 10000
			}
		},
		COMBAT = {
			{
				name = "eyelids_dummy",
				forward_axis = "z",
				half_fov = tweak_data.ai.humans.ai_player.HALF_FOV,
				half_zfov = tweak_data.ai.humans.ai_player.HALF_ZFOV,
				range = 10000
			}
		}
	}
	A0_0.current_unit_eyes = A0_0.UNIT_EYES.STANDARD
	A0_0.UNIT_WEAPONS = {
		{
			name = "a_weapon_left_front",
			id = "",
			enabled = true
		}
	}
	A0_0.SPEEDS = {walk = 0.5, run = 1}
	A0_0.LINE_OF_FIRE_SLOT_MASK = "player_line_of_fire_blockers"
	A0_0.FRIENDLY_UNITS_SLOT_MASK = "players"
	A0_0.WEAPONS_RANGE = 2500
	A0_0.SOUND_LEVEL_HEARING_THRESHOLD = 0
	A0_0.TIME_TO_FORGET_THREATNING_UNIT = 300
	A0_0.TIME_TO_FORGET_UNIDENTIFIED_THREAT = 10
	A0_0.ROTATE_TO_WAYPOINT_DIRECTION_START_DISTANCE = 600
	A0_0.arrived_radius = 50
	A0_0.radius = 69
	A0_0.input.exiting_wounded = false
	A0_0.AGGRESIVE_MOVE_TIMERS = {10, 20}
end
