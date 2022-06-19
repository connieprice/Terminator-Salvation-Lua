core:module("RadialBlurManager")
core:require_module("CoreClass")
if not RadialBlurManager then
	RadialBlurManager = CoreClass.class()
end
RadialBlurManager.init = function(l_1_0)
	l_1_0._blur_types = {}
	l_1_0._blur_category = {}
	l_1_0._current_blurs = {}
	l_1_0._current_blurs_step = {}
	l_1_0._current_blur_selected = {}
	l_1_0._default_blur_category = nil
	l_1_0._constant_blur = {}
	l_1_0._constant_blur.position = Vector3(0, 0, 0)
	l_1_0._constant_blur.current_opacity = 0
	l_1_0._constant_blur.current_speed = 0
	l_1_0._constant_blur.falloff = 0.5
	l_1_0._constant_blur.time = 0
	l_1_0._enabled = true
	l_1_0:flush_xml()
end

RadialBlurManager.update = function(l_2_0, l_2_1)
end

RadialBlurManager.update_blur = function(l_3_0, l_3_1, l_3_2, l_3_3)
	if l_3_0._current_blurs[l_3_2][l_3_1].sustain + l_3_0._current_blurs[l_3_2][l_3_1].decay == 0 then
		l_3_0._current_blurs[l_3_2][l_3_1].current_opacity = l_3_0._current_blurs[l_3_2][l_3_1].opacity
		l_3_0._current_blurs[l_3_2][l_3_1].current_speed = l_3_0._current_blurs[l_3_2][l_3_1].speed
	else
		if l_3_0._current_blurs[l_3_2][l_3_1].timer:time() < l_3_0._current_blurs[l_3_2][l_3_1].sustain + l_3_0._current_blurs[l_3_2][l_3_1].decay then
			local l_3_4 = l_3_3 - l_3_0._current_blurs[l_3_2][l_3_1].position:length()
			local l_3_5 = (l_3_0._current_blurs[l_3_2][l_3_1].sustain + l_3_0._current_blurs[l_3_2][l_3_1].decay - l_3_0._current_blurs[l_3_2][l_3_1].timer:time()) / l_3_0._current_blurs[l_3_2][l_3_1].decay
			local l_3_6 = 1 - math.clamp(l_3_4 - l_3_0._current_blurs[l_3_2][l_3_1].decline_distance_min, 0, l_3_0._current_blurs[l_3_2][l_3_1].decline_distance_range) / l_3_0._current_blurs[l_3_2][l_3_1].decline_distance_range
			l_3_0._current_blurs[l_3_2][l_3_1].current_opacity = l_3_0._current_blurs[l_3_2][l_3_1].opacity * l_3_5 * l_3_6
			l_3_0._current_blurs[l_3_2][l_3_1].current_speed = l_3_0._current_blurs[l_3_2][l_3_1].speed * l_3_5
		end
	else
		l_3_0._current_blurs[l_3_2][l_3_1] = nil
		return 
	end
	if l_3_0._blur_category[l_3_0._current_blurs[l_3_2][l_3_1].category].visible == true and (l_3_0._current_blur_selected == nil or l_3_0._current_blur_selected.current_opacity < l_3_0._current_blurs[l_3_2][l_3_1].current_opacity) then
		l_3_0._current_blur_selected = l_3_0._current_blurs[l_3_2][l_3_1]
	end
end

RadialBlurManager.render_blur = function(l_4_0, l_4_1)
	if l_4_1 == nil then
		l_4_0._radial_mat:set_variable("opacity", 0)
	else
		l_4_0._radial_mat:set_variable("world_pos", l_4_1.position)
		l_4_0._radial_mat:set_variable("kernel_size", l_4_1.current_speed)
		l_4_0._radial_mat:set_variable("falloff_exponent", l_4_1.falloff)
		l_4_0._radial_mat:set_variable("opacity", l_4_1.current_opacity)
	end
end

