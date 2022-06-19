if not LocalUserActivityTracker then
	LocalUserActivityTracker = class()
end
LocalUserActivityTracker.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._local_user_activity_query = l_1_1
	l_1_0._user_index = l_1_2
end

LocalUserActivityTracker.update = function(l_2_0, l_2_1, l_2_2)
	local l_2_3 = l_2_0:_activity()
	if l_2_3 == "in_game" then
		local l_2_4 = l_2_0:_game_mode()
		if l_2_4 ~= l_2_0._current_game_mode then
			l_2_0._current_game_mode = l_2_4
			l_2_0:_game_mode_changed(l_2_4)
		end
		local l_2_5 = (l_2_0:_world_info())
		local l_2_6 = nil
		if l_2_5 then
			l_2_6 = l_2_5.id
		end
	if l_2_6 ~= l_2_0._current_world then
		end
		l_2_0._current_world = l_2_6
		l_2_0:_world_changed(l_2_5)
	end
	if l_2_3 ~= l_2_0._current_activity then
		l_2_0._current_activity = l_2_3
		l_2_0:_activity_changed(l_2_3)
	end
end

LocalUserActivityTracker._activity = function(l_3_0)
	if l_3_0._local_user_activity_query:has_assigned_unit() then
		return "in_game"
	else
		if l_3_0._local_user_activity_query:is_menu_bound() then
			return "menu"
		end
	else
		return "idle"
	end
end

LocalUserActivityTracker._game_mode = function(l_4_0)
	if managers.player_slot:number_of_occupied_slots() > 1 then
		return "co_op"
	else
		return "single_player"
	end
end

LocalUserActivityTracker._world_info = function(l_5_0)
	local l_5_1 = managers.game:level_name()
	if not l_5_1 then
		return nil
	end
	local l_5_2 = managers.world_info:info_from_name(l_5_1)
	if not l_5_2 then
		return nil
	end
	return l_5_2
end


