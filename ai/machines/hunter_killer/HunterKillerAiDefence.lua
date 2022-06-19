HunterKillerAiDefence = HunterKillerAiDefence or class()
function HunterKillerAiDefence.init_data(A0_0, A1_1)
	local L2_2
	L2_2 = {}
	A1_1._defence = L2_2
	L2_2 = A1_1._defence
	L2_2.forced_flares = {}
	L2_2 = A1_1._defence
	L2_2.forced_flare_cnt = nil
	L2_2 = A1_1._defence
	L2_2.forced_flare_start = nil
end
function HunterKillerAiDefence.logic_hk_defence_init(A0_3, A1_4, A2_5, A3_6, A4_7, A5_8, A6_9, A7_10)
	local L8_11
	L8_11 = 0
	return L8_11
end
function HunterKillerAiDefence.logic_hk_defence_passive(A0_12, A1_13, A2_14, A3_15, A4_16, A5_17, A6_18, A7_19)
	if #A2_14:ai_data().input.forced_flares > 0 then
		A2_14:ai_data()._defence.forced_flares = A2_14:ai_data().input.forced_flares
		A2_14:ai_data()._defence.forced_flare_cnt = 1
		return 0
	end
	A2_14:ai_data().output.allowed_to_release_flare = false
	return nil
end
function HunterKillerAiDefence.logic_hk_defence_forced_flare(A0_20, A1_21, A2_22, A3_23, A4_24, A5_25, A6_26, A7_27)
	if #A2_22:ai_data().input.forced_flares > 0 then
		A0_20:_hk_defence_forced_flare(A2_22, A1_21, 1)
	end
	if #A2_22:ai_data().input.forced_flares == 0 then
		A2_22:ai_data().output.allowed_to_release_flare = false
		return 0
	end
	return nil
end
function HunterKillerAiDefence.logic_hk_defence_flare(A0_28, A1_29, A2_30, A3_31, A4_32, A5_33, A6_34, A7_35)
	return nil
end
function HunterKillerAiDefence._hk_defence_forced_flare(A0_36, A1_37, A2_38)
	A0_36:_update_forced_flare_rounds(A1_37, A2_38)
	if #A1_37:ai_data().input.forced_flares == 0 then
		A1_37:ai_data().output.allowed_to_release_flare = false
		return
	end
	if A1_37:ai_data()._defence.forced_flare_cnt % 2 == 0 then
		A1_37:ai_data().output.allowed_to_release_flare = false
		return
	end
	if 0 < #A1_37:ai_data()._defence.forced_flares then
		A1_37:ai_data().output.allowed_to_release_flare = true
	else
		A1_37:ai_data().output.allowed_to_release_flare = false
	end
end
function HunterKillerAiDefence._update_forced_flare_rounds(A0_39, A1_40, A2_41)
	if A1_40:ai_data()._defence.forced_flare_cnt <= #A1_40:ai_data()._defence.forced_flares then
		if not A1_40:ai_data()._defence.forced_flare_start then
			A1_40:ai_data()._defence.forced_flare_start = A2_41
		end
		if A2_41 > A1_40:ai_data()._defence.forced_flare_start + tonumber(A1_40:ai_data()._defence.forced_flares[A1_40:ai_data()._defence.forced_flare_cnt]) then
			A1_40:ai_data()._defence.forced_flare_cnt = A1_40:ai_data()._defence.forced_flare_cnt + 1
			A1_40:ai_data()._defence.forced_flare_start = nil
			if A1_40:ai_data()._defence.forced_flare_cnt > #A1_40:ai_data()._defence.forced_flares then
				A1_40:ai_data().input.forced_flares = {}
			end
		end
	end
end
