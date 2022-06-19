require("shared/AverageOverTime")
DynamicMusicManager = DynamicMusicManager or class()
function DynamicMusicManager.init(A0_0)
	A0_0._average_level = AverageOverTime:new(70)
	A0_0._action_level = 0
	A0_0.LEVEL_NONE = 0
	A0_0.LEVEL_AMBIENCE = 1
	A0_0.LEVEL_ACTION = 2
	A0_0.LEVEL_INTENSE = 3
	A0_0._level = A0_0.LEVEL_NONE
	A0_0._use_action_level = false
end
function DynamicMusicManager.update(A0_1, A1_2)
	if not A0_1._use_action_level then
		return
	end
	A0_1._average_level:add(A0_1._action_level * A1_2, A1_2)
	if not A0_1._average_level:is_complete() then
		return
	end
	if A0_1._average_level:value() > 0.8 then
		A0_1:select_if_stable(A0_1.LEVEL_INTENSE)
	elseif A0_1._average_level:value() > 0.5 then
		A0_1:select_if_stable(A0_1.LEVEL_ACTION)
	else
		A0_1:select_if_stable(A0_1.LEVEL_AMBIENCE)
	end
end
function DynamicMusicManager.select_if_stable(A0_3, A1_4)
	local L2_5
	if A1_4 == A0_3._level then
		return
	end
	A0_3._level = A1_4
	if A1_4 == A0_3.LEVEL_AMBIENCE then
		L2_5 = "normal"
	elseif A1_4 == A0_3.LEVEL_ACTION then
		L2_5 = "action"
	elseif A1_4 == A0_3.LEVEL_INTENSE then
		L2_5 = "panic"
	end
	managers.music2:set_mode(L2_5)
end
function DynamicMusicManager.set_action_level(A0_6, A1_7)
	assert(A1_7 >= 0 and A1_7 <= 1)
	A0_6._action_level = A1_7
	A0_6._use_action_level = true
end