RadialBlurManager.set_velocity_blur = function(l_5_0, l_5_1, l_5_2, l_5_3)
	local l_5_4 = math.clamp(l_5_3:length() - 500, 0, 4000) / 4000
	l_5_0._constant_blur.position = l_5_2 + l_5_3:normalized() * 1500
	l_5_0._constant_blur.current_opacity = 0.6 * l_5_4
	l_5_0._constant_blur.current_speed = 16 * l_5_4
	l_5_0._constant_blur.time = l_5_1 + 1
end

RadialBlurManager.get_free_blur_slot = function(l_6_0, l_6_1)
	local l_6_2 = l_6_0._blur_types[l_6_1].spawn_limit
	do
		local l_6_3 = 1
		if l_6_0._current_blurs_step[l_6_1] then
			l_6_3 = l_6_0._current_blurs_step[l_6_1]
		while 1 do
			end
			while l_6_0._current_blurs[l_6_1][l_6_3] do
				l_6_3 = l_6_3 + 1
				if l_6_0._blur_types[l_6_1].spawn_limit < l_6_3 then
					l_6_3 = 1
				end
				l_6_2 = l_6_2 - 1
				if l_6_2 == 0 then
					local l_6_4 = false
					local l_6_5 = false
					for l_6_9 = 1, l_6_0._blur_types[l_6_1].spawn_limit do
						if not l_6_4 or l_6_0._current_blurs[l_6_1][l_6_9].time < l_6_4 then
							l_6_4 = l_6_0._current_blurs[l_6_1][l_6_9].time
							l_6_5 = l_6_9
						end
					end
					l_6_0._current_blurs_step[l_6_1] = l_6_5
					return l_6_5
				end
			end
			l_6_0._current_blurs_step[l_6_1] = l_6_3
			return l_6_3
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

RadialBlurManager.create_blur = function(l_7_0, l_7_1, l_7_2, l_7_3)
	if not l_7_0._current_blurs[l_7_2] then
		l_7_0._current_blurs[l_7_2] = {}
	end
	local l_7_4 = l_7_0:get_free_blur_slot(l_7_2)
	l_7_0._current_blurs[l_7_2][l_7_4] = {}
	if l_7_0._blur_types[l_7_2].sustain == 0 and l_7_0._blur_types[l_7_2].decay == 0 then
		l_7_0._current_blurs[l_7_2][l_7_4].sustain = l_7_0._blur_types[l_7_2].sustain
	else
		l_7_0._current_blurs[l_7_2][l_7_4].sustain = l_7_1:time() + l_7_0._blur_types[l_7_2].sustain
	end
	l_7_0._current_blurs[l_7_2][l_7_4]._debug_name = l_7_2
	l_7_0._current_blurs[l_7_2][l_7_4].decay = l_7_0._blur_types[l_7_2].decay
	l_7_0._current_blurs[l_7_2][l_7_4].opacity = l_7_0._blur_types[l_7_2].opacity
	l_7_0._current_blurs[l_7_2][l_7_4].speed = l_7_0._blur_types[l_7_2].speed
	l_7_0._current_blurs[l_7_2][l_7_4].falloff = l_7_0._blur_types[l_7_2].falloff
	l_7_0._current_blurs[l_7_2][l_7_4].decline_distance_min = l_7_0._blur_types[l_7_2].decline_distance_min
	l_7_0._current_blurs[l_7_2][l_7_4].decline_distance_max = l_7_0._blur_types[l_7_2].decline_distance_max
	l_7_0._current_blurs[l_7_2][l_7_4].decline_distance_range = l_7_0._blur_types[l_7_2].decline_distance_max - l_7_0._blur_types[l_7_2].decline_distance_min
	l_7_0._current_blurs[l_7_2][l_7_4].category = l_7_0._blur_types[l_7_2].category
	l_7_0._current_blurs[l_7_2][l_7_4].timer = l_7_1
	l_7_0._current_blurs[l_7_2][l_7_4].time = l_7_1:time()
	l_7_0._current_blurs[l_7_2][l_7_4].position = l_7_3
	l_7_0._current_blurs[l_7_2][l_7_4].current_opacity = l_7_0._blur_types[l_7_2].opacity
	l_7_0._current_blurs[l_7_2][l_7_4].current_speed = l_7_0._blur_types[l_7_2].speed
	local l_7_5 = {}
	l_7_5.name = l_7_2
	l_7_5.index = l_7_4
	return l_7_5
