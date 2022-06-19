require("managers/actionmanagers/AMWeaponPickup")
if not AMMagneticChargePickup then
	AMMagneticChargePickup = class(AMWeaponPickup)
end
AMMagneticChargePickup.init = function(l_1_0, l_1_1, l_1_2)
	AMWeaponPickup.init(l_1_0, l_1_1, l_1_2, "charge_magnetic")
end


