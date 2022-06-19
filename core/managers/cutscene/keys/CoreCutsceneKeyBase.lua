if not CoreCutsceneKeyBase then
	CoreCutsceneKeyBase = class()
end
CoreCutsceneKeyBase.init = function(l_1_0, l_1_1)
	l_1_0:set_key_collection(l_1_1)
end

CoreCutsceneKeyBase.load = function(l_2_0, l_2_1, l_2_2)
	if not l_2_2 then
		l_2_2 = l_2_0
	end
	if l_2_2.super and l_2_2.super.load then
		l_2_2.super.load(l_2_0, l_2_1, l_2_2.super)
	end
	if l_2_2 == CoreCutsceneKeyBase and l_2_1:parameter("frame") then
		local l_2_6, l_2_7, l_2_8, l_2_9, l_2_10, l_2_11 = l_2_0:set_frame, l_2_0, tonumber(l_2_1:parameter("frame")), .end
		l_2_6(l_2_7, l_2_8, l_2_9, l_2_10, l_2_11)
	end
	if not l_2_2.__serialized_attributes then
		for i_0,i_1 in pairs({}) do
		end
		if l_2_1:parameter(i_0) then
			l_2_0["__" .. l_2_12] = l_2_13(l_2_1:parameter(i_0))
		end
	end
end

CoreCutsceneKeyBase.populate_from_editor = function(l_3_0, l_3_1)
	l_3_0:set_frame(l_3_1:playhead_position())
end

CoreCutsceneKeyBase.set_key_collection = function(l_4_0, l_4_1)
	l_4_0.__key_collection = l_4_1
end

CoreCutsceneKeyBase.set_cast = function(l_5_0, l_5_1)
	l_5_0._cast = l_5_1
end

CoreCutsceneKeyBase.clone = function(l_6_0)
	local l_6_1 = clone
	local l_6_2 = l_6_0
	return l_6_1(l_6_2)
end

CoreCutsceneKeyBase.prime = function(l_7_0, l_7_1)
end

CoreCutsceneKeyBase.unload = function(l_8_0, l_8_1)
end

CoreCutsceneKeyBase.type_name = function(l_9_0)
	return l_9_0.NAME or "Unknown"
end

CoreCutsceneKeyBase._key_collection = function(l_10_0)
	return l_10_0.__key_collection
end

CoreCutsceneKeyBase.frame = function(l_11_0)
	return l_11_0._frame or 0
end

CoreCutsceneKeyBase.set_frame = function(l_12_0, l_12_1)
	l_12_0._frame = l_12_1
end

CoreCutsceneKeyBase.time = function(l_13_0)
	return l_13_0:frame() / 30
end

CoreCutsceneKeyBase.preceeding_key = function(l_14_0, l_14_1)
	if l_14_0:_key_collection() then
		return l_14_0:_key_collection():last_key_before(l_14_0:time(), l_14_0.ELEMENT_NAME, l_14_1)
	end
end

CoreCutsceneKeyBase.can_evaluate_with_player = function(l_15_0, l_15_1)
	return l_15_1 ~= nil
end

CoreCutsceneKeyBase.is_valid = function(l_16_0, l_16_1)
	local l_16_5, l_16_6 = ipairs, l_16_0:attribute_names()
	l_16_5 = l_16_5(l_16_6)
	for i_0,i_1 in l_16_5 do
		if not l_16_0:is_valid_attribute_value(l_16_4, l_16_0:attribute_value(l_16_4)) then
			if l_16_1 then
				Application:error("Attribute \"" .. l_16_4 .. "\" is invalid.")
			end
			return false
		end
	end
	return true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutsceneKeyBase.is_valid_attribute_value = function(l_17_0, l_17_1, l_17_2)
	local l_17_3 = l_17_0["is_valid_" .. l_17_1]
	if l_17_3 ~= nil then
		local l_17_4 = l_17_3(l_17_0, l_17_2)
		l_17_4 = l_17_4
		return l_17_4
	end
end

