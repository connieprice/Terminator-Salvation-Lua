if not CoreExpressionManager then
	CoreExpressionManager = class()
end
CoreExpressionManager.init = function(l_1_0)
	l_1_0._units = {}
	l_1_0._preloads = {}
end

CoreExpressionManager.update = function(l_2_0, l_2_1, l_2_2)
	local l_2_6, l_2_7, l_2_8, l_2_9 = nil
	for i_0,i_1 in pairs(l_2_0._units) do
		if not i_1:update(l_2_1, l_2_2) then
			l_2_0._units[i_0] = nil
		end
	end
end

CoreExpressionManager.preload = function(l_3_0, l_3_1)
	l_3_0._preloads[l_3_1] = Database:load_node(Database:lookup("expression", l_3_1))
end

CoreExpressionManager.play = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4)
	local l_4_5 = l_4_0._units
	local l_4_6 = l_4_1:key()
	l_4_5[l_4_6] = CoreExpressionMovie:new(l_4_1, l_4_2, l_4_3, l_4_0._preloads[l_4_3], l_4_4)
end

CoreExpressionManager.stop = function(l_5_0, l_5_1)
	l_5_0._units[l_5_1:key()] = nil
end

if not CoreExpressionMovie then
	CoreExpressionMovie = class()
end
CoreExpressionMovie.init = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4, l_6_5)
	l_6_0._ANIM_FPS = 30
	l_6_0._unit = l_6_1
	l_6_0._target = l_6_2
	l_6_0._t = 0
	l_6_0._frame = 1
	l_6_0._loop = l_6_5
	l_6_0._expressions = {}
	l_6_0:load_file(l_6_3, l_6_4)
	if not l_6_0._target then
		l_6_0._target = l_6_0._root_node:child(0):parameter("target")
	end
end

CoreExpressionMovie.create_node = function(l_7_0, l_7_1, l_7_2)
	local l_7_6, l_7_7 = pairs, l_7_2:parameter_map()
	l_7_6 = l_7_6(l_7_7)
	for i_0,i_1 in l_7_6 do
		l_7_1:set_parameter(l_7_4, l_7_5)
	end
	for i_0 in l_7_2:children() do
		l_7_0:create_node(l_7_1:make_child(i_0:name()), i_0)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreExpressionMovie.load_file = function(l_8_0, l_8_1, l_8_2)
	if l_8_2 then
		l_8_0._root_node = l_8_2
	else
		if Database:has("expression", l_8_1) then
			l_8_0._root_node = Database:load_node(Database:lookup("expression", l_8_1))
		end
	else
		local l_8_3 = File:new_parse_xml(l_8_1)
		l_8_0._root_node = Node(l_8_3:name())
		local l_8_8, l_8_9 = l_8_0:create_node, l_8_0
		l_8_8(l_8_9, l_8_0._root_node, l_8_3)
	end
	local l_8_4 = l_8_0._root_node:child(0)
	for i_0 in l_8_4:children() do
		table.insert(l_8_0._expressions, i_0:parameter("name"))
	end
	l_8_0._frame_node = l_8_0._root_node:child(1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreExpressionMovie.find_weight = function(l_9_0, l_9_1, l_9_2)
	local l_9_7, l_9_8, l_9_9 = nil
	local l_9_3 = l_9_0._frame_node:child(l_9_1)
	for i_0 in l_9_3:children() do
		if i_0:parameter("name") == l_9_2 then
			local l_9_11, l_9_12, l_9_13 = tonumber, l_9_10:parameter("weight"), .end
			return l_9_11(l_9_12, l_9_13)
		end
	end
	return 0
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreExpressionMovie.update = function(l_10_0, l_10_1, l_10_2)
	local l_10_9, l_10_10, l_10_12, l_10_14, l_10_16, l_10_18 = nil
	if not alive(l_10_0._unit) then
		return false
	else
		l_10_0._t = l_10_0._t + l_10_2
		while 1 / l_10_0._ANIM_FPS < l_10_0._t do
			l_10_0._t = l_10_0._t - 1 / l_10_0._ANIM_FPS
			l_10_0._frame = l_10_0._frame + 1
		end
		if l_10_0._frame_node:num_children() <= l_10_0._frame then
			if l_10_0._loop then
				l_10_0._frame = 1
				l_10_0._t = 0
			end
		else
			return false
		end
		local l_10_3 = {}
		local l_10_4 = {}
		local l_10_5 = l_10_0._frame_node:child(l_10_0._frame)
		for i_0 in l_10_5:children() do
			local l_10_13, l_10_15, l_10_17, l_10_19 = i_0:parameter("name")
			l_10_15 = table
			l_10_15 = l_10_15.insert
			l_10_17 = l_10_4
			l_10_19 = l_10_13
			l_10_15(l_10_17, l_10_19)
			l_10_15 = table
			l_10_15 = l_10_15.insert
			l_10_17 = l_10_3
			l_10_19 = math
			l_10_19 = l_10_19.lerp
			l_10_15(l_10_17, l_10_19)
		end
		if #l_10_3 < 3 then
			for i_0,i_1 in ipairs(l_10_0._expressions) do
				 -- DECOMPILER ERROR: Overwrote pending register.

				if not table.contains(l_10_4, l_10_19) then
					table.insert(l_10_3, 0)
					table.insert(l_10_4, i_1)
				if #l_10_3 > 2 then
					end
			else
				end
			end
		end
		if l_10_3[1] + l_10_3[2] + l_10_3[3] < 1 then
			l_10_3[1] = l_10_3[1] + (1 - (l_10_3[1] + l_10_3[2] + l_10_3[3])) / 3
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_10_3[2] = l_10_3[2] + (1 - (l_10_3[1] + l_10_3[2] + l_10_3[3])) / 3
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_10_3[3] = l_10_3[3] + (1 - (l_10_3[1] + l_10_3[2] + l_10_3[3])) / 3
		end
		l_10_0._unit:set_morph_target_expressions(l_10_0._target, l_10_4[1], l_10_3[1], l_10_4[2], l_10_3[2], l_10_4[3], l_10_3[3])
		return true
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end


