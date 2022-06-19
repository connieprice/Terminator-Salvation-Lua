if not UnitStatusCondition then
	UnitStatusCondition = class()
end
UnitStatusCondition.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0.status_type = l_1_1
	l_1_0.callback = l_1_2
end