CoreCutsceneKeyBase.is_valid_object_name = function(l_18_0, l_18_1, l_18_2)
	if l_18_1 then
		local l_18_3 = table.contains
		local l_18_4, l_18_5 = l_18_0:_unit_object_names, l_18_0
		if not l_18_2 then
			l_18_4 = l_18_4(l_18_5, l_18_0:unit_name())
		end
		l_18_5 = l_18_1
		l_18_3 = l_18_3(l_18_4, l_18_5)
	if not l_18_3 then
		end
	end
	l_18_3 = false
	return l_18_3
end

CoreCutsceneKeyBase.is_valid_unit_name = function(l_19_0, l_19_1)
	local l_19_2 = table.contains
	local l_19_3 = l_19_0:_unit_names()
	local l_19_4 = l_19_1
	return l_19_2(l_19_3, l_19_4)
end

CoreCutsceneKeyBase._unit_names = function(l_20_0)
	local l_20_6, l_20_7, l_20_8 = nil
	if not l_20_0._cast or not l_20_0._cast:unit_names() then
		local l_20_1, l_20_2 = {}
	end
	if not managers.cutscene or not managers.cutscene:cutscene_actors_in_world() then
		for i_0,i_1 in pairs({}) do
		end
		local l_20_3 = nil
		table.insert(l_20_3, i_0)
	end
	table.sort(l_20_3)
	return l_20_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutsceneKeyBase._unit_type = function(l_21_0, l_21_1)
	local l_21_2 = l_21_0:_unit(l_21_1, true)
	do
		if l_21_2 then
			return l_21_2:name()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreCutsceneKeyBase._unit_object_names = function(l_22_0, l_22_1)
	local l_22_2 = managers.cutscene:actor_database():unit_type_info(l_22_0:_unit_type(l_22_1))
	if not l_22_2 or not l_22_2:object_names() then
		return {}
	end
end

CoreCutsceneKeyBase._unit_initial_object_visibility = function(l_23_0, l_23_1, l_23_2)
	local l_23_3 = managers.cutscene:actor_database():unit_type_info(l_23_0:_unit_type(l_23_1))
	do
		if l_23_3 then
			return l_23_3:initial_object_visibility(l_23_2)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreCutsceneKeyBase._unit_extension_info = function(l_24_0, l_24_1)
	local l_24_2 = managers.cutscene:actor_database():unit_type_info(l_24_0:_unit_type(l_24_1))
	if not l_24_2 or not l_24_2:extensions() then
		return {}
	end
end

CoreCutsceneKeyBase._unit_animation_groups = function(l_25_0, l_25_1)
	local l_25_2 = managers.cutscene:actor_database():unit_type_info(l_25_0:_unit_type(l_25_1))
	if not l_25_2 or not l_25_2:animation_groups() then
		return {}
	end
end

CoreCutsceneKeyBase._unit = function(l_26_0, l_26_1, l_26_2)
	if (not l_26_0._cast or l_26_0._cast:unit(l_26_1) == nil) and managers.cutscene then
		local l_26_3 = managers.cutscene:cutscene_actors_in_world()[l_26_1]
	end
	local l_26_4 = nil
	local l_26_6 = assert
	do
		l_26_6(l_26_2 or l_26_4, "Unit \"" .. (l_26_1 or "nil") .. "\" not found in cast or world.")
		return l_26_4
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutsceneKeyBase._unit_object = function(l_27_0, l_27_1, l_27_2, l_27_3)
	local l_27_4 = l_27_0:_unit(l_27_1, l_27_3)
	if l_27_4 then
		local l_27_6 = l_27_4:get_object(l_27_2)
		local l_27_8 = assert
		local l_27_10 = l_27_3 or l_27_6
		do
			l_27_8(l_27_10, "Object \"" .. (l_27_2 or "nil") .. "\" not found in unit \"" .. (l_27_1 or "nil") .. "\".")
			return l_27_6
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 10 
end

