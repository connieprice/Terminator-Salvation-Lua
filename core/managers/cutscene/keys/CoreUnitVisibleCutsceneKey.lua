require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreUnitVisibleCutsceneKey = CoreUnitVisibleCutsceneKey or class(CoreCutsceneKeyBase)
CoreUnitVisibleCutsceneKey.ELEMENT_NAME = "unit_visible"
CoreUnitVisibleCutsceneKey.NAME = "Unit Visibility"
CoreUnitVisibleCutsceneKey:register_serialized_attribute("unit_name", "")
CoreUnitVisibleCutsceneKey:register_serialized_attribute("visible", true, toboolean)
function CoreUnitVisibleCutsceneKey.__tostring(A0_0)
	return (A0_0:visible() and "Show" or "Hide") .. " \"" .. A0_0:unit_name() .. "\"."
end
function CoreUnitVisibleCutsceneKey.unload(A0_1)
	if A0_1._cast then
		A0_1:play(nil, true)
	end
end
function CoreUnitVisibleCutsceneKey.play(A0_2, A1_3, A2_4, A3_5)
	assert(type(A0_2.evaluate) == "function", "Cutscene key must define the \"evaluate\" method to use the default CoreCutsceneKeyBase:play method.")
	if A2_4 then
		if A0_2:preceeding_key({
			unit_name = A0_2:unit_name()
		}) then
			A0_2:preceeding_key({
				unit_name = A0_2:unit_name()
			}):evaluate(A1_3, false)
		else
			A0_2:evaluate(A1_3, false, true)
		end
	else
		A0_2:evaluate(A1_3, A3_5)
	end
end
function CoreUnitVisibleCutsceneKey.evaluate(A0_6, A1_7, A2_8, A3_9)
	local L4_10, L5_11
	L4_10 = assert
	L5_11 = A0_6._cast
	L4_10(L5_11)
	if not A3_9 then
		L5_11 = A0_6
		L4_10 = A0_6.visible
		L4_10 = L4_10(L5_11)
		A3_9 = L4_10
	end
	L4_10 = A0_6._cast
	L5_11 = L4_10
	L4_10 = L4_10.unit
	L4_10 = L4_10(L5_11, A0_6:unit_name())
	if L4_10 then
		L5_11 = A0_6._cast
		L5_11 = L5_11.set_unit_visible
		L5_11(L5_11, A0_6:unit_name(), A3_9)
	else
		L5_11 = A0_6._unit
		L5_11 = L5_11(A0_6, A0_6:unit_name(), true)
		if L5_11 then
			set_unit_and_children_visible(L5_11, A3_9)
		end
	end
end
