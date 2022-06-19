dead = function(l_1_0)
	if not alive(l_1_0) then
		return true
	end
	local l_1_1, l_1_2 = l_1_0:damage_data():is_fully_damaged, l_1_0:damage_data()
	return l_1_1(l_1_2)
end


