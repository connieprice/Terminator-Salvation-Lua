AMDebugText = AMDebugText or class(CoreActionElement)
function AMDebugText.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMDebugText.activate_now(A0_3)
	local L1_4
	L1_4 = Application
	L1_4 = L1_4.debug_build
	L1_4 = L1_4(L1_4)
	if not L1_4 then
		return
	end
	L1_4 = managers
	L1_4 = L1_4.player
	L1_4 = L1_4.human_players
	L1_4 = L1_4(L1_4)
	for 