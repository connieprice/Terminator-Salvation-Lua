if not StunBodySetup then
	StunBodySetup = class()
end
StunBodySetup.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	assert(l_1_1)
	assert(l_1_2)
	assert(l_1_3)
	l_1_0.body_name = l_1_1
	l_1_0.max_health = l_1_2
	l_1_0.health_per_second = l_1_3
	l_1_0.damage_unit = l_1_4
end


