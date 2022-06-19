if not InteractQuery then
	InteractQuery = class()
end
InteractQuery.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
end

InteractQuery.can_interact_with = function(l_2_0, l_2_1)
	return true
end


