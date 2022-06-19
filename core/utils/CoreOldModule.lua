core:module("CoreOldModule")
base_is_required = function(l_1_0)
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_1_0 ~= "RELEASE" and (l_1_0 ~= "NETWORK" or not Network:multiplayer()) and l_1_0 == "DEBUG" and not Application:ews_enabled() and not Application:editor() then
		local l_1_1 = Application:debug_build()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_1_1
end

base_require = function(l_2_0, l_2_1, l_2_2)
	if base_is_required(l_2_2) then
		if l_2_1 then
			require(l_2_0 .. "_" .. l_2_1)
		end
	else
		require(l_2_0)
	end
end

get_core_or_local = function(l_3_0)
	if not rawget(_G, l_3_0) then
		return rawget(_G, "Core" .. l_3_0)
	end
end

core_or_local = function(l_4_0, ...)
	do
		if get_core_or_local(l_4_0) then
			return get_core_or_local(l_4_0):new(...)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

core_prepare_full_load = function(l_5_0, l_5_1)
	if l_5_1 and l_5_1.prepare_full_load then
		l_5_1:prepare_full_load(l_5_0)
	end
	return l_5_0
end


