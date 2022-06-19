require("managers/actionmanagers/AMWeaponPickup")
if not AMM79Pickup then
	AMM79Pickup = class(AMWeaponPickup)
end
AMM79Pickup.init = function(l_1_0, l_1_1, l_1_2)
	AMWeaponPickup.init(l_1_0, l_1_1, l_1_2, "m79_grenadelauncher")
end


