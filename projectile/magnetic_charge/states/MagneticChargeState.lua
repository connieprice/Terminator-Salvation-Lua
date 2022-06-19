MagneticChargeState = MagneticChargeState or class()
function MagneticChargeState.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._event_emitter = managers.action_event:create_emitter(A1_1)
end
function MagneticChargeState.destroy(A0_2)
	A0_2._event_emitter:destroy()
end
