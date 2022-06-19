if not CoreCutsceneKeyCollection then
	CoreCutsceneKeyCollection = class()
end
CoreCutsceneKeyCollection.keys = function(l_1_0, l_1_1)
	local l_1_2, l_1_3 = l_1_0:keys_between, l_1_0
	local l_1_4 = -1
	local l_1_5 = math.huge
	local l_1_6 = l_1_1
	return l_1_2(l_1_3, l_1_4, l_1_5, l_1_6)
end

CoreCutsceneKeyCollection.keys_between = function(l_2_0, l_2_1, l_2_2, l_2_3)
	if l_2_1 == l_2_2 then
		return function()
  end
	end
	local l_2_4 = l_2_0:_all_keys_sorted_by_time()
	if l_2_1 < l_2_2 then
		return function()
		-- upvalues: l_2_5 , l_2_6 , l_2_4 , l_2_1 , l_2_2 , l_2_3
		while 1 do
			while 1 do
				if l_2_5 < l_2_6 then
					l_2_5 = l_2_5 + 1
					local l_4_0 = l_2_4[l_2_5]
				if l_4_0 then
					if l_2_1 < l_4_0:time() then
						if l_4_0:time() <= l_2_2 then
							end
							if l_2_3 == nil or l_2_3 == l_4_0.ELEMENT_NAME then
								return l_4_0
							end
						end
					end
				end
				do break end
			end
			 -- WARNING: missing end command somewhere! Added here
		end
  end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		return function()
		-- upvalues: l_2_5 , l_2_4 , l_2_1 , l_2_2 , l_2_3
		while 1 do
			while 1 do
				if l_2_5 > 1 then
					l_2_5 = l_2_5 - 1
					local l_5_0 = l_2_4[l_2_5]
				if l_5_0 then
					if l_5_0:time() <= l_2_1 then
						if l_2_2 < l_5_0:time() then
							end
							if l_2_3 == nil or l_2_3 == l_5_0.ELEMENT_NAME then
								return l_5_0
							end
						end
					end
				end
				do break end
			end
			 -- WARNING: missing end command somewhere! Added here
		end
  end
	end
	 -- WARNING: undefined locals caused missing assignments!
end

CoreCutsceneKeyCollection.keys_to_update = function(l_3_0, l_3_1, l_3_2)
	do
		local l_3_3 = l_3_0:_all_keys_sorted_by_time()
		return function()
		-- upvalues: l_3_4 , l_3_5 , l_3_3 , l_3_1 , l_3_2
		while 1 do
			while 1 do
				if l_3_4 < l_3_5 then
					l_3_4 = l_3_4 + 1
					local l_4_0 = l_3_3[l_3_4]
				if l_3_1 < l_4_0:time() then
					end
					do return end
				end
			end
			if (l_3_2 == nil or l_3_2 ~= l_4_0.ELEMENT_NAME) or type(l_4_0.update) == "function" then
				return l_4_0
			end
		end
  end
	end
	 -- WARNING: undefined locals caused missing assignments!
end

CoreCutsceneKeyCollection.first_key = function(l_4_0, l_4_1, l_4_2, l_4_3)
	local l_4_7, l_4_8 = ipairs, l_4_0:_all_keys_sorted_by_time()
	do
		l_4_7 = l_4_7(l_4_8)
		for i_0,i_1 in l_4_7 do
			if l_4_1 <= l_4_6:time() and (l_4_2 == nil or l_4_2 == l_4_6.ELEMENT_NAME) and (l_4_3 == nil or table.true_for_all(l_4_3, function(l_5_0, l_5_1)
				-- upvalues: l_4_8
				return l_4_8[l_5_1](l_4_8) == l_5_0
      end)) then
				return l_4_6, l_4_5
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreCutsceneKeyCollection.last_key_before = function(l_5_0, l_5_1, l_5_2, l_5_3)
	local l_5_4 = nil
	local l_5_7, l_5_8 = ipairs, l_5_0:_all_keys_sorted_by_time()
	do
		l_5_7 = l_5_7(l_5_8)
		for i_0,i_1 in l_5_7 do
			if l_5_1 <= i_1:time() then
				do return end
			end
			if (l_5_2 == nil or l_5_2 == i_1.ELEMENT_NAME) and (l_5_3 == nil or table.true_for_all(l_5_3, function(l_6_0, l_6_1)
				-- upvalues: l_5_9
				return l_5_9[l_6_1](l_5_9) == l_6_0
      end)) then
				l_5_4 = i_1
			end
		end
		return l_5_4
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end


