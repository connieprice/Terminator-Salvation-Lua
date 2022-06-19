if not TargetingInfo then
	TargetingInfo = class()
end
TargetingInfo.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	assert(l_1_0.default)
	l_1_0._default_objects = l_1_0:_get_objects(l_1_0.default)
end

TargetingInfo.is_visible = function(l_2_0, l_2_1, l_2_2)
	return l_2_0:_target_object(l_2_1, l_2_2, l_2_0._default_objects) ~= nil
end

TargetingInfo.target_position = function(l_3_0, l_3_1, l_3_2, l_3_3)
	local l_3_7 = l_3_0:_target_object
	local l_3_8 = l_3_0
	local l_3_9 = l_3_1
	l_3_7 = l_3_7(l_3_8, l_3_9, l_3_2, l_3_0._default_objects, l_3_3)
	local l_3_4 = nil
	if not l_3_7 then
		l_3_8 = nil
		return l_3_8
	end
	l_3_8, l_3_9 = l_3_7:position, l_3_7
	local l_3_5, l_3_6 = nil
	return l_3_8(l_3_9)
end

TargetingInfo.primary_target_position = function(l_4_0)
	local l_4_1 = l_4_0._default_objects[1]
	local l_4_2, l_4_3 = l_4_1:position, l_4_1
	return l_4_2(l_4_3)
end

TargetingInfo.target_objects = function(l_5_0)
	return l_5_0._default_objects
end

TargetingInfo._get_objects = function(l_6_0, l_6_1)
	local l_6_6, l_6_7, l_6_8, l_6_9 = nil
	local l_6_2 = {}
	for i_0,i_1 in ipairs(l_6_1) do
		assert(l_6_0._unit:get_object(i_1), "Unit '" .. l_6_0._unit:name() .. "' has no object named '" .. i_1 .. "'")
		table.insert(l_6_2, l_6_0._unit:get_object(i_1))
	end
	return l_6_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

TargetingInfo._target_object = function(l_7_0, l_7_1, l_7_2, l_7_3, l_7_4)
	local l_7_8, l_7_9, l_7_10, l_7_11 = nil
	for i_0,i_1 in ipairs(l_7_3) do
		if not l_7_0:_raycast(l_7_1, i_1, l_7_2, l_7_4) then
			return i_1
		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

TargetingInfo._raycast = function(l_8_0, l_8_1, l_8_2, l_8_3, l_8_4)
	if l_8_4 then
		local l_8_5, l_8_6 = l_8_0._unit:raycast, l_8_0._unit
		local l_8_7 = "ray"
		local l_8_8 = l_8_1
		local l_8_9 = l_8_2:position()
		local l_8_10 = "slot_mask"
		local l_8_11 = l_8_3
		local l_8_12, l_8_21 = "ignore_unit"
		l_8_21 = l_8_4
		local l_8_13, l_8_22 = nil
		return l_8_5(l_8_6, l_8_7, l_8_8, l_8_9, l_8_10, l_8_11, l_8_12, l_8_21)
	end
	local l_8_14, l_8_15 = l_8_0._unit:raycast, l_8_0._unit
	local l_8_16 = "ray"
	local l_8_17 = l_8_1
	local l_8_18 = l_8_2:position()
	local l_8_19 = "slot_mask"
	local l_8_20 = l_8_3
	return l_8_14(l_8_15, l_8_16, l_8_17, l_8_18, l_8_19, l_8_20)
end


