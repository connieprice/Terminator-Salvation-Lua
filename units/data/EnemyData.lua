if not EnemyData then
	EnemyData = class()
end
EnemyData.init = function(l_1_0, l_1_1)
	l_1_0.is_firing = false
	l_1_0.is_reloading = false
	l_1_0.preparing_to_fire = false
	l_1_0.dead = false
	l_1_0.can_be_stunned = true
	l_1_0.stun_request = false
	l_1_0.is_stunned = false
	l_1_0.num_scans = 0
	l_1_0.full_outline_by_deafult = false
	l_1_0.full_outline_by_full_weapon = true
	l_1_0.only_outline_by_full_weapon = false
end


