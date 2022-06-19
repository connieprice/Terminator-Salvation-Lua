if not DamageDefenseMaterial then
	DamageDefenseMaterial = class()
end
DamageDefenseMaterial.init = function(l_1_0)
end

DamageDefenseMaterial.calculate_damage = function(l_2_0, l_2_1)
	local l_2_9, l_2_10, l_2_11, l_2_12 = nil
	local l_2_2 = assert
	l_2_2(l_2_1.damage_factor >= 0)
	local l_2_5 = nil
	for i_0 in pairs(l_2_1) do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_2_0[i_0] and (not l_2_5 or l_2_5 < l_2_1[i_0] - l_2_0[i_0]) then
			l_2_5 = l_2_1[i_0] - l_2_0[i_0]
			 -- DECOMPILER ERROR: Overwrote pending register.

		end
	end
	if not l_2_5 or l_2_5 < 0 then
		l_2_5 = 0
	end
	return l_2_2, l_2_5 * l_2_1.damage_factor
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


