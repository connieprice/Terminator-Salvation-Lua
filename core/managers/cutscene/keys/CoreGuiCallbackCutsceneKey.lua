require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
if not CoreGuiCallbackCutsceneKey then
	CoreGuiCallbackCutsceneKey = class(CoreCutsceneKeyBase)
end
CoreGuiCallbackCutsceneKey.ELEMENT_NAME = "gui_callback"
CoreGuiCallbackCutsceneKey.NAME = "Gui Callback"
CoreGuiCallbackCutsceneKey:register_serialized_attribute("name", "")
CoreGuiCallbackCutsceneKey:register_serialized_attribute("function_name", "")
CoreGuiCallbackCutsceneKey:register_serialized_attribute("enabled", true, toboolean)
CoreGuiCallbackCutsceneKey.control_for_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreGuiCallbackCutsceneKey.__tostring = function(l_1_0)
	return "Call " .. l_1_0:function_name() .. " in gui \"" .. l_1_0:name() .. "\"."
end

CoreGuiCallbackCutsceneKey.evaluate = function(l_2_0, l_2_1, l_2_2)
	if l_2_0:enabled() then
		l_2_1:invoke_callback_in_gui(l_2_0:name(), l_2_0:function_name(), l_2_1)
	end
end

CoreGuiCallbackCutsceneKey.is_valid_name = function(l_3_0, l_3_1)
	local l_3_2, l_3_3 = Database:has, Database
	local l_3_4 = "gui"
	local l_3_5 = l_3_1
	return l_3_2(l_3_3, l_3_4, l_3_5)
end

CoreGuiCallbackCutsceneKey.refresh_control_for_name = function(l_4_0, l_4_1)
	l_4_1:freeze()
	l_4_1:clear()
	local l_4_2 = l_4_0:name()
	local l_4_6, l_4_7 = ipairs, Database:all(false, "gui")
	l_4_6 = l_4_6(l_4_7)
	for i_0,i_1 in l_4_6 do
		l_4_1:append(l_4_5:name())
		if l_4_5:name() == l_4_2 then
			l_4_1:set_value(l_4_2)
		end
	end
	l_4_1:thaw()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


