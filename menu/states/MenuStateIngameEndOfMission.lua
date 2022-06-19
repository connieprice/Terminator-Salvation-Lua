if not MenuStateIngameEndOfMission then
	MenuStateIngameEndOfMission = class(FiniteStateMachineState)
end
MenuStateIngameEndOfMission.init = function(l_1_0)
	l_1_0._menu:ingame_gui():fade_down_slow()
end

MenuStateIngameEndOfMission.update = function(l_2_0)
	if l_2_0._menu:ingame_gui():is_faded_down() then
		l_2_0._menu._is_end_of_mission_done = true
	end
end

MenuStateIngameEndOfMission.transition = function(l_3_0)
end