CoreCutsceneKeyBase._unit_extension = function(l_28_0, l_28_1, l_28_2, l_28_3)
	local l_28_4 = l_28_0:_unit(l_28_1, l_28_3)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	do
		local l_28_6 = nil
	end
	local l_28_7 = nil
	local l_28_9 = nil
	local l_28_11 = assert
	do
		l_28_11(l_28_3 or (not l_28_4 or type(l_28_4[l_28_2]) == "function") and l_28_4[l_28_2](l_28_4) or nil, "Extension \"" .. (l_28_2 or "nil") .. "\" not found in unit \"" .. (l_28_1 or "nil") .. "\".")
		return l_28_9
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutsceneKeyBase._unit_is_owned_by_level = function(l_29_0, l_29_1)
	return not managers.cutscene or managers.cutscene:cutscene_actors_in_world()[l_29_1] ~= nil
end

CoreCutsceneKeyBase.play = function(l_30_0, l_30_1, l_30_2, l_30_3)
	local l_30_4 = assert
	l_30_4(type(l_30_0.evaluate) == "function", "Cutscene key must define the \"evaluate\" method to use the default CoreCutsceneKeyBase:play method.")
	if l_30_2 then
		l_30_4 = type
		l_30_4 = l_30_4(l_30_0.revert)
		if l_30_4 == "function" then
			l_30_4(l_30_0, l_30_1)
		 -- DECOMPILER ERROR: Overwrote pending register.

		else
			local l_30_7 = l_30_0
			local l_30_8 = {}
			if l_30_0.unit_name then
				l_30_8.unit_name = l_30_0:unit_name()
			end
			if l_30_0.object_name then
				l_30_8.object_name = l_30_0:object_name()
				 -- DECOMPILER ERROR: Overwrote pending register.

			end
		if l_30_4 then
			end
			l_30_7, l_30_8 = l_30_4:evaluate, l_30_4
			l_30_7(l_30_8, l_30_1, false)
		end
	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		l_30_4(l_30_0, l_30_1, l_30_3)
	end
end

CoreCutsceneKeyBase._save_under = function(l_31_0, l_31_1)
	local l_31_2 = assert(l_31_0.ELEMENT_NAME, "Required string member ELEMENT_NAME not declared in cutscene key class.")
	local l_31_3 = l_31_1:make_child(l_31_2)
	l_31_3:set_parameter("frame", tostring(l_31_0:frame()))
	local l_31_4 = true
	local l_31_8, l_31_9 = ipairs, l_31_0:attribute_names(l_31_4)
	l_31_8 = l_31_8(l_31_9)
	for i_0,i_1 in l_31_8 do
		l_31_3:set_parameter(l_31_7, tostring(l_31_0:attribute_value(l_31_7)))
	end
	return l_31_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutsceneKeyBase.attribute_names = function(l_32_0, l_32_1, l_32_2, l_32_3)
	if not l_32_2 then
		l_32_2 = getmetatable(l_32_0)
	end
	if not l_32_3 then
		l_32_3 = {}
	end
	if l_32_2.super then
		local l_32_7, l_32_9, l_32_11 = CoreCutsceneKeyBase.attribute_names, l_32_0, l_32_1
		local l_32_8, l_32_10, l_32_12 = l_32_2.super, l_32_3
		l_32_7(l_32_9, l_32_11, l_32_8, l_32_10)
	end
	if not l_32_2.__serialized_attribute_order then
		for i_0,i_1 in ipairs({}) do
		end
		if not l_32_1 or l_32_0["__" .. i_1] ~= nil then
			table.insert(l_32_3, i_1)
		end
	end
	return l_32_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutsceneKeyBase.attribute_value = function(l_33_0, l_33_1)
	if l_33_0[l_33_1] then
		return l_33_0[l_33_1](l_33_0)
	end
end

CoreCutsceneKeyBase.attribute_value_from_string = function(l_34_0, l_34_1, l_34_2)
	if l_34_2 == "" then
		return nil
	else
		local l_34_3 = l_34_0.__serialized_attributes[l_34_1]
		local l_34_4 = l_34_3
		local l_34_5 = l_34_2
		return l_34_4(l_34_5)
	end
end

CoreCutsceneKeyBase.set_attribute_value_from_string = function(l_35_0, l_35_1, l_35_2)
	local l_35_3 = l_35_0:attribute_value_from_string(l_35_1, l_35_2)
	local l_35_4 = l_35_0["set_" .. l_35_1]
	local l_35_5 = l_35_0
	local l_35_6 = l_35_3
	return l_35_4(l_35_5, l_35_6)
