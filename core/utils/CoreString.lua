core:module("CoreString")
string.begins = function(l_1_0, l_1_1)
	if l_1_0:sub(1, #l_1_1) ~= l_1_1 then
		return not l_1_0 or not l_1_1
	end
	return false
end

string.ends = function(l_2_0, l_2_1)
	if #l_2_1 ~= 0 and l_2_0:sub(-#l_2_1) ~= l_2_1 then
		return not l_2_0 or not l_2_1
	end
	return false
end

string.case_insensitive_compare = function(l_3_0, l_3_1)
	return string.lower(l_3_0) < string.lower(l_3_1)
end

string.split = function(l_4_0, l_4_1, l_4_2, l_4_3)
	local l_4_11, l_4_12, l_4_13, l_4_14 = nil
	local l_4_4 = {}
	local l_4_5 = "(.-)" .. l_4_1 .. "()"
	local l_4_6 = 0
	local l_4_7 = 0
	for i_0,i_1 in string.gmatch(l_4_0, l_4_5) do
		l_4_7 = i_1
		if l_4_2 or i_0 ~= "" then
			l_4_6 = l_4_6 + 1
			l_4_4[l_4_6] = i_0
	else
		if l_4_6 == l_4_3 then
			end
		end
		l_4_4[l_4_6 + 1] = (l_4_2 or string.sub(l_4_0, l_4_7) ~= "") and string.sub(l_4_0, l_4_7) or nil
		return l_4_4
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 24 
end

string.join = function(l_5_0, l_5_1, l_5_2)
	local l_5_3 = table.collect(l_5_1, function(l_6_0)
		-- upvalues: l_5_2
		local l_6_1 = tostring(l_6_0)
		if l_6_1 ~= "" or l_5_2 then
			return l_6_1
		end
  end)
	local l_5_4 = table.concat
	local l_5_5 = l_5_3
	local l_5_6 = l_5_0
	return l_5_4(l_5_5, l_5_6)
end

string.trim = function(l_6_0, l_6_1)
	if not l_6_1 then
		l_6_1 = "%s*"
	end
	local l_6_2 = string.match
	local l_6_3 = l_6_0
	local l_6_5 = "^"
	local l_6_6 = l_6_1
	local l_6_7 = "(.-)"
	local l_6_8 = l_6_1
	l_6_5 = l_6_5 .. l_6_6 .. l_6_7 .. l_6_8 .. "$"
	local l_6_4 = nil
	return l_6_2(l_6_3, l_6_5)
end

string.capitalize = function(l_7_0)
	local l_7_1 = string.gsub
	local l_7_2 = l_7_0
	local l_7_3 = "(%w)(%w*)"
	local l_7_4 = function(l_8_0, l_8_1)
		return string.upper(l_8_0) .. string.lower(l_8_1)
  end
	return l_7_1(l_7_2, l_7_3, l_7_4)
end

string.pretty = function(l_8_0, l_8_1)
	local l_8_2 = string.gsub(l_8_0, "%W", " ")
	return l_8_1 and string.capitalize(l_8_2) or l_8_2
end

string.rep = function(l_9_0, l_9_1)
	local l_9_2 = ""
	for l_9_6 = 1, l_9_1 do
		l_9_2 = l_9_2 .. l_9_0
	end
	return l_9_2
end

string.left = function(l_10_0, l_10_1)
	return l_10_0 .. " ":rep(l_10_1 - l_10_0:len())
end


