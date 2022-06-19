require("units/beings/rail/RailNpc/RailNpc")
if not Driver then
	Driver = class(RailNpc)
end
Driver._MAX_TURNING = 20
Driver.init = function(l_1_0, l_1_1)
	RailNpc.init(l_1_0, l_1_1)
end

Driver.setup = function(l_2_0, l_2_1)
	l_2_0._is_driver = l_2_1
end

Driver.set_vehicle = function(l_3_0, l_3_1)
	RailNpc.set_vehicle(l_3_0, l_3_1)
	if not l_3_0._is_driver then
		return 
	end
	l_3_0._turn_wheel = l_3_0._vehicle:get_object("at_wheel_lf")
	if l_3_1:name():find("pickup") or l_3_1:name():find("ram") then
		l_3_0._anim_machine:play_redirect("turn_pickup")
	end
	if l_3_1:name():find("van") then
		l_3_0._anim_machine:play_redirect("turn_van")
	end
	if l_3_1:name():find("rail_vehicle_school_bus") then
		l_3_0._anim_machine:play_redirect("turn_school_bus")
	end
	if l_3_1:name():find("rail_vehicle_buggy") then
		l_3_0._anim_machine:play_redirect("turn_buggy")
	end
end

Driver.update = function(l_4_0, l_4_1, l_4_2, l_4_3)
	RailNpc.update(l_4_0, l_4_1, l_4_2, l_4_3)
	if not l_4_0._is_driver then
		return 
	end
	if alive(l_4_0._vehicle) then
		if l_4_0._vehicle:name() == "rail_vehicle_buggy" then
			if l_4_0._turn_wheel:new_local_rotation():roll() > 0 then
				local l_4_4 = 180 - l_4_0._turn_wheel:new_local_rotation():roll()
			end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		elseif l_4_4 < 0 then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		do
			local l_4_5 = -180 - l_4_4
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		local l_4_6 = nil
		l_4_0._anim_machine:set_global("turn", 0.5 - l_4_5 / (2 * Driver._MAX_TURNING))
	end
end


