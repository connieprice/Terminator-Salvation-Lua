if not MenuStateIngamePausing then
	MenuStateIngamePausing = class(MenuStateFadeDown)
end
MenuStateIngamePausing.init = function(l_1_0)
	l_1_0._time = 0
	managers.volume:activate_set("pause")
end

MenuStateIngamePausing.update = function(l_2_0, l_2_1)
	l_2_0._time = l_2_0._time + l_2_1
end

MenuStateIngamePausing.transition = function(l_3_0)
	if l_3_0._time > 0.01 then
		return MenuStateIngamePaused
	end
end


