if not AMEndOfMission then
	AMEndOfMission = class(CoreActionElement)
end
AMEndOfMission.activate_now = function(l_1_0)
	managers.game_transition:exec_end_of_mission()
	l_1_0:deactivate_now()
end


