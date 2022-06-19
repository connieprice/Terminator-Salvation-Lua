require("shared/TableAlgorithms")
if not RumbleManager then
	RumbleManager = class()
end
RumbleManager.init = function(l_1_0)
	l_1_0._listeners = {}
	l_1_0._listeners_id = 0
	l_1_0._listeners_count = 0
	l_1_0._effects = {}
	l_1_0._effects_id = 0
	l_1_0._effects_count = 0
	l_1_0._presets = {}
	l_1_0:load_presets()
end

local l_0_0 = function(l_2_0, l_2_1)
	local l_2_2 = math.clamp
	local l_2_3 = l_2_0 / l_2_1
	local l_2_4 = 0
	local l_2_5 = 1
	return l_2_2(l_2_3, l_2_4, l_2_5)
end

local l_0_1 = function(l_3_0, l_3_1)
	local l_3_2 = math.log10
	local l_3_4 = math.clamp
	local l_3_5 = l_3_0 / l_3_1
	local l_3_6 = 0
	l_3_4 = l_3_4(l_3_5, l_3_6, 1)
	l_3_4 = 9 * l_3_4
	l_3_4 = 1 + l_3_4
	local l_3_3 = nil
	return l_3_2(l_3_4)
end

RumbleManager.presets = function(l_4_0)
	local l_4_5, l_4_6, l_4_7 = nil
	local l_4_1 = {}
	for i_0,i_1 in pairs(l_4_0._presets) do
		table.insert(l_4_1, i_0)
	end
	return l_4_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RumbleManager.load_presets = function(l_5_0)
	local l_5_5, l_5_6 = nil
	do
		local l_5_1 = File:new_parse_xml("data/effects/global_rumble_effects.xml")
		for i_0 in l_5_1:children() do
			l_5_0._presets[i_0:parameter("name")] = {}
			if l_5_7:has_parameter("radius") then
				l_5_0._presets[i_0:parameter("name")].radius = tonumber(l_5_7:parameter("radius"))
			else
				l_5_0._presets[i_0:parameter("name")].radius = 100
			end
			do
				if l_5_7:has_parameter("scale") then
					local l_5_8 = nil
					l_5_0._presets[l_5_8].scale = l_5_7:parameter("scale")
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			else
				l_5_0._presets[l_5_8].scale = "linear"
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_5_7:has_parameter("spatial") then
				local l_5_9 = nil
				do
					local l_5_15, l_5_16, l_5_17 = l_5_0._presets[l_5_8], l_5_7:parameter, l_5_7
					l_5_16 = l_5_16(l_5_17, "spatial")
					l_5_16 = l_5_16 == "true"
					l_5_15.position_3d = l_5_16
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			else
				l_5_0._presets[l_5_9].position_3d = true
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_5_0._presets[l_5_9].atoms = {}
			for i_0 in l_5_7:children() do
				local l_5_12 = nil
				if l_5_19:has_parameter("engine") then
					do return end
				end
				if l_5_19:has_parameter("peak") then
					do return end
				end
				if l_5_19:has_parameter("attack") then
					do return end
				end
				if l_5_19:has_parameter("sustain") then
					do return end
				end
				if l_5_19:has_parameter("release") then
					do return end
				end
				table.insert(l_5_0._presets[l_5_12].atoms, {engine = l_5_19:parameter("engine"), engine = RumbleManager._ENGINE_BOTH, peak = tonumber(l_5_19:parameter("peak")), peak = 0, attack = tonumber(l_5_19:parameter("attack")), attack = 0, sustain = tonumber(l_5_19:parameter("sustain")), sustain = 0, release = tonumber(l_5_19:parameter("release")), release = 0})
			end
		end
	end
	 -- WARNING: undefined locals caused missing assignments!
end

RumbleManager.create_listener = function(l_6_0, l_6_1)
	l_6_0._effects_id = l_6_0._effects_id + 1
	local l_6_2 = l_6_0._listeners
	local l_6_3 = l_6_0._effects_id
	local l_6_4 = {}
	l_6_4.controller = l_6_1
	l_6_4.position = Vector3(0, 0, 0)
	l_6_4.rotation = Rotation()
	l_6_4.effects = {}
	l_6_2[l_6_3] = l_6_4
	l_6_2 = l_6_0._listeners_count
	l_6_2 = l_6_2 + 1
	l_6_0._listeners_count = l_6_2
	l_6_2 = l_6_0._effects_id
	return l_6_2
end

RumbleManager.destroy_listener = function(l_7_0, l_7_1)
	local l_7_2 = assert
	l_7_2(l_7_0._listeners[l_7_1] ~= nil)
	l_7_2 = l_7_0._listeners
	l_7_2[l_7_1] = nil
	l_7_2 = l_7_0._listeners_count
	l_7_2 = l_7_2 - 1
	l_7_0._listeners_count = l_7_2
end

RumbleManager.set_listener_position = function(l_8_0, l_8_1, l_8_2)
	local l_8_3 = l_8_0._listeners[l_8_1]
	if l_8_3 then
		l_8_3.position = l_8_2
	end
end

RumbleManager.set_listener_rotation = function(l_9_0, l_9_1, l_9_2)
	local l_9_3 = l_9_0._listeners[l_9_1]
	if l_9_3 then
		l_9_3.rotation = l_9_2
	end
end

RumbleManager.play_preset = function(l_10_0, l_10_1, l_10_2)
	local l_10_3 = l_10_0._presets[l_10_1]
	if l_10_3 then
		local l_10_4, l_10_5 = l_10_0:play, l_10_0
		local l_10_6 = l_10_3
		local l_10_7 = l_10_2
		return l_10_4(l_10_5, l_10_6, l_10_7)
	else
		return -1
	end
