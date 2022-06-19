TutorialManager = TutorialManager or class()
function TutorialManager.init(A0_0)
	A0_0:_parse_tutorial_xml()
end
function TutorialManager.get_tutorials(A0_1)
	local L1_2
	L1_2 = A0_1._tutorials
	return L1_2
end
function TutorialManager.set_current_tutorial(A0_3, A1_4)
	A0_3._current_tutorial_id = A1_4
end
function TutorialManager.clear_current_tutorial(A0_5)
	local L1_6
	A0_5._current_tutorial_id = nil
end
function TutorialManager.get_current_tutorial(A0_7)
	local L1_8
	L1_8 = A0_7._current_tutorial_id
	if L1_8 then
		L1_8 = A0_7._tutorials
		L1_8 = L1_8[A0_7._current_tutorial_id]
		return L1_8
	else
		L1_8 = nil
		return L1_8
	end
end
function TutorialManager._parse_tutorial_xml(A0_9)
	local L1_10
	L1_10 = {}
	A0_9._tutorials = L1_10
	L1_10 = "data/gui/tutorials.xml"
	if File:exists(L1_10) then
		for 