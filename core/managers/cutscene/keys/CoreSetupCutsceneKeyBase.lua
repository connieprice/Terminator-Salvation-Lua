require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreSetupCutsceneKeyBase = CoreSetupCutsceneKeyBase or class(CoreCutsceneKeyBase)
function CoreSetupCutsceneKeyBase.populate_from_editor(A0_0, A1_1)
end
function CoreSetupCutsceneKeyBase.frame(A0_2)
	local L1_3
	L1_3 = 0
	return L1_3
end
function CoreSetupCutsceneKeyBase.set_frame(A0_4, A1_5)
end
function CoreSetupCutsceneKeyBase.on_gui_representation_changed(A0_6, A1_7, A2_8)
end
function CoreSetupCutsceneKeyBase.prime(A0_9, A1_10)
	error("Cutscene keys deriving from CoreSetupCutsceneKeyBase must define the \"prime\" method.")
end
function CoreSetupCutsceneKeyBase.play(A0_11, A1_12, A2_13, A3_14)
end
