if not PostUpdateManager then
	PostUpdateManager = class()
end
PostUpdateManager.init = function(l_1_0)
	l_1_0._extensions = {}
end

PostUpdateManager.register = function(l_2_0, l_2_1, l_2_2)
	local l_2_3 = table.insert
	local l_2_4 = l_2_0._extensions
	local l_2_5 = {}
	l_2_5._unit = l_2_1
	l_2_5._extension = l_2_2
	l_2_3(l_2_4, l_2_5)
end

PostUpdateManager.update = function(l_3_0)
	local l_3_1, l_3_2 = nil, nil
	l_3_1 = next(l_3_0._extensions, l_3_1)
	while 1 do
		while 1 do
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_3_1 then
				if alive(l_3_2._unit) then
					l_3_2._extension:post_update()
				end
				l_3_0._extensions[l_3_1] = nil
			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end


