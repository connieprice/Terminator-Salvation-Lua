if not RailPath then
	RailPath = class()
end
RailPath.init = function(l_1_0, l_1_1)
	l_1_0._rem = {}
	l_1_0._users = {}
end

RailPath.set = function(l_2_0, l_2_1)
	local l_2_5, l_2_6 = nil
	l_2_0._path = {}
	for i_0,i_1 in ipairs(l_2_1) do
		local l_2_9 = table.insert
		l_2_9(l_2_0._path, {position = l_2_8, rotation = Rotation(0, 0, 0)})
	end
end

RailPath.get = function(l_3_0, l_3_1, l_3_2)
	if l_3_1 ~= nil and l_3_2 ~= nil then
		local l_3_3 = {}
		local l_3_4 = l_3_2
		for l_3_8 = l_3_1, #l_3_0._path - 1 do
			l_3_4 = Vector3.rotate_with(l_3_2, Rotation:look_at(l_3_0._path[l_3_8].position, l_3_0._path[l_3_8 + 1].position, math.UP))
			local l_3_9 = table.insert
			local l_3_10 = l_3_3
			local l_3_11 = {}
			l_3_11.position = l_3_0._path[l_3_8].position + l_3_4
			l_3_11.rotation = Rotation(0, 0, 0)
			l_3_9(l_3_10, l_3_11)
		end
		local l_3_12 = table.insert
		local l_3_13 = l_3_3
		local l_3_14 = {}
		l_3_14.position = l_3_0._path[#l_3_0._path].position + l_3_4
		l_3_14.rotation = Rotation(0, 0, 0)
		l_3_12(l_3_13, l_3_14)
		return l_3_3
	end
	return l_3_0._path
end

RailPath.get2 = function(l_4_0, l_4_1, l_4_2)
	if l_4_1 ~= nil and l_4_2 ~= nil then
		local l_4_3 = {}
		local l_4_4 = l_4_2
		for l_4_8 = l_4_1, #l_4_0._path - 1 do
			l_4_4 = Vector3.rotate_with(l_4_2, Rotation:look_at(l_4_0._path[l_4_8].position, l_4_0._path[l_4_8 + 1].position, math.UP))
			table.insert(l_4_3, l_4_0._path[l_4_8].position + l_4_4)
		end
		table.insert(l_4_3, l_4_0._path[#l_4_0._path].position)
		return l_4_3
	end
	return l_4_0._path
end

RailPath.add_user = function(l_5_0, l_5_1)
	l_5_0._users[l_5_1] = true
end

RailPath.despawn_users = function(l_6_0)
	local l_6_4, l_6_5, l_6_6, l_6_7 = nil
	for i_0,i_1 in pairs(l_6_0._users) do
		if alive(i_0) then
			i_0:damage():set_fully_damaged()
		end
	end
	l_6_0._users = {}
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RailPath.update = function(l_7_0)
	if tweak_data.rail.PATH_DEBUG == true then
		l_7_0:draw()
	end
end

RailPath.remember = function(l_8_0, l_8_1, l_8_2, l_8_3)
	if l_8_0._rem[l_8_1] == nil then
		l_8_0._rem[l_8_1] = {}
	end
	local l_8_4 = {}
	l_8_4.pos = l_8_2
	l_8_4.start_pos = l_8_3
	table.insert(l_8_0._rem[l_8_1], l_8_4)
end

RailPath.draw = function(l_9_0)
	local l_9_6, l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_12, l_9_13, l_9_14, l_9_15 = nil
	local l_9_1 = Draw:pen()
	l_9_1:set("green")
	local l_9_2 = l_9_0._path[1]
	for i_0,i_1 in pairs(l_9_0._path) do
		local l_9_23, l_9_25, l_9_27, l_9_29, l_9_31 = l_9_1:line, l_9_1, i_1, l_9_2
		l_9_31 = 5
		local l_9_20, l_9_22, l_9_24, l_9_26, l_9_28, l_9_30, l_9_32 = nil
		l_9_23(l_9_25, l_9_27, l_9_29, l_9_31)
		l_9_2 = l_9_21
	end
	l_9_1:set("yellow")
	for i_0,i_1 in pairs(l_9_0._rem) do
		for i_0,i_1 in pairs(i_1) do
			do
				l_9_1:sphere(i_1.pos, 60, 5)
				l_9_1:sphere(i_1.start_pos, 30, 5)
				l_9_1:line(i_1.pos, i_1.start_pos)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RailPath.get_closest_point = function(l_10_0, l_10_1, l_10_2)
	local l_10_10, l_10_11, l_10_12, l_10_13 = nil
	l_10_2 = "flyer"
	local l_10_3 = 1
	local l_10_4 = 1000000
	local l_10_5 = 1
	local l_10_6 = nil
	for i_0,i_1 in pairs(l_10_0._path) do
		if mvector3.distance(l_10_1, i_1.position) < l_10_4 then
			l_10_4 = mvector3.distance(l_10_1, i_1.position)
			l_10_6 = i_1.position
			l_10_5 = l_10_14
		end
	end
	if l_10_6 == nil or l_10_2 then
		return l_10_6, l_10_5, l_10_4
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 26 
end