end

CoreCutsceneKeyBase.register_control = function(l_36_0, l_36_1)
	l_36_0:register_serialized_attribute(l_36_1, nil, nil)
end

CoreCutsceneKeyBase.register_serialized_attribute = function(l_37_0, l_37_1, l_37_2, l_37_3)
	local l_37_4 = l_37_0
	if not l_37_4.__serialized_attributes then
		l_37_4.__serialized_attributes = {}
	end
	local l_37_5 = l_37_4.__serialized_attributes
	do
		l_37_5[l_37_1] = l_37_3 or tostring
		l_37_5 = l_37_4.__serialized_attribute_order
		if not l_37_5 then
			l_37_4.__serialized_attribute_order, l_37_5 = l_37_5, {}
		end
		l_37_5 = table
		l_37_5 = l_37_5.contains
		l_37_5 = l_37_5(l_37_4.__serialized_attribute_order, l_37_1)
		if not l_37_5 then
			l_37_5 = table
			l_37_5 = l_37_5.insert
			l_37_5(l_37_4.__serialized_attribute_order, l_37_1)
		end
		l_37_5 = function(l_38_0)
		-- upvalues: l_37_1 , l_37_2
		local l_38_1 = l_38_0["__" .. l_37_1]
		return l_38_1 == nil and l_37_2 or l_38_1
  end
		l_37_4[l_37_1] = l_37_5
		l_37_5 = "set_"
		l_37_5 = l_37_5 .. l_37_1
		l_37_4[l_37_5] = function(l_39_0, l_39_1)
		-- upvalues: l_37_1 , l_37_2
		local l_39_2 = l_39_0["__" .. l_37_1]
		if l_39_0.on_attribute_before_changed then
			l_39_0:on_attribute_before_changed(l_37_1, l_39_1, l_39_2)
		end
		if l_39_0["is_valid_" .. l_37_1] and not l_39_0["is_valid_" .. l_37_1](l_39_0, l_39_1, l_39_2) then
			return false
		else
			local l_39_3 = "__" .. l_37_1
			local l_39_4 = iff
			l_39_4 = l_39_4(l_39_1 == l_37_2, nil, l_39_1)
			l_39_0[l_39_3] = l_39_4
			l_39_3 = l_39_0.on_attribute_changed
			if l_39_3 then
				l_39_3, l_39_4 = l_39_0:on_attribute_changed, l_39_0
				l_39_3(l_39_4, l_37_1, l_39_1, l_39_2)
			end
			l_39_3 = true
			return l_39_3
		end
  end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutsceneKeyBase.attribute_affects = function(l_38_0, l_38_1, ...)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_38_0.__control_dependencies then
		l_38_0.__control_dependencies = {}
	end
	local l_38_3 = nil
	if not l_38_3.__control_dependencies[l_38_1] then
		local l_38_4 = table.list_union
	end
	local l_38_5 = nil
	l_38_5 = l_38_5({}, {...})
	l_38_3.__control_dependencies[l_38_1] = l_38_5
end

