require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
if not CoreUnitCallbackCutsceneKey then
	CoreUnitCallbackCutsceneKey = class(CoreCutsceneKeyBase)
end
CoreUnitCallbackCutsceneKey.ELEMENT_NAME = "unit_callback"
CoreUnitCallbackCutsceneKey.NAME = "Unit Callback"
CoreUnitCallbackCutsceneKey:register_serialized_attribute("unit_name", "")
CoreUnitCallbackCutsceneKey:register_serialized_attribute("extension", "")
CoreUnitCallbackCutsceneKey:register_serialized_attribute("method", "")
CoreUnitCallbackCutsceneKey:register_serialized_attribute("enabled", true, toboolean)
CoreUnitCallbackCutsceneKey:register_serialized_attribute("arguments")
CoreUnitCallbackCutsceneKey:attribute_affects("unit_name", "extension")
CoreUnitCallbackCutsceneKey:attribute_affects("extension", "method")
CoreUnitCallbackCutsceneKey:attribute_affects("method", "arguments")
CoreUnitCallbackCutsceneKey.control_for_unit_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreUnitCallbackCutsceneKey.control_for_extension = CoreCutsceneKeyBase.standard_combo_box_control
CoreUnitCallbackCutsceneKey.control_for_method = CoreCutsceneKeyBase.standard_combo_box_control
CoreUnitCallbackCutsceneKey.__tostring = function(l_1_0)
	return "Call " .. l_1_0:unit_name() .. ":" .. l_1_0:extension() .. "():" .. l_1_0:method() .. "(" .. l_1_0:arguments_string() .. ")"
end

CoreUnitCallbackCutsceneKey.arguments_string = function(l_2_0)
	local l_2_1 = string.join
	local l_2_2 = ", "
	do
		if not l_2_0._method_params or not l_2_0._method_params[l_2_0:method()] then
			local l_2_3, l_2_4, l_2_5, l_2_6 = table.collect({}, function(l_3_0)
		local l_3_1, l_3_2 = l_3_0:inspect, l_3_0
		return l_3_1(l_3_2)
  end), .end
			return l_2_1(l_2_2, l_2_3, l_2_4, l_2_5, l_2_6)
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 16 
end

CoreUnitCallbackCutsceneKey.load = function(l_3_0, l_3_1, l_3_2)
	local l_3_7 = nil
	l_3_0.super.load(l_3_0, l_3_1, l_3_2)
	l_3_0._method_params = {}
	local l_3_3 = {}
	for i_0 in l_3_1:children() do
		CoreUnitCallbackCutsceneKeyParam:new():load(l_3_8)
		table.insert(l_3_3, CoreUnitCallbackCutsceneKeyParam:new())
	end
	if l_3_0:is_valid_method(l_3_0:method()) then
		l_3_0._method_params[l_3_0:method()] = l_3_3
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreUnitCallbackCutsceneKey._save_under = function(l_4_0, l_4_1)
	local l_4_7, l_4_9, l_4_11 = nil
	local l_4_2 = l_4_0.super._save_under(l_4_0, l_4_1)
	if l_4_0._method_params then
		local l_4_6, l_4_8, l_4_10 = ipairs, l_4_0._method_params, l_4_0:method
		l_4_10 = l_4_10(l_4_0)
		l_4_8 = l_4_8[l_4_10]
	if not l_4_8 then
		end
	end
	l_4_6, l_4_8 = l_4_6(l_4_8), {}
	for i_0,i_1 in l_4_6 do
		do
			local l_4_5 = nil
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			if not l_4_5 then
				l_4_5(l_4_4, l_4_2)
			end
		end
		return l_4_2
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreUnitCallbackCutsceneKey.play = function(l_5_0, l_5_1, l_5_2, l_5_3)
	if l_5_0:enabled() then
		if not l_5_2 or not "undo_" .. l_5_0:method() then
			local l_5_4, l_5_5 = l_5_0:method()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_5_0:_invoke_if_exists(l_5_4, l_5_1)
	end
end

