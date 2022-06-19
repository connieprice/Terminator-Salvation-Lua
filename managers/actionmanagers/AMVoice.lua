if not AMVoice then
	AMVoice = class(CoreActionElement)
end
AMVoice.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMVoice.activate_now = function(l_2_0)
	local l_2_5, l_2_6, l_2_7, l_2_8 = nil
	local l_2_1 = {}
	for i_0,i_1 in pairs(l_2_0.units) do
		if alive(managers.unit_scripting:get_unit_by_name(i_1.script_name)) then
			managers.unit_scripting:get_unit_by_name(i_1.script_name):drama():say(l_2_0.voice_lines[i_1.type_name].voice_line_id)
		else
			Application:error("Unit " .. unit_name .. " not found!")
		end
	end
	l_2_0:deactivate_now()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


