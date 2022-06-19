AMEndOfMission = AMEndOfMission or class(CoreActionElement)
function AMEndOfMission.activate_now(A0_0)
	managers.game_transition:exec_end_of_mission()
	A0_0:deactivate_now()
end
