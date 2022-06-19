require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
if not CoreDiscontinuityCutsceneKey then
	CoreDiscontinuityCutsceneKey = class(CoreCutsceneKeyBase)
end
CoreDiscontinuityCutsceneKey.ELEMENT_NAME = "discontinuity"
CoreDiscontinuityCutsceneKey.NAME = "Discontinuity"
CoreDiscontinuityCutsceneKey:register_control("description")
CoreDiscontinuityCutsceneKey.refresh_control_for_description = CoreCutsceneKeyBase.VOID
CoreDiscontinuityCutsceneKey.label_for_description = CoreCutsceneKeyBase.VOID
CoreDiscontinuityCutsceneKey.is_valid_description = CoreCutsceneKeyBase.TRUE
CoreDiscontinuityCutsceneKey.__tostring = function(l_1_0)
	return "Notifies a discontinuity in linear time."
end

CoreDiscontinuityCutsceneKey.play = function(l_2_0, l_2_1, l_2_2, l_2_3)
	l_2_1:_notify_discontinuity()
end

CoreDiscontinuityCutsceneKey.control_for_description = function(l_3_0, l_3_1)
	local l_3_2 = "Discontinuity keys signify a break in linear time. They enable us to dampen physics, etc. during rapid actor movement.\n\nDiscontinuity keys are inserted by the optimizer as the cutscene is exported to the game, but you can also insert them yourself."
	local l_3_3 = EWS:TextCtrl(l_3_1, l_3_2, "", "NO_BORDER,TE_RICH,TE_MULTILINE,TE_READONLY")
	l_3_3:set_min_size(l_3_3:get_min_size():with_y(160))
	l_3_3:set_background_colour(l_3_1:background_colour():unpack())
	return l_3_3
end

CoreDiscontinuityCutsceneKey.validate_control_for_attribute = function(l_4_0, l_4_1)
	if l_4_1 ~= "description" then
		local l_4_2 = l_4_0.super.validate_control_for_attribute
		local l_4_3 = l_4_0
		local l_4_4 = l_4_1
		return l_4_2(l_4_3, l_4_4)
	end
	return true
end