CoreUnitCallbackCutsceneKey.skip = function(l_6_0, l_6_1)
	if l_6_0:enabled() then
		l_6_0:_invoke_if_exists("skip_" .. l_6_0:method(), l_6_1)
	end
end

CoreUnitCallbackCutsceneKey.is_valid_unit_name = function(l_7_0, l_7_1)
	if l_7_0.super.is_valid_unit_name(l_7_0, l_7_1) then
		return not table.empty(l_7_0:_unit_extension_info(l_7_1))
	end
end

CoreUnitCallbackCutsceneKey.is_valid_extension = function(l_8_0, l_8_1)
	local l_8_2 = l_8_0:_unit_extension_info(l_8_0:unit_name())[l_8_1]
	do
		if l_8_2 then
			return not table.empty(l_8_2)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreUnitCallbackCutsceneKey.is_valid_method = function(l_9_0, l_9_1)
	if l_9_1 ~= nil and not string.begins(l_9_1, "undo_") then
		local l_9_2 = not string.begins(l_9_1, "skip_")
	else
		return false
	end
end

CoreUnitCallbackCutsceneKey.refresh_control_for_extension = function(l_10_0, l_10_1)
	l_10_1:freeze()
	l_10_1:clear()
	local l_10_7, l_10_8 = table.find_all_values, table.map_keys
	l_10_8 = l_10_8(l_10_0:_unit_extension_info(l_10_0:unit_name()))
	l_10_7 = l_10_7(l_10_8, function(l_11_0)
		-- upvalues: l_10_0
		local l_11_1, l_11_2 = l_10_0:is_valid_extension, l_10_0
		local l_11_3 = l_11_0
		return l_11_1(l_11_2, l_11_3)
  end)
	local l_10_2 = nil
	l_10_8 = table
	l_10_8 = l_10_8.empty
	l_10_2 = l_10_7
	l_10_8 = l_10_8(l_10_2)
	if not l_10_8 then
		l_10_8, l_10_2 = l_10_1:set_enabled, l_10_1
		l_10_8(l_10_2, true)
		l_10_8, l_10_2 = l_10_0:extension, l_10_0
		l_10_8 = l_10_8(l_10_2)
		local l_10_3 = nil
		l_10_2 = ipairs
		l_10_3 = l_10_7
		l_10_2 = l_10_2(l_10_3)
		for i_0,i_1 in l_10_2 do
			l_10_1:append(l_10_6)
			if l_10_6 == l_10_8 then
				l_10_1:set_value(l_10_8)
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		l_10_8(l_10_1, false)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_10_8(l_10_1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreUnitCallbackCutsceneKey.refresh_control_for_method = function(l_11_0, l_11_1)
	l_11_1:freeze()
	l_11_1:clear()
	local l_11_2 = l_11_0:_unit_extension_info(l_11_0:unit_name())[l_11_0:extension()]
	if l_11_2 then
		l_11_1:set_enabled(true)
		local l_11_3 = l_11_0:method()
		local l_11_7, l_11_8 = ipairs, table.map_keys(l_11_2)
		l_11_7 = l_11_7(l_11_8)
		for i_0,i_1 in l_11_7 do
			l_11_1:append(l_11_6)
			if l_11_6 == l_11_3 then
				l_11_1:set_value(l_11_3)
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		l_11_3(l_11_1, false)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_11_3(l_11_1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreUnitCallbackCutsceneKey.refresh_control_for_arguments = function(l_12_0, l_12_1)
	l_12_1:freeze()
	l_12_1:destroy_children()
	local l_12_2 = EWS:BoxSizer("VERTICAL")
	local l_12_3 = l_12_0:_unit_extension_info(l_12_0:unit_name())[l_12_0:extension()]
	if not l_12_3 or not l_12_3[l_12_0:method()] then
		local l_12_4, l_12_22, l_12_23 = {}
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if #l_12_4 > 0 then
		local l_12_5 = nil
		EWS:StaticText(l_12_1, "Method Arguments"):set_font_size(10)
		l_12_2:add(EWS:StaticLine(l_12_1), 0, 10, "TOP,EXPAND")
		l_12_2:add(EWS:StaticText(l_12_1, "Method Arguments"), 0, 5, "ALL,EXPAND")
		local l_12_9 = nil
		local l_12_10 = l_12_2:add
		l_12_10(l_12_2, EWS:StaticLine(l_12_1), 0, 0, "EXPAND")
		l_12_10 = ipairs
		l_12_10 = l_12_10(l_12_5)
		for i_0,i_1 in l_12_10 do
			do
				local l_12_12 = l_12_0:_param_with_name(i_1)
				EWS:TextCtrl(l_12_1, ""):set_min_size(EWS:TextCtrl(l_12_1, ""):get_min_size():with_x(0))
				EWS:TextCtrl(l_12_1, ""):connect("EVT_COMMAND_TEXT_UPDATED", function()
					-- upvalues: l_12_11 , l_12_12
					l_12_11.string_value = l_12_12:get_value()
        end)
				EWS:TextCtrl(l_12_1, ""):set_value(l_12_12.string_value)
				local l_12_13, l_12_14 = , EWS:TextCtrl(l_12_1, ""):set_enabled
				l_12_14(EWS:TextCtrl(l_12_1, ""), l_12_12.value_type ~= "nil")
				local l_12_21 = EWS:ComboBox
				l_12_21 = l_12_21(EWS, l_12_1, "", "", "CB_DROPDOWN,CB_READONLY")
				l_12_21:connect("EVT_COMMAND_COMBOBOX_SELECTED", function()
					-- upvalues: l_12_11 , l_12_14 , l_12_12
					l_12_11.value_type = l_12_14:get_value()
					local l_14_0, l_14_1 = l_12_12:set_enabled, l_12_12
					l_14_0(l_14_1, l_12_11.value_type ~= "nil")
        end)
				for i_0,i_1 in ipairs(l_12_14) do
					l_12_21:append(i_1)
					if l_12_12.value_type == i_1 then
						l_12_21:set_value(i_1)
					end
				end
				EWS:BoxSizer("HORIZONTAL"):add(l_12_21, 0, 5, "RIGHT,EXPAND")
				EWS:BoxSizer("HORIZONTAL"):add(l_12_13, 1, 0, "EXPAND")
				l_12_2:add(EWS:StaticText(l_12_1, string.pretty(l_12_12.name, true) .. ":"), 0, 5, "TOP,LEFT,RIGHT")
				l_12_2:add(EWS:BoxSizer("HORIZONTAL"), 0, 5, "ALL,EXPAND")
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	l_12_9(l_12_1, l_12_2)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_12_9(l_12_1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreUnitCallbackCutsceneKey.control_for_arguments = function(l_13_0, l_13_1, l_13_2)
	return EWS:Panel(l_13_1)
end

CoreUnitCallbackCutsceneKey._invoke_if_exists = function(l_14_0, l_14_1, l_14_2)
	local l_14_3 = l_14_0:_unit_extension(l_14_0:unit_name(), l_14_0:extension(), true)
	if not l_14_3 then
		Application:error("Unit \"" .. l_14_0:unit_name() .. "\" does not have the extension \"" .. l_14_0:extension() .. "\".")
		return 
	end
	local l_14_4 = l_14_3[l_14_1]
	if not l_14_4 then
		local l_14_11, l_14_13, l_14_15, l_14_17 = Application:error, Application, string.pretty(l_14_0:extension(), true), " extension on unit \""
		local l_14_12, l_14_14, l_14_16, l_14_18 = l_14_0:unit_name(), "\" does not support the call \"", l_14_1
		l_14_18 = "\"."
		l_14_15 = l_14_15 .. l_14_17 .. l_14_12 .. l_14_14 .. l_14_16 .. l_14_18
		l_14_11(l_14_13, l_14_15)
		return 
	end
	if not l_14_0._method_params or not l_14_0._method_params[l_14_0:method()] then
		local l_14_5, l_14_6 = {}
	end
	local l_14_7 = nil
	for i_0,i_1 in ipairs(l_14_7) do
		local l_14_8 = {}
		do
			if i_1:value(l_14_0, l_14_2) == nil and not i_1:is_nil() then
				Application:error(string.format("Bad argument %s in call to %s:%s():%s(%s)", i_1:__tostring(), l_14_0:unit_name(), l_14_0:extension(), l_14_1, string.join(", ", table.collect(l_14_7, function(l_15_0)
			return l_15_0.name
    end))))
				return 
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			l_14_8[l_14_20] = i_1:value(l_14_0, l_14_2)
		end
	end
	l_14_4(l_14_3, table.unpack_sparse(l_14_8))
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreUnitCallbackCutsceneKey._param_with_name = function(l_15_0, l_15_1)
	assert(l_15_0:is_valid_method(l_15_0:method()), "Method \"" .. l_15_0:method() .. "\" is invalid.")
	if not l_15_0._method_params or l_15_0._method_params[l_15_0:method()] == nil then
		local l_15_2, l_15_3, l_15_4, l_15_5, l_15_6, l_15_8 = {}
		l_15_3 = l_15_0._method_params
		if not l_15_3 then
			l_15_0._method_params, l_15_3 = l_15_3, {}
		end
		l_15_3 = l_15_0._method_params
		l_15_4, l_15_5 = l_15_0:method, l_15_0
		l_15_4 = l_15_4(l_15_5)
		l_15_3[l_15_4] = l_15_2
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if table.find_value(l_15_2, function(l_16_0)
		-- upvalues: l_15_1
		return l_16_0.name == l_15_1
  end) == nil then
		local l_15_7, l_15_9 = , CoreUnitCallbackCutsceneKeyParam.new()
		l_15_9.name = l_15_1
		table.insert(l_15_7, l_15_9)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_15_9
end

if not CoreUnitCallbackCutsceneKeyParam then
	CoreUnitCallbackCutsceneKeyParam = class()
end
CoreUnitCallbackCutsceneKeyParam.__tostring = function(l_16_0)
	return tostring(l_16_0.name) .. "=" .. tostring(l_16_0:inspect())
end

CoreUnitCallbackCutsceneKeyParam.init = function(l_17_0)
	l_17_0.value_type = "nil"
	l_17_0.name = "nil"
	l_17_0.string_value = ""
end

CoreUnitCallbackCutsceneKeyParam.load = function(l_18_0, l_18_1)
	l_18_0.value_type = l_18_1:name()
	l_18_0.name = l_18_1:parameter("name")
	l_18_0.string_value = l_18_1:parameter("value")
end

CoreUnitCallbackCutsceneKeyParam.value = function(l_19_0, l_19_1)
	local l_19_4, l_19_5, l_19_8, l_19_9 = nil
	if not l_19_0:is_nil() then
		if l_19_0.value_type == "string" then
			return l_19_0.string_value
		end
	elseif l_19_0.value_type == "number" then
		local l_19_2 = tonumber
		local l_19_3 = l_19_0.string_value
		return l_19_2(l_19_3)
	elseif l_19_0.value_type == "boolean" then
		local l_19_6 = toboolean
		local l_19_7 = l_19_0.string_value
		return l_19_6(l_19_7)
	elseif l_19_0.value_type == "unit" then
		if l_19_1 then
			return l_19_1:_unit(l_19_0.string_value, true)
		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreUnitCallbackCutsceneKeyParam.is_nil = function(l_20_0)
	return l_20_0.value_type == "nil"
end

CoreUnitCallbackCutsceneKeyParam.inspect = function(l_21_0)
	return l_21_0.string_value
end

CoreUnitCallbackCutsceneKeyParam._save_under = function(l_22_0, l_22_1)
	local l_22_2 = l_22_1:make_child(l_22_0.value_type)
	l_22_2:set_parameter("name", tostring(l_22_0.name))
	l_22_2:set_parameter("value", l_22_0.string_value)
	return l_22_2
end