end

RadialBlurManager.set_visible_all = function(l_8_0, l_8_1)
	local l_8_5, l_8_6 = nil
	for i_0,i_1 in pairs(l_8_0._blur_category) do
		i_1.visible = l_8_1
	end
end

RadialBlurManager.set_visible = function(l_9_0, l_9_1, l_9_2)
	if l_9_0._blur_category[l_9_1] then
		l_9_0._blur_category[l_9_1].visible = l_9_2
	end
end

RadialBlurManager.update_blur_position = function(l_10_0, l_10_1, l_10_2)
	l_10_0._current_blurs[l_10_1.name][l_10_1.index].position = l_10_2
end

RadialBlurManager.update_blur_speed = function(l_11_0, l_11_1, l_11_2)
	l_11_0._current_blurs[l_11_1.name][l_11_1.index].current_speed = l_11_2
	l_11_0._current_blurs[l_11_1.name][l_11_1.index].speed = l_11_2
end

RadialBlurManager.update_blur_opacity = function(l_12_0, l_12_1, l_12_2)
	l_12_0._current_blurs[l_12_1.name][l_12_1.index].current_opacity = l_12_2
	l_12_0._current_blurs[l_12_1.name][l_12_1.index].opacity = l_12_2
end

RadialBlurManager.destroy_blur = function(l_13_0, l_13_1, l_13_2)
	local l_13_3 = l_13_0._current_blurs[l_13_1.name][l_13_1.index]
	if l_13_3 then
		l_13_3.sustain = l_13_3.timer:time()
		l_13_3.decay = l_13_2
	end
end

RadialBlurManager.pause_all = function(l_14_0)
end

RadialBlurManager.resume_all = function(l_15_0)
end

RadialBlurManager.destroy_all = function(l_16_0)
	l_16_0._current_blurs = {}
end

RadialBlurManager.xml_read_blur_effect = function(l_17_0, l_17_1)
	local l_17_2 = l_17_1:parameter("name")
	l_17_0:add_type(l_17_2)
	local l_17_3 = nil
	if l_17_1:parameter("category") == "" then
		l_17_3 = l_17_0._default_blur_category
	else
		l_17_3 = l_17_1:parameter("category")
	if not l_17_0._blur_category[l_17_3] then
		end
		Application:error("Category '" .. l_17_3 .. "' referred to by blur '" .. l_17_2 .. "' does not exist. Using default!")
		l_17_3 = l_17_0._default_blur_category
	end
	if l_17_1:has_parameter("spawn_limit") then
		local l_17_7, l_17_8, l_17_9, l_17_10, l_17_11, l_17_12, l_17_13, l_17_14, l_17_15, l_17_16, l_17_17, l_17_18, l_17_19, l_17_20, l_17_21, l_17_22, l_17_23, l_17_24, l_17_25, l_17_26, l_17_27, l_17_28, l_17_29, l_17_30 = l_17_0._blur_types[l_17_2], tonumber, l_17_1:parameter("spawn_limit"), .end
		l_17_8 = l_17_8(l_17_9, l_17_10, l_17_11, l_17_12, l_17_13, l_17_14, l_17_15, l_17_16, l_17_17, l_17_18, l_17_19, l_17_20, l_17_21, l_17_22, l_17_23, l_17_24, l_17_25, l_17_26, l_17_27, l_17_28, l_17_29, l_17_30)
		l_17_7.spawn_limit = l_17_8
	else
		l_17_0._blur_types[l_17_2].spawn_limit = 3
	end
	l_17_0._blur_types[l_17_2].sustain = 0
	l_17_0._blur_types[l_17_2].decay = 0
	l_17_0._blur_types[l_17_2].category = l_17_3
	for i_0 in l_17_1:children() do
		if i_0:name() == "param" and i_0:parameter("name") ~= "" and i_0:parameter("value") ~= "" then
			if i_0:parameter("name") == "sustain" then
				l_17_0._blur_types[l_17_2].sustain = tonumber(i_0:parameter("value"))
			end
		else
			if i_0:parameter("name") == "decay" then
				l_17_0._blur_types[l_17_2].decay = tonumber(i_0:parameter("value"))
			end
		else
			if i_0:parameter("name") == "opacity" then
				l_17_0._blur_types[l_17_2].opacity = tonumber(i_0:parameter("value"))
			end
		else
			if i_0:parameter("name") == "speed" then
				l_17_0._blur_types[l_17_2].speed = tonumber(i_0:parameter("value"))
			end
		else
			if i_0:parameter("name") == "falloff" then
				l_17_0._blur_types[l_17_2].falloff = tonumber(i_0:parameter("value"))
			end
		else
			if i_0:parameter("name") == "decline_distance_min" then
				l_17_0._blur_types[l_17_2].decline_distance_min = tonumber(i_0:parameter("value"))
			end
		else
			if i_0:parameter("name") == "decline_distance_max" then
				l_17_0._blur_types[l_17_2].decline_distance_max = tonumber(i_0:parameter("value"))
			end
		end
	end
