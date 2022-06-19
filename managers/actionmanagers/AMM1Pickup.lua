require("managers/actionmanagers/AMWeaponPickup")
AMM1Pickup = AMM1Pickup or class(AMWeaponPickup)
function AMM1Pickup.init(A0_0, A1_1, A2_2)
	AMWeaponPickup.init(A0_0, A1_1, A2_2, "m1a_rifle")
end
