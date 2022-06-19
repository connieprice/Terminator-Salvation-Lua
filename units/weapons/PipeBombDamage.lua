if not PipeBombDamage then
	PipeBombDamage = class(UnitDamage)
end
PipeBombDamage.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	UnitDamage.init(l_1_0, l_1_1, PlayerBodyDamage, l_1_3, l_1_4, l_1_5, l_1_6)
	l_1_0._unit = l_1_1
end

PipeBombDamage.add_damage = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7, l_2_8)
	if l_2_1 == "collision" then
		l_2_7 = 0
	end
	if l_2_1 == "ezsqz_bullet" then
		l_2_0._unit:base():bullet_hit()
	end
	local l_2_9 = UnitDamage.add_damage
	local l_2_10 = l_2_0
	local l_2_11 = l_2_1
	local l_2_12 = l_2_2
	local l_2_13 = l_2_3
	local l_2_14 = l_2_4
	local l_2_15 = l_2_5
	local l_2_16 = l_2_6
	local l_2_17 = l_2_7
	local l_2_18 = l_2_8
	return l_2_9(l_2_10, l_2_11, l_2_12, l_2_13, l_2_14, l_2_15, l_2_16, l_2_17, l_2_18)
end

PipeBombDamage.dead = function(l_3_0, l_3_1)
end


