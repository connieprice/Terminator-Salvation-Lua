require("units/beings/machines/effects/MachineSound")
if not WalkerSound then
	WalkerSound = class(MachineSound)
end
WalkerSound.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	managers.action_event:register_listener(l_1_0, l_1_1, l_1_1)
end

WalkerSound.destroy = function(l_2_0, l_2_1)
	managers.action_event:unregister_listener(l_2_0)
end


