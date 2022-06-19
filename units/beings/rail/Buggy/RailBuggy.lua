if not RailBuggy then
	RailBuggy = class(RailWheeledVehicle)
end
RailBuggy.init = function(l_1_0, l_1_1)
	RailWheeledVehicle.init(l_1_0, l_1_1)
end

RailBuggy.update = function(l_2_0, l_2_1, l_2_2, l_2_3)
	RailWheeledVehicle.update(l_2_0, l_2_1, l_2_2, l_2_3)
end

RailBuggy.brace_needed = function(l_3_0)
	if l_3_0._total_current_rot.x > 10 or l_3_0._total_current_rot.y > 10 then
		return true
	end
	return true
end


