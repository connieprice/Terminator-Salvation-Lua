core:module("CoreClass")
__class_names = {}
class = function(...)
	local l_1_1 = ...
	if select("#", ...) >= 1 and l_1_1 == nil then
		error("trying to inherit from nil", 2)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	{super = l_1_1}.__index = {super = l_1_1}
	 -- DECOMPILER ERROR: Confused about usage of registers!

	setmetatable({super = l_1_1}, l_1_1)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	{super = l_1_1}.new = function(l_2_0, ...)
		-- upvalues: l_1_2
		setmetatable({}, l_1_2)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if ({}).init then
			return {}, {}:init(...)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		return {}
  end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return {super = l_1_1}
end

class_name = function(l_2_0)
	local l_2_4, l_2_5 = nil
	if not __class_names[l_2_0] then
		for i_0,i_1 in pairs(_G) do
			__class_names[i_1] = i_0
		end
	end
	return __class_names[l_2_0] or "table"
end

type_name = function(l_3_0)
	local l_3_1 = type(l_3_0)
	if l_3_1 == "userdata" and l_3_0.type_name then
		return l_3_0.type_name
	end
	return l_3_1
end

type_or_class_name = function(l_4_0)
	local l_4_1 = type_name(l_4_0)
	if l_4_1 == "table" then
		local l_4_2 = getmetatable(l_4_0)
	if l_4_2 then
		end
		l_4_1 = class_name(l_4_2)
	end
	return l_4_1
end

mixin = function(l_5_0, ...)
	local l_5_4, l_5_5, l_5_9, l_5_10 = ipairs, {}, ..., .end
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	l_5_4 = l_5_4(l_5_5)
	for l_5_10,i_1 in l_5_4 do
		local l_5_3 = nil
		l_5_3 = pairs
		l_5_3 = l_5_3(l_5_2)
		for i_0,i_1 in l_5_3 do
			if l_5_8 ~= "new" and l_5_8 ~= "__index" then
				rawset(l_5_0, l_5_8, i_1)
			end
		end
	end
	return l_5_0
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

mix = function(...)
	local l_6_1 = mixin
	local l_6_2 = {}
	return l_6_1(l_6_2, ...)
end

mixin_add = function(l_7_0, ...)
	local l_7_4, l_7_5, l_7_9, l_7_10 = ipairs, {}, ..., .end
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	l_7_4 = l_7_4(l_7_5)
	for l_7_10,i_1 in l_7_4 do
		local l_7_3 = nil
		l_7_3 = pairs
		l_7_3 = l_7_3(l_7_2)
		for i_0,i_1 in l_7_3 do
			table.insert(l_7_0, i_1)
		end
	end
	return l_7_0
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

mix_add = function(...)
	local l_8_1 = mixin_add
	local l_8_2 = {}
	return l_8_1(l_8_2, ...)
end

hijack_func = function(l_9_0, l_9_1, l_9_2)
	do
		local l_9_3, l_9_4, l_9_5, l_9_6, l_9_7, l_9_8 = getmetatable(l_9_0) or l_9_0
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_9_3 then
		Application:error("Can't hijack nil instance or class.")
	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif not l_9_3[l_9_1] then
		Application:error("Unable to hijack non-existing function \"" .. tostring(l_9_1) .. "\".")
	else
		local l_9_9 = nil
	if not l_9_9["hijacked_" .. l_9_1] then
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_9_9["hijacked_" .. l_9_1] = l_9_9[l_9_1]
		do
			if not l_9_2 then
				l_9_9[l_9_1] = function()
    end
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
end

unhijack_func = function(l_10_0, l_10_1)
	do
		local l_10_2, l_10_3, l_10_4 = getmetatable(l_10_0) or l_10_0
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_10_2 then
		Application:error("Can't unhijack nil instance or class.")
	else
		local l_10_5 = nil
		 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_10_5["hijacked_" .. l_10_1] then
		end
		l_10_5[l_10_1] = l_10_5["hijacked_" .. l_10_1]
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_10_5["hijacked_" .. l_10_1] = nil
	end
end

if not __frozen__newindex then
	__frozen__newindex = function(l_11_0, l_11_1, l_11_2)
	error(string.format("Attempt to set %s = %s in frozen %s.", tostring(l_11_1), tostring(l_11_2), type_or_class_name(l_11_0)))
end

end
freeze = function(...)
		local l_12_3, l_12_4 = ipairs, {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		for i_0,i_1 in l_12_3 do
			if not is_frozen(i_1) then
				if getmetatable(i_1) == nil then
					local l_12_6 = nil
					local l_12_7 = setmetatable
					local l_12_8 = l_12_5
					l_12_7(l_12_8, {__newindex = __frozen__newindex, __metatable = nil})
				end
			else
				local l_12_9 = nil
				local l_12_10 = setmetatable
				local l_12_11 = l_12_5
				l_12_10(l_12_11, {__index = l_12_9.__index, __newindex = __frozen__newindex, __metatable = l_12_9})
			end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		return l_12_3
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: undefined locals caused missing assignments!
  end
is_frozen = function(l_13_0)
	local l_13_1 = debug.getmetatable(l_13_0)
	do
		return not l_13_1 or l_13_1.__newindex == __frozen__newindex
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

frozen_class = function(...)
	do
		local l_14_1 = nil
		return l_14_1
	end
	 -- WARNING: undefined locals caused missing assignments!
end

responder = function(...)
	local l_15_2 = {...}
	local l_15_3 = function()
		-- upvalues: l_15_1
		local l_16_0 = unpack
		local l_16_1 = l_15_1
		return l_16_0(l_16_1)
  end
	local l_15_4 = setmetatable
	do
		return l_15_4({}, {__index = function()
		-- upvalues: l_15_2
		return l_15_2
  end})
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

responder_map = function(l_16_0)
	local l_16_5, l_16_6, l_16_7, l_16_8, l_16_9, l_16_13, l_16_14, l_16_15, l_16_16 = nil
	do
	end
	local l_16_1 = {}
	for i_0,i_1 in pairs(l_16_0) do
		do
			if i_0 == "default" then
				local l_16_12 = setmetatable
				l_16_12(l_16_1, {__index = function()
				-- upvalues: l_16_6
				return function()
					-- upvalues: l_16_6
					return l_16_6
        end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

      end})
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			l_16_1[l_16_10] = function()
			-- upvalues: l_16_6
			return l_16_6
    end
		end
	end
	return l_16_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

if not GetSet then
	GetSet = class()
end
GetSet.init = function(l_17_0, l_17_1)
	local l_17_5, l_17_6, l_17_7, l_17_8, l_17_9, l_17_10, l_17_11, l_17_12, l_17_13, l_17_14 = nil
	do
	end
	for i_0,i_1 in pairs(l_17_1) do
		l_17_0["_" .. i_0] = i_1
		l_17_0[i_0] = function(l_18_0)
			-- upvalues: l_17_5
			return l_18_0["_" .. l_17_5]
    end
		l_17_0["set_" .. i_0] = function(l_19_0, l_19_1)
			-- upvalues: l_17_5
			l_19_0["_" .. l_17_5] = l_19_1
    end
	end
end


