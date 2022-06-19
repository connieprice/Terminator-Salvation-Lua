InvulnerableBodyDamage = InvulnerableBodyDamage or class(BodyDamage)
function InvulnerableBodyDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	BodyDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4)
end
function InvulnerableBodyDamage.damage_endurance(A0_5, A1_6, A2_7, A3_8, A4_9, A5_10, A6_11, A7_12)
	return BodyDamage.damage_endurance(A0_5, A1_6, A2_7, A3_8, A4_9, A5_10, 0, A7_12)
end
