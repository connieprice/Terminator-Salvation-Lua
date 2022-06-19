require("managers/actionmanagers/AMWeaponPickup")
AMMagneticChargePickup = AMMagneticChargePickup or class(AMWeaponPickup)
function AMMagneticChargePickup.init(A0_0, A1_1, A2_2)
	AMWeaponPickup.init(A0_0, A1_1, A2_2, "charge_magnetic")
end
