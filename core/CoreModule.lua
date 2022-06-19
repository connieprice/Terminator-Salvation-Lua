local l_0_0 = 0
local l_0_1 = 1
local l_0_2 = {}
l_0_2.PRODUCTION_ONLY = "PRODUCTION_ONLY"
l_0_2.new = function(l_1_0)
	local l_1_1 = {}
	setmetatable(l_1_1, l_1_0)
	l_1_1:init()
	return l_1_1
end

l_0_2.init = function(l_2_0)
	local l_2_4, l_2_5 = nil
	l_2_0._core_modules = {}
	l_2_0._core_file_paths = {}
	l_2_0._core_meta_data = {}
	l_2_0._proj_modules = {}
	l_2_0._proj_file_paths = {}
	l_2_0._proj_meta_data = {}
	l_2_0._next_module_type = {}
	l_2_0._pristine_G = {}
	for i_0,i_1 in pairs(_G) do
		l_2_0._pristine_G[i_0] = i_1
	end
	l_2_0._pristine_G.core = l_2_0
	return l_2_0
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_2.register_core_module = function(l_3_0, l_3_1, l_3_2)
	local l_3_3 = l_3_0:_get_module_name(l_3_1)
	local l_3_4 = assert
	l_3_4(l_3_0._core_file_paths[l_3_3] == nil, "Core module already registered")
	l_3_4 = l_3_0._core_file_paths
	l_3_4[l_3_3] = l_3_1
	l_3_4 = l_3_0._core_meta_data
	l_3_4[l_3_3] = l_3_2
end

l_0_2.replace_core_module = function(l_4_0, l_4_1, l_4_2)
	local l_4_3 = l_4_0:_get_module_name(l_4_1)
	local l_4_4 = assert
	l_4_4(l_4_0._proj_file_paths[l_4_3] == nil, "Module already registered")
	l_4_4 = l_4_0._proj_file_paths
	l_4_4[l_4_3] = l_4_1
	l_4_4 = l_4_0._proj_meta_data
	l_4_4[l_4_3] = l_4_2
end

l_0_2.register_module = function(l_5_0, l_5_1, l_5_2)
	local l_5_3 = l_5_0:_get_module_name(l_5_1)
	local l_5_4 = assert
	l_5_4(l_5_0._core_file_paths[l_5_3] == nil, "Core module already registered")
	l_5_4 = assert
	l_5_4(l_5_0._proj_file_paths[l_5_3] == nil, "Module already registered")
	l_5_4 = l_5_0._proj_file_paths
	l_5_4[l_5_3] = l_5_1
	l_5_4 = l_5_0._proj_meta_data
	l_5_4[l_5_3] = l_5_2
end

l_0_2.require_core_module = function(l_6_0, l_6_1)
	-- upvalues: l_0_0
	local l_6_2 = assert(l_6_0._core_file_paths[l_6_1], "Module not registered")
	l_6_0._next_module_type[l_6_1] = l_0_0
	require(l_6_2)
	local l_6_3 = assert
	l_6_3(l_6_0._next_module_type[l_6_1] == nil, "Required module needs core:module(<module_name>)")
	l_6_3 = assert
	local l_6_6 = l_6_0._core_modules[l_6_1]
	local l_6_7 = "Module not required properly (declared with core:module(<module_name>)?)"
	return l_6_3(l_6_6, l_6_7)
end

