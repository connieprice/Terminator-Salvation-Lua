BodyDamage = BodyDamage or class(CoreBodyDamage)
BodyDamage.ARMOR_ATTRIBUTE_NAME = "armor"
BodyDamage.IS_HEAD_ATTRIBUTE_NAME = "is_head"
BodyDamage.EXPLOSION_RECEIVER_ATTRIBUTE_NAME = "explosion_receiver"
BodyDamage.NORMAL_ARMOR_NAME = "normal"
BodyDamage.LOW_ARMOR_NAME = "low"
BodyDamage.HIGH_ARMOR_NAME = "high"
function BodyDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5)
	CoreBodyDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	if not A5_5 then
		A5_5 = A0_0:get_body_param("material")
		A5_5 = A5_5 or "steel"
		assert(A5_5)
	end
	A0_0._damage_defense_material = managers.damage_defense_material:material(A5_5)
	assert(A0_0._damage_defense_material)
	A0_0._armor_type = A0_0:get_body_param(BodyDamage.ARMOR_ATTRIBUTE_NAME) or BodyDamage.NORMAL_ARMOR_NAME
	A0_0._is_head = A0_0:get_body_param(BodyDamage.IS_HEAD_ATTRIBUTE_NAME) or false
	A0_0._explosion_receiver = A0_0:get_body_param(BodyDamage.EXPLOSION_RECEIVER_ATTRIBUTE_NAME)
	if A0_0._explosion_receiver == nil then
		A0_0._explosion_receiver = true
	end
	A0_0._damage_multiplier = 1
end
function BodyDamage.set_damage_multiplier(A0_6, A1_7)
	A0_6._damage_multiplier = A1_7
end
function BodyDamage.faith_damage(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13)
	local L6_14, L7_15, L8_16, L9_17
	L6_14 = A0_8._damage_defense_material
	L7_15 = L6_14
	L6_14 = L6_14.calculate_damage
	L8_16 = A5_13
	L7_15 = L6_14(L7_15, L8_16)
	L8_16 = A0_8._damage_multiplier
	L7_15 = L7_15 * L8_16
	L8_16 = assert
	L9_17 = L7_15
	L8_16(L9_17)
	L8_16 = assert
	L9_17 = L7_15 >= 0
	L8_16(L9_17)
	L9_17 = A0_8
	L8_16 = A0_8._get_damage_function
	L8_16 = L8_16(L9_17, A5_13.inflictor_type)
	L9_17 = L8_16
	L9_17(A0_8, A1_9, A2_10, A3_11, A4_12, L7_15)
	L9_17 = L6_14
	return L9_17, L7_15
end
function BodyDamage._get_damage_function(A0_18, A1_19)
	local L2_20, L3_21
	L2_20 = "damage_"
	L3_21 = A1_19
	L2_20 = L2_20 .. L3_21
	L3_21 = A0_18[L2_20]
	assert(L3_21)
	return L3_21
end
function BodyDamage.is_explosion_receiver(A0_22)
	local L1_23
	L1_23 = A0_22._explosion_receiver
	return L1_23
end
function BodyDamage.damage_endurance(A0_24, A1_25, A2_26, A3_27, A4_28, A5_29, A6_30, A7_31)
	if alive(A2_26) and A2_26:control() and A2_26:control():is_human_controlled() and A0_24._damage["player_" .. A1_25] ~= nil then
		A1_25 = "player_" .. A1_25
	end
	return CoreBodyDamage.damage_endurance(A0_24, A1_25, A2_26, A3_27, A4_28, A5_29, A6_30, A7_31)
end
function BodyDamage.damage_explosion(A0_32, A1_33, A2_34, A3_35, A4_36, A5_37)
	A5_37 = A0_32:damage_endurance("explosion", A1_33, A2_34, A3_35, A4_36, A5_37, Vector3(0, 0, 0))
	return A0_32._unit_extension:damage_explosion(A1_33, A0_32._body, A2_34, A3_35, A4_36, A5_37)
end
