AMVoice = AMVoice or class(CoreActionElement)
function AMVoice.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMVoice.activate_now(A0_3)
	local L1_4, L2_5, L3_6, L4_7, L5_8, L6_9, L7_10
	L1_4 = {}
	for L5_8, L6_9 in L2_5(L3_6) do
		L7_10 = managers
		L7_10 = L7_10.unit_scripting
		L7_10 = L7_10.get_unit_by_name
		L7_10 = L7_10(L7_10, L6_9.script_name)
		if alive(L7_10) then
			L7_10:drama():say(A0_3.voice_lines[L6_9.type_name].voice_line_id)
		else
			Application:error("Unit " .. unit_name .. " not found!")
		end
	end
	L2_5(L3_6)
end
