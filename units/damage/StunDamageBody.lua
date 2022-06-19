if not StunDamageBody then
	StunDamageBody = class(BodyDamage)
end
StunDamageBody.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7, l_1_8)
	BodyDamage.init(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_8)
	l_1_0._accumulated_damage = 0
	l_1_0._health_per_second = l_1_7
	l_1_0._max_health = l_1_6
	l_1_0._health = l_1_0._max_health
	l_1_0._damage_unit = l_1_5
	l_1_0._emitter = managers.action_event:create_emitter(l_1_1)
end

StunDamageBody.destroy = function(l_2_0)
	l_2_0._emitter:destroy()
end

StunDamageBody.faith_damage = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5)
	local l_3_6, l_3_7 = l_3_0._damage_defense_material:calculate_damage(l_3_5)
	if l_3_7 > 0 then
		l_3_0._emitter:unit_stun_body_damaged(l_3_0._unit)
	end
	l_3_0._health = l_3_0._health - l_3_7
	if l_3_0._damage_unit then
		local l_3_8 = BodyDamage.faith_damage
		local l_3_9 = l_3_0
		local l_3_10 = l_3_1
		local l_3_11 = l_3_2
		local l_3_12 = l_3_3
		local l_3_13 = l_3_4
		local l_3_14 = l_3_5
		return l_3_8(l_3_9, l_3_10, l_3_11, l_3_12, l_3_13, l_3_14)
	else
		return l_3_6, l_3_7
	end
end

StunDamageBody.update = function(l_4_0, l_4_1)
	l_4_0._health = l_4_0._health + l_4_1 * l_4_0._health_per_second
	if l_4_0._max_health < l_4_0._health then
		l_4_0._health = l_4_0._max_health
	end
end

StunDamageBody.stunned = function(l_5_0)
	return l_5_0._health < 0
end

StunDamageBody.reset = function(l_6_0)
	l_6_0._health = l_6_0._max_health
end


