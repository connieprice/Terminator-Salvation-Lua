if not TankWeaponSecondary then
	TankWeaponSecondary = class(GenericProjectileWeapon)
end
TankWeaponSecondary.init = function(l_1_0, l_1_1)
	GenericProjectileWeapon.init(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._fire_logic = l_1_0._unit:logic()
end

TankWeaponSecondary.fire = function(l_2_0, l_2_1)
	if l_2_0._fire_logic:get_power_up_percent() > 1 then
		local l_2_2 = 1
	end
	local l_2_3 = nil
	local l_2_4 = nil
	local l_2_5, l_2_6 = l_2_0._damage_on_max_power_up * l_2_3, l_2_0:set_explosion_damage_at_center
	local l_2_7 = l_2_0
	l_2_6(l_2_7, {hard = l_2_5, soft = l_2_5})
	l_2_6 = GenericProjectileWeapon
	l_2_6 = l_2_6.fire
	l_2_7 = l_2_0
	l_2_6(l_2_7, l_2_1)
end

TankWeaponSecondary.destroy = function(l_3_0)
	GenericProjectileWeapon.destroy(l_3_0)
end


