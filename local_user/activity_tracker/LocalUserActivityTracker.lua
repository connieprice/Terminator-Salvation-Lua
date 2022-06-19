LocalUserActivityTracker = LocalUserActivityTracker or class()
function LocalUserActivityTracker.init(A0_0, A1_1, A2_2)
	A0_0._local_user_activity_query = A1_1
	A0_0._user_index = A2_2
end
function LocalUserActivityTracker.update(A0_3, A1_4, A2_5)
	local L3_6, L4_7, L5_8
	L4_7 = A0_3
	L3_6 = A0_3._activity
	L3_6 = L3_6(L4_7)
	if L3_6 == "in_game" then
		L5_8 = A0_3
		L4_7 = A0_3._game_mode
		L4_7 = L4_7(L5_8)
		L5_8 = A0_3._current_game_mode
		if L4_7 ~= L5_8 then
			A0_3._current_game_mode = L4_7
			L5_8 = A0_3._game_mode_changed
			L5_8(A0_3, L4_7)
		end
		L5_8 = A0_3._world_info
		L5_8 = L5_8(A0_3)
		if L5_8 then
		end
		if L5_8.id ~= A0_3._current_world then
			A0_3._current_world = L5_8.id
			A0_3:_world_changed(L5_8)
		end
	end
	L4_7 = A0_3._current_activity
	if L3_6 ~= L4_7 then
		A0_3._current_activity = L3_6
		L5_8 = A0_3
		L4_7 = A0_3._activity_changed
		L4_7(L5_8, L3_6)
	end
end
function LocalUserActivityTracker._activity(A0_9)
	if A0_9._local_user_activity_query:has_assigned_unit() then
		return "in_game"
	elseif A0_9._local_user_activity_query:is_menu_bound() then
		return "menu"
	else
		return "idle"
	end
end
function LocalUserActivityTracker._game_mode(A0_10)
	if managers.player_slot:number_of_occupied_slots() > 1 then
		return "co_op"
	else
		return "single_player"
	end
end
function LocalUserActivityTracker._world_info(A0_11)
	local L1_12
	L1_12 = managers
	L1_12 = L1_12.game
	L1_12 = L1_12.level_name
	L1_12 = L1_12(L1_12)
	if not L1_12 then
		return nil
	end
	if not managers.world_info:info_from_name(L1_12) then
		return nil
	end
	return (managers.world_info:info_from_name(L1_12))
end
