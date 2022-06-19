MenuStateIngameResumingFromCutscene = MenuStateIngameResumingFromCutscene or class(MenuStateIngameResuming)
function MenuStateIngameResumingFromCutscene.transition(A0_0)
	if managers.game:is_end_of_misson() then
		return MenuStateIngameEndOfMission
	elseif not managers.game:is_paused() then
		return MenuStateIngameRunning
	end
end
