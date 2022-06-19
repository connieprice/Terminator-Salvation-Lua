require("units/beings/rail/RailNpc/RailNpc")
Driver = Driver or class(RailNpc)
Driver._MAX_TURNING = 20
function Driver.init(A0_0, A1_1)
	RailNpc.init(A0_0, A1_1)
end
function Driver.setup(A0_2, A1_3)
	A0_2._is_driver = A1_3
end
function Driver.set_vehicle(A0_4, A1_5)
	RailNpc.set_vehicle(A0_4, A1_5)
	if not A0_4._is_driver then
		return
	end
	A0_4._turn_wheel = A0_4._vehicle:get_object("at_wheel_lf")
	if A1_5:name():find("pickup") or A1_5:name():find("ram") then
		A0_4._anim_machine:play_redirect("turn_pickup")
	end
	if A1_5:name():find("van") then
		A0_4._anim_machine:play_redirect("turn_van")
	end
	if A1_5:name():find("rail_vehicle_school_bus") then
		A0_4._anim_machine:play_redirect("turn_school_bus")
	end
	if A1_5:name():find("rail_vehicle_buggy") then
		A0_4._anim_machine:play_redirect("turn_buggy")
	end
end
function Driver.update(A0_6, A1_7, A2_8, A3_9)
	local L4_10, L5_11
	L4_10 = RailNpc
	L4_10 = L4_10.update
	L5_11 = A0_6
	L4_10(L5_11, A1_7, A2_8, A3_9)
	L4_10 = A0_6._is_driver
	if not L4_10 then
		return
	end
	L4_10 = alive
	L5_11 = A0_6._vehicle
	L4_10 = L4_10(L5_11)
	if L4_10 then
		L4_10 = A0_6._turn_wheel
		L5_11 = L4_10
		L4_10 = L4_10.new_local_rotation
		L4_10 = L4_10(L5_11)
		L5_11 = L4_10
		L4_10 = L4_10.roll
		L4_10 = L4_10(L5_11)
		L5_11 = A0_6._vehicle
		L5_11 = L5_11.name
		L5_11 = L5_11(L5_11)
		if L5_11 == "rail_vehicle_buggy" then
			if L4_10 > 0 then
				L4_10 = 180 - L4_10
			elseif L4_10 < 0 then
				L4_10 = -180 - L4_10
			else
				L4_10 = 0
			end
		end
		L5_11 = Driver
		L5_11 = L5_11._MAX_TURNING
		L5_11 = 2 * L5_11
		L5_11 = L4_10 / L5_11
		L5_11 = 0.5 - L5_11
		A0_6._anim_machine:set_global("turn", L5_11)
	end
end
