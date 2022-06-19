TankWeaponSecondary = TankWeaponSecondary or class(GenericProjectileWeapon)
function TankWeaponSecondary.init(A0_0, A1_1)
	GenericProjectileWeapon.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._fire_logic = A0_0._unit:logic()
end
function TankWeaponSecondary.fire(A0_2, A1_3)
	A0_2:set_explosion_damage_at_center({
		hard = A0_2._damage_on_max_power_up * 1,
		soft = A0_2._damage_on_max_power_up * 1
	})
	GenericProjectileWeapon.fire(A0_2, A1_3)
end
function TankWeaponSecondary.destroy(A0_4)
	GenericProjectileWeapon.destroy(A0_4)
end
