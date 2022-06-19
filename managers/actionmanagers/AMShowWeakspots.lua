require("shared/TableAlgorithms")
AMShowWeakspots = AMShowWeakspots or class(CoreActionElement)
function AMShowWeakspots.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMShowWeakspots.activate_now(A0_3)
	local L1_4, L2_5, L3_6, L4_7, L5_8, L6_9, L7_10, L8_11, L9_12, L10_13, L11_14, L12_15, L13_16
	L1_4 = Application
	L1_4 = L1_4.debug
	L5_8 = "range="
	L6_9 = A0_3.range
	L1_4(L2_5, L3_6, L4_7, L5_8, L6_9)
	L1_4 = A0_3.targets
	if L1_4 then
		L1_4 = A0_3._get_units_by_names
		L1_4 = L1_4(L2_5, L3_6)
		for L5_8, L6_9 in L2_5(L3_6) do
			L8_11 = L6_9
			L7_10 = L6_9.damage
			L7_10 = L7_10(L8_11)
			L8_11 = L7_10
			L7_10 = L7_10.set_show_weakspots
			L7_10(L8_11, L9_12, L10_13)
		end
		for L5_8 = 1, 2 do
			L6_9 = managers
			L6_9 = L6_9.player_slot
			L7_10 = L6_9
			L6_9 = L6_9.slot
			L8_11 = L5_8
			L6_9 = L6_9(L7_10, L8_11)
			if L6_9 then
				L8_11 = L6_9
				L7_10 = L6_9.spawned_unit
				L7_10 = L7_10(L8_11)
				if L7_10 then
					L8_11 = L7_10.player_data
					L8_11 = L8_11(L9_12)
					L8_11 = L8_11.weakspot_unit_list
					for L12_15, L13_16 in L9_12(L10_13) do
						table.insert(L8_11, L13_16)
					end
				end
			end
		end
	end
	L1_4 = A0_3.deactivate_now
	L1_4(L2_5)
end
function AMShowWeakspots._get_units_by_names(A0_17, A1_18)
	local L2_19, L3_20, L4_21, L5_22, L6_23, L7_24, L8_25
	L2_19 = {}
	for L6_23, L7_24 in L3_20(L4_21) do
		L8_25 = managers
		L8_25 = L8_25.unit_scripting
		L8_25 = L8_25.get_unit_by_name
		L8_25 = L8_25(L8_25, L7_24.script_name)
		table.insert(L2_19, L8_25)
	end
	return L2_19
end
