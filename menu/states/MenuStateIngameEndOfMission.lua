MenuStateIngameEndOfMission = MenuStateIngameEndOfMission or class(FiniteStateMachineState)
function MenuStateIngameEndOfMission.init(A0_0)
	A0_0._menu:ingame_gui():fade_down_slow()
end
function MenuStateIngameEndOfMission.update(A0_1)
	if A0_1._menu:ingame_gui():is_faded_down() then
		A0_1._menu._is_end_of_mission_done = true
	end
end
function MenuStateIngameEndOfMission.transition(A0_2)
	local L1_3
end