CoreCutsceneKeyBase.populate_sizer_with_editable_attributes = function(l_39_0, l_39_1, l_39_2)
	local l_39_6, l_39_7 = ipairs, l_39_0:attribute_names()
	do
		l_39_6 = l_39_6(l_39_7)
		for i_0,i_1 in l_39_6 do
			local l_39_8 = nil
			do
				l_39_8 = l_39_0:control_for_attribute(l_39_5, l_39_2, function()
					-- upvalues: l_39_0 , l_39_7 , l_39_8 , l_39_2
					local l_40_0 = l_39_0:validate_control_for_attribute(l_39_7)
					if l_40_0 then
						if l_39_8:get_value() ~= nil or not "" then
							local l_40_2, l_40_3, l_40_4, l_40_5 = tostring(l_39_8:get_value())
						end
						 -- DECOMPILER ERROR: Confused about usage of registers!

						l_39_0:set_attribute_value_from_string(l_39_7, l_40_2)
						l_39_0:refresh_controls_dependent_on(l_39_7)
						l_39_2:fit_inside()
					end
        end)
				if not l_39_0.__controls then
					l_39_0.__controls = {}
				end
				l_39_0.__controls[l_39_5] = l_39_8
				l_39_0:refresh_control_for_attribute(l_39_5)
				local l_39_10 = nil
				if type_name(l_39_8) == "EWSPanel" then
					l_39_1:add(l_39_8, 1, 0, "EXPAND")
				else
					local l_39_11 = nil
					local l_39_12 = table.contains
					l_39_12 = l_39_12({"EWSCheckBox", "EWSButton", "EWSBitmapButton", "EWSStaticLine"}, l_39_11)
					 -- DECOMPILER ERROR: Overwrote pending register.

					if not l_39_12 and l_39_12 then
						l_39_1:add(EWS:StaticText(l_39_2, l_39_12 .. ":"), 0, 5, "TOP,LEFT,RIGHT")
					end
					 -- DECOMPILER ERROR: Overwrote pending register.

					l_39_12(l_39_1, l_39_11 == "table" and l_39_8.panel and l_39_8:panel() or l_39_8, 0, 5, "ALL,EXPAND")
				end
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreCutsceneKeyBase.attribute_label = function(l_40_0, l_40_1)
	local l_40_4 = nil
	if l_40_0["label_for_" .. l_40_1] then
		local l_40_2 = l_40_0["label_for_" .. l_40_1]
		local l_40_3 = l_40_0
		return l_40_2(l_40_3)
	else
		local l_40_5 = string.pretty
		local l_40_6 = l_40_1
		local l_40_7 = true
		return l_40_5(l_40_6, l_40_7)
	end
end

CoreCutsceneKeyBase.attribute_is_boolean = function(l_41_0, l_41_1)
	return l_41_0:attribute_value_from_string(l_41_1, "true") == true and l_41_0:attribute_value_from_string(l_41_1, "false") == false
end

CoreCutsceneKeyBase.control_for_attribute = function(l_42_0, l_42_1, l_42_2, l_42_3)
	local l_42_8, l_42_9 = nil
	if l_42_0["control_for_" .. l_42_1] then
		local l_42_4 = l_42_0["control_for_" .. l_42_1]
		local l_42_5 = l_42_0
		local l_42_6 = l_42_2
		local l_42_7 = l_42_3
		return l_42_4(l_42_5, l_42_6, l_42_7)
	else
		if l_42_0:attribute_is_boolean(l_42_1) then
			local l_42_10 = EWS:CheckBox(l_42_2, l_42_0:attribute_label(l_42_1))
			l_42_10:set_min_size(l_42_10:get_min_size():with_x(0))
			l_42_10:connect("EVT_COMMAND_CHECKBOX_CLICKED", l_42_3)
			return l_42_10
		end
	else
		local l_42_11 = EWS:TextCtrl(l_42_2, "")
		l_42_11:set_min_size(l_42_11:get_min_size():with_x(0))
		l_42_11:connect("EVT_COMMAND_TEXT_UPDATED", l_42_3)
		return l_42_11
	end
end

CoreCutsceneKeyBase.refresh_control_for_attribute = function(l_43_0, l_43_1)
	if l_43_0.__controls then
		local l_43_2, l_43_3, l_43_4, l_43_5, l_43_6, l_43_7, l_43_8, l_43_9, l_43_11, l_43_12 = l_43_0.__controls[l_43_1]
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_43_2 and (l_43_2.alive == nil or alive(l_43_2)) then
		if l_43_0["refresh_control_for_" .. l_43_1] then
			l_43_0["refresh_control_for_" .. l_43_1](l_43_0, l_43_2)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			if l_43_0:attribute_is_boolean(l_43_1) then
				l_43_2:set_value(l_43_0:attribute_value(l_43_1))
			end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		elseif l_43_2.change_value ~= nil then
			local l_43_10 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_43_10:change_value(tostring((type(l_43_0:attribute_value(l_43_1)) ~= "number" or string.format("%g", l_43_0:attribute_value(l_43_1)) == nil) and "" or string.format("%g", l_43_0:attribute_value(l_43_1))))
		end
		l_43_0:validate_control_for_attribute(l_43_1)
	elseif l_43_0.__controls then
		l_43_0.__controls[l_43_1] = nil
	end
