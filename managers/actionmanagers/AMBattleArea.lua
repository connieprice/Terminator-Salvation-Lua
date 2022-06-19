AMBattleArea = AMBattleArea or class(CoreActionElement)
function AMBattleArea.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMBattleArea.activate_now(A0_3)
	local L1_4, L2_5, L3_6
	L3_6 = managers
	L3_6 = L3_6.player
	L3_6 = L3_6.human_players
	L3_6 = L3_6(L3_6)
	for 