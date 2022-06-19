require("shared/TableAlgorithms")
GameRulesManager = GameRulesManager or class()
function GameRulesManager.init(A0_0)
	local L1_1
end
function GameRulesManager.update(A0_2, A1_3)
	local L2_4
	L2_4 = managers
	L2_4 = L2_4.player
	L2_4 = L2_4.human_players
	L2_4 = L2_4(L2_4)
	A0_2:_update_rules(L2_4)
	A0_2:check_all_human_players_down(L2_4)
end
function GameRulesManager.check_all_human_players_down(A0_5, A1_6)
	if TableAlgorithms.is_empty(A1_6) then
		return
	end
	for 