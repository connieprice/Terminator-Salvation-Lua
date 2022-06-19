AMTutorial = AMTutorial or class(CoreActionElement)
function AMTutorial.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMTutorial.activate_now(A0_3)
	if A0_3._mode == "show" then
		managers.tutorial:set_current_tutorial(A0_3.tutorial_id)
	elseif A0_3._mode == "hide" then
		managers.tutorial:clear_current_tutorial()
	end
	A0_3:deactivate_now()
end
