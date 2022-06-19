MenuStateIngameResuming = MenuStateIngameResuming or class(FiniteStateMachineState)
function MenuStateIngameResuming.init(A0_0)
	A0_0._menu._is_ready_to_resume = true
	managers.volume:deactivate_set("pause")
	A0_0._menu:gui_interface():set_state("resuming_from_pause")
end
function MenuStateIngameResuming.exit(A0_1)
	local L1_2, L2_3, L3_4, L4_5, L5_6
	if L1_2 then
		L5_6 = L2_3(L3_4)
		for L4_5, L5_6 in L1_2(L2_3, L3_4, L4_5, L5_6, L2_3(L3_4)) do
			L5_6:set_dof_updator(callback(L5_6, L5_6, "_update_dof"))
		end
	end
end
function MenuStateIngameResuming.update(A0_7, A1_8)
end
function MenuStateIngameResuming.transition(A0_9)
	if not managers.game:is_paused() and A0_9._menu:gui_interface():page_change_completed() then
		return MenuStateIngameRunning
	end
end
