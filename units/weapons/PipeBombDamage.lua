PipeBombDamage = PipeBombDamage or class(UnitDamage)
function PipeBombDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	UnitDamage.init(A0_0, A1_1, PlayerBodyDamage, A3_3, A4_4, A5_5, A6_6)
	A0_0._unit = A1_1
end
function PipeBombDamage.add_damage(A0_7, A1_8, A2_9, A3_10, A4_11, A5_12, A6_13, A7_14, A8_15)
	if A1_8 == "collision" then
		A7_14 = 0
	end
	if A1_8 == "ezsqz_bullet" then
		A0_7._unit:base():bullet_hit()
	end
	return UnitDamage.add_damage(A0_7, A1_8, A2_9, A3_10, A4_11, A5_12, A6_13, A7_14, A8_15)
end
function PipeBombDamage.dead(A0_16, A1_17)
end
