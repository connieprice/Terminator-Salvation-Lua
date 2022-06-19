if not MenuStateIngameResumingFromCutscene then
	MenuStateIngameResumingFromCutscene = class(MenuStateIngameResuming)
end
MenuStateIngameResumingFromCutscene.transition = function(l_1_0)
	if managers.game:is_end_of_misson() then
		return MenuStateIngameEndOfMission
	else
		if not managers.game:is_paused() then
			return MenuStateIngameRunning
		end
	end
end


