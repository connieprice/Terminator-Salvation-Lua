if not AMSceneTrigger then
	AMSceneTrigger = class(CoreActionElement)
end
AMSceneTrigger.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMSceneTrigger.activate_now = function(l_2_0)
	l_2_0:deactivate_now()
end


