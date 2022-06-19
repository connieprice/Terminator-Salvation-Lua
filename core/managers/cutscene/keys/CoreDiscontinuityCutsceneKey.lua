require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreDiscontinuityCutsceneKey = CoreDiscontinuityCutsceneKey or class(CoreCutsceneKeyBase)
CoreDiscontinuityCutsceneKey.ELEMENT_NAME = "discontinuity"
CoreDiscontinuityCutsceneKey.NAME = "Discontinuity"
CoreDiscontinuityCutsceneKey:register_control("description")
CoreDiscontinuityCutsceneKey.refresh_control_for_description = CoreCutsceneKeyBase.VOID
CoreDiscontinuityCutsceneKey.label_for_description = CoreCutsceneKeyBase.VOID
CoreDiscontinuityCutsceneKey.is_valid_description = CoreCutsceneKeyBase.TRUE
function CoreDiscontinuityCutsceneKey.__tostring(A0_0)
	local L1_1
	L1_1 = "Notifies a discontinuity in linear time."
	return L1_1
end
function CoreDiscontinuityCutsceneKey.play(A0_2, A1_3, A2_4, A3_5)
	A1_3:_notify_discontinuity()
end
function CoreDiscontinuityCutsceneKey.control_for_description(A0_6, A1_7)
	local L2_8
	L2_8 = [[
Discontinuity keys signify a break in linear time. They enable us to dampen physics, etc. during rapid actor movement.

Discontinuity keys are inserted by the optimizer as the cutscene is exported to the game, but you can also insert them yourself.]]
	EWS:TextCtrl(A1_7, L2_8, "", "NO_BORDER,TE_RICH,TE_MULTILINE,TE_READONLY"):set_min_size(EWS:TextCtrl(A1_7, L2_8, "", "NO_BORDER,TE_RICH,TE_MULTILINE,TE_READONLY"):get_min_size():with_y(160))
	EWS:TextCtrl(A1_7, L2_8, "", "NO_BORDER,TE_RICH,TE_MULTILINE,TE_READONLY"):set_background_colour(A1_7:background_colour():unpack())
	return (EWS:TextCtrl(A1_7, L2_8, "", "NO_BORDER,TE_RICH,TE_MULTILINE,TE_READONLY"))
end
function CoreDiscontinuityCutsceneKey.validate_control_for_attribute(A0_9, A1_10)
	if A1_10 ~= "description" then
		return A0_9.super.validate_control_for_attribute(A0_9, A1_10)
	end
	return true
end
