RailPickup = RailPickup or class(RailWheeledVehicle)
function RailPickup.init(A0_0, A1_1)
	RailWheeledVehicle.init(A0_0, A1_1)
	managers.action_event:register_listener(A0_0, A1_1, A1_1)
end
function RailPickup.driver_leave(A0_2)
	A0_2._driver:play_redirect("driver_leave")
end
function RailPickup.driver_outside_point(A0_3)
	A0_3._driver:play_redirect("driver_point")
end
function RailPickup.passenger_talk_and_driver_exit(A0_4)
	A0_4._passenger:play_redirect("talk")
	A0_4._driver:play_redirect("driver_exit")
	A0_4._unit:play_redirect("door")
end
function RailPickup.player_in_turret_point(A0_5)
	A0_5:get_first_linked_player():play_redirect("turret_point")
	if A0_5:get_first_linked_player():base()._current_state._name == "PlayerOnRailTurret" then
		A0_5:get_first_linked_player():base()._current_state:let_go_off_weapon()
	end
end
function RailPickup.player_jump_to_ram(A0_6)
	local L1_7, L2_8, L3_9, L4_10, L5_11, L6_12, L7_13
	L2_8 = A0_6
	L1_7 = A0_6.get_first_linked_player
	L1_7 = L1_7(L2_8)
	L2_8 = L1_7.play_redirect
	L2_8(L3_9, L4_10)
	L2_8 = World
	L2_8 = L2_8.find_units_quick
	L6_12 = L5_11
	L7_13 = "rail_vehicles"
	L7_13 = L5_11(L6_12, L7_13)
	L2_8 = L2_8(L3_9, L4_10, L5_11, L6_12, L7_13, L5_11(L6_12, L7_13))
	for L6_12, L7_13 in L3_9(L4_10) do
		if L7_13:name():find("ram") then
			L1_7:rail():enter_vehicle(L7_13, "turret_seat")
		end
	end
end
function RailPickup.update(A0_14, A1_15, A2_16, A3_17)
	RailWheeledVehicle.update(A0_14, A1_15, A2_16, A3_17)
end
function RailPickup.brace_needed(A0_18)
	local L1_19
	L1_19 = A0_18._total_current_rot
	L1_19 = L1_19.x
	if not (L1_19 > 10) then
		L1_19 = A0_18._total_current_rot
		L1_19 = L1_19.y
	elseif L1_19 > 10 then
		L1_19 = true
		return L1_19
	end
	L1_19 = true
	return L1_19
end
function RailPickup.destroy(A0_20)
	RailWheeledVehicle.destroy(A0_20)
	managers.action_event:unregister_listener(A0_20)
end
function RailPickup.feedback_bullet_hit(A0_21, A1_22, A2_23, A3_24)
	if A1_22 == A0_21:get_first_linked_player() then
		if A3_24 ~= A2_23.unit:slot() and A3_24 == 4 then
			managers.rumble:play_preset("rail_weapon_m2_killing_hit", A0_21._unit:get_object("a_player_turret"):position())
		elseif A2_23.unit:in_slot(managers.slot:get_mask("enemies")) then
			managers.rumble:play_preset("rail_weapon_m2_hit", A0_21._unit:get_object("a_player_turret"):position())
		end
	end
end
