AMRailVehicleEditSeat = AMRailVehicleEditSeat or class(CoreActionElement)
function AMRailVehicleEditSeat.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
	tweak_data.rail.rail_level = true
end
function AMRailVehicleEditSeat.activate_now(A0_3)
	local L1_4, L2_5, L3_6, L4_7, L5_8, L6_9, L7_10, L8_11
	L1_4 = managers
	L1_4 = L1_4.unit_scripting
	L2_5 = L1_4
	L1_4 = L1_4.get_unit_by_name
	L1_4 = L1_4(L2_5, L3_6)
	if L1_4 == nil then
		return
	end
	L2_5 = L1_4.base
	L2_5 = L2_5(L3_6)
	L2_5 = L2_5.get_players_in_vehicle
	L2_5 = L2_5(L3_6)
	for L6_9, L7_10 in L3_6(L4_7) do
		L8_11 = L7_10.player_data
		L8_11 = L8_11(L7_10)
		L8_11 = L8_11.on_rail_vehicle
		if L8_11 then
			L8_11 = L1_4.base
			L8_11 = L8_11(L1_4)
			L8_11 = L8_11.get_seat
			L8_11 = L8_11(L8_11, L7_10)
			assert(L8_11)
			L8_11:set_rotation(Rotation(0, 0, A0_3.rotation))
			L7_10:player_data().rail_seat_modified = true
		end
	end
	L3_6(L4_7)
end
