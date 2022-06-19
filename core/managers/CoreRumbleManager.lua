if not CoreRumbleManager then
	CoreRumbleManager = class()
end
CoreRumbleManager.init = function(l_1_0)
	l_1_0._last_played_ids = {}
	l_1_0._preset_rumbles = {}
	l_1_0._rumbling_controller_types = {}
	l_1_0:initialize_controller_types()
	l_1_0._registered_controllers = {}
	l_1_0._controller_to_unit_map = {}
	l_1_0._enabled = true
end

CoreRumbleManager.add_preset_rumbles = function(l_2_0, l_2_1, l_2_2)
	l_2_0._preset_rumbles[l_2_1] = l_2_2
end

CoreRumbleManager.initialize_controller_types = function(l_3_0)
	l_3_0._rumbling_controller_types.xbox360 = true
	l_3_0._rumbling_controller_types.ps3 = true
end

CoreRumbleManager.paused_update = function(l_4_0, l_4_1, l_4_2)
	l_4_0:update(l_4_1, l_4_2)
end

CoreRumbleManager.update = function(l_5_0, l_5_1, l_5_2)
end

CoreRumbleManager.stop = function(l_6_0, l_6_1)
	local l_6_5, l_6_6, l_6_7, l_6_8, l_6_9, l_6_10, l_6_14, l_6_15, l_6_16, l_6_17, l_6_18, l_6_19, l_6_20, l_6_21 = nil
	if l_6_1 then
		if l_6_1 == "all" then
			for i_0,i_1 in pairs(l_6_0._registered_controllers) do
				if i_1 then
					i_1:stop_rumble()
				end
			end
		end
	else
		for i_0,i_1 in pairs(l_6_1.controllers) do
			i_1:stop_rumble(l_6_1[1])
			if l_6_1[2] then
				i_1:stop_rumble(l_6_1[2])
			end
		end
	end
end

CoreRumbleManager.register_controller = function(l_7_0, l_7_1, l_7_2)
	if l_7_0._rumbling_controller_types[l_7_1.TYPE] then
		local l_7_3 = l_7_1:get_controller()
		l_7_0._registered_controllers[l_7_3:user_index()] = l_7_3
		l_7_0._controller_to_unit_map[l_7_3] = l_7_2
		return true
	end
end

CoreRumbleManager.set_enabled = function(l_8_0, l_8_1)
	l_8_0._enabled = l_8_1
	if not l_8_1 then
		l_8_0:stop("all")
	end
end

CoreRumbleManager.enabled = function(l_9_0)
	return l_9_0._enabled
end

