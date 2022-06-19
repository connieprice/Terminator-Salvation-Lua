AiPositioningDirector = AiPositioningDirector or class()
function AiPositioningDirector.init(A0_0)
	A0_0._units = {}
end
function AiPositioningDirector.add_ai_unit(A0_1, A1_2)
	A0_1._units[A1_2] = A1_2
end
function AiPositioningDirector.remove_ai_unit(A0_3, A1_4)
	A0_3._units[A1_4] = nil
end
function AiPositioningDirector.update(A0_5, A1_6, A2_7)
	A0_5:_update_covers(A1_6, A2_7)
end
function AiPositioningDirector._update_covers(A0_8, A1_9, A2_10)
	local L3_11, L4_12, L5_13
	for 