require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
if not CoreObjectVisibleCutsceneKey then
	CoreObjectVisibleCutsceneKey = class(CoreCutsceneKeyBase)
end
CoreObjectVisibleCutsceneKey.ELEMENT_NAME = "object_visible"
CoreObjectVisibleCutsceneKey.NAME = "Object Visibility"
CoreObjectVisibleCutsceneKey:register_serialized_attribute("unit_name", "")
CoreObjectVisibleCutsceneKey:register_serialized_attribute("object_name", "")
CoreObjectVisibleCutsceneKey:register_serialized_attribute("visible", true, toboolean)
CoreObjectVisibleCutsceneKey.__tostring = function(l_1_0)
	return (l_1_0:visible() and "Show" or "Hide") .. " \"" .. l_1_0:object_name() .. "\" in \"" .. l_1_0:unit_name() .. "\"."
end

CoreObjectVisibleCutsceneKey.unload = function(l_2_0, l_2_1)
	if l_2_1 and l_2_0._cast then
		l_2_0:play(l_2_1, true)
	end
end

CoreObjectVisibleCutsceneKey.skip = function(l_3_0, l_3_1)
	if l_3_0._cast then
		l_3_0:play(l_3_1)
	end
end

CoreObjectVisibleCutsceneKey.play = function(l_4_0, l_4_1, l_4_2, l_4_3)
	if l_4_2 then
		local l_4_4, l_4_5 = l_4_0:preceeding_key, l_4_0
		local l_4_6 = {}
		l_4_6.unit_name = l_4_0:unit_name()
		l_4_6.object_name = l_4_0:object_name()
		l_4_4 = l_4_4(l_4_5, l_4_6)
		if l_4_4 then
			l_4_5, l_4_6 = l_4_4:evaluate, l_4_4
			l_4_5(l_4_6, l_4_1, false)
		else
			l_4_5, l_4_6 = l_4_0:evaluate, l_4_0
			l_4_5(l_4_6, l_4_1, false, l_4_0:_unit_initial_object_visibility(l_4_0:unit_name(), l_4_0:object_name()))
		end
	else
		l_4_0:evaluate(l_4_1, l_4_3)
	end
end

CoreObjectVisibleCutsceneKey.evaluate = function(l_5_0, l_5_1, l_5_2, l_5_3)
	assert(l_5_0._cast)
	local l_5_4 = l_5_0:_unit_object(l_5_0:unit_name(), l_5_0:object_name())
	l_5_4:set_visibility(l_5_3 == nil and l_5_0:visible() or l_5_3)
end

CoreObjectVisibleCutsceneKey.is_valid_object_name = function(l_6_0, l_6_1)
	if not l_6_0.super.is_valid_object_name(l_6_0, l_6_1) then
		return false
	else
		local l_6_2 = l_6_0:_unit_object(l_6_0:unit_name(), l_6_1, true)
		do
			return not l_6_2 or l_6_2.set_visibility ~= nil
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end


