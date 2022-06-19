require("managers/actionmanagers/AMWeaponPickup")
AMM4Pickup = AMM4Pickup or class(AMWeaponPickup)
function AMM4Pickup.init(A0_0, A1_1, A2_2)
	AMWeaponPickup.init(A0_0, A1_1, A2_2, "m4_carbine")
end
