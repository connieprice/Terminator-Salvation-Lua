require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
if not CoreUnitVisibleCutsceneKey then
	CoreUnitVisibleCutsceneKey = class(CoreCutsceneKeyBase)
end
CoreUnitVisibleCutsceneKey.ELEMENT_NAME = "unit_visible"
CoreUnitVisibleCutsceneKey.NAME = "Unit Visibility"
CoreUnitVisibleCutsceneKey:register_serialized_attribute("unit_name", "")
CoreUnitVisibleCutsceneKey:register_serialized_attribute("visible", true, toboolean)
CoreUnitVisibleCutsceneKey.__tostring = function(l_1_0)
	return (l_1_0:visible() and "Show" or "Hide") .. " \"" .. l_1_0:unit_name() .. "\"."
end

CoreUnitVisibleCutsceneKey.unload = function(l_2_0)
	if l_2_0._cast then
		l_2_0:play(nil, true)
	end
end

CoreUnitVisibleCutsceneKey.play = function(l_3_0, l_3_1, l_3_2, l_3_3)
	local l_3_4 = assert
	l_3_4(type(l_3_0.evaluate) == "function", "Cutscene key must define the \"evaluate\" method to use the default CoreCutsceneKeyBase:play method.")
	if l_3_2 then
		local l_3_7 = l_3_0
		local l_3_8 = {}
		l_3_8.unit_name = l_3_0:unit_name()
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_3_4 then
			l_3_7, l_3_8 = l_3_4:evaluate, l_3_4
			l_3_7(l_3_8, l_3_1, false)
		else
			l_3_7, l_3_8 = l_3_0:evaluate, l_3_0
			l_3_7(l_3_8, l_3_1, false, true)
		end
	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		l_3_4(l_3_0, l_3_1, l_3_3)
	end
end

CoreUnitVisibleCutsceneKey.evaluate = function(l_4_0, l_4_1, l_4_2, l_4_3)
	assert(l_4_0._cast)
	if not l_4_3 then
		l_4_3 = l_4_0:visible()
	end
	local l_4_4 = l_4_0._cast:unit(l_4_0:unit_name())
	if l_4_4 then
		l_4_0._cast:set_unit_visible(l_4_0:unit_name(), l_4_3)
	else
		local l_4_5 = l_4_0:_unit(l_4_0:unit_name(), true)
	if l_4_5 then
		end
		set_unit_and_children_visible(l_4_5, l_4_3)
	end
end


