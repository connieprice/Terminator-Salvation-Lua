require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreObjectVisibleCutsceneKey = CoreObjectVisibleCutsceneKey or class(CoreCutsceneKeyBase)
CoreObjectVisibleCutsceneKey.ELEMENT_NAME = "object_visible"
CoreObjectVisibleCutsceneKey.NAME = "Object Visibility"
CoreObjectVisibleCutsceneKey:register_serialized_attribute("unit_name", "")
CoreObjectVisibleCutsceneKey:register_serialized_attribute("object_name", "")
CoreObjectVisibleCutsceneKey:register_serialized_attribute("visible", true, toboolean)
function CoreObjectVisibleCutsceneKey.__tostring(A0_0)
	return (A0_0:visible() and "Show" or "Hide") .. " \"" .. A0_0:object_name() .. "\" in \"" .. A0_0:unit_name() .. "\"."
end
function CoreObjectVisibleCutsceneKey.unload(A0_1, A1_2)
	if A1_2 and A0_1._cast then
		A0_1:play(A1_2, true)
	end
end
function CoreObjectVisibleCutsceneKey.skip(A0_3, A1_4)
	if A0_3._cast then
		A0_3:play(A1_4)
	end
end
function CoreObjectVisibleCutsceneKey.play(A0_5, A1_6, A2_7, A3_8)
	if A2_7 then
		if A0_5:preceeding_key({
			unit_name = A0_5:unit_name(),
			object_name = A0_5:object_name()
		}) then
			A0_5:preceeding_key({
				unit_name = A0_5:unit_name(),
				object_name = A0_5:object_name()
			}):evaluate(A1_6, false)
		else
			A0_5:evaluate(A1_6, false, A0_5:_unit_initial_object_visibility(A0_5:unit_name(), A0_5:object_name()))
		end
	else
		A0_5:evaluate(A1_6, A3_8)
	end
end
function CoreObjectVisibleCutsceneKey.evaluate(A0_9, A1_10, A2_11, A3_12)
	assert(A0_9._cast)
	A0_9:_unit_object(A0_9:unit_name(), A0_9:object_name()):set_visibility(A3_12 == nil and A0_9:visible() or A3_12)
end
function CoreObjectVisibleCutsceneKey.is_valid_object_name(A0_13, A1_14)
	if not A0_13.super.is_valid_object_name(A0_13, A1_14) then
		return false
	else
		return A0_13:_unit_object(A0_13:unit_name(), A1_14, true) and A0_13:_unit_object(A0_13:unit_name(), A1_14, true).set_visibility ~= nil
	end
end
