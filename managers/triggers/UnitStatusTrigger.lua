require("units/editor/UnitStatusCondition")
UnitStatusTrigger = UnitStatusTrigger or class(CoreTriggerBase)
function UnitStatusTrigger.init(A0_0, A1_1, A2_2, A3_3)
	CoreTriggerBase.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._name = A2_2:parameter("name")
	A0_0._status_type = A2_2:parameter("status_type")
	A0_0._threshold = tonumber(A2_2:parameter("threshold"))
	A0_0._hub_element_name = A2_2:parameter("hub_element_name")
	A0_0:parse_hitzones(A2_2:parameter("hitzones_alive"), A2_2:parameter("hitzones_destroyed"))
	managers.unit_scripting:get_unit_by_name_callback(A0_0._name, callback(A0_0, A0_0, "unit_spawned"))
end
function UnitStatusTrigger.parse_hitzones(A0_4, A1_5, A2_6)
	local L3_7, L4_8, L5_9, L6_10, L7_11, L8_12
	L3_7 = {}
	L4_8 = {}
	if L3_7 then
		for L8_12 in L5_9(L6_10, L7_11) do
			table.insert(L3_7, tonumber(L8_12))
		end
	end
	if L4_8 then
		for L8_12 in L5_9(L6_10, L7_11) do
			table.insert(L4_8, tonumber(L8_12))
		end
	end
	L5_9.alive = L3_7
	L5_9.destroyed = L4_8
	A0_4._hitzones = L5_9
end
function UnitStatusTrigger.unit_spawned(A0_13, A1_14)
	local L2_15
	L2_15 = UnitStatusCondition
	L2_15 = L2_15.new
	L2_15 = L2_15(L2_15, A0_13._status_type, callback(A0_13, A0_13, "status_achieved"))
	L2_15.threshold = A0_13._threshold
	L2_15.hitzones = A0_13._hitzones
	L2_15.hub_element_name = A0_13._hub_element_name
	A1_14:base():register_status_callback(L2_15)
end
function UnitStatusTrigger.status_achieved(A0_16)
	A0_16._user:trigger_activated(A0_16._id, 1)
end
