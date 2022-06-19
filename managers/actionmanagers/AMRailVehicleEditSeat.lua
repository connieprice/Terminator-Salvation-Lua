if not AMRailVehicleEditSeat then
	AMRailVehicleEditSeat = class(CoreActionElement)
end
AMRailVehicleEditSeat.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
	tweak_data.rail.rail_level = true
end

AMRailVehicleEditSeat.activate_now = function(l_2_0)
	local l_2_6, l_2_7, l_2_8, l_2_9, l_2_10, l_2_11 = nil
	local l_2_1 = managers.unit_scripting:get_unit_by_name(l_2_0.vehicle_name)
	if l_2_1 == nil then
		return 
	end
	local l_2_2 = l_2_1:base():get_players_in_vehicle()
	for i_0,i_1 in pairs(l_2_2) do
		if i_1:player_data().on_rail_vehicle then
			assert(l_2_1:base():get_seat(i_1))
			l_2_1:base():get_seat(i_1):set_rotation(Rotation(0, 0, l_2_0.rotation))
			i_1:player_data().rail_seat_modified = true
		end
	end
	l_2_0:deactivate_now()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


