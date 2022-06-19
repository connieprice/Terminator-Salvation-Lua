require("menu/ingame/IntroCreditsText")
if not IntroCredits then
	IntroCredits = class()
end
IntroCredits.init = function(l_1_0, l_1_1)
	assert(l_1_1)
	l_1_0._parent_panel = l_1_1
	local l_1_2, l_1_3 = l_1_1:panel, l_1_1
	local l_1_4 = {}
	l_1_4.layer = 99
	l_1_2 = l_1_2(l_1_3, l_1_4)
	l_1_0._panel = l_1_2
	l_1_2 = File
	l_1_2, l_1_3 = l_1_2:new_parse_xml, l_1_2
	l_1_4 = "data/gui/intro_credits.xml"
	l_1_2 = l_1_2(l_1_3, l_1_4)
	l_1_0._node = l_1_2
	l_1_0._index = 0
	l_1_0._total_time = 0
	l_1_0._is_done = false
	l_1_2, l_1_3 = l_1_0:next_node, l_1_0
	l_1_2(l_1_3)
end

IntroCredits.destroy = function(l_2_0)
	l_2_0._parent_panel:remove(l_2_0._panel)
	l_2_0._panel = nil
end

IntroCredits.time_to_seconds = function(l_3_0, l_3_1)
	return tonumber(string.sub(l_3_1, 1, 2)) * 60 + tonumber(string.sub(l_3_1, 4, 5))
	 -- WARNING: undefined locals caused missing assignments!
end

IntroCredits.next_node = function(l_4_0)
	if l_4_0._index == l_4_0._node:num_children() then
		return true
	end
	local l_4_1 = l_4_0._node:child(l_4_0._index)
	l_4_0._index = l_4_0._index + 1
	local l_4_2 = l_4_0:time_to_seconds(l_4_1:parameter("time"))
	local l_4_3 = l_4_1:parameter("head")
	local l_4_4 = l_4_1:parameter("line")
	l_4_0._panel:clear()
	local l_4_5 = l_4_0._panel:height() - tweak_data.hud.intro_credits.VERTICAL_POSITION
	local l_4_6 = tweak_data.hud.intro_credits.SHOW_TIME
	l_4_0._credit = IntroCreditsText:new(l_4_0._panel, l_4_2, l_4_3, l_4_4, l_4_6, l_4_5)
	return false
end

IntroCredits.update = function(l_5_0, l_5_1)
	if l_5_0._is_done then
		return l_5_0._is_done
	end
	l_5_0._total_time = l_5_0._total_time + l_5_1
	do
		if l_5_0._credit:is_active(l_5_0._total_time) then
			local l_5_2 = l_5_0._credit:update(l_5_1)
			if l_5_2 then
				l_5_0._credit = nil
				l_5_0._is_done = l_5_0:next_node()
			end
		else
			return 
		end
	end
	return l_5_0._is_done
end

IntroCredits.is_done = function(l_6_0)
	return l_6_0._is_done
end


