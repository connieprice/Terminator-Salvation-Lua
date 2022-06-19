AreaGroup = AreaGroup or class(CoreAreaGroup)
function AreaGroup.init(A0_0, A1_1, A2_2, A3_3)
	CoreAreaGroup.init(A0_0, A1_1, A2_2, A3_3)
end
function AreaGroup.set_properties(A0_4, A1_5)
	CoreAreaGroup.set_properties(A0_4, A1_5)
	A0_4._unit_infos = A1_5.unit_infos
	if A1_5.condition_all then
		A0_4._condition = TableAlgorithms.count(A0_4._unit_infos)
	else
		A0_4._condition = A1_5.condition_number
	end
end
function AreaGroup.activate(A0_6)
	cat_debug("gaspode", "-- AreaGroup:activate - area:", A0_6._name)
	A0_6:insert_units_in_unit_vector()
	CoreAreaGroup.activate(A0_6)
end
function AreaGroup.insert_units_in_unit_vector(A0_7)
	local L1_8, L2_9, L3_10, L4_11, L5_12, L6_13, L7_14
	L1_8 = {}
	for L5_12, L6_13 in L2_9(L3_10) do
		L7_14 = nil
		if managers.unit_scripting:unit_exists(L6_13.script_name) then
			L7_14 = managers.unit_scripting:get_unit_by_name(L6_13.script_name)
		end
		if alive(L7_14) and (not L7_14:damage_data() or not L7_14:damage_data():is_fully_damaged()) then
			table.insert(A0_7._units_vector, L7_14)
		end
	end
end
function AreaGroup.check_area_group(A0_15)
	A0_15._units_vector = {}
	A0_15:insert_units_in_unit_vector()
	CoreAreaGroup.check_area_group(A0_15)
end
