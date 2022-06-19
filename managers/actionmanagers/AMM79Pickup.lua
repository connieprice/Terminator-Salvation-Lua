require("managers/actionmanagers/AMWeaponPickup")
AMM79Pickup = AMM79Pickup or class(AMWeaponPickup)
function AMM79Pickup.init(A0_0, A1_1, A2_2)
	AMWeaponPickup.init(A0_0, A1_1, A2_2, "m79_grenadelauncher")
end
