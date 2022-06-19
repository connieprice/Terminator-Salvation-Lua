require("shared/SharedMath")
require("ai/common/NavigationGraphUtilities")
require("shared/SharedMath")
if not MovementPathUtilities then
	MovementPathUtilities = {}
end
MovementPathUtilities.should_recalculate_path = function(l_1_0, l_1_1)
	local l_1_2 = l_1_0:ai_data()
	if not l_1_2:path() then
		return true
	end
	if l_1_2:new_path_requested() then
		return true
	end
	if l_1_1 then
		if l_1_2._behavior.latest_target_position == nil then
			l_1_2._behavior.latest_target_position = l_1_1
			return true
		end
		local l_1_3 = mvector3.distance(l_1_2._behavior.latest_target_position, l_1_1)
		local l_1_4 = mvector3.distance(l_1_0:position(), l_1_1)
		local l_1_5 = l_1_3 / l_1_4
	if l_1_5 > 0.2 then
		end
		l_1_2._behavior.latest_target_position = l_1_1
		return true
	end
	local l_1_6 = l_1_2.input.moving_to_position
	if l_1_6 and not NavigationGraphUtilities.ai_check_can_move_there(l_1_0, l_1_6, nil, nil, true) then
		return true
	end
	return false
end

MovementPathUtilities.path_length = function(l_2_0, l_2_1)
	local l_2_7, l_2_8, l_2_9, l_2_10 = nil
	local l_2_2 = l_2_0
	local l_2_3 = 0
	for i_0,i_1 in ipairs(l_2_1) do
		l_2_3 = l_2_3 + mvector3.distance(i_1, l_2_2)
		l_2_2 = i_1
	end
	return l_2_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MovementPathUtilities.remaining_path = function(l_3_0)
	local l_3_1 = l_3_0:ai_data()
	local l_3_2 = l_3_1:path()
	if not l_3_2 or l_3_1:new_path_requested() then
		return nil
	end
	local l_3_3 = l_3_1.input.moving_to_position
	if not l_3_3 then
		return l_3_2
	end
	local l_3_4 = MovementPathUtilities.next_index(l_3_2, l_3_3)
	if l_3_4 == 1 then
		return l_3_2
	end
	local l_3_5 = {}
	for l_3_9 = l_3_4 + 1, #l_3_2 do
		table.insert(l_3_5, l_3_2[l_3_9])
	end
	if #l_3_5 == 0 then
		return nil
	end
	return l_3_5
end

MovementPathUtilities.has_arrived = function(l_4_0, l_4_1)
	local l_4_2 = 0.25 * l_4_0:oobb():size().y
	local l_4_3 = mvector3.distance(l_4_0:position(), l_4_1)
	return l_4_3 < l_4_2
end

MovementPathUtilities.next_index = function(l_5_0, l_5_1)
	local l_5_5, l_5_6, l_5_7 = nil
	for i_0,i_1 in pairs(l_5_0) do
		if l_5_1 == i_1 then
			return i_0
		end
	end
	return #l_5_0
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MovementPathUtilities.restrict_path = function(l_6_0, l_6_1, l_6_2, l_6_3)
	local l_6_4 = nil
	while #l_6_0 > 0 and not SharedMath.is_inside_sphere(l_6_0[#l_6_0], l_6_1, l_6_2) do
		l_6_4 = l_6_0[#l_6_0]
		table.remove(l_6_0)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_6_4 then
		if #l_6_0 > 0 then
			do return end
		end
		if not SharedMath.is_inside_sphere(l_6_3, l_6_1, l_6_2) then
			return nil
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_6_5 = nil
		assert(SharedMath.intersect_ray_sphere(l_6_1, l_6_2, l_6_4, nil))
		local l_6_6 = nil
		table.insert(l_6_0, math.lerp(l_6_4, l_6_5, SharedMath.intersect_ray_sphere(l_6_1, l_6_2, l_6_4, nil)))
	end
	return l_6_0
end


