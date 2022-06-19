if not String then
	String = {}
end
String.split = function(l_1_0, l_1_1)
	local l_1_2 = {}
	if not l_1_1 then
		l_1_1 = "[ ]"
	end
	local l_1_3 = 1
	do
		while 1 do
			local l_1_4, l_1_5 = string.find(l_1_0, l_1_1, l_1_3)
			while l_1_4 do
				table.insert(l_1_2, string.sub(l_1_0, l_1_3, l_1_4 - 1))
				l_1_3 = l_1_5 + 1
				l_1_4 = string.find(l_1_0, l_1_1, l_1_3)
			end
			table.insert(l_1_2, string.sub(l_1_0, l_1_3))
			return l_1_2
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

String.strip = function(l_2_0)
	local l_2_1 = ""
	for l_2_5 = 1, #l_2_0 do
		local l_2_6 = string.sub(l_2_0, l_2_5, l_2_5)
		if string.byte(l_2_6) > 31 then
			l_2_1 = l_2_1 .. l_2_6
		end
	end
	return l_2_1
end


