require("units/UnitPhysics")
if not PlayerPhysics then
	PlayerPhysics = class(UnitPhysics)
end
local l_0_0 = PlayerPhysics
local l_0_1 = {}
l_0_1[Polar(1, 0, 180)] = "from_front"
l_0_1[Polar(1, 0, 270)] = "from_left"
l_0_1[Polar(1, 0, 0)] = "from_back"
l_0_1[Polar(1, 0, 90)] = "from_right"
l_0_0._FOUR_WAY_REDIRECTS = l_0_1
l_0_0 = PlayerPhysics
l_0_1 = function(l_1_0, l_1_1, l_1_2, l_1_3)
	if l_1_3 == "strike_of_death" and l_1_0._unit:player_data().revive_when_fully_damaged then
		local l_1_4, l_1_5, l_1_6, l_1_8, l_1_9 = "strike_of_death_" .. l_1_0:_four_way_redirect(l_1_2)
	else
		local l_1_7 = nil
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_1_7 then
		local l_1_10 = nil
		l_1_1 * l_1_2:play_redirect(l_1_10)
	end
end

l_0_0.push = l_0_1
l_0_0 = PlayerPhysics
l_0_1 = function(l_2_0, l_2_1)
	local l_2_10, l_2_11, l_2_12, l_2_13, l_2_14 = nil
	local l_2_2 = l_2_0._unit
	local l_2_3 = l_2_2:rotation()
	local l_2_4 = (l_2_1:to_polar_with_reference(l_2_3:y(), math.UP))
	local l_2_5, l_2_6 = nil, nil
	for i_0,i_1 in pairs(PlayerPhysics._FOUR_WAY_REDIRECTS) do
		if not l_2_6 or math.abs(i_0 - l_2_4.spin) < l_2_6 then
			l_2_5 = i_1
			l_2_6 = math.abs(i_0 - l_2_4.spin)
		end
	end
	return l_2_5
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0._four_way_redirect = l_0_1

