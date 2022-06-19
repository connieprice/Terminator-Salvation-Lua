require("mission_objective/MissionObjective")
MissionObjectiveManager = MissionObjectiveManager or class()
function MissionObjectiveManager.init(A0_0)
	A0_0._objectives = {}
	A0_0:load_objectives(File:new_parse_xml("data/settings/mission_objectives.xml"):children())
end
function MissionObjectiveManager.load_objectives(A0_1, A1_2)
	local L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11
	for L5_6 in A1_2, nil, nil do
		L7_8 = L5_6
		L6_7 = L5_6.parameter
		L8_9 = "id"
		L6_7 = L6_7(L7_8, L8_9)
		L7_8 = "all"
		L8_9 = assert
		L9_10 = L6_7
		L10_11 = "Missing mission objective id"
		L8_9(L9_10, L10_11)
		L8_9 = MissionObjective
		L9_10 = L8_9
		L8_9 = L8_9.new
		L10_11 = L6_7
		L8_9 = L8_9(L9_10, L10_11, L7_8)
		L10_11 = L5_6
		L9_10 = L5_6.parameter
		L9_10 = L9_10(L10_11, "text_id")
		L10_11 = L5_6.parameter
		L10_11 = L10_11(L5_6, "time")
		assert(L9_10, "Missing text_id for mission objective " .. L6_7)
		L8_9:set_text_id(L9_10)
		if L10_11 then
			L8_9:set_time(tonumber(L10_11))
		end
		A0_1._objectives[L6_7] = L8_9
	end
end
function MissionObjectiveManager.destroy(A0_12)
	local L1_13
end
function MissionObjectiveManager.objectives(A0_14)
	local L1_15
	L1_15 = A0_14._objectives
	return L1_15
end
function MissionObjectiveManager.objective(A0_16, A1_17)
	local L2_18
	L2_18 = assert
	L2_18(A1_17 ~= "", "No mission objective! Enter a Mission Objective ID.")
	L2_18 = A0_16._objectives
	L2_18 = L2_18[A1_17]
	assert(L2_18, "can not find objective " .. A1_17)
	return L2_18
end
