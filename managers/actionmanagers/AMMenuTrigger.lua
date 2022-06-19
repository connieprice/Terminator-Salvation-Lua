if not AMMenuTrigger then
	AMMenuTrigger = class(CoreActionElement)
end
AMMenuTrigger.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMMenuTrigger.activate_now = function(l_2_0)
	l_2_0:deactivate_now()
end


