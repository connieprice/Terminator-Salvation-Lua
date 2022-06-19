require("units/UnitPhysics")
PlayerPhysics = PlayerPhysics or class(UnitPhysics)
PlayerPhysics._FOUR_WAY_REDIRECTS = {
	[Polar(1, 0, 180)] = "from_front",
	[Polar(1, 0, 270)] = "from_left",
	[Polar(1, 0, 0)] = "from_back",
	[Polar(1, 0, 90)] = "from_right"
}
function PlayerPhysics.push(A0_0, A1_1, A2_2, A3_3)
	local L4_4
	if A3_3 == "strike_of_death" and A0_0._unit:player_data().revive_when_fully_damaged then
		L4_4 = "strike_of_death_" .. A0_0:_four_way_redirect(A2_2)
	else
		L4_4 = "hurt_" .. A0_0:_four_way_redirect(A2_2)
	end
	if L4_4 then
		A0_0._unit:play_redirect(L4_4)
	end
end
function PlayerPhysics._four_way_redirect(A0_5, A1_6)
	local L2_7, L3_8, L4_9, L5_10, L6_11
	L2_7 = A0_5._unit
	L4_9 = L2_7
	L3_8 = L2_7.rotation
	L3_8 = L3_8(L4_9)
	L5_10 = A1_6
	L4_9 = A1_6.to_polar_with_reference
	L6_11 = L3_8.y
	L6_11 = L6_11(L3_8)
	L4_9 = L4_9(L5_10, L6_11, math.UP)
	L5_10, L6_11 = nil, nil
	for 