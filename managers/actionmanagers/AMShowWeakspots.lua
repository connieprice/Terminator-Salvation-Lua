require("shared/TableAlgorithms")
if not AMShowWeakspots then
	AMShowWeakspots = class(CoreActionElement)
end
AMShowWeakspots.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMShowWeakspots.activate_now = function(l_2_0)
	local l_2_12, l_2_13, l_2_14, l_2_15 = nil
	local l_2_5 = Application:debug
	local l_2_6 = Application
	l_2_5(l_2_6, "ShowWeakspots ACTIVATED: duration=", l_2_0.duration, "range=", l_2_0.range)
	l_2_5 = l_2_0.targets
	if l_2_5 then
		l_2_5, l_2_6 = l_2_0:_get_units_by_names, l_2_0
		l_2_5 = l_2_5(l_2_6, l_2_0.targets)
		local l_2_1 = nil
		l_2_6 = ipairs
		l_2_1 = l_2_5
		l_2_6 = l_2_6(l_2_1)
		for i_0,i_1 in l_2_6 do
			l_2_4:damage():set_show_weakspots(l_2_0.duration, l_2_0.range)
		end
		for i = 1, 2 do
			if managers.player_slot:slot(i) then
				local l_2_7 = managers.player_slot:slot(i):spawned_unit()
			if l_2_7 then
				end
				local l_2_8 = l_2_7:player_data().weakspot_unit_list
				for i_0,i_1 in ipairs(l_2_5) do
					table.insert(l_2_8, i_1)
				end
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	l_2_5(l_2_0)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AMShowWeakspots._get_units_by_names = function(l_3_0, l_3_1)
	local l_3_6, l_3_7, l_3_8, l_3_9 = nil
	local l_3_2 = {}
	for i_0,i_1 in pairs(l_3_1) do
		table.insert(l_3_2, managers.unit_scripting:get_unit_by_name(i_1.script_name))
	end
	return l_3_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


