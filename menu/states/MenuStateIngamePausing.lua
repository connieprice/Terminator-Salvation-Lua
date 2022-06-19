MenuStateIngamePausing = MenuStateIngamePausing or class(MenuStateFadeDown)
function MenuStateIngamePausing.init(A0_0)
	A0_0._time = 0
	managers.volume:activate_set("pause")
end
function MenuStateIngamePausing.update(A0_1, A1_2)
	local L2_3
	L2_3 = A0_1._time
	L2_3 = L2_3 + A1_2
	A0_1._time = L2_3
end
function MenuStateIngamePausing.transition(A0_4)
	if A0_4._time > 0.01 then
		return MenuStateIngamePaused
	end
end
