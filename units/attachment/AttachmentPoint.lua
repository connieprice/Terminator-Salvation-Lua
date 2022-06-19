if not AttachmentPoint then
	AttachmentPoint = class()
end
AttachmentPoint.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._unit = l_1_1
	l_1_0._name = l_1_2
	l_1_0._object = l_1_3
	l_1_0._attached_units = {}
end

AttachmentPoint.destroy = function(l_2_0)
	local l_2_4, l_2_5, l_2_6, l_2_7, l_2_8, l_2_9 = nil
	for i_0,i_1 in pairs(l_2_0._attached_units) do
		if alive(i_1) and i_1:attachment() then
			i_1:attachment():detached_from_unit(l_2_0._unit)
		end
	end
end

AttachmentPoint.valid = function(l_3_0)
	local l_3_1 = alive
	local l_3_2 = l_3_0._unit
	return l_3_1(l_3_2)
end

AttachmentPoint.name = function(l_4_0)
	return l_4_0._name
end

AttachmentPoint.position = function(l_5_0)
	local l_5_1, l_5_2 = l_5_0._object:position, l_5_0._object
	return l_5_1(l_5_2)
end

AttachmentPoint.rotation = function(l_6_0)
	local l_6_1, l_6_2 = l_6_0._object:rotation, l_6_0._object
	return l_6_1(l_6_2)
end

AttachmentPoint.attach_unit = function(l_7_0, l_7_1, l_7_2)
	assert(l_7_1:get_object(l_7_2))
	local l_7_3 = assert
	l_7_3(TableAlgorithms.count_if(l_7_0._attached_units, function(l_8_0)
		-- upvalues: l_7_1
		return l_8_0 == l_7_1
  end) == 0)
	l_7_3 = l_7_0._unit
	l_7_3(l_7_3, l_7_0._object:name(), l_7_1, l_7_2)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_3(l_7_0._attached_units, l_7_1)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_7_3 then
		l_7_3:attached_to_unit(l_7_0._unit)
	end
end

AttachmentPoint.detach_unit = function(l_8_0, l_8_1)
	local l_8_2 = assert
	l_8_2(TableAlgorithms.count_if(l_8_0._attached_units, function(l_9_0)
		-- upvalues: l_8_1
		return l_9_0 == l_8_1
  end) == 1)
	l_8_2 = TableAlgorithms
	l_8_2 = l_8_2.remove_if
	l_8_2(l_8_0._attached_units, function(l_10_0)
		-- upvalues: l_8_1
		return l_10_0 == l_8_1
  end)
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_8_2 then
		l_8_2:detached_from_unit(l_8_0._unit)
	end
end

AttachmentPoint.attached_units = function(l_9_0)
	return l_9_0._attached_units
end


