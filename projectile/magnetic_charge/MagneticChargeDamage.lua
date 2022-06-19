MagneticChargeDamage = MagneticChargeDamage or class(UnitDamage)
function MagneticChargeDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	UnitDamage.init(A0_0, A1_1, BodyDamage, A3_3, A4_4, A5_5, A6_6)
	A0_0._unit = A1_1
end
function MagneticChargeDamage.add_damage(A0_7, A1_8, A2_9, A3_10, A4_11, A5_12, A6_13, A7_14, A8_15)
	print("Add_damage", A1_8)
	if A1_8 == "ezsqz_bullet" or A1_8 == "player_bullet" then
		UnitDamage.add_damage(A0_7, A1_8, A2_9, A3_10, A4_11, A5_12, A6_13, A7_14, A8_15)
	end
end
function MagneticChargeDamage.dead(A0_16, A1_17)
	print("Killing unit " .. A0_16._unit:name())
	A0_16._unit:base():bullet_hit()
end
