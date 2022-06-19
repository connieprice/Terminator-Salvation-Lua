require("menu/ingame/IntroCreditsText")
IntroCredits = IntroCredits or class()
function IntroCredits.init(A0_0, A1_1)
	assert(A1_1)
	A0_0._parent_panel = A1_1
	A0_0._panel = A1_1:panel({layer = 99})
	A0_0._node = File:new_parse_xml("data/gui/intro_credits.xml")
	A0_0._index = 0
	A0_0._total_time = 0
	A0_0._is_done = false
	A0_0:next_node()
end
function IntroCredits.destroy(A0_2)
	A0_2._parent_panel:remove(A0_2._panel)
	A0_2._panel = nil
end
function IntroCredits.time_to_seconds(A0_3, A1_4)
	return tonumber(string.sub(A1_4, 1, 2)) * 60 + tonumber(string.sub(A1_4, 4, 5))
end
function IntroCredits.next_node(A0_5)
	local L1_6, L2_7, L3_8, L4_9, L5_10, L6_11
	L1_6 = A0_5._index
	L2_7 = A0_5._node
	L3_8 = L2_7
	L2_7 = L2_7.num_children
	L2_7 = L2_7(L3_8)
	if L1_6 == L2_7 then
		L1_6 = true
		return L1_6
	end
	L1_6 = A0_5._node
	L2_7 = L1_6
	L1_6 = L1_6.child
	L3_8 = A0_5._index
	L1_6 = L1_6(L2_7, L3_8)
	L2_7 = A0_5._index
	L2_7 = L2_7 + 1
	A0_5._index = L2_7
	L3_8 = A0_5
	L2_7 = A0_5.time_to_seconds
	L5_10 = L1_6
	L4_9 = L1_6.parameter
	L6_11 = "time"
	L6_11 = L4_9(L5_10, L6_11)
	L2_7 = L2_7(L3_8, L4_9, L5_10, L6_11, L4_9(L5_10, L6_11))
	L4_9 = L1_6
	L3_8 = L1_6.parameter
	L5_10 = "head"
	L3_8 = L3_8(L4_9, L5_10)
	L5_10 = L1_6
	L4_9 = L1_6.parameter
	L6_11 = "line"
	L4_9 = L4_9(L5_10, L6_11)
	L5_10 = A0_5._panel
	L6_11 = L5_10
	L5_10 = L5_10.clear
	L5_10(L6_11)
	L5_10 = A0_5._panel
	L6_11 = L5_10
	L5_10 = L5_10.height
	L5_10 = L5_10(L6_11)
	L6_11 = tweak_data
	L6_11 = L6_11.hud
	L6_11 = L6_11.intro_credits
	L6_11 = L6_11.VERTICAL_POSITION
	L5_10 = L5_10 - L6_11
	L6_11 = tweak_data
	L6_11 = L6_11.hud
	L6_11 = L6_11.intro_credits
	L6_11 = L6_11.SHOW_TIME
	A0_5._credit = IntroCreditsText:new(A0_5._panel, L2_7, L3_8, L4_9, L6_11, L5_10)
	return false
end
function IntroCredits.update(A0_12, A1_13)
	if A0_12._is_done then
		return A0_12._is_done
	end
	A0_12._total_time = A0_12._total_time + A1_13
	if A0_12._credit:is_active(A0_12._total_time) then
		if A0_12._credit:update(A1_13) then
			A0_12._credit = nil
			A0_12._is_done = A0_12:next_node()
		else
			return
		end
	end
	return A0_12._is_done
end
function IntroCredits.is_done(A0_14)
	local L1_15
	L1_15 = A0_14._is_done
	return L1_15
end
