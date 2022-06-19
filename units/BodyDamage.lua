if not BodyDamage then
	BodyDamage = class(CoreBodyDamage)
end
BodyDamage.ARMOR_ATTRIBUTE_NAME = "armor"
BodyDamage.IS_HEAD_ATTRIBUTE_NAME = "is_head"
BodyDamage.EXPLOSION_RECEIVER_ATTRIBUTE_NAME = "explosion_receiver"
BodyDamage.NORMAL_ARMOR_NAME = "normal"
BodyDamage.LOW_ARMOR_NAME = "low"
BodyDamage.HIGH_ARMOR_NAME = "high"
BodyDamage.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5)
	CoreBodyDamage.init(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	if not l_1_5 then
		l_1_5 = l_1_0:get_body_param("material")
		if not l_1_5 then
			l_1_5 = "steel"
		end
		assert(l_1_5)
	end
	l_1_0._damage_defense_material = managers.damage_defense_material:material(l_1_5)
	assert(l_1_0._damage_defense_material)
	if not l_1_0:get_body_param(BodyDamage.ARMOR_ATTRIBUTE_NAME) then
		l_1_0._armor_type = BodyDamage.NORMAL_ARMOR_NAME
	end
	l_1_0._is_head = l_1_0:get_body_param(BodyDamage.IS_HEAD_ATTRIBUTE_NAME) or false
	l_1_0._explosion_receiver = l_1_0:get_body_param(BodyDamage.EXPLOSION_RECEIVER_ATTRIBUTE_NAME)
	if l_1_0._explosion_receiver == nil then
		l_1_0._explosion_receiver = true
	end
	l_1_0._damage_multiplier = 1
end

BodyDamage.set_damage_multiplier = function(l_2_0, l_2_1)
	l_2_0._damage_multiplier = l_2_1
end

BodyDamage.faith_damage = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5)
	local l_3_6 = l_3_0._damage_defense_material:calculate_damage(l_3_5)
	local l_3_7 = l_3_0._damage_defense_material * l_3_0._damage_multiplier
	assert(l_3_7)
	local l_3_8 = assert
	l_3_8(l_3_7 >= 0)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_8(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_7)
	return l_3_6, l_3_7
end

BodyDamage._get_damage_function = function(l_4_0, l_4_1)
	local l_4_2 = "damage_" .. l_4_1
	local l_4_3 = l_4_0[l_4_2]
	assert(l_4_3)
	return l_4_3
end

BodyDamage.is_explosion_receiver = function(l_5_0)
	return l_5_0._explosion_receiver
end

BodyDamage.damage_endurance = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4, l_6_5, l_6_6, l_6_7)
	if alive(l_6_2) and l_6_2:control() and l_6_2:control():is_human_controlled() then
		local l_6_8 = "player_" .. l_6_1
	if l_6_0._damage[l_6_8] ~= nil then
		end
		l_6_1 = l_6_8
	end
	local l_6_9 = CoreBodyDamage.damage_endurance
	local l_6_10 = l_6_0
	local l_6_11 = l_6_1
	local l_6_12 = l_6_2
	local l_6_13 = l_6_3
	local l_6_14 = l_6_4
	local l_6_15 = l_6_5
	local l_6_16 = l_6_6
	local l_6_17 = l_6_7
	return l_6_9(l_6_10, l_6_11, l_6_12, l_6_13, l_6_14, l_6_15, l_6_16, l_6_17)
end

BodyDamage.damage_explosion = function(l_7_0, l_7_1, l_7_2, l_7_3, l_7_4, l_7_5)
	local l_7_14, l_7_15, l_7_16, l_7_17 = l_7_0:damage_endurance, l_7_0, "explosion", l_7_1
	l_7_14 = l_7_14(l_7_15, l_7_16, l_7_17, l_7_2, l_7_3, l_7_4, l_7_5, Vector3(0, 0, 0))
	l_7_5 = l_7_14
	l_7_14 = l_7_0._unit_extension
	l_7_14, l_7_15 = l_7_14:damage_explosion, l_7_14
	local l_7_6, l_7_7 = nil
	l_7_16 = l_7_1
	local l_7_8 = nil
	l_7_17 = l_7_0._body
	local l_7_9 = nil
	l_7_6 = l_7_2
	local l_7_10 = nil
	l_7_7 = l_7_3
	local l_7_11 = nil
	l_7_8 = l_7_4
	local l_7_12 = nil
	l_7_9 = l_7_5
	local l_7_13 = nil
	return l_7_14(l_7_15, l_7_16, l_7_17, l_7_6, l_7_7, l_7_8, l_7_9)
end


