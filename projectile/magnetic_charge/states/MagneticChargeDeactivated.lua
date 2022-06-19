require("projectile/magnetic_charge/states/MagneticChargeState")
require("projectile/magnetic_charge/states/MagneticChargeNotActivated")
MagneticChargeDeactivated = MagneticChargeDeactivated or class(MagneticChargeState)
function MagneticChargeDeactivated.init(A0_0, A1_1)
	MagneticChargeState.init(A0_0, A1_1)
	A0_0._weapon_data = A1_1:weapon_data()
end
function MagneticChargeDeactivated.enter(A0_2)
	A0_2._event_emitter:magnetic_charge_deactivated(A0_2._unit)
end
function MagneticChargeDeactivated.update(A0_3, A1_4)
	if A0_3._weapon_data.fire_input > 0 then
		return MagneticChargeNotActivated:new(A0_3._unit)
	end
end
