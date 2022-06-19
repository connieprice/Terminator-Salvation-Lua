require("menu/ingame/IntroCreditsText")
if not ChapterText then
	ChapterText = class()
end
ChapterText.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._parent_panel = l_1_1
	l_1_0._wait_time = 6
	l_1_0._level_id = l_1_2
end

ChapterText.destroy = function(l_2_0)
	if l_2_0._text then
		l_2_0._text:destroy()
		l_2_0._text = nil
	end
end

ChapterText.update = function(l_3_0, l_3_1)
	l_3_0._wait_time = l_3_0._wait_time - l_3_1
	if l_3_0._wait_time < 0 and not l_3_0._text then
		l_3_0:_show_chapter_text()
	end
	if l_3_0._text then
		local l_3_2, l_3_3 = l_3_0._text:update, l_3_0._text
		local l_3_4 = l_3_1
		return l_3_2(l_3_3, l_3_4)
	end
end

ChapterText._show_chapter_text = function(l_4_0)
	local l_4_1 = l_4_0._level_id
	local l_4_2 = Localizer:lookup("chapter_head_" .. tostring(l_4_1))
	local l_4_3 = (Localizer:lookup("chapter_line_" .. tostring(l_4_1)))
	local l_4_4 = nil
	local l_4_5 = 5
	local l_4_6 = tweak_data.hud.chapter_texts.VERTICAL_POSITION
	l_4_0._text = IntroCreditsText:new(l_4_0._parent_panel, l_4_4, l_4_2, l_4_3, l_4_5, l_4_6, false, false)
end


