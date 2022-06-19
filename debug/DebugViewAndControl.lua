local l_0_0 = function()
	assert(managers.user_viewport)
	local l_1_0, l_1_1 = next((managers.user_viewport:viewports()), nil)
	return l_1_0, l_1_1
end

control_unit = function(l_2_0)
	-- upvalues: l_0_0
	local l_2_1 = l_0_0()
	assert(l_2_1)
	l_2_1:control_unit(l_2_0)
end

view_unit = function(l_3_0)
	-- upvalues: l_0_0
	local l_3_1, l_3_2 = l_0_0()
	assert(l_3_2)
	l_3_2:view_unit(l_3_0)
end

reset_view_and_control = function()
	-- upvalues: l_0_0
	local l_4_0, l_4_1 = l_0_0()
	assert(l_4_0)
	assert(l_4_1)
	local l_4_2 = l_4_0:assigned_unit()
	l_4_0:control_unit(l_4_2)
	l_4_1:view_unit(l_4_2)
end

select_character = function()
	-- upvalues: l_0_0
	local l_5_17, l_5_18, l_5_19, l_5_20 = nil
	local l_5_0 = 10
	local l_5_1, l_5_2 = l_0_0()
	assert(l_5_2)
	local l_5_3 = l_5_2:engine_camera()
	assert(l_5_3)
	local l_5_4 = l_5_3:position()
	local l_5_5 = l_5_3:new_rotation():y()
	local l_5_6 = l_5_3:far_range()
	local l_5_7 = managers.slot:get_mask("players", "friends", "enemies")
	local l_5_8 = l_5_2:viewed_unit()
	local l_5_9 = math.sin(l_5_0) * l_5_6
	local l_5_16 = World:find_units
	l_5_16 = (l_5_16(World, "cone", l_5_4, l_5_4 + l_5_6 * l_5_5, l_5_9, l_5_7))
	local l_5_10 = nil
	local l_5_11, l_5_12 = nil
	l_5_12 = pairs
	l_5_12 = l_5_12(l_5_16)
	for i_0,i_1 in l_5_12 do
		if i_1 ~= l_5_8 then
			local l_5_22 = nil
			 -- DECOMPILER ERROR: Overwrote pending register.

		if not l_5_11 or i_1:position() - l_5_4:length() < l_5_11 then
			end
			l_5_11 = i_1:position() - l_5_4:length()
		end
	end
	return l_5_10
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


