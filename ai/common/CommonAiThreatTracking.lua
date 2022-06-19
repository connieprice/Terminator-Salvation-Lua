require("ai/common/CommonAiThreat")
require("ai/common/IntelUtilities")
require("ai/common/FindTargetsObject")
require("shared/TableAlgorithms")
require("shared/ClusterCalculator")
CommonAiThreatTracking = CommonAiThreatTracking or class()
CommonAiThreatTracking.EVENT_CORRELATION_THRESHOLD = 0.8
CommonAiThreatTracking.EVENT_CORRELATION_MAX_TIME = 3
CommonAiThreatTracking.MAX_NON_UNIT_THREATS = 3
function CommonAiThreatTracking.init_data(A0_0, A1_1)
	local L2_2, L3_3
	L2_2 = {}
	A1_1._threat_tracking = L2_2
	L2_2 = A1_1._threat_tracking
	L3_3 = {}
	L2_2._threats = L3_3
	L2_2 = A1_1._threat_tracking
	L2_2._new_threats_last_processed_time = 0
	L2_2 = A1_1._threat_tracking
	L3_3 = {}
	L2_2._targets = L3_3
end
function CommonAiThreatTracking.logic_common_threat_tracking_main(A0_4, A1_5, A2_6, A3_7, A4_8, A5_9, A6_10, A7_11)
	local L8_12, L9_13, L10_14
	L9_13 = A2_6
	L8_12 = A2_6.ai_data
	L8_12 = L8_12(L9_13)
	L9_13 = L8_12._threat_tracking
	L10_14 = A0_4._find_targets
	L10_14 = L10_14(A0_4, A2_6, L8_12)
	A0_4:_process_damages(A1_5, L9_13, L8_12.input.buffered_damages, A2_6)
	A0_4:_purge_threats(A1_5, L9_13._threats, L8_12)
	A0_4:_process_events(A1_5, L9_13, L8_12._sensory_data, A2_6)
	A0_4:_try_to_blame(A2_6, L8_12, L9_13._threats, L10_14)
	A0_4:_scan_for_targets(A2_6, L8_12, L9_13._threats, L10_14, A1_5)
	A0_4:_update_unit_clusters(L9_13._threats, L8_12.threat_constants)
	A0_4:_update_threats(L9_13._threats, A1_5)
	if Global.category_debug_render["ai.threat"] then
		A0_4:_debug_render(A2_6, L8_12, L9_13, Global.category_debug_render["ai.threat"])
	end
	L8_12.output.has_threats = not TableAlgorithms.is_empty(L9_13._threats)
	return nil
end
function CommonAiThreatTracking._debug_render(A0_15, A1_16, A2_17, A3_18, A4_19)
	local L5_20, L6_21, L7_22, L8_23, L9_24, L10_25, L11_26, L12_27, L13_28, L14_29, L15_30, L16_31, L17_32
	if A4_19 ~= true then
		L6_21 = A1_16
		L5_20 = A1_16.name
		L5_20 = L5_20(L6_21)
		if L5_20 ~= A4_19 then
			return
		end
	end
	L5_20 = Draw
	L6_21 = L5_20
	L5_20 = L5_20.brush
	L5_20 = L5_20(L6_21)
	L6_21 = L5_20.set_persistance
	L6_21(L7_22, L8_23)
	L6_21 = Draw
	L6_21 = L6_21.brush
	L6_21 = L6_21(L7_22)
	L10_25 = 60
	L7_22(L8_23, L9_24, L10_25)
	L7_22(L8_23, L9_24)
	for L10_25, L11_26 in L7_22(L8_23) do
		L12_27 = nil
		L13_28 = alive
		L15_30 = L11_26
		L14_29 = L11_26.unit
		L17_32 = L14_29(L15_30)
		L13_28 = L13_28(L14_29, L15_30, L16_31, L17_32, L14_29(L15_30))
		if L13_28 then
			L13_28 = Color
			L14_29 = 1
			L15_30 = 0
			L16_31 = 0
			L13_28 = L13_28(L14_29, L15_30, L16_31)
			L12_27 = L13_28
		else
			L13_28 = Color
			L14_29 = 1
			L15_30 = 1
			L16_31 = 0
			L13_28 = L13_28(L14_29, L15_30, L16_31)
			L12_27 = L13_28
		end
		L14_29 = L6_21
		L13_28 = L6_21.set
		L15_30 = L12_27
		L16_31 = "OverlayVertexColorTextured"
		L13_28(L14_29, L15_30, L16_31)
		L14_29 = L5_20
		L13_28 = L5_20.set_color
		L15_30 = L12_27
		L13_28(L14_29, L15_30)
		L13_28 = "threat"
		L15_30 = A1_16
		L14_29 = A1_16.position
		L14_29 = L14_29(L15_30)
		L15_30 = Vector3
		L16_31 = 0
		L17_32 = 0
		L15_30 = L15_30(L16_31, L17_32, 100)
		L14_29 = L14_29 + L15_30
		L15_30 = nil
		L17_32 = L11_26
		L16_31 = L11_26.last_known_position
		L16_31 = L16_31(L17_32)
		if L16_31 then
			L17_32 = L11_26
			L16_31 = L11_26.last_known_position
			L16_31 = L16_31(L17_32)
			L15_30 = L16_31
		else
			L17_32 = A1_16
			L16_31 = A1_16.position
			L16_31 = L16_31(L17_32)
			L17_32 = L11_26.last_known_direction
			L17_32 = L17_32(L11_26)
			L17_32 = 1000 * L17_32
			L16_31 = L16_31 + L17_32
			L17_32 = Vector3
			L17_32 = L17_32(0, 0, 100)
			L15_30 = L16_31 + L17_32
		end
		L17_32 = L5_20
		L16_31 = L5_20.line
		L16_31(L17_32, L14_29, L15_30, 50)
		L17_32 = L11_26
		L16_31 = L11_26.unit_line_of_sight
		L16_31 = L16_31(L17_32)
		if L16_31 then
			L16_31 = L13_28
			L17_32 = " LOS "
			L13_28 = L16_31 .. L17_32
		end
		L17_32 = L11_26
		L16_31 = L11_26.unit_line_of_fire
		L16_31 = L16_31(L17_32)
		if L16_31 then
			L16_31 = L13_28
			L17_32 = " LOF "
			L13_28 = L16_31 .. L17_32
		end
		L17_32 = L11_26
		L16_31 = L11_26.unit
		L16_31 = L16_31(L17_32)
		if L16_31 then
			L16_31 = L13_28
			L17_32 = ": "
			L13_28 = L16_31 .. L17_32 .. L11_26:unit():name()
		end
		L17_32 = L11_26
		L16_31 = L11_26.associated_event
		L16_31 = L16_31(L17_32)
		if L16_31 then
			L17_32 = L11_26
			L16_31 = L11_26.associated_event
			L16_31 = L16_31(L17_32)
			L17_32 = L16_31
			L16_31 = L16_31.type_id
			L16_31 = L16_31(L17_32)
			L17_32 = L16_31
			for 