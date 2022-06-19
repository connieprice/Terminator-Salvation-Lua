if not UnitSpawnUtility then
	UnitSpawnUtility = {}
end
UnitSpawnUtility.spawn_position = function(l_1_0, l_1_1, l_1_2)
	if l_1_0 and #l_1_0 > 0 then
		local l_1_3 = l_1_0[1].waypoints
		local l_1_4 = UnitSpawnUtility.spawn_position_from_waypoints(l_1_3)
		do
			local l_1_5 = l_1_3 or l_1_2
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		return l_1_4, l_1_5
	end
	return l_1_1, l_1_2
end

UnitSpawnUtility.spawn_position_from_waypoints = function(l_2_0)
	local l_2_1, l_2_2 = nil, nil
	l_2_1 = l_2_0[1].position
	assert(l_2_1, "there must be a position defined on the first waypoint")
	if #l_2_0 ~= 1 then
		l_2_2 = Rotation:look_at(l_2_0[1].position, l_2_0[2].position, math.UP)
	else
		l_2_2 = l_2_0[1].rotation
	end
	return l_2_1, l_2_2
end

UnitSpawnUtility.warp_to = function(l_3_0, l_3_1, l_3_2)
	if alive(l_3_0) then
		local l_3_3 = l_3_0:base()
		if l_3_3 and l_3_3.warp_to then
			l_3_3:warp_to(l_3_1, l_3_2)
		else
			l_3_0:warp_to(l_3_1, l_3_2)
		end
		local l_3_4 = l_3_0:ai_nerve_system()
		if l_3_4 then
			l_3_4:warp_to(l_3_1, l_3_2)
		end
	else
		Application:error("Unit not found!")
	end
end


