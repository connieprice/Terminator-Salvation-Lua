if not AMTeleport then
	AMTeleport = class(CoreActionElement)
end
AMTeleport.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMTeleport.activate_now = function(l_2_0)
	local l_2_5, l_2_6, l_2_7, l_2_8, l_2_9, l_2_10, l_2_11, l_2_12 = nil
	local l_2_1 = {}
	for i_0,i_1 in pairs(l_2_0.units) do
		table.insert(l_2_1, i_1.script_name)
	end
	table.sort(l_2_1)
	for i_0,i_1 in ipairs(l_2_0.locations) do
		if l_2_1[i_0] then
			if alive(managers.unit_scripting:get_unit_by_name(l_2_1[i_0])) then
				UnitSpawnUtility.warp_to(managers.unit_scripting:get_unit_by_name(l_2_1[i_0]), l_2_14.rotation, l_2_14.position)
			end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			Application:error("Unit " .. l_2_1[i_0] .. " not found!")
		end
	end
	l_2_0:deactivate_now()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


