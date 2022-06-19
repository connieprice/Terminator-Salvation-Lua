require("shared/TableAlgorithms")
if not AMLookAt then
	AMLookAt = class(CoreActionElement)
end
AMLookAt.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMLookAt.activate_now = function(l_2_0)
	local l_2_5, l_2_6, l_2_7, l_2_8, l_2_12, l_2_13, l_2_14, l_2_15, l_2_17, l_2_18, l_2_19, l_2_20 = nil
	local l_2_1 = managers.player:players()
	l_2_0.relative_fov = l_2_0.relative_fov or -20
	for i_0,i_1 in pairs(l_2_1) do
		if alive(i_1) then
			if l_2_0.units and TableAlgorithms.count(l_2_0.units) > 0 then
				for i_0,i_1 in pairs(l_2_0.units) do
					if alive(managers.unit_scripting:get_unit_by_name(i_1.script_name)) then
						l_2_10:drama():set_next_look_at_unit(managers.unit_scripting:get_unit_by_name(i_1.script_name), l_2_0.timer, l_2_0.relative_fov)
					end
				end
			end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			l_2_10:drama():set_next_look_at_position(l_2_0.position, l_2_0.timer, l_2_0.relative_fov)
		end
	end
	l_2_0:deactivate_now()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


