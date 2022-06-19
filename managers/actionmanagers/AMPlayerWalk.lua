AMPlayerWalk = AMPlayerWalk or class(CoreActionElement)
function AMPlayerWalk.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMPlayerWalk.activate_now(A0_3)
	local L1_4, L2_5, L3_6, L4_7, L5_8, L6_9
	L1_4 = managers
	L1_4 = L1_4.player
	L1_4 = L1_4.players
	L1_4 = L1_4(L2_5)
	for L5_8, L6_9 in L2_5(L3_6) do
		if alive(L6_9) then
			if A0_3._mode == "limitations_on" then
				L6_9:player_data().limited_to_walk = A0_3.limited_to_walk
			elseif A0_3._mode == "limitations_off" then
				L6_9:player_data().limited_to_walk = false
			end
		end
	end
	L2_5(L3_6)
end
