core:module("CoreSongProject")
core:require_module("CoreKeywordArguments")
core:require_module("CoreClass")
local l_0_0 = CoreKeywordArguments.parse_kwargs
local l_0_1 = function(l_1_0)
	if l_1_0 ~= nil then
		local l_1_1 = l_1_0:parameters()
		local l_1_2 = function(l_2_0, l_2_1)
			local l_2_2 = rawget(l_2_0, l_2_1)
			local l_2_3 = assert
			l_2_3(l_2_2 ~= nil, "Attempt to index a non-existent key.")
			return l_2_2
    end
		local l_1_3 = setmetatable
		local l_1_4 = l_1_1
		local l_1_5 = {}
		l_1_5.__index = l_1_2
		l_1_3(l_1_4, l_1_5)
		return l_1_1
	end
end

end
 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

if not SongProject then
	 -- WARNING: undefined locals caused missing assignments!
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 26 

