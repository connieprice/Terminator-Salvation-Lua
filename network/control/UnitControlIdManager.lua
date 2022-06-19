if not UnitControlIdManager then
	UnitControlIdManager = class()
end
UnitControlIdManager.init = function(l_1_0)
	l_1_0._id_to_unit = {}
	l_1_0._unit_to_id = {}
end

UnitControlIdManager.get_free_id = function(l_2_0, l_2_1)
	for l_2_5 = 1, 1024 do
		if l_2_0._id_to_unit[l_2_5] == nil then
			l_2_0._id_to_unit[l_2_5] = l_2_1
			return l_2_5
		end
	end
	error("out of id")
end

UnitControlIdManager.free_unit_id = function(l_3_0, l_3_1)
	local l_3_2 = l_3_0._unit_to_id[l_3_1:key()]
	assert(l_3_2)
	l_3_0._unit_to_id[l_3_1:key()] = nil
	l_3_0._id_to_unit[l_3_2] = nil
end

UnitControlIdManager.clear_unit_id_association = function(l_4_0)
	l_4_0._unit_to_id = {}
	l_4_0._id_to_unit = {}
end

UnitControlIdManager.associate_unit_with_id = function(l_5_0, l_5_1, l_5_2)
	l_5_0._unit_to_id[l_5_1:key()] = l_5_2
	l_5_0._id_to_unit[l_5_2] = l_5_1
end

UnitControlIdManager.get_unit_id = function(l_6_0, l_6_1)
	if l_6_0._unit_to_id[l_6_1:key()] == nil then
		if l_6_0._next_unit_id then
			local l_6_2, l_6_3, l_6_4, l_6_5, l_6_6, l_6_7 = l_6_0._next_unit_id
			l_6_0._next_unit_id = nil
		else
			l_6_0:associate_unit_with_id(l_6_1, l_6_0:get_free_id())
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		assert(l_6_0:get_free_id())
		 -- DECOMPILER ERROR: Confused about usage of registers!

		return l_6_0:get_free_id()
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 16 
end

UnitControlIdManager.unit_from_id = function(l_7_0, l_7_1)
	return l_7_0._id_to_unit[l_7_1]
end


