if not HunterKillerDamageData then
	HunterKillerDamageData = class(DamageData)
end
HunterKillerDamageData.init = function(l_1_0, l_1_1)
	DamageData.init(l_1_0, l_1_1)
	l_1_0.last_damage_taken = 0
end

HunterKillerDamageData.scale_health = function(l_2_0, l_2_1)
end


