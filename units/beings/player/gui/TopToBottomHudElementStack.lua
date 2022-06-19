require("units/beings/player/gui/HudElementStack")
TopToBottomSubtitlesHudElementStack = TopToBottomSubtitlesHudElementStack or class(HudElementStack)
function TopToBottomSubtitlesHudElementStack._recalculate_target_positions(A0_0, A1_1)
	local L2_2, L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9
	L2_2 = TableAlgorithms
	L2_2 = L2_2.count
	L2_2 = L2_2(L3_3)
	if L2_2 > 2 then
		L2_2 = 2
	end
	for L6_6, L7_7 in L3_3(L4_4) do
		L9_9 = L7_7
		L8_8 = L7_7.is_fading_out
		L8_8 = L8_8(L9_9)
		if not L8_8 then
			L8_8 = L7_7._panel
			L9_9 = L8_8
			L8_8 = L8_8.height
			L8_8 = L8_8(L9_9)
			L9_9 = L2_2 - L6_6
			L9_9 = L8_8 * L9_9
			L8_8 = L8_8 + L9_9
			L9_9 = A0_0._panel
			L9_9 = L9_9.height
			L9_9 = L9_9(L9_9)
			L9_9 = L9_9 - L8_8
			L9_9 = L9_9 - A0_0._spacing
			if L6_6 <= A0_0._maximum_messages_shown then
				L7_7:mark_should_show()
				L7_7:set_y(L9_9)
			end
		end
	end
end
TopToBottomHudElementStack = TopToBottomHudElementStack or class(HudElementStack)
function TopToBottomHudElementStack._recalculate_target_positions(A0_10, A1_11)
	local L2_12, L3_13, L4_14, L5_15, L6_16, L7_17, L8_18, L9_19, L10_20, L11_21
	L2_12 = A0_10._panel
	L3_13 = L2_12
	L2_12 = L2_12.height
	L2_12 = L2_12(L3_13)
	L2_12 = L2_12 * 0.05
	L3_13 = 1
	for L7_17, L8_18 in L4_14(L5_15) do
		L10_20 = L8_18
		L9_19 = L8_18.is_fading_out
		L9_19 = L9_19(L10_20)
		if not L9_19 then
			L9_19 = L8_18._panel
			L10_20 = L9_19
			L9_19 = L9_19.height
			L9_19 = L9_19(L10_20)
			L10_20 = L2_12 + L9_19
			L11_21 = A0_10._spacing
			L2_12 = L10_20 - L11_21
			L11_21 = L8_18
			L10_20 = L8_18.y_has_been_set
			L10_20 = L10_20(L11_21)
			if L10_20 then
				L11_21 = L8_18
				L10_20 = L8_18.y
				L10_20 = L10_20(L11_21)
				if L2_12 < L10_20 then
					L11_21 = L8_18
					L10_20 = L8_18.y
					L10_20 = L10_20(L11_21)
					L10_20 = L10_20 - L2_12
					L11_21 = L10_20
					if L11_21 > 20 then
						L11_21 = 20
					end
					L2_12 = L8_18:y() - L11_21 * A1_11
				end
				L10_20 = A0_10._maximum_messages_shown
				if L7_17 <= L10_20 then
					L11_21 = L8_18
					L10_20 = L8_18.mark_should_show
					L10_20(L11_21)
				end
			end
			L11_21 = L8_18
			L10_20 = L8_18.set_y
			L10_20(L11_21, L2_12)
		end
	end
end
