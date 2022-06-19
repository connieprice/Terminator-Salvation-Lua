if not MagneticChargeDamage then
	MagneticChargeDamage = class(UnitDamage)
end
MagneticChargeDamage.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	UnitDamage.init(l_1_0, l_1_1, BodyDamage, l_1_3, l_1_4, l_1_5, l_1_6)
	l_1_0._unit = l_1_1
end

MagneticChargeDamage.add_damage = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7, l_2_8)
	print("Add_damage", l_2_1)
	if l_2_1 == "ezsqz_bullet" or l_2_1 == "player_bullet" then
		UnitDamage.add_damage(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7, l_2_8)
	end
end

MagneticChargeDamage.dead = function(l_3_0, l_3_1)
	print("Killing unit " .. l_3_0._unit:name())
	l_3_0._unit:base():bullet_hit()
end


