if not UnitPhysics then
	UnitPhysics = class()
end
UnitPhysics.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
end

UnitPhysics.push = function(l_2_0, l_2_1, l_2_2, l_2_3)
	l_2_0._unit:push(l_2_1, l_2_2)
end


