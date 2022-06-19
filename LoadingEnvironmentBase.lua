if not class then
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

end
if not math.lerp then
	math.lerp = function(l_2_0, l_2_1, l_2_2)
	return l_2_0 * (1 - l_2_2) + l_2_1 * l_2_2
end

end

