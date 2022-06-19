require("units/beings/player/gui/PanelFader")
SubtitlePanelStateFading = SubtitlePanelStateFading or class()
function SubtitlePanelStateFading.init(A0_0, A1_1, A2_2, A3_3)
	A3_3 = A3_3 or 20
	A0_0._alpha = PanelFader:new(A0_0.subtitle:panel(), A1_1, A3_3)
	A0_0._alpha:set_target(A2_2)
end
function SubtitlePanelStateFading.update(A0_4, A1_5)
	A0_4._alpha:update(A1_5)
end
function SubtitlePanelStateFading.transition(A0_6)
	if A0_6._alpha:has_reached_target() then
		return A0_6:next_state()
	end
end
SubtitlePanelStateFadeIn = SubtitlePanelStateFadeIn or class(SubtitlePanelStateFading)
function SubtitlePanelStateFadeIn.init(A0_7)
	SubtitlePanelStateFading.init(A0_7, 0, 1, 40)
end
function SubtitlePanelStateFadeIn.next_state(A0_8)
	local L1_9
	L1_9 = SubtitlePanelStateDisplaying
	return L1_9
end
SubtitlePanelStateDisplaying = SubtitlePanelStateDisplaying or class()
function SubtitlePanelStateDisplaying.init(A0_10)
	local L1_11
	A0_10._timer = 0
	A0_10._max_time = 4
	A0_10._min_time = 0.5
end
function SubtitlePanelStateDisplaying.update(A0_12, A1_13)
	local L2_14
	L2_14 = A0_12._timer
	L2_14 = L2_14 + A1_13
	A0_12._timer = L2_14
end
function SubtitlePanelStateDisplaying.transition(A0_15)
	if A0_15.subtitle:lines_are_dismissed() and A0_15._timer > A0_15._min_time then
		return SubtitlePanelStateFadeOut
	end
end
SubtitlePanelStateFadeOut = SubtitlePanelStateFadeOut or class(SubtitlePanelStateFading)
function SubtitlePanelStateFadeOut.init(A0_16)
	SubtitlePanelStateFading.init(A0_16, 1, 0)
end
function SubtitlePanelStateFadeOut.next_state(A0_17)
	local L1_18
	L1_18 = SubtitlePanelStateDone
	return L1_18
end
SubtitlePanelStateDone = SubtitlePanelStateDone or class()
function SubtitlePanelStateDone.init(A0_19)
	A0_19.subtitle:set_fade_is_done()
end
function SubtitlePanelStateDone.transition(A0_20)
	local L1_21
end