l_0_2.require_module = function(l_7_0, l_7_1)
	-- upvalues: l_0_1 , l_0_0
	if l_7_0._proj_file_paths[l_7_1] ~= nil then
		local l_7_2 = assert
		l_7_2(l_7_0._next_module_type[l_7_1] == nil, "Module not required properly")
		l_7_2 = l_7_0._next_module_type
		l_7_2[l_7_1] = l_0_1
		l_7_2 = require
		l_7_2(l_7_0._proj_file_paths[l_7_1])
		l_7_2 = l_7_0._next_module_type
		l_7_2[l_7_1] = nil
		l_7_2 = rawset
		local l_7_7 = getfenv(2)
		l_7_2(l_7_7, l_7_1, l_7_0._proj_modules[l_7_1])
		l_7_2 = assert
		l_7_7 = l_7_0._proj_modules
		l_7_7 = l_7_7[l_7_1]
		local l_7_5 = nil
		l_7_5 = "Module not required properly (declared with core:module(<module_name>)?)"
		local l_7_6 = nil
		return l_7_2(l_7_7, l_7_5)
	else
		if l_7_0._core_file_paths[l_7_1] ~= nil then
			local l_7_8 = assert
			l_7_8(l_7_0._next_module_type[l_7_1] == nil, "Module not required properly")
			l_7_8 = l_7_0._next_module_type
			l_7_8[l_7_1] = l_0_0
			l_7_8 = require
			l_7_8(l_7_0._core_file_paths[l_7_1])
			l_7_8 = l_7_0._next_module_type
			l_7_8[l_7_1] = nil
			l_7_8 = rawset
			local l_7_13 = getfenv(2)
			l_7_8(l_7_13, l_7_1, l_7_0._core_modules[l_7_1])
			l_7_8 = assert
			l_7_13 = l_7_0._core_modules
			l_7_13 = l_7_13[l_7_1]
			local l_7_11 = nil
			l_7_11 = "Module not required properly (declared with core:module(<module_name>)?)"
			local l_7_12 = nil
			return l_7_8(l_7_13, l_7_11)
		end
	else
		error("Module not registred")
	end
end

l_0_2.module = function(l_8_0, l_8_1)
	-- upvalues: l_0_0 , l_0_1
	local l_8_2 = nil
	assert(l_8_0._next_module_type[l_8_1] ~= nil, "Module not required properly")
	if l_8_0._next_module_type[l_8_1] == l_0_0 then
		if not l_8_0._core_modules[l_8_1] then
			l_8_2 = {}
		end
		l_8_0._core_modules[l_8_1] = l_8_2
	else
		if l_8_0._next_module_type[l_8_1] == l_0_1 then
			if not l_8_0._proj_modules[l_8_1] then
				l_8_2 = {}
			end
			l_8_0._proj_modules[l_8_1] = l_8_2
		end
	end
	l_8_0._next_module_type[l_8_1] = nil
	l_8_2._M = l_8_2
	l_8_2._NAME = l_8_1
	local l_8_5 = setmetatable
	local l_8_6 = l_8_2
	l_8_5(l_8_6, {__index = l_8_0._pristine_G})
	l_8_5 = setfenv
	l_8_6 = 2
	l_8_5(l_8_6, l_8_2)
end

l_0_2.prepare_reload = function(l_9_0)
	l_9_0._core_file_paths = {}
	l_9_0._core_meta_data = {}
	l_9_0._proj_file_paths = {}
	l_9_0._proj_meta_data = {}
	l_9_0._next_module_type = {}
end

l_0_2.copy_module_to_global = function(l_10_0, l_10_1)
	local l_10_6, l_10_7, l_10_8, l_10_9, l_10_10 = nil
	local l_10_2 = l_10_0:require_module(l_10_1)
	for i_0,i_1 in pairs(l_10_2) do
		rawset(_G, i_0, i_1)
	end
end

l_0_2._get_module_name = function(l_11_0, l_11_1)
	local l_11_2 = assert
	l_11_2(type(l_11_1) == "string")
	l_11_2 = 1
	while 1 do
		local l_11_5 = string.find(l_11_1, "/", l_11_2, true)
		while l_11_5 do
			l_11_2 = l_11_5 + 1
			l_11_5 = string.find(l_11_1, "/", l_11_2, true)
		end
		local l_11_6 = string.sub(l_11_1, l_11_2)
		do
			local l_11_7 = assert
			l_11_7(l_11_6 ~= "", string.format("Malformed module_file_path '%s'", l_11_1))
			return l_11_6
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

if _G.core == nil then
	_G.core = l_0_2:init()
else
	_G.core:prepare_reload()
end