end

CoreCutsceneKeyBase.refresh_controls_dependent_on = function(l_44_0, l_44_1, l_44_2)
	local l_44_6, l_44_7, l_44_8, l_44_9, l_44_10, l_44_11, l_44_12, l_44_13, l_44_14, l_44_15 = nil
	if not l_44_2 then
		l_44_2 = {}
	end
	if l_44_2[l_44_1] == nil then
		if not l_44_0.__control_dependencies or not l_44_0.__control_dependencies[l_44_1] then
			for i_0,i_1 in ipairs({}) do
			end
			l_44_0:refresh_control_for_attribute(i_1)
			l_44_2[i_1] = true
			l_44_0:refresh_controls_dependent_on(i_1, l_44_2)
		end
	end
end

CoreCutsceneKeyBase.validate_control_for_attribute = function(l_45_0, l_45_1)
	if l_45_0.__controls then
		local l_45_2, l_45_3, l_45_6, l_45_7, l_45_8 = l_45_0.__controls[l_45_1]
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_45_2 == nil then
		return false
	else
		local l_45_4 = nil
		local l_45_5 = table.contains
		l_45_5 = l_45_5({"EWSPanel", "EWSCheckBox", "EWSRadioButton", "EWSSlider", "EWSButton", "EWSBitmapButton", "EWSStaticLine", "EWSColorWell"}, type_name(l_45_4))
	if l_45_5 then
		end
		l_45_5 = true
		return l_45_5
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_45_9 = nil
	if not l_45_0:is_valid_attribute_value(l_45_1, l_45_0:attribute_value_from_string(l_45_1, l_45_4:get_value())) or not EWS:get_system_colour("WINDOW") then
		local l_45_10, l_45_11, l_45_12 = , Color("ff9999")
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_45_9:set_background_colour(l_45_11 * 255:unpack())
	if type_name(l_45_9) ~= "table" then
		l_45_9:refresh()
		l_45_9:update()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_45_10
end

CoreCutsceneKeyBase.standard_divider_control = function(l_46_0, l_46_1)
	local l_46_2 = EWS:StaticLine(l_46_1)
	l_46_2:set_min_size(l_46_2:get_min_size():with_x(0))
	return l_46_2
end

CoreCutsceneKeyBase.standard_combo_box_control = function(l_47_0, l_47_1, l_47_2)
	local l_47_3 = EWS:ComboBox(l_47_1, "", "", "CB_DROPDOWN,CB_READONLY,CB_SORT")
	l_47_3:set_min_size(l_47_3:get_min_size():with_x(0))
	l_47_3:connect("EVT_COMMAND_COMBOBOX_SELECTED", l_47_2)
	return l_47_3
end

CoreCutsceneKeyBase.standard_combo_box_control_refresh = function(l_48_0, l_48_1, l_48_2)
	return function(l_49_0, l_49_1)
		-- upvalues: l_48_1 , l_48_2
		local l_49_6, l_49_7, l_49_8, l_49_9 = nil
		l_49_1:freeze()
		l_49_1:clear()
		local l_49_2 = l_49_0:attribute_value(l_48_1)
		for i_0,i_1 in ipairs(l_48_2) do
			l_49_1:append(tostring(i_1))
			if tostring(i_1) == l_49_2 then
				l_49_1:set_value(tostring(i_1))
			end
		end
		l_49_1:thaw()
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end

CoreCutsceneKeyBase.standard_percentage_slider_control = function(l_49_0, l_49_1, l_49_2)
	local l_49_3 = EWS:Slider(l_49_1, 0, 0, 100, "", "SL_AUTOTICKS")
	l_49_3:set_tick_freq(50)
	l_49_3:connect("EVT_SCROLL_CHANGED", l_49_2)
	l_49_3:connect("EVT_SCROLL_THUMBTRACK", l_49_2)
	return l_49_3
end

