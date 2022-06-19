if not TutorialManager then
	TutorialManager = class()
end
TutorialManager.init = function(l_1_0)
	l_1_0:_parse_tutorial_xml()
end

TutorialManager.get_tutorials = function(l_2_0)
	return l_2_0._tutorials
end

TutorialManager.set_current_tutorial = function(l_3_0, l_3_1)
	l_3_0._current_tutorial_id = l_3_1
end

TutorialManager.clear_current_tutorial = function(l_4_0)
	l_4_0._current_tutorial_id = nil
end

TutorialManager.get_current_tutorial = function(l_5_0)
	if l_5_0._current_tutorial_id then
		return l_5_0._tutorials[l_5_0._current_tutorial_id]
	else
		return nil
	end
end

TutorialManager._parse_tutorial_xml = function(l_6_0)
	local l_6_6, l_6_7, l_6_8, l_6_9, l_6_10 = nil
	l_6_0._tutorials = {}
	local l_6_1 = "data/gui/tutorials.xml"
	if File:exists(l_6_1) then
		local l_6_2 = File:parse_xml(l_6_1)
		for i_0 in l_6_2:children() do
			local l_6_12 = i_0:parameter("name")
			local l_6_13 = l_6_11:parameter("text")
			local l_6_14 = l_6_11:parameter("texture")
			local l_6_15 = l_6_11:parameter("background")
			local l_6_16 = l_6_0._tutorials
			l_6_16[l_6_12] = {text = l_6_13, texture = l_6_14, background = l_6_15}
		end
	end
end


