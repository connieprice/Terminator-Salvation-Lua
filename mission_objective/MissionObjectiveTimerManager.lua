require("mission_objective/MissionObjectiveTimer")
if not MissionObjectiveTimerManager then
	MissionObjectiveTimerManager = class()
end
MissionObjectiveTimerManager.init = function(l_1_0)
	l_1_0._timers = {}
end

MissionObjectiveTimerManager.destroy = function(l_2_0)
end

MissionObjectiveTimerManager.update = function(l_3_0, l_3_1)
	local l_3_5, l_3_6, l_3_7, l_3_8 = nil
	for i_0,i_1 in pairs(l_3_0._timers) do
		i_1:update(l_3_1)
	end
end

MissionObjectiveTimerManager.add_objective_timer = function(l_4_0, l_4_1, l_4_2, l_4_3)
	local l_4_4 = MissionObjectiveTimer:new(l_4_2, l_4_3)
	l_4_0._timers[l_4_4] = l_4_4
	return l_4_4
end

MissionObjectiveTimerManager.remove_objective_timer = function(l_5_0, l_5_1)
	l_5_0._timers[l_5_1] = nil
end


