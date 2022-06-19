require("projectile/magnetic_charge/states/MagneticChargeState")
require("projectile/magnetic_charge/states/MagneticChargeNotActivated")
if not MagneticChargeDeactivated then
	MagneticChargeDeactivated = class(MagneticChargeState)
end
MagneticChargeDeactivated.init = function(l_1_0, l_1_1)
	MagneticChargeState.init(l_1_0, l_1_1)
	l_1_0._weapon_data = l_1_1:weapon_data()
end

MagneticChargeDeactivated.enter = function(l_2_0)
	l_2_0._event_emitter:magnetic_charge_deactivated(l_2_0._unit)
end

MagneticChargeDeactivated.update = function(l_3_0, l_3_1)
	if l_3_0._weapon_data.fire_input > 0 then
		local l_3_2, l_3_3 = MagneticChargeNotActivated:new, MagneticChargeNotActivated
		local l_3_4 = l_3_0._unit
		return l_3_2(l_3_3, l_3_4)
	end
end


