StunDamageBody = StunDamageBody or class(BodyDamage)
function StunDamageBody.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7, A8_8)
	BodyDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A8_8)
	A0_0._accumulated_damage = 0
	A0_0._health_per_second = A7_7
	A0_0._max_health = A6_6
	A0_0._health = A0_0._max_health
	A0_0._damage_unit = A5_5
	A0_0._emitter = managers.action_event:create_emitter(A1_1)
end
function StunDamageBody.destroy(A0_9)
	A0_9._emitter:destroy()
end
function StunDamageBody.faith_damage(A0_10, A1_11, A2_12, A3_13, A4_14, A5_15)
	local L6_16, L7_17
	L6_16 = A0_10._damage_defense_material
	L7_17 = L6_16
	L6_16 = L6_16.calculate_damage
	L7_17 = L6_16(L7_17, A5_15)
	if L7_17 > 0 then
		A0_10._emitter:unit_stun_body_damaged(A0_10._unit)
	end
	A0_10._health = A0_10._health - L7_17
	if A0_10._damage_unit then
		return BodyDamage.faith_damage(A0_10, A1_11, A2_12, A3_13, A4_14, A5_15)
	else
		return L6_16, L7_17
	end
end
function StunDamageBody.update(A0_18, A1_19)
	local L2_20, L3_21
	L2_20 = A0_18._health
	L3_21 = A0_18._health_per_second
	L3_21 = A1_19 * L3_21
	L2_20 = L2_20 + L3_21
	A0_18._health = L2_20
	L2_20 = A0_18._health
	L3_21 = A0_18._max_health
	if L2_20 > L3_21 then
		L2_20 = A0_18._max_health
		A0_18._health = L2_20
	end
end
function StunDamageBody.stunned(A0_22)
	return A0_22._health < 0
end
function StunDamageBody.reset(A0_23)
	A0_23._health = A0_23._max_health
end
