require("managers/actionmanagers/AMWeaponPickup")
if not AMM1Pickup then
	AMM1Pickup = class(AMWeaponPickup)
end
AMM1Pickup.init = function(l_1_0, l_1_1, l_1_2)
	AMWeaponPickup.init(l_1_0, l_1_1, l_1_2, "m1a_rifle")
end