end

RadialBlurManager.xml_read_blur_category = function(l_18_0, l_18_1)
	local l_18_2 = false
	if l_18_1:parameter("default") == "true" then
		l_18_2 = true
	end
	l_18_0:add_category(l_18_1:parameter("name"), l_18_2)
end

RadialBlurManager.flush_xml = function(l_19_0)
	local l_19_4, l_19_5, l_19_6, l_19_7, l_19_8, l_19_9, l_19_10 = nil
	l_19_0._blur_xml_root = File:parse_xml("data/settings/blur_effects.xml")
	if l_19_0._blur_xml_root and l_19_0._blur_xml_root:name() == "blur_effects" then
		for i_0 in l_19_0._blur_xml_root:children() do
			if i_0:name() == "blur_category" then
				if i_0:parameter("name") ~= "" then
					l_19_0:xml_read_blur_category(i_0)
				end
			else
				Application:error("Error in " .. tostring(i_0:file()) .. " line " .. tostring(i_0:line()) .. ": blur_category doesn't have a name")
			end
		end
		if l_19_0._default_blur_category == nil then
			local l_19_11, l_19_12, l_19_13, l_19_14, l_19_15, l_19_16, l_19_17 = tostring(element:file())
			Application:error("Error in " .. l_19_11 .. l_19_12)
			l_19_0.add_category("default", true)
		end
		for i_0 in l_19_0._blur_xml_root:children() do
			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_19_12(i_0) == "blur_effect" then
				if i_0:parameter("name") ~= "" then
					l_19_0:xml_read_blur_effect(i_0)
				end
			else
				Application:error("Error in " .. tostring(i_0:file()) .. " line " .. tostring(i_0:line()) .. ": blur_effect doesn't have a name")
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

RadialBlurManager.add_type = function(l_20_0, l_20_1, l_20_2, l_20_3, l_20_4, l_20_5, l_20_6, l_20_7, l_20_8)
	l_20_0._current_blurs[l_20_1] = nil
	l_20_0._blur_types[l_20_1] = {}
	l_20_0._blur_types[l_20_1].sustain = l_20_2
	l_20_0._blur_types[l_20_1].decay = l_20_3
	l_20_0._blur_types[l_20_1].opacity = l_20_4
	l_20_0._blur_types[l_20_1].speed = l_20_5
	l_20_0._blur_types[l_20_1].falloff = l_20_6
	l_20_0._blur_types[l_20_1].decline_distance_min = l_20_7
	l_20_0._blur_types[l_20_1].decline_distance_max = l_20_8
end

RadialBlurManager.add_category = function(l_21_0, l_21_1, l_21_2)
	if l_21_2 or l_21_0._default_blur_category == nil then
		l_21_0._default_blur_category = l_21_1
	end
	l_21_0._blur_category[l_21_1] = {}
	l_21_0._blur_category[l_21_1].visible = true
end


