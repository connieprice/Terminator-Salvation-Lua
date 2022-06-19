if not BufferedDamage then
	BufferedDamage = class()
end
BufferedDamage.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._attack_unit = l_1_3
	l_1_0._damage = l_1_1
	l_1_0._direction = l_1_2
	l_1_0._read = false
end

BufferedDamage.equal = function(l_2_0, l_2_1, l_2_2)
	if l_2_2 ~= l_2_0._attack_unit then
		return false
	end
	if mvector3.dot(l_2_1, l_2_0._direction) < 0.9 then
		return false
	end
	return true
end

BufferedDamage.add_damage = function(l_3_0, l_3_1)
	l_3_0._damage = l_3_0._damage + l_3_1
end

BufferedDamage.direction = function(l_4_0)
	return l_4_0._direction
end

BufferedDamage.damage = function(l_5_0)
	return l_5_0._damage
end

BufferedDamage.read = function(l_6_0)
	return l_6_0._read
end

BufferedDamage.set_read = function(l_7_0)
	l_7_0._read = true
end


