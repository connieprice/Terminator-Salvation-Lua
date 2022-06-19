InstantFeedbackBullet = InstantFeedbackBullet or class(InstantBullet)
function InstantFeedbackBullet.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7, A8_8, A9_9, A10_10, A11_11, A12_12, A13_13)
	InstantBullet.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7, A8_8, A9_9, A10_10, A11_11, A12_12, A13_13)
end
function InstantFeedbackBullet.destroy(A0_14)
	InstantBullet.destroy(A0_14)
	if A0_14._feedback_emitter then
		A0_14._feedback_emitter:destroy()
	end
end
function InstantFeedbackBullet.hit(A0_15, A1_16)
	local L2_17, L3_18, L4_19
	L2_17 = A1_16.unit
	L3_18 = alive
	L4_19 = L2_17
	L3_18 = L3_18(L4_19)
	if L3_18 then
		L4_19 = L2_17
		L3_18 = L2_17.slot
		L3_18 = L3_18(L4_19)
		L4_19 = managers
		L4_19 = L4_19.action_event
		L4_19 = L4_19.create_emitter
		L4_19 = L4_19(L4_19, nil)
		A0_15._feedback_emitter = L4_19
		L4_19 = A0_15._feedback_emitter
		L4_19 = L4_19.feedback_bullet_hit
		L4_19(L4_19, A0_15._spawning_unit, A1_16, L3_18)
	end
	L3_18 = A0_15._spawning_unit
	L4_19 = L3_18
	L3_18 = L3_18.base
	L3_18 = L3_18(L4_19)
	L4_19 = L3_18.show_bullet_hit
	if L4_19 then
		A0_15._disable_hit_effect = not L4_19(L3_18)
	end
	InstantBullet.hit(A0_15, A1_16)
end
