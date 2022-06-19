RailBuggy = RailBuggy or class(RailWheeledVehicle)
function RailBuggy.init(A0_0, A1_1)
	RailWheeledVehicle.init(A0_0, A1_1)
end
function RailBuggy.update(A0_2, A1_3, A2_4, A3_5)
	RailWheeledVehicle.update(A0_2, A1_3, A2_4, A3_5)
end
function RailBuggy.brace_needed(A0_6)
	local L1_7
	L1_7 = A0_6._total_current_rot
	L1_7 = L1_7.x
	if not (L1_7 > 10) then
		L1_7 = A0_6._total_current_rot
		L1_7 = L1_7.y
	elseif L1_7 > 10 then
		L1_7 = true
		return L1_7
	end
	L1_7 = true
	return L1_7
end
