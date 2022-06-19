require("ai/common/CommonAiThreatTracking")
if not SpiderAiThreatTracking then
	SpiderAiThreatTracking = class(CommonAiThreatTracking)
end
SpiderAiThreatTracking.init_data = function(l_1_0, l_1_1)
	CommonAiThreatTracking.init_data(l_1_0, l_1_1)
	l_1_1._threat_tracking._update_index = 1
end

SpiderAiThreatTracking.logic_spider_threat_tracking_main = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7)
	local l_2_8 = 3
	local l_2_9 = l_2_2:ai_data()
	local l_2_10 = false
	if l_2_9.current_unit_eyes == l_2_9.UNIT_EYES.PATROL then
		l_2_10 = true
	end
	if l_2_9._threat_tracking._update_index == l_2_8 then
		CommonAiThreatTracking:logic_common_threat_tracking_main(l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7)
		l_2_9._threat_tracking._update_index = 1
	elseif l_2_10 then
		l_2_0:_minimal_threat_tracking(l_2_1, l_2_2)
	end
	l_2_9._threat_tracking._update_index = l_2_9._threat_tracking._update_index + 1
end

SpiderAiThreatTracking._minimal_threat_tracking = function(l_3_0, l_3_1, l_3_2)
	local l_3_3 = l_3_2:ai_data()
	local l_3_4 = l_3_3._threat_tracking
	local l_3_5 = l_3_0:_find_targets(l_3_2, l_3_3)
	l_3_0:_process_damages(l_3_1, l_3_4, l_3_3.input.buffered_damages, l_3_2)
	l_3_0:_scan_for_targets(l_3_2, l_3_3, l_3_4._threats, l_3_5, l_3_1)
	l_3_0:_update_threats(l_3_4._threats, l_3_1)
end


