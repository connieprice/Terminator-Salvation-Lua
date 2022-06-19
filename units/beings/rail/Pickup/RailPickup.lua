if not RailPickup then
	RailPickup = class(RailWheeledVehicle)
end
RailPickup.init = function(l_1_0, l_1_1)
	RailWheeledVehicle.init(l_1_0, l_1_1)
	managers.action_event:register_listener(l_1_0, l_1_1, l_1_1)
end

RailPickup.driver_leave = function(l_2_0)
	l_2_0._driver:play_redirect("driver_leave")
end

RailPickup.driver_outside_point = function(l_3_0)
	l_3_0._driver:play_redirect("driver_point")
end

RailPickup.passenger_talk_and_driver_exit = function(l_4_0)
	l_4_0._passenger:play_redirect("talk")
	l_4_0._driver:play_redirect("driver_exit")
	l_4_0._unit:play_redirect("door")
end

RailPickup.player_in_turret_point = function(l_5_0)
	local l_5_1 = l_5_0:get_first_linked_player()
	l_5_1:play_redirect("turret_point")
	local l_5_2 = l_5_1:base()._current_state
	if l_5_2._name == "PlayerOnRailTurret" then
		l_5_2:let_go_off_weapon()
	end
end

RailPickup.player_jump_to_ram = function(l_6_0)
	local l_6_1 = l_6_0:get_first_linked_player()
	l_6_1:play_redirect("jump_to_ram")
	local l_6_6, l_6_7 = World:find_units_quick, World
	l_6_6 = l_6_6(l_6_7, "all", managers.slot:get_mask("rail_vehicles"))
	local l_6_2 = nil
	l_6_7 = pairs
	l_6_2 = l_6_6
	l_6_7 = l_6_7(l_6_2)
	for i_0,i_1 in l_6_7 do
		if l_6_5:name():find("ram") then
			l_6_1:rail():enter_vehicle(l_6_5, "turret_seat")
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RailPickup.update = function(l_7_0, l_7_1, l_7_2, l_7_3)
	RailWheeledVehicle.update(l_7_0, l_7_1, l_7_2, l_7_3)
end

RailPickup.brace_needed = function(l_8_0)
	if l_8_0._total_current_rot.x > 10 or l_8_0._total_current_rot.y > 10 then
		return true
	end
	return true
end

RailPickup.destroy = function(l_9_0)
	RailWheeledVehicle.destroy(l_9_0)
	managers.action_event:unregister_listener(l_9_0)
end

RailPickup.feedback_bullet_hit = function(l_10_0, l_10_1, l_10_2, l_10_3)
	if l_10_1 == l_10_0:get_first_linked_player() then
		local l_10_4 = l_10_2.unit
		local l_10_5 = l_10_4:in_slot(managers.slot:get_mask("enemies"))
		if l_10_3 ~= l_10_4:slot() and l_10_3 == 4 then
			managers.rumble:play_preset("rail_weapon_m2_killing_hit", l_10_0._unit:get_object("a_player_turret"):position())
		end
	elseif l_10_5 then
		managers.rumble:play_preset("rail_weapon_m2_hit", l_10_0._unit:get_object("a_player_turret"):position())
	end
end


