if not MagneticChargeState then
	MagneticChargeState = class()
end
MagneticChargeState.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._event_emitter = managers.action_event:create_emitter(l_1_1)
end

MagneticChargeState.destroy = function(l_2_0)
	l_2_0._event_emitter:destroy()
end


