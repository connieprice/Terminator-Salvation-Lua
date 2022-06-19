require("projectile/magnetic_charge/states/MagneticChargeState")
require("projectile/magnetic_charge/states/MagneticChargeDeactivated")
MagneticChargeActivated = MagneticChargeActivated or class(MagneticChargeState)
function MagneticChargeActivated.init(A0_0, A1_1, A2_2)
	MagneticChargeState.init(A0_0, A1_1)
	A0_0._attachment_point = A2_2
end
function MagneticChargeActivated.enter(A0_3)
	A0_3._unit:base()._deactivate = false
	A0_3._unit:base()._activated = true
	A0_3._event_emitter:magnetic_charge_activated(A0_3._unit)
end
function MagneticChargeActivated.leave(A0_4)
	A0_4._unit:base()._activated = false
	if A0_4:_attached() then
		A0_4:_detach()
	end
end
function MagneticChargeActivated._attached(A0_5)
	if not A0_5._attachment_point:valid() then
		return false
	end
	return TableAlgorithms.count_if(A0_5._attachment_point:attached_units(), function(A0_6)
		local L1_7
		L1_7 = _UPVALUE0_
		L1_7 = L1_7._unit
		L1_7 = A0_6 == L1_7
		return L1_7
	end) > 0
end
function MagneticChargeActivated._detach(A0_8)
	assert(A0_8:_attached())
	A0_8._attachment_point:detach_unit(A0_8._unit)
end
function MagneticChargeActivated.update(A0_9, A1_10)
	if A0_9._unit:base()._deactivate then
		return MagneticChargeDeactivated:new(A0_9._unit)
	end
	if A0_9._unit:base()._bullet_hit then
		World:spawn_unit(A0_9._unit:base()._explosion_unit, A0_9._unit:position(), A0_9._unit:rotation())
		managers.sequence:run_sequence_simple("explosion", A0_9._unit)
		return MagneticChargeDeactivated:new(A0_9._unit)
	end
end
