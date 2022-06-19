ActionLevelDirector = ActionLevelDirector or class()
function ActionLevelDirector.init(A0_0)
	local L1_1
	L1_1 = {}
	A0_0._units = L1_1
	L1_1 = tweak_data
	L1_1 = L1_1.directors
	L1_1 = L1_1.music_director
	L1_1 = L1_1.PLAYER_THREATENED_MEMORY_TIME
	L1_1 = -L1_1
	A0_0._last_time_local_player_threatened = L1_1
end
function ActionLevelDirector.add_ai_unit(A0_2, A1_3)
	A0_2._units[A1_3] = A1_3
end
function ActionLevelDirector.remove_ai_unit(A0_4, A1_5)
	A0_4._units[A1_5] = nil
end
function ActionLevelDirector.update(A0_6, A1_7, A2_8)
	local L3_9, L4_10, L5_11, L6_12, L7_13, L8_14
	L3_9 = false
	L4_10 = false
	L5_11, L6_12, L7_13 = nil, nil, nil
	for 