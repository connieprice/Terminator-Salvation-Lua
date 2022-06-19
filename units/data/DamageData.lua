if not DamageData then
	DamageData = class()
end
DamageData.init = function(l_1_0, l_1_1)
	l_1_0.damage = 0
	l_1_0.health = 1
	l_1_0.is_affected_by_explosion_physics_effect = true
end

DamageData.save = function(l_2_0, l_2_1)
	TableAlgorithms.merge_except_functions(l_2_1, l_2_0)
end

DamageData.load = function(l_3_0, l_3_1)
	TableAlgorithms.merge_except_functions(l_3_0, l_3_1)
end

DamageData.revive = function(l_4_0)
	l_4_0.damage = 0
end

DamageData.is_fully_damaged = function(l_5_0)
	return l_5_0.health <= l_5_0.damage
end

DamageData.scale_health = function(l_6_0, l_6_1)
	local l_6_2 = l_6_0.damage / l_6_0.health
	l_6_0.health = l_6_1
	l_6_0.damage = l_6_2 * l_6_1
end


