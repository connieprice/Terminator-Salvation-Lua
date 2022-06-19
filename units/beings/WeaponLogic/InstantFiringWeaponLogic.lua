require("units/beings/WeaponLogic/WeaponLogic")
if not InstantWeaponLogic then
	InstantFiringWeaponLogic = class(WeaponLogic)
end
InstantFiringWeaponLogic.init = function(l_1_0, l_1_1, l_1_2)
	WeaponLogic.init(l_1_0, l_1_1, l_1_2)
end

InstantFiringWeaponLogic.update = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6)
	if not l_2_0:_aiming_at_target(l_2_4, l_2_6) then
		l_2_3 = 0
	end
	l_2_0:_update_weapon_data(l_2_2, l_2_3, l_2_4, l_2_5)
end