CoreCutsceneKeyBase.standard_percentage_slider_control_refresh = function(l_50_0, l_50_1)
	return function(l_51_0, l_51_1)
		-- upvalues: l_50_1
		local l_51_2 = l_51_0:attribute_value(l_50_1)
		l_51_1:set_value(math.clamp(l_51_2 * 100, 0, 100))
  end
end

CoreCutsceneKeyBase.control_for_unit_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreCutsceneKeyBase.control_for_object_name = CoreCutsceneKeyBase.standard_combo_box_control
CoreCutsceneKeyBase.refresh_control_for_unit_name = function(l_51_0, l_51_1, l_51_2)
	local l_51_8, l_51_9, l_51_10, l_51_11, l_51_12, l_51_13, l_51_14, l_51_15, l_51_16, l_51_17 = nil
	l_51_1:freeze()
	l_51_1:clear()
	do
		local l_51_3 = l_51_0:_unit_names()
		if table.empty(l_51_3) then
			l_51_1:set_enabled(false)
		else
			l_51_1:set_enabled(true)
			if not l_51_2 then
				for i_0,i_1 in pairs(l_51_3) do
					local l_51_5 = l_51_0:unit_name()
					if l_51_0:is_valid_unit_name(i_1) then
						l_51_1:append(i_1)
					if i_1 == l_51_5 then
						end
						l_51_1:set_value(l_51_5)
					end
				end
			end
			l_51_1:thaw()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 24 
end

CoreCutsceneKeyBase.refresh_control_for_object_name = function(l_52_0, l_52_1, l_52_2, l_52_3)
	local l_52_9, l_52_10, l_52_11, l_52_12, l_52_13, l_52_14, l_52_15, l_52_16, l_52_17, l_52_18 = nil
	l_52_1:freeze()
	l_52_1:clear()
	local l_52_4, l_52_5 = l_52_0:_unit_object_names, l_52_0
	do
		if not l_52_2 then
			l_52_4 = l_52_4(l_52_5, l_52_0:unit_name())
		end
		l_52_5 = #l_52_4
		if l_52_5 == 0 then
			l_52_5(l_52_1, false)
		 -- DECOMPILER ERROR: Overwrote pending register.

		else
			l_52_5(l_52_1, true)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			if not l_52_3 then
				for i_0,i_1 in ipairs(l_52_4) do
					if l_52_0:is_valid_object_name(i_1, l_52_2) then
						l_52_1:append(i_1)
					if i_1 == l_52_5 then
						end
						l_52_1:set_value(l_52_5)
					end
				end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_52_5(l_52_1)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 25 
end

CoreCutsceneKeyBase.on_gui_representation_changed = function(l_53_0, l_53_1, l_53_2)
	l_53_0:set_frame(l_53_2:start_time())
end

CoreCutsceneKeyBase.VOID = function(l_54_0)
	local l_54_1 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_54_1
end

CoreCutsceneKeyBase.TRUE = function(l_55_0)
	return true
end

CoreCutsceneKeyBase.string_to_vector = function(l_56_0)
	local l_56_1 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_56_2 = string.match(l_56_0, "Vector3%((%-?[%d%.]+), (%-?[%d%.]+), (%-?[%d%.]+)%)").collect()
	 -- DECOMPILER ERROR: Overwrote pending register.

	return #l_56_2 == 3 and Vector3(tonumber(l_56_2)) or nil
end

CoreCutsceneKeyBase.string_to_rotation = function(l_57_0)
	local l_57_1 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_57_2 = string.match(l_57_0, "Rotation%((%-?[%d%.]+), (%-?[%d%.]+), (%-?[%d%.]+)%)").collect()
	 -- DECOMPILER ERROR: Overwrote pending register.

	return #l_57_2 == 3 and Rotation(tonumber(l_57_2)) or nil
end

CoreCutsceneKeyBase.string_to_color = function(l_58_0)
	local l_58_1 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_58_2 = string.match(l_58_0, "Color%(([%d%.]+) %* %(([%d%.]+), ([%d%.]+), ([%d%.]+)%)%)").collect()
	 -- DECOMPILER ERROR: Overwrote pending register.

	return #l_58_2 == 4 and Color(tonumber(l_58_2)) or nil
end

CoreCutsceneKeyBase:attribute_affects("unit_name", "object_name")