CoreRumbleManager.play = function(l_10_0, l_10_1, l_10_2, l_10_3)
	local l_10_18, l_10_20, l_10_22, l_10_24, l_10_27 = nil
	if not l_10_0._enabled or not Global.rumble or not l_10_1 or not l_10_2 then
		return false
	end
	local l_10_4 = {}
	if l_10_2 == "all" then
		l_10_4 = l_10_0._registered_controllers
	elseif l_10_2.type_name == "Unit" then
		if alive(l_10_2) and l_10_2:base() then
			if not l_10_2:base()._is_husk then
				local l_10_5 = l_10_2:base():get_controller()
			end
		else
			local l_10_6, l_10_7, l_10_8, l_10_9, l_10_10 = false
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_10_6 and l_10_6:get_controller() and l_10_0._rumbling_controller_types[l_10_6.TYPE] then
			local l_10_11 = nil
			l_10_4[1] = l_10_6:get_controller()
		if l_10_0._registered_controllers[l_10_6:get_controller():user_index()] ~= l_10_6:get_controller() then
			end
			local l_10_17, l_10_19, l_10_21, l_10_23, l_10_26 = , l_10_0:register_controller, l_10_0, l_10_11, l_10_2
			l_10_19(l_10_21, l_10_23, l_10_26)
		end
	else
		if l_10_0._rumbling_controller_types[l_10_2.TYPE] then
			l_10_4[1] = l_10_2:get_controller()
		end
	end
	local l_10_12 = l_10_0._preset_rumbles[l_10_1]
	if l_10_12 then
		local l_10_13 = {}
		l_10_13.controllers = l_10_4
		l_10_13.name = l_10_1
		for i_0,i_1 in pairs(l_10_4) do
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_10_0._last_played_ids[i_1] and l_10_0._last_played_ids[i_1][l_10_1] and (i_1:is_rumble_playing(l_10_0._last_played_ids[i_1][l_10_1][1]) or i_1:is_rumble_playing(l_10_0._last_played_ids[i_1][l_10_1][2])) then
				l_10_0:stop(l_10_0._last_played_ids[i_1][l_10_1])
			end
			if not l_10_12.timer then
				local l_10_29, l_10_40, l_10_41 = , l_10_3 or 1, TimerManager:game()
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_10_12.engine == "hybrid" then
				local l_10_30 = nil
				local l_10_31 = nil
				local l_10_32 = not l_10_3 or type(l_10_3) ~= "table" or not l_10_3.func or l_10_3.func(l_10_0._controller_to_unit_map[l_10_36], l_10_3.params) or 1
				local l_10_33, l_10_34 = , table.insert
				do
					local l_10_35 = l_10_13
					l_10_34(l_10_35, 1, l_10_31:rumble({engine = "left", timer = l_10_33, peak = (l_10_12.peak.l or 1) * l_10_32, attack = l_10_12.attack.l, sustain = l_10_12.sustain.l, release = l_10_12.release.l}))
					l_10_34 = table
					l_10_34 = l_10_34.insert
					l_10_35 = l_10_13
					l_10_34(l_10_35, 2, l_10_31:rumble({engine = "right", timer = l_10_33, peak = (l_10_12.peak.r or 1) * l_10_32, attack = l_10_12.attack.r, sustain = l_10_12.sustain.r, release = l_10_12.release.r}))
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			else
				local l_10_37, l_10_38 = nil
				local l_10_39 = nil
				 -- DECOMPILER ERROR: Confused about usage of registers!

				l_10_13[1] = l_10_31:rumble({engine = l_10_12.engine, timer = l_10_33, peak = (l_10_12.peak or 1) * l_10_39, attack = l_10_12.attack, sustain = l_10_12.sustain, release = l_10_12.release})
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			if not l_10_12.cumulative then
				if not l_10_0._last_played_ids[l_10_38] then
					l_10_0._last_played_ids[l_10_38] = {}
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				l_10_0._last_played_ids[l_10_38][l_10_1] = l_10_13
			end
		end
		return l_10_13
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		l_10_13 = Application
		l_10_13(l_10_13, "CoreRumbleManager:: Effect ", l_10_1, " not found.")
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreRumbleManager.set_multiplier = function(l_11_0, l_11_1, l_11_2)
	local l_11_7, l_11_8, l_11_9, l_11_10, l_11_11, l_11_12, l_11_13, l_11_14, l_11_15, l_11_16, l_11_17, l_11_18 = nil
	if not l_11_0._enabled or not Global.rumble or not l_11_1 or not l_11_2 then
		return false
	end
	do
		local l_11_3 = l_11_0._preset_rumbles[l_11_1.name]
		for i_0,i_1 in pairs(l_11_1.controllers) do
			if not l_11_3.peak.l then
				i_1:set_rumble_peak(l_11_1[1], (not l_11_1[2] or 1) * l_11_2)
			end
			i_1:set_rumble_peak(l_11_1[2], (l_11_3.peak.r or 1) * l_11_2)
			for i_0,i_1 in l_11_4 do
				i_1:set_rumble_peak(l_11_1[1], (l_11_3.peak or 1) * l_11_2)
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

CoreRumbleManager.mult_distance_lerp = function(l_12_0, l_12_1, l_12_2)
	if not l_12_2.full_dis then
		local l_12_3, l_12_4, l_12_6, l_12_8 = not alive(l_12_1) or 0
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_12_2.zero_dis then
		local l_12_5, l_12_7, l_12_9 = , 1000 - l_12_3
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	return (l_12_2.multiplier or 1) * (l_12_7 - math.clamp(l_12_2.source - l_12_1:position():length() - l_12_5, 0, l_12_7)) / l_12_7
	return 0
end


