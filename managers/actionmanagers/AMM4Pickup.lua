require("managers/actionmanagers/AMWeaponPickup")
if not AMM4Pickup then
	AMM4Pickup = class(AMWeaponPickup)
end
AMM4Pickup.init = function(l_1_0, l_1_1, l_1_2)
	AMWeaponPickup.init(l_1_0, l_1_1, l_1_2, "m4_carbine")
end


