require("mission_objective/MissionObjective")
if not MissionObjectiveManager then
	MissionObjectiveManager = class()
end
MissionObjectiveManager.init = function(l_1_0)
	l_1_0._objectives = {}
	local l_1_1 = File:new_parse_xml("data/settings/mission_objectives.xml")
	l_1_0:load_objectives(l_1_1:children())
end

MissionObjectiveManager.load_objectives = function(l_2_0, l_2_1)
	local l_2_5, l_2_6 = nil
	local l_2_2 = l_2_1
	for i_0 in l_2_2 do
		local l_2_8 = i_0:parameter("id")
		assert(l_2_8, "Missing mission objective id")
		local l_2_9 = nil
		local l_2_10 = MissionObjective:new(l_2_8, "all")
		local l_2_11 = l_2_7:parameter("text_id")
		assert(l_2_11, "Missing text_id for mission objective " .. l_2_8)
		l_2_10:set_text_id(l_2_11)
		if l_2_7:parameter("time") then
			l_2_10:set_time(tonumber(l_2_7:parameter("time")))
		end
		l_2_0._objectives[l_2_8] = l_2_10
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MissionObjectiveManager.destroy = function(l_3_0)
end

MissionObjectiveManager.objectives = function(l_4_0)
	return l_4_0._objectives
end

MissionObjectiveManager.objective = function(l_5_0, l_5_1)
	local l_5_2 = assert
	l_5_2(l_5_1 ~= "", "No mission objective! Enter a Mission Objective ID.")
	l_5_2 = l_5_0._objectives
	l_5_2 = l_5_2[l_5_1]
	assert(l_5_2, "can not find objective " .. l_5_1)
	return l_5_2
end