end

RumbleManager.play = function(l_11_0, l_11_1, l_11_2)
	-- upvalues: l_0_0 , l_0_1
	local l_11_8, l_11_9, l_11_10, l_11_11, l_11_12, l_11_13, l_11_14, l_11_15 = nil
	l_11_0._effects_id = l_11_0._effects_id + 1
	local l_11_3 = TableAlgorithms.recursive_copy(l_11_1)
	local l_11_4 = 0
	for i_0,i_1 in ipairs(l_11_3.atoms) do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_11_4 < i_1.attack + i_1.sustain + i_1.release then
			l_11_4 = i_1.attack + i_1.sustain + i_1.release
		end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_11_3.scale == "linear" then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_11_3.scale == "log" then
		assert(nil)
		do
			local l_11_17 = {}
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_11_0._effects[l_11_0._effects_id] = l_11_17
			l_11_0._effects_count = l_11_0._effects_count + 1
			return l_11_0._effects_id
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 33 
end

RumbleManager.stop = function(l_12_0, l_12_1)
	l_12_0._effects[l_12_1] = nil
	l_12_0._effects_count = l_12_0._effects_count - 1
end

RumbleManager.set_position = function(l_13_0, l_13_1, l_13_2)
	l_13_0._effects[l_13_1].position = l_13_2
end

RumbleManager.update = function(l_14_0, l_14_1, l_14_2)
	local l_14_6, l_14_7, l_14_8, l_14_9, l_14_10, l_14_11, l_14_12, l_14_13, l_14_14, l_14_15, l_14_16, l_14_17, l_14_18, l_14_19, l_14_20, l_14_21, l_14_25, l_14_26, l_14_27, l_14_28, l_14_29, l_14_34, l_14_35, l_14_36, l_14_37, l_14_38, l_14_39, l_14_40, l_14_41, l_14_45, l_14_46, l_14_47, l_14_48, l_14_49, l_14_50, l_14_51, l_14_52, l_14_53, l_14_59, l_14_61 = nil
	for i_0,i_1 in pairs(l_14_0._effects) do
		i_1.time = i_1.time + l_14_2
		if i_1.life_time < i_1.time then
			l_14_0._effects_count = l_14_0._effects_count - 1
			l_14_0._effects[i_0] = nil
		end
	end
	for i_0,i_1 in pairs(l_14_0._listeners) do
		for i_0,i_1 in pairs(i_1.effects) do
			if l_14_0._effects[i_0] == nil then
				for i_0,i_1 in pairs(i_1) do
					local l_14_60 = nil
					l_14_23.controller:stop_rumble(i_1.rumble_id)
				end
				l_14_23.effects[l_14_32] = nil
			end
		end
	end
	for i_0,i_1 in pairs(l_14_0._listeners) do
		for i_0,i_1 in pairs(l_14_0._effects) do
			if i_1.position - l_14_43.position:length() < i_1.effect.radius then
				if l_14_43.effects[i_0] == nil then
					for i_0,i_1 in pairs(i_1.effect.atoms) do
						local l_14_58 = {}
						local l_14_63 = nil
						table.insert(l_14_58, {rumble_id = l_14_43.controller:rumble({engine = i_1.engine, time = TimerManager:game(), peak = i_1.peak, attack = math.max(i_1.attack - l_14_57.time, 0), sustain = math.max(i_1.sustain - math.max(l_14_57.time - i_1.attack, 0), 0), release = math.max(i_1.release - math.max(l_14_57.time - i_1.attack - i_1.sustain, 0), 0)}), atom = i_1})
					end
					l_14_43.effects[l_14_56] = l_14_58
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				local l_14_72, l_14_73 = nil
				local l_14_67 = nil
				 -- DECOMPILER ERROR: Confused about usage of registers!

				local l_14_68 = nil
				for l_14_79,l_14_80 in pairs(l_14_68) do
					do
						local l_14_69, l_14_70, l_14_71 = , l_14_57.position - l_14_43.position:rotate_with(l_14_43.rotation:inverse()):flat(math.UP):normalized(), 1 - l_14_67.scale_func(l_14_63, l_14_67.effect.radius)
						 -- DECOMPILER ERROR: Confused about usage of registers!

						end
						 -- DECOMPILER ERROR: unhandled construct in 'if'

						 -- DECOMPILER ERROR: unhandled construct in 'if'

						if l_14_67.effect.position_3d and table.insert.atom.engine == "left" and l_14_70.x > 0 then
							if l_14_70.x < 0.707 then
								do return end
							end
							 -- DECOMPILER ERROR: Overwrote pending register.

						end
						do return end
						 -- DECOMPILER ERROR: Confused about usage of registers!

						if l_14_74.atom.engine == "right" and l_14_70.x < 0 then
							if l_14_70.x > -0.707 then
								do return end
							end
							 -- DECOMPILER ERROR: Overwrote pending register.

						end
						do
							local l_14_75 = nil
						end
						 -- DECOMPILER ERROR: Confused about usage of registers!

						 -- DECOMPILER ERROR: Confused about usage of registers!

						l_14_43.controller:set_rumble_peak(l_14_75.rumble_id, l_14_75.atom.peak * (l_14_71 * (1 - l_14_70.x / 0.707) * (1 - l_14_70.x / -0.707)))
					end
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			elseif l_14_68 ~= nil then
				for i_0,i_1 in pairs(l_14_68) do
					do
						local l_14_76, l_14_77, l_14_78 = nil
						l_14_43.controller:stop_rumble(i_1.rumble_id)
					end
					l_14_43.effects[l_14_77] = nil
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


