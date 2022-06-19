if not SimpleRandomGenerator then
	SimpleRandomGenerator = class()
end
SimpleRandomGenerator.init = function(l_1_0, l_1_1)
	l_1_0._rand_number = l_1_1
end

SimpleRandomGenerator.rand = function(l_2_0)
	l_2_0._rand_number = ((l_2_0._rand_number + 1) * 75 - 1) % 65537
	return l_2_0._rand_number
end


