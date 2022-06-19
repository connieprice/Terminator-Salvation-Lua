if not PhysicsModifier then
	PhysicsModifier = class()
end
PhysicsModifier.init = function(l_1_0, l_1_1)
	l_1_0._acceleration = 0
	l_1_0._velocity = 0
	do
		l_1_0._value = l_1_1 or 0
		l_1_0._damping_constant = 0
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

PhysicsModifier.set_acceleration = function(l_2_0, l_2_1)
	l_2_0._acceleration = l_2_1
	l_2_0._velocity_limit = 0
end

PhysicsModifier.set_velocity_limit = function(l_3_0, l_3_1)
	l_3_0._velocity_limit = l_3_1
end

PhysicsModifier.set_spring = function(l_4_0, l_4_1, l_4_2, l_4_3)
	l_4_0._length = l_4_1
	l_4_0._position = l_4_2
	l_4_0._spring_constant = l_4_3
end

PhysicsModifier.set_damper = function(l_5_0, l_5_1, l_5_2)
	l_5_0._damping_constant = l_5_1
	if l_5_2 then
		l_5_0._spring_damping_constant = l_5_2
	else
		l_5_0._spring_damping_constant = l_5_1
	end
end

PhysicsModifier.update = function(l_6_0, l_6_1)
	local l_6_2 = nil
	if l_6_0._length < math.abs(l_6_0._value - l_6_0._position) then
		local l_6_3 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_6_3 > 0 then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_6_2 = l_6_0._acceleration + -(l_6_0._value - nil) * l_6_0._spring_constant - l_6_0._spring_damping_constant * l_6_0._velocity
	else
		l_6_2 = l_6_0._acceleration - l_6_0._damping_constant * l_6_0._velocity
	end
	l_6_0._velocity = l_6_0._velocity + (l_6_2) * l_6_1
	l_6_0._velocity = math.clamp(l_6_0._velocity, -l_6_0._velocity_limit, l_6_0._velocity_limit)
	l_6_0._value = l_6_0._value + l_6_0._velocity * l_6_1
end

PhysicsModifier.value = function(l_7_0)
	return l_7_0._value
end

PhysicsModifier.velocity = function(l_8_0)
	return l_8_0._velocity
end


