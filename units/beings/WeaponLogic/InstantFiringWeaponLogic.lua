require("units/beings/WeaponLogic/WeaponLogic")
InstantFiringWeaponLogic = InstantWeaponLogic or class(WeaponLogic)
function InstantFiringWeaponLogic.init(A0_0, A1_1, A2_2)
	WeaponLogic.init(A0_0, A1_1, A2_2)
end
function InstantFiringWeaponLogic.update(A0_3, A1_4, A2_5, A3_6, A4_7, A5_8, A6_9)
	if not A0_3:_aiming_at_target(A4_7, A6_9) then
		A3_6 = 0
	end
	A0_3:_update_weapon_data(A2_5, A3_6, A4_7, A5_8)
end
