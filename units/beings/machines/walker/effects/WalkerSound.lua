require("units/beings/machines/effects/MachineSound")
WalkerSound = WalkerSound or class(MachineSound)
function WalkerSound.init(A0_0, A1_1)
	A0_0._unit = A1_1
	managers.action_event:register_listener(A0_0, A1_1, A1_1)
end
function WalkerSound.destroy(A0_2, A1_3)
	managers.action_event:unregister_listener(A0_2)
end
