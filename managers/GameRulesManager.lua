require("shared/TableAlgorithms")
if not GameRulesManager then
	GameRulesManager = class()
end
GameRulesManager.init = function(l_1_0)
end

GameRulesManager.update = function(l_2_0, l_2_1)
	local l_2_2 = managers.player:human_players()
	l_2_0:_update_rules(l_2_2)
	l_2_0:check_all_human_players_down(l_2_2)
end

GameRulesManager.check_all_human_players_down = function(l_3_0, l_3_1)
	local l_3_5, l_3_6 = nil
	if TableAlgorithms.is_empty(l_3_1) then
		return 
	end
	for i_0,i_1 in pairs(l_3_1) do
		if not i_1:damage_data():is_fully_damaged() then
			return 
		end
	end
	managers.game_transition:game_over()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

GameRulesManager.set_team_mode = function(l_4_0, l_4_1)
	l_4_0._is_team_mode = l_4_1
end

GameRulesManager.is_team_mode = function(l_5_0)
	return l_5_0._is_team_mode
end

GameRulesManager._update_rules = function(l_6_0, l_6_1)
	local l_6_6, l_6_7, l_6_8, l_6_9 = nil
	local l_6_2 = TableAlgorithms.count(l_6_1)
	for i_0,i_1 in pairs(l_6_1) do
		i_1:player_data().revive_when_fully_damaged = l_6_0:is_team_mode() or l_6_2 > 1
	end
end


