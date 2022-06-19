require("shared/scheduler/Operation")
if not RaycastOperation then
	RaycastOperation = class(Operation)
end
RaycastOperation.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	local l_1_4 = assert
	l_1_4(#l_1_1 >= 2)
	l_1_0._positions = l_1_1
	l_1_0._slot_mask = l_1_2
	l_1_0._ignore_units = l_1_3
	l_1_0.ray = nil
end

RaycastOperation.start = function(l_2_0)
	local l_2_1, l_2_4, l_2_5, l_2_6, l_2_7, l_2_9, l_2_10 = nil
	for i_0,i_1 in ipairs(l_2_0._positions) do
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_2_1 then
			if l_2_0._ignore_units then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Confused about usage of registers!

		if nil then
			end
			l_2_0.ray = nil
			return 
		end
		l_2_1 = i_1
	end
end

RaycastOperation.update = function(l_3_0, l_3_1)
end

RaycastOperation.done = function(l_4_0)
	return true
end


