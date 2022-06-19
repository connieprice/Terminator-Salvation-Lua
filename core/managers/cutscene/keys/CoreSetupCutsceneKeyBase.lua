require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
if not CoreSetupCutsceneKeyBase then
	CoreSetupCutsceneKeyBase = class(CoreCutsceneKeyBase)
end
CoreSetupCutsceneKeyBase.populate_from_editor = function(l_1_0, l_1_1)
end

CoreSetupCutsceneKeyBase.frame = function(l_2_0)
	return 0
end

CoreSetupCutsceneKeyBase.set_frame = function(l_3_0, l_3_1)
end

CoreSetupCutsceneKeyBase.on_gui_representation_changed = function(l_4_0, l_4_1, l_4_2)
end

CoreSetupCutsceneKeyBase.prime = function(l_5_0, l_5_1)
	error("Cutscene keys deriving from CoreSetupCutsceneKeyBase must define the \"prime\" method.")
end

CoreSetupCutsceneKeyBase.play = function(l_6_0, l_6_1, l_6_2, l_6_3)
end


