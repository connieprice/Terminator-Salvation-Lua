require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
if not CoreChangeShadowCutsceneKey then
	CoreChangeShadowCutsceneKey = class(CoreCutsceneKeyBase)
end
CoreChangeShadowCutsceneKey.ELEMENT_NAME = "change_shadow"
CoreChangeShadowCutsceneKey.NAME = "Shadow Change"
CoreChangeShadowCutsceneKey:register_serialized_attribute("name", "")
CoreChangeShadowCutsceneKey.__tostring = function(l_1_0)
	return "Change shadow settings to \"" .. l_1_0:name() .. "\"."
end

CoreChangeShadowCutsceneKey.prime = function(l_2_0, l_2_1)
	managers.shadow:preload(l_2_0:name())
end

CoreChangeShadowCutsceneKey.evaluate = function(l_3_0, l_3_1, l_3_2)
	local l_3_3 = l_3_0:name()
	managers.shadow:preload(l_3_3)
	managers.shadow:push(l_3_3)
	l_3_0._on_stack = true
end

CoreChangeShadowCutsceneKey.revert = function(l_4_0)
	if l_4_0._on_stack then
		managers.shadow:pop(l_4_0:name())
		l_4_0._on_stack = false
	end
end

CoreChangeShadowCutsceneKey.unload = function(l_5_0)
	if l_5_0._on_stack then
		managers.shadow:pop(l_5_0:name())
		l_5_0._on_stack = false
	end
end

CoreChangeShadowCutsceneKey.can_evaluate_with_player = function(l_6_0, l_6_1)
	return true
end

CoreChangeShadowCutsceneKey.is_valid_name = function(l_7_0, l_7_1)
	local l_7_5, l_7_6 = ipairs, managers.shadow:list()
	l_7_5 = l_7_5(l_7_6)
	for i_0,i_1 in l_7_5 do
		if l_7_4 == l_7_1 then
			return true
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreChangeShadowCutsceneKey.control_for_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreChangeShadowCutsceneKey.refresh_control_for_name = function(l_8_0, l_8_1)
	l_8_1:freeze()
	l_8_1:clear()
	local l_8_2 = l_8_0:name()
	local l_8_6, l_8_7 = ipairs, managers.shadow:list()
	l_8_6 = l_8_6(l_8_7)
	for i_0,i_1 in l_8_6 do
		l_8_1:append(l_8_5)
		if l_8_5 == l_8_2 then
			l_8_1:set_value(l_8_5)
		end
	end
	l_8_1:thaw()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


