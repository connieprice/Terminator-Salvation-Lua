if not WeaponMounting then
	WeaponMounting = class()
end
WeaponMounting.mount = function(l_1_0, l_1_1, l_1_2)
	local l_1_6, l_1_7, l_1_8, l_1_9, l_1_10, l_1_11, l_1_12, l_1_13 = nil
	for i_0,i_1 in pairs(l_1_2) do
		if l_1_15.unit_link then
			l_1_0:link(i_1.character_object_name, l_1_1, i_1.weapon_object_name)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			local l_1_16 = nil
			assert(l_1_1:get_object(i_1.weapon_object_name))
			l_1_1:get_object(i_1.weapon_object_name):set_local_position(Vector3())
			l_1_1:get_object(i_1.weapon_object_name):set_local_rotation(Rotation())
			local l_1_17 = nil
			assert(l_1_0:get_object(l_1_16))
			l_1_1:get_object(i_1.weapon_object_name):link(l_1_0:get_object(l_1_16))
		end
	end
end


