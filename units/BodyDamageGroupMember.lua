require("units/BodyDamage")
BodyDamageGroupMember = BodyDamageGroupMember or class(BodyDamage)
function BodyDamageGroupMember.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	BodyDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	A0_0._group = A5_5
	A0_0._damage_unit = A6_6
end
function BodyDamageGroupMember.damage_endurance(A0_7, A1_8, A2_9, A3_10, A4_11, A5_12, A6_13, A7_14)
	A0_7._group:add_damage(A6_13)
	return BodyDamage.damage_endurance(A0_7, A1_8, A2_9, A3_10, A4_11, A5_12, A6_13, A7_14)
end
function BodyDamageGroupMember.damage_bullet(A0_15, A1_16, A2_17, A3_18, A4_19, A5_20, A6_21)
	A5_20 = A0_15:damage_endurance("bullet", A1_16, A2_17, A3_18, A4_19, A5_20, Vector3(0, 0, 0))
	if A0_15._damage_unit then
		return A0_15._unit_extension:damage_bullet(A1_16, A0_15._body, A2_17, A3_18, A4_19, A5_20, A6_21)
	end
	return true, 0
end
function BodyDamageGroupMember.damage_explosion(A0_22, A1_23, A2_24, A3_25, A4_26, A5_27, A6_28)
	A5_27 = A0_22:damage_endurance("explosion", A1_23, A2_24, A3_25, A4_26, A5_27, Vector3(0, 0, 0))
	if A0_22._damage_unit then
		return A0_22._unit_extension:damage_explosion(A1_23, A0_22._body, A2_24, A3_25, A4_26, A5_27)
	end
	return true, 0
end
