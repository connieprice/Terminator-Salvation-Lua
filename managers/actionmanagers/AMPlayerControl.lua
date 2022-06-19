AMPlayerControl = AMPlayerControl or class(CoreActionElement)
function AMPlayerControl.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMPlayerControl.activate_now(A0_3)
	local L1_4, L2_5, L3_6, L4_7, L5_8, L6_9
	for L4_7, L5_8 in L1_4(L2_5) do
		L6_9 = managers
		L6_9 = L6_9.unit_scripting
		L6_9 = L6_9.get_unit_by_name
		L6_9 = L6_9(L6_9, L5_8.script_name)
		if alive(L6_9) then
			if A0_3._mode == "player_control" and L6_9:control():saved_controller_wrapper() then
				L6_9:control():set_user_controlled(L6_9:control():saved_controller_wrapper())
			elseif A0_3._mode == "ai_control" and not L6_9:control():is_ai_controlled() then
				L6_9:control():set_ai_controlled_keep_controller_wrapper()
			end
		end
	end
	L1_4(L2_5)
end
