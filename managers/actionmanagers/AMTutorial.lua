if not AMTutorial then
	AMTutorial = class(CoreActionElement)
end
AMTutorial.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMTutorial.activate_now = function(l_2_0)
	if l_2_0._mode == "show" then
		managers.tutorial:set_current_tutorial(l_2_0.tutorial_id)
	elseif l_2_0._mode == "hide" then
		managers.tutorial:clear_current_tutorial()
	end
	l_2_0:deactivate_now()
end


