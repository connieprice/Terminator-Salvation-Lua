if not VisibilityQuery then
	VisibilityQuery = class()
end
VisibilityQuery.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
end

VisibilityQuery.visible_from_position = function(l_2_0, l_2_1)
	return true
end

VisibilityQuery.hitable_from_position = function(l_3_0, l_3_1)
	return true
end


