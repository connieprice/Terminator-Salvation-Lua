require("menu/ingame/IntroCreditsText")
ChapterText = ChapterText or class()
function ChapterText.init(A0_0, A1_1, A2_2)
	A0_0._parent_panel = A1_1
	A0_0._wait_time = 6
	A0_0._level_id = A2_2
end
function ChapterText.destroy(A0_3)
	if A0_3._text then
		A0_3._text:destroy()
		A0_3._text = nil
	end
end
function ChapterText.update(A0_4, A1_5)
	A0_4._wait_time = A0_4._wait_time - A1_5
	if A0_4._wait_time < 0 and not A0_4._text then
		A0_4:_show_chapter_text()
	end
	if A0_4._text then
		return A0_4._text:update(A1_5)
	end
end
function ChapterText._show_chapter_text(A0_6)
	local L1_7, L2_8, L3_9, L4_10, L5_11, L6_12
	L1_7 = A0_6._level_id
	L2_8 = Localizer
	L3_9 = L2_8
	L2_8 = L2_8.lookup
	L4_10 = "chapter_head_"
	L5_11 = tostring
	L6_12 = L1_7
	L5_11 = L5_11(L6_12)
	L4_10 = L4_10 .. L5_11
	L2_8 = L2_8(L3_9, L4_10)
	L3_9 = Localizer
	L4_10 = L3_9
	L3_9 = L3_9.lookup
	L5_11 = "chapter_line_"
	L6_12 = tostring
	L6_12 = L6_12(L1_7)
	L5_11 = L5_11 .. L6_12
	L3_9 = L3_9(L4_10, L5_11)
	L4_10 = nil
	L5_11 = 5
	L6_12 = tweak_data
	L6_12 = L6_12.hud
	L6_12 = L6_12.chapter_texts
	L6_12 = L6_12.VERTICAL_POSITION
	A0_6._text = IntroCreditsText:new(A0_6._parent_panel, L4_10, L2_8, L3_9, L5_11, L6_12, false, false)
end
