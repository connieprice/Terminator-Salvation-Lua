require("units/beings/TargetingInfo")
if not RailPickupTargetingInfo then
	RailPickupTargetingInfo = class(TargetingInfo)
end
RailPickupTargetingInfo.init = function(l_1_0, l_1_1)
	TargetingInfo.init(l_1_0, l_1_1)
end

RailPickupTargetingInfo.primary_target_position = function(l_2_0)
	local l_2_3 = l_2_0._default_objects
	local l_2_4 = math.random
	l_2_4 = l_2_4(1, #l_2_0._default_objects)
	l_2_3 = l_2_3[l_2_4]
	l_2_3, l_2_4 = l_2_3:position, l_2_3
	local l_2_1, l_2_2 = nil
	return l_2_3(l_2_4)
end

RailPickupTargetingInfo._target_object = function(l_3_0, l_3_1, l_3_2, l_3_3)
	local l_3_7, l_3_8, l_3_9, l_3_10 = nil
	for i_0,i_1 in ipairs(l_3_3) do
		if not World:raycast("ray", l_3_1, i_1:position(), "slot_mask", l_3_2, "ignore_unit", l_3_0._unit) then
			return i_1
		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


