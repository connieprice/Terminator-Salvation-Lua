if not MenuStateIngameResuming then
	MenuStateIngameResuming = class(FiniteStateMachineState)
end
MenuStateIngameResuming.init = function(l_1_0)
	l_1_0._menu._is_ready_to_resume = true
	managers.volume:deactivate_set("pause")
	l_1_0._menu:gui_interface():set_state("resuming_from_pause")
end

MenuStateIngameResuming.exit = function(l_2_0)
	if managers.user_viewport then
		local l_2_4, l_2_5 = pairs, managers.user_viewport:viewports()
		l_2_4 = l_2_4(l_2_5)
		for i_0,i_1 in l_2_4 do
			l_2_3:set_dof_updator(callback(l_2_3, l_2_3, "_update_dof"))
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

MenuStateIngameResuming.update = function(l_3_0, l_3_1)
end

MenuStateIngameResuming.transition = function(l_4_0)
	if not managers.game:is_paused() and l_4_0._menu:gui_interface():page_change_completed() then
		return MenuStateIngameRunning
	end
end


