if not WeaponLogicFactory then
	WeaponLogicFactory = class()
end
WeaponLogicFactory.create_weapon_logic = function(l_1_0, l_1_1, l_1_2)
	local l_1_3 = l_1_0.class_name
	local l_1_4 = assert
	do
		l_1_4(not l_1_3 or l_1_3 ~= "")
		l_1_4 = rawget
		l_1_4 = l_1_4(_G, l_1_3)
		assert(l_1_4, "Weapon logic class named '" .. l_1_3 .. "' doesn't exist")
		return l_1_4:new(l_1_1, l_1_2, WeaponLogicFactory._create_setup(l_1_0.setup))
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

WeaponLogicFactory._create_setup = function(l_2_0)
	if not l_2_0 then
		return 
	end
	local l_2_1 = l_2_0.class_name
	local l_2_2 = assert
	l_2_2(not l_2_1 or l_2_1 ~= "")
	l_2_2 = rawget
	l_2_2 = l_2_2(_G, l_2_1)
	assert(l_2_2, "Weapon logic setup class named '" .. l_2_1 .. "' doesn't exist")
	do
		local l_2_4 = l_2_0.parameters
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_2_4 then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		return nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


