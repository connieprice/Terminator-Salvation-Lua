require("game/states/GameStateFrozen")
if not GameStateFreeze then
	GameStateFreeze = class(FiniteStateMachineState)
end
GameStateFreeze.init = function(l_1_0)
	l_1_0.game._current_blur = managers.environment:radial_blur_manager():create_blur(TimerManager:game(), "menu_ingame", Vector3(0, 0, 0))
	l_1_0._frame = 0
end

GameStateFreeze.update = function(l_2_0, l_2_1)
	l_2_0._frame = l_2_0._frame + 1
end

GameStateFreeze.transition = function(l_3_0)
	if l_3_0._frame > 4 then
		return GameStateFrozen
	end
end


