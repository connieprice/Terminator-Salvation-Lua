require("units/beings/player/gui/PanelFader")
if not SubtitlePanelStateFading then
	SubtitlePanelStateFading = class()
end
SubtitlePanelStateFading.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	if not l_1_3 then
		l_1_3 = 20
	end
	l_1_0._alpha = PanelFader:new(l_1_0.subtitle:panel(), l_1_1, l_1_3)
	l_1_0._alpha:set_target(l_1_2)
end

SubtitlePanelStateFading.update = function(l_2_0, l_2_1)
	l_2_0._alpha:update(l_2_1)
end

SubtitlePanelStateFading.transition = function(l_3_0)
	if l_3_0._alpha:has_reached_target() then
		local l_3_1, l_3_2 = l_3_0:next_state, l_3_0
		return l_3_1(l_3_2)
	end
end

if not SubtitlePanelStateFadeIn then
	SubtitlePanelStateFadeIn = class(SubtitlePanelStateFading)
end
SubtitlePanelStateFadeIn.init = function(l_4_0)
	SubtitlePanelStateFading.init(l_4_0, 0, 1, 40)
end

SubtitlePanelStateFadeIn.next_state = function(l_5_0)
	return SubtitlePanelStateDisplaying
end

if not SubtitlePanelStateDisplaying then
	SubtitlePanelStateDisplaying = class()
end
SubtitlePanelStateDisplaying.init = function(l_6_0)
	l_6_0._timer = 0
	l_6_0._max_time = 4
	l_6_0._min_time = 0.5
end

SubtitlePanelStateDisplaying.update = function(l_7_0, l_7_1)
	l_7_0._timer = l_7_0._timer + l_7_1
end

SubtitlePanelStateDisplaying.transition = function(l_8_0)
	if l_8_0.subtitle:lines_are_dismissed() and l_8_0._min_time < l_8_0._timer then
		return SubtitlePanelStateFadeOut
	end
end

if not SubtitlePanelStateFadeOut then
	SubtitlePanelStateFadeOut = class(SubtitlePanelStateFading)
end
SubtitlePanelStateFadeOut.init = function(l_9_0)
	SubtitlePanelStateFading.init(l_9_0, 1, 0)
end

SubtitlePanelStateFadeOut.next_state = function(l_10_0)
	return SubtitlePanelStateDone
end

if not SubtitlePanelStateDone then
	SubtitlePanelStateDone = class()
end
SubtitlePanelStateDone.init = function(l_11_0)
	l_11_0.subtitle:set_fade_is_done()
end

SubtitlePanelStateDone.transition = function(l_12_0)
end


