require("ai/common/CommonAiThreatTracking")
SpiderAiThreatTracking = SpiderAiThreatTracking or class(CommonAiThreatTracking)
function SpiderAiThreatTracking.init_data(A0_0, A1_1)
	CommonAiThreatTracking.init_data(A0_0, A1_1)
	A1_1._threat_tracking._update_index = 1
end
function SpiderAiThreatTracking.logic_spider_threat_tracking_main(A0_2, A1_3, A2_4, A3_5, A4_6, A5_7, A6_8, A7_9)
	if A2_4:ai_data()._threat_tracking._update_index == 3 then
		CommonAiThreatTracking:logic_common_threat_tracking_main(A1_3, A2_4, A3_5, A4_6, A5_7, A6_8, A7_9)
		A2_4:ai_data()._threat_tracking._update_index = 1
	else
		if true then
			A0_2:_minimal_threat_tracking(A1_3, A2_4)
		end
		A2_4:ai_data()._threat_tracking._update_index = A2_4:ai_data()._threat_tracking._update_index + 1
	end
end
function SpiderAiThreatTracking._minimal_threat_tracking(A0_10, A1_11, A2_12)
	local L3_13, L4_14, L5_15
	L4_14 = A2_12
	L3_13 = A2_12.ai_data
	L3_13 = L3_13(L4_14)
	L4_14 = L3_13._threat_tracking
	L5_15 = A0_10._find_targets
	L5_15 = L5_15(A0_10, A2_12, L3_13)
	A0_10:_process_damages(A1_11, L4_14, L3_13.input.buffered_damages, A2_12)
	A0_10:_scan_for_targets(A2_12, L3_13, L4_14._threats, L5_15, A1_11)
	A0_10:_update_threats(L4_14._threats, A1_11)
end
