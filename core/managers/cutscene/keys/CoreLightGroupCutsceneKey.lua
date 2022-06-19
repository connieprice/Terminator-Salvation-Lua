require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
if not CoreLightGroupCutsceneKey then
	CoreLightGroupCutsceneKey = class(CoreCutsceneKeyBase)
end
CoreLightGroupCutsceneKey.ELEMENT_NAME = "light_group"
CoreLightGroupCutsceneKey.NAME = "Light Group"
CoreLightGroupCutsceneKey:register_serialized_attribute("group", "")
CoreLightGroupCutsceneKey:register_serialized_attribute("enable", false, toboolean)
CoreLightGroupCutsceneKey:attribute_affects("group", "enable")
CoreLightGroupCutsceneKey.__tostring = function(l_1_0)
	local l_1_1 = string.format
	local l_1_2 = "Change light group, %s stateto %s."
	local l_1_3 = l_1_0:group()
	local l_1_4, l_1_5, l_1_6 = tostring(l_1_0:enable()), .end
	return l_1_1(l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
end

CoreLightGroupCutsceneKey.prime = function(l_2_0)
	l_2_0:_build_group_cache()
end

CoreLightGroupCutsceneKey.evaluate = function(l_3_0)
	local l_3_5, l_3_6, l_3_7, l_3_8 = nil
	local l_3_1 = assert(l_3_0:_light_groups()[l_3_0:group()], "Could not find group!")
	for i_0,i_1 in ipairs(l_3_1) do
		l_3_0:_enable_lights(i_1, l_3_0:enable())
	end
end

CoreLightGroupCutsceneKey.revert = function(l_4_0)
	local l_4_6, l_4_7, l_4_8, l_4_9 = nil
	local l_4_1, l_4_2 = l_4_0:preceeding_key, l_4_0
	local l_4_3 = {}
	l_4_3.group = l_4_0:group()
	l_4_1 = l_4_1(l_4_2, l_4_3)
	if l_4_1 then
		l_4_2, l_4_3 = l_4_1:evaluate, l_4_1
		l_4_2(l_4_3)
	else
		l_4_2 = assert
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_4_2 = l_4_2(l_4_3, "Could not find group!")
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0,i_1 in l_4_3 do
			l_4_0:_enable_lights(i_1, false)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreLightGroupCutsceneKey.unload = function(l_5_0)
	local l_5_4, l_5_5, l_5_9, l_5_10 = pairs, l_5_0:_light_groups(), .end
	l_5_4 = l_5_4(l_5_5, l_5_9, l_5_10)
	for l_5_10,i_1 in l_5_4 do
		local l_5_2, l_5_3 = nil
		l_5_2 = ipairs
		l_5_3 = l_5_1
		l_5_2 = l_5_2(l_5_3)
		for i_0,i_1 in l_5_2 do
			l_5_0:_enable_lights(l_5_8, false)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreLightGroupCutsceneKey.can_evaluate_with_player = function(l_6_0, l_6_1)
	return true
end

CoreLightGroupCutsceneKey.is_valid_group = function(l_7_0, l_7_1)
	local l_7_5 = pairs
	l_7_5 = l_7_5(l_7_0:_light_groups())
	for i_0,i_1 in l_7_5 do
		if l_7_4 == l_7_1 then
			return true
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreLightGroupCutsceneKey.is_valid_enable = function(l_8_0)
	return true
end

CoreLightGroupCutsceneKey.on_attribute_changed = function(l_9_0, l_9_1, l_9_2, l_9_3)
	if l_9_1 == "group" or l_9_1 == "enable" and not l_9_2 then
		l_9_0:_eval_prev_group()
	end
end

CoreLightGroupCutsceneKey._light_groups = function(l_10_0)
	if not l_10_0._light_groups_cache then
		l_10_0:_build_group_cache()
	end
	return l_10_0._light_groups_cache
end

CoreLightGroupCutsceneKey._enable_lights = function(l_11_0, l_11_1, l_11_2)
	local l_11_3 = l_11_1:get_objects_by_type("light")
	if #l_11_3 == 0 then
		local l_11_8, l_11_10 = Application:stack_dump_error, Application
		local l_11_7, l_11_9 = "[CoreLightGroupCutsceneKey] No lights in unit: ", l_11_1:name()
		l_11_7 = l_11_7 .. l_11_9
		l_11_8(l_11_10, l_11_7)
	end
	for i_0,i_1 in ipairs(l_11_3) do
		i_1:set_enable(l_11_2)
	end
end

CoreLightGroupCutsceneKey._build_group_cache = function(l_12_0)
	l_12_0._light_groups_cache = {}
	local l_12_4, l_12_5 = pairs, managers.cutscene:cutscene_actors_in_world()
	l_12_4 = l_12_4(l_12_5)
	for i_0,i_1 in l_12_4 do
		local l_12_6, l_12_7, l_12_8 = string.match(l_12_2, "(.+)_(.+)_(.+)")
		if l_12_6 == "lightgroup" then
			if not l_12_0._light_groups_cache[l_12_7] then
				l_12_0._light_groups_cache[l_12_7] = {}
			end
			table.insert(l_12_0._light_groups_cache[l_12_7], l_12_3)
			l_12_0:_enable_lights(l_12_3, false)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreLightGroupCutsceneKey._eval_prev_group = function(l_13_0)
	local l_13_1, l_13_2 = l_13_0:preceeding_key, l_13_0
	local l_13_3 = {}
	l_13_3.group = l_13_0:group()
	l_13_1 = l_13_1(l_13_2, l_13_3)
	if l_13_1 then
		l_13_2, l_13_3 = l_13_1:evaluate, l_13_1
		l_13_2(l_13_3)
	else
		l_13_2, l_13_3 = l_13_0:evaluate, l_13_0
		l_13_2(l_13_3)
	end
end

CoreLightGroupCutsceneKey.refresh_control_for_group = function(l_14_0, l_14_1)
	l_14_1:freeze()
	l_14_1:clear()
	local l_14_2 = l_14_0:group()
	local l_14_6, l_14_7 = pairs, l_14_0:_light_groups()
	l_14_6 = l_14_6(l_14_7)
	for i_0,i_1 in l_14_6 do
		l_14_1:append(l_14_4)
		if l_14_4 == l_14_2 then
			l_14_1:set_value(l_14_4)
		end
	end
	l_14_1:thaw()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreLightGroupCutsceneKey.check_box_control = function(l_15_0, l_15_1, l_15_2)
	local l_15_3 = EWS:CheckBox(l_15_1, "Enable", "", "")
	l_15_3:set_min_size(l_15_3:get_min_size():with_x(0))
	l_15_3:connect("EVT_COMMAND_CHECKBOX_CLICKED", l_15_2)
	return l_15_3
end

CoreLightGroupCutsceneKey.refresh_control_for_enable = function(l_16_0, l_16_1)
	l_16_1:set_value(l_16_0:enable())
end

CoreLightGroupCutsceneKey.control_for_group = CoreCutsceneKeyBase.standard_combo_box_control
CoreLightGroupCutsceneKey.control_for_enable = CoreLightGroupCutsceneKey.check_box_control

