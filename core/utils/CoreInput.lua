core:module("CoreInput")
core:require_module("CoreClass")
shift = function()
	if not Input:keyboard():down("left shift") then
		return Input:keyboard():down("right shift")
	end
end

ctrl = function()
	if not Input:keyboard():down("left ctrl") then
		return Input:keyboard():down("right ctrl")
	end
end

alt = function()
	local l_3_0, l_3_1 = Input:keyboard():down, Input:keyboard()
	local l_3_2 = "left alt"
	return l_3_0(l_3_1, l_3_2)
end

if not RepKey then
	RepKey = CoreClass.class()
end
RepKey.init = function(l_4_0, l_4_1, l_4_2, l_4_3)
	do
		if not l_4_1 then
			l_4_0._keys = {}
		end
		l_4_0._current_time = 0
		l_4_0._current_rep_time = 0
		l_4_0._pause = l_4_2 or 0.5
		l_4_0._rep = l_4_3 or 0.1
		l_4_0._input = Input:keyboard()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RepKey.set_input = function(l_5_0, l_5_1)
	l_5_0._input = l_5_1
end

RepKey.update = function(l_6_0, l_6_1, l_6_2)
	local l_6_7, l_6_8 = nil
	local l_6_3 = false
	for i_0,i_1 in ipairs(l_6_0._keys) do
		if l_6_0._input:down(i_1) then
			l_6_3 = true
	else
		end
	end
	if l_6_3 then
		if l_6_0._current_time ~= 0 or l_6_0._pause <= l_6_0._current_time then
			if l_6_0._rep <= l_6_0._current_rep_time then
				do return end
			end
	else
		return false
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end


