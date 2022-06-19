require("game/states/GameStateFrozen")
GameStateFreeze = GameStateFreeze or class(FiniteStateMachineState)
function GameStateFreeze.init(A0_0)
	A0_0.game._current_blur = managers.environment:radial_blur_manager():create_blur(TimerManager:game(), "menu_ingame", Vector3(0, 0, 0))
	A0_0._frame = 0
end
function GameStateFreeze.update(A0_1, A1_2)
	local L2_3
	L2_3 = A0_1._frame
	L2_3 = L2_3 + 1
	A0_1._frame = L2_3
end
function GameStateFreeze.transition(A0_4)
	if A0_4._frame > 4 then
		return GameStateFrozen
	end
end
