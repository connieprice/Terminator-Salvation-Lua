if not AMAiWaypointTrigger then
	AMAiWaypointTrigger = class(CoreActionElement)
end
AMAiWaypointTrigger.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMAiWaypointTrigger.activate_now = function(l_2_0)
	l_2_0:deactivate_now()
end


