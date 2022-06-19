if not InvulnerableBodyDamage then
	InvulnerableBodyDamage = class(BodyDamage)
end
InvulnerableBodyDamage.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	BodyDamage.init(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
end

InvulnerableBodyDamage.damage_endurance = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7)
	local l_2_8 = BodyDamage.damage_endurance
	local l_2_9 = l_2_0
	local l_2_10 = l_2_1
	local l_2_11 = l_2_2
	local l_2_12 = l_2_3
	local l_2_13 = l_2_4
	local l_2_14 = l_2_5
	local l_2_15 = 0
	local l_2_16 = l_2_7
	return l_2_8(l_2_9, l_2_10, l_2_11, l_2_12, l_2_13, l_2_14, l_2_15, l_2_16)
end


