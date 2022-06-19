require("core/managers/controller/CoreControllerWrapperSettings")
require("core/managers/controller/CoreControllerWrapperGamepad")
require("core/managers/controller/CoreControllerWrapperPC")
require("core/managers/controller/CoreControllerWrapperXbox360")
require("core/managers/controller/CoreControllerWrapperPS3")
require("core/managers/controller/CoreControllerWrapperDebug")
if not CoreControllerManager then
	CoreControllerManager = class()
end
CoreControllerManager.CORE_CONTROLLER_SETTING_FILE = CoreControllerManager.CORE_CONTROLLER_SETTING_FILE or "data\\settings\\core_controller_settings.xml"
CoreControllerManager.init = function(l_1_0, l_1_1, l_1_2)
	local l_1_7, l_1_8, l_1_12, l_1_13 = nil
	if not Global.controller_manager then
		Global.controller_manager = {}
	end
	l_1_0:create_virtual_pad()
	l_1_0._last_default_controller_index_change_callback_id = 0
	l_1_0._default_controller_index_change_callback_map = {}
	l_1_0._controller_wrapper_list = {}
	l_1_0._controller_wrapper_map = {}
	l_1_0._next_controller_wrapper_id = 1
	l_1_0._supported_wrapper_types = {}
	local l_1_3 = l_1_0._supported_wrapper_types
	local l_1_4 = get_core_or_local("ControllerWrapperGamepad").TYPE
	l_1_3[l_1_4] = get_core_or_local("ControllerWrapperGamepad")
	l_1_3 = l_1_0._supported_wrapper_types
	l_1_4 = get_core_or_local
	l_1_4 = l_1_4("ControllerWrapperPC")
	l_1_4 = l_1_4.TYPE
	l_1_3[l_1_4] = get_core_or_local("ControllerWrapperPC")
	l_1_3 = l_1_0._supported_wrapper_types
	l_1_4 = get_core_or_local
	l_1_4 = l_1_4("ControllerWrapperXbox360")
	l_1_4 = l_1_4.TYPE
	l_1_3[l_1_4] = get_core_or_local("ControllerWrapperXbox360")
	l_1_3 = l_1_0._supported_wrapper_types
	l_1_4 = get_core_or_local
	l_1_4 = l_1_4("ControllerWrapperPS3")
	l_1_4 = l_1_4.TYPE
	local l_1_6 = get_core_or_local
	l_1_6 = l_1_6("ControllerWrapperPS3")
	l_1_3[l_1_4] = l_1_6
	l_1_0._supported_controller_type_map, l_1_3 = l_1_3, {}
	l_1_3 = pairs
	l_1_4 = l_1_0._supported_wrapper_types
	l_1_3 = l_1_3(l_1_4)
	for i_0,i_1 in l_1_3 do
		for i_0,i_1 in ipairs(i_1.CONTROLLER_TYPE_LIST) do
			l_1_0._supported_controller_type_map[i_1] = l_1_5
		end
	end
	l_1_0._last_version = nil
	l_1_0._last_core_version = nil
	l_1_0._default_settings_path = l_1_2
	l_1_0._controller_setup = {}
	l_1_0._core_controller_setup = {}
	l_1_0._settings_path = l_1_1
	l_1_0:load_core_settings(false)
	l_1_0._settings_file_changed_callback_list = {}
	l_1_0._last_settings_file_changed_callback_id = 0
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerManager.update = function(l_2_0, l_2_1, l_2_2)
	local l_2_6, l_2_7, l_2_8, l_2_9, l_2_10, l_2_11 = nil
	for i_0,i_1 in pairs(l_2_0._controller_wrapper_list) do
		if i_1:enabled() then
			i_1:update(l_2_1, l_2_2)
		end
	end
end

CoreControllerManager.paused_update = function(l_3_0, l_3_1, l_3_2)
	local l_3_6, l_3_7, l_3_8, l_3_9, l_3_10, l_3_11 = nil
	for i_0,i_1 in pairs(l_3_0._controller_wrapper_list) do
		if i_1:enabled() then
			i_1:paused_update(l_3_1, l_3_2)
		end
	end
end

CoreControllerManager.add_settings_file_changed_callback = function(l_4_0, l_4_1)
	l_4_0._last_settings_file_changed_callback_id = l_4_0._last_settings_file_changed_callback_id + 1
	l_4_0._settings_file_changed_callback_list[l_4_0._last_settings_file_changed_callback_id] = l_4_1
	return l_4_0._last_settings_file_changed_callback_id
end

CoreControllerManager.remove_settings_file_changed_callback = function(l_5_0, l_5_1)
	l_5_0._settings_file_changed_callback_list[l_5_1] = nil
end

CoreControllerManager.create_controller = function(l_6_0, l_6_1, l_6_2, l_6_3)
	local l_6_4 = nil
	if l_6_3 then
		local l_6_5 = nil
		local l_6_6, l_6_7 = {}, nil
		local l_6_8 = nil
		repeat
			l_6_7 = l_6_0:check_controllers(0, l_6_1, true, {})
			if l_6_7 then
				if not l_6_8 then
					l_6_8 = l_6_7
				end
				table.insert(l_6_6, l_6_7)
				l_6_0._next_controller_wrapper_id = l_6_0._next_controller_wrapper_id + 1
				 -- DECOMPILER ERROR: Confused about usage of registers!

				{}[l_6_7:get_type()] = true
			end
		until not l_6_7
		l_6_5 = get_core_or_local("ControllerWrapperDebug"):new(l_6_6, l_6_0._next_controller_wrapper_id, l_6_1, l_6_8, get_core_or_local("ControllerWrapperSettings"):new(get_core_or_local("ControllerWrapperDebug").TYPE))
	elseif not l_6_2 and not Global.controller_manager.default_controller_index then
		l_6_2 = l_6_0:get_preferred_default_index()
	end
	do
		local l_6_9, l_6_10, l_6_11, l_6_12, l_6_13, l_6_14, l_6_15, l_6_16, l_6_17, l_6_18, l_6_19 = l_6_0:check_controllers(l_6_2, l_6_1, false, nil)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_6_9 then
		if l_6_1 then
			if l_6_0._controller_wrapper_map[l_6_1] then
				l_6_9:destroy()
				error("Tried to create a controller with a name \"" .. tostring(l_6_1) .. "\" that already exists.")
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_6_0._controller_wrapper_map[l_6_1] = l_6_9
		end
		cat_print("controller_manager", "[ControllerManager] Created new controller. Name: " .. tostring(l_6_1) .. ", Index: " .. tostring(l_6_2) .. ", Debug: " .. tostring(l_6_3) .. ", Id: " .. tostring(l_6_0._next_controller_wrapper_id))
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_6_9:add_destroy_callback(callback(l_6_0, l_6_0, "controller_wrapper_destroy_callback"))
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_6_0._controller_wrapper_list[l_6_0._next_controller_wrapper_id] = l_6_9
		l_6_0._next_controller_wrapper_id = l_6_0._next_controller_wrapper_id + 1
	else
		cat_print("controller_manager", "[ControllerManager] Failed to create new controller. Name: " .. tostring(l_6_1) .. ", Index: " .. tostring(l_6_2) .. ", Debug: " .. tostring(l_6_3))
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_6_9
end

CoreControllerManager.get_preferred_default_index = function(l_7_0)
	local l_7_1 = 0
	for l_7_5 = 0, Input:num_real_controllers() - 1 do
		local l_7_6 = Input:controller(l_7_5)
		if l_7_6 and l_7_6:connected() then
			local l_7_7 = l_7_6:type()
			local l_7_8 = l_7_0._supported_controller_type_map[l_7_7]
		if l_7_8 then
			end
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if l_7_7 == l_7_0._supported_wrapper_types[l_7_8].CONTROLLER_TYPE_LIST[1] and l_7_7 ~= "win32_keyboard" then
			end
			return l_7_5 - l_7_1
		end
		do return end
		l_7_1 = l_7_1 + 1
	end
	return 0
end

CoreControllerManager.check_controllers = function(l_8_0, l_8_1, l_8_2, l_8_3, l_8_4)
	local l_8_5 = nil
	for l_8_9 = 0, Input:num_real_controllers() - 1 do
		local l_8_6 = 0
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if Input:controller(R10_PC10) then
			local l_8_11 = nil
			local l_8_12 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_8_0._supported_controller_type_map[Input:controller(R10_PC10):type()] and (not l_8_4 or not l_8_4[l_8_0._supported_controller_type_map[Input:controller(R10_PC10):type()]]) then
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			local l_8_13 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if l_8_12 == l_8_0._supported_wrapper_types[l_8_0._supported_controller_type_map[Input:controller(R10_PC10):type()]].CONTROLLER_TYPE_LIST[1] and l_8_1 <= l_8_10 - l_8_6 then
			end
			l_8_5 = l_8_0._supported_wrapper_types[l_8_0._supported_controller_type_map[Input:controller(R10_PC10):type()]]:new(l_8_0._next_controller_wrapper_id, l_8_2, l_8_11, l_8_0._controller_setup[l_8_13], l_8_3, false, l_8_0._virtual_game_pad)
			do break end
		end
		do return end
		l_8_6 = l_8_6 + 1
	end
	if not l_8_5 and not l_8_3 then
		Application:stack_dump_error("Incorrect index parameter sent to managers.controller:create_controller( ... ).\nTHIS WILL CRASH SOON, SO FIX IT!\n")
		l_8_5 = l_8_0:check_controllers(0, l_8_2, l_8_3, nil)
	end
	return l_8_5
end

CoreControllerManager.get_real_controller_count = function(l_9_0)
	local l_9_1, l_9_2 = Input:num_real_controllers, Input
	return l_9_1(l_9_2)
end

CoreControllerManager.get_wrapper_count = function(l_10_0)
	local l_10_1 = 0
	for l_10_5 = 0, Input:num_real_controllers() - 1 do
		local l_10_6 = Input:controller(l_10_5)
		if l_10_6 then
			local l_10_7 = l_10_6:type()
			local l_10_8 = l_10_0._supported_controller_type_map[l_10_7]
		if l_10_8 then
			end
		if l_10_7 == l_10_0._supported_wrapper_types[l_10_8].CONTROLLER_TYPE_LIST[1] then
			end
			l_10_1 = l_10_1 + 1
		end
	end
	return l_10_1
end

CoreControllerManager.add_default_controller_index_change_callback = function(l_11_0, l_11_1)
	l_11_0._last_default_controller_index_change_callback_id = l_11_0._last_default_controller_index_change_callback_id + 1
	l_11_0._default_controller_index_change_callback_map[l_11_0._last_default_controller_index_change_callback_id] = l_11_1
	return l_11_0._last_default_controller_index_change_callback_id
end

CoreControllerManager.remove_default_controller_index_change_callback = function(l_12_0, l_12_1)
	l_12_0._default_controller_index_change_callback_map[l_12_1] = nil
end

CoreControllerManager.set_default_controller_index = function(l_13_0, l_13_1)
	if Global.controller_manager.default_controller_index ~= l_13_1 then
		local l_13_6 = cat_print
		local l_13_7 = "controller_manager"
		l_13_6(l_13_7, "[ControllerManager] Changed default controller index from " .. tostring(Global.controller_manager.default_controller_index) .. " to " .. tostring(l_13_1) .. ".")
		l_13_6 = Global
		l_13_6 = l_13_6.controller_manager
		l_13_6.default_controller_index = l_13_1
		local l_13_2 = nil
		l_13_7 = pairs
		l_13_2 = l_13_0._default_controller_index_change_callback_map
		l_13_7 = l_13_7(l_13_2)
		for i_0,i_1 in l_13_7 do
			do
				table.insert(l_13_6, l_13_5)
			end
			for i_0,i_1 in ipairs(l_13_6) do
				i_1(l_13_1)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreControllerManager.get_default_controller_index = function(l_14_0)
	return Global.controller_manager.default_controller_index
end

CoreControllerManager.controller_wrapper_destroy_callback = function(l_15_0, l_15_1)
	local l_15_2 = l_15_1:get_id()
	local l_15_3 = l_15_1:get_name()
	cat_print("controller_manager", "[ControllerManager] Destroyed controller. Name: " .. tostring(l_15_3) .. ", Id: " .. tostring(l_15_2))
	l_15_0._controller_wrapper_list[l_15_2] = nil
	if l_15_3 then
		l_15_0._controller_wrapper_map[l_15_3] = nil
	end
end

CoreControllerManager.load_core_settings = function(l_16_0, l_16_1)
	if File:config_exists(l_16_0.CORE_CONTROLLER_SETTING_FILE) then
		local l_16_2 = File:parse_xml(l_16_0.CORE_CONTROLLER_SETTING_FILE)
		local l_16_6 = tonumber
		l_16_6 = l_16_6(l_16_2:parameter("core_version"))
		l_16_0._last_core_version = l_16_6
		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0 in l_16_6 do
			local l_16_7 = l_16_5:name()
			if l_16_0._core_controller_setup[l_16_7] then
				Application:error("Duplicate core controller settings for \"" .. tostring(l_16_7) .. "\" found in \"" .. tostring(path) .. "\". Overwrites existing one.")
			end
			l_16_0._core_controller_setup[l_16_7] = get_core_or_local("ControllerWrapperSettings"):new(l_16_7, l_16_5, nil)
			l_16_0._controller_setup[l_16_7] = l_16_0._core_controller_setup[l_16_7]
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_16_6 then
			l_16_0:load_settings(l_16_0._settings_path, l_16_1)
		end
		return true
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		l_16_2 = false
		return l_16_2
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreControllerManager.load_settings = function(l_17_0, l_17_1, l_17_2)
	local l_17_3 = false
	if l_17_0._default_settings_path and (not l_17_1 or not File:config_exists(l_17_1)) then
		if l_17_1 then
			Application:error("Invalid path \"" .. tostring(l_17_1) .. "\", defaults to \"" .. tostring(l_17_0._default_settings_path) .. "\".")
		end
		l_17_1 = l_17_0._default_settings_path
		l_17_2 = false
	end
	if l_17_1 and File:config_exists(l_17_1) then
		local l_17_4 = File:parse_xml(l_17_1)
		local l_17_5 = tonumber(l_17_4:parameter("version"))
		local l_17_20, l_17_21 = tonumber, l_17_4:parameter("core_version")
		l_17_20 = l_17_20(l_17_21)
		local l_17_6 = nil
		l_17_21 = l_17_0._last_version
		if l_17_21 and l_17_5 then
			l_17_21 = l_17_0._last_version
			l_17_21 = l_17_21 <= l_17_5
			local l_17_8, l_17_10, l_17_11, l_17_13, l_17_15 = nil
		end
		l_17_6 = l_17_0._default_settings_path
		if l_17_1 ~= l_17_6 then
			l_17_6 = l_17_0._last_core_version
		if l_17_6 and l_17_20 then
			end
			l_17_6 = l_17_0._last_core_version
		end
		l_17_6 = l_17_6 <= l_17_20
		if l_17_21 and l_17_6 then
			l_17_0._controller_setup = {}
			l_17_0._settings_path = l_17_1
			for i_0,i_1 in pairs(l_17_0._controller_wrapper_list) do
				i_1:clear_connections(false)
			end
			for i_0 in l_17_4:children() do
				if l_17_0._controller_setup[i_0:name()] then
					Application:error("Duplicate controller settings for \"" .. tostring(i_0:name()) .. "\" found in \"" .. tostring(l_17_1) .. "\". Overwrites existing one.")
				end
				l_17_0._controller_setup[i_0:name()] = get_core_or_local("ControllerWrapperSettings"):new(i_0:name(), i_0, l_17_0._core_controller_setup[i_0:name()])
			end
			l_17_0._last_version = l_17_5
			l_17_3 = true
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		else
			if l_17_1 == l_17_0._default_settings_path or l_17_2 then
				if File:exists(l_17_1) then
					File:delete_file(l_17_1)
				end
			if string.gsub(l_17_1, "(.*).xml", "%1.xmb") then
				end
			if File:config_exists(string.gsub(l_17_1, "(.*).xml", "%1.xmb")) then
				end
				File:delete_file(string.gsub(l_17_1, "(.*).xml", "%1.xmb"))
			end
			Application:error("Old controller settings file \"" .. tostring(l_17_1) .. "\" detected (version: \"" .. tostring(l_17_5) .. "\", core version: \"" .. tostring(l_17_20) .. "\", latest version: \"" .. tostring(l_17_0._last_version) .. "\", latest core version: \"" .. tostring(l_17_0._last_core_version) .. "\"." .. " Loads the default path \"" .. tostring(l_17_0._default_settings_path) .. "\" instead." .. " Removes the invalid path.")
		if l_17_1 ~= l_17_0._default_settings_path then
			end
			l_17_0:load_settings(l_17_0._default_settings_path, false)
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		local l_17_25, l_17_26, l_17_27, l_17_28, l_17_30, l_17_32, l_17_33 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_17_29, l_17_31, l_17_34 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_17_4(l_17_5, l_17_20)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	for l_17_21,l_17_6 in l_17_4 do
		do
			local l_17_22, l_17_23, l_17_24 = nil
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			if not l_17_22 then
				l_17_0._controller_setup[l_17_21] = l_17_22
			end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_17_4(l_17_5)
		for i_0,i_1 in pairs(l_17_0._settings_file_changed_callback_list) do
			 -- DECOMPILER ERROR: Overwrote pending register.

			i_1(l_17_22)
		end
		return l_17_3
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerManager.save_settings = function(l_18_0, l_18_1)
	if l_18_0._last_version then
		local l_18_2 = File:open(l_18_1, "w")
		local l_18_3 = ""
		if l_18_0._last_core_version then
			l_18_3 = string.format(" core_version=\"%g\"", l_18_0._last_core_version)
		end
		local l_18_7, l_18_8 = l_18_2:puts, l_18_2
		l_18_7(l_18_8, string.format("<controller_settings version=\"%g\"%s>", l_18_0._last_version, l_18_3))
		l_18_7 = pairs
		l_18_8 = l_18_0._controller_setup
		l_18_7 = l_18_7(l_18_8)
		for i_0,i_1 in l_18_7 do
			l_18_2:puts("\t<" .. tostring(l_18_5) .. ">")
			l_18_6:print_output(l_18_2, 2)
			l_18_2:puts("\t</" .. tostring(l_18_5) .. ">")
		end
		l_18_2:puts("</controller_settings>")
		l_18_2:close()
		l_18_0._settings_path = l_18_1
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		l_18_2 = Application
		l_18_2, l_18_3 = l_18_2:error, l_18_2
		l_18_2(l_18_3, "Unable to save controller settings. No settings to save.")
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreControllerManager.rebind_connections = function(l_19_0)
	local l_19_4, l_19_5, l_19_6, l_19_7, l_19_8, l_19_9 = nil
	for i_0,i_1 in pairs(l_19_0._controller_wrapper_list) do
		i_1:rebind_connections(l_19_0._controller_setup[i_1:get_type()], l_19_0._controller_setup)
	end
end

CoreControllerManager.get_settings_map = function(l_20_0)
	return l_20_0._controller_setup
end

CoreControllerManager.get_settings = function(l_21_0, l_21_1)
	return l_21_0._controller_setup[l_21_1]
end

CoreControllerManager.get_default_settings_path = function(l_22_0)
	return l_22_0._default_settings_path
end

CoreControllerManager.set_default_settings_path = function(l_23_0, l_23_1)
	l_23_0._default_settings_path = l_23_1
end

CoreControllerManager.get_settings_path = function(l_24_0)
	return l_24_0._default_settings_path
end

CoreControllerManager.set_settings_path = function(l_25_0, l_25_1)
	l_25_0._settings_path = l_25_1
end

CoreControllerManager.create_virtual_pad = function(l_26_0)
	if not l_26_0._virtual_game_pad then
		l_26_0._virtual_game_pad = Input:create_virtual_controller("all_gamepads")
	end
	l_26_0._virtual_game_pad:clear_connections()
	local l_26_1 = 0
	local l_26_2 = 0
	while 1 do
		local l_26_3 = Input:num_real_controllers()
		while l_26_2 < l_26_3 do
			local l_26_4 = Input:controller(l_26_2)
			if l_26_4 and l_26_4:type() == "win32_game_controller" and l_26_4:connected() then
				l_26_1 = l_26_1 + 1
				for l_26_8 = 0, l_26_4:num_buttons() - 1 do
					l_26_0._virtual_game_pad:connect(l_26_4, l_26_4:button_name(l_26_8), "gamepad" .. tostring(l_26_1) .. "_B" .. tostring(l_26_8))
				end
				for l_26_12 = 0, l_26_4:num_axes() - 1 do
					l_26_0._virtual_game_pad:connect(l_26_4, l_26_4:axis_name(l_26_12), "gamepad" .. tostring(l_26_1) .. "_A" .. tostring(l_26_12))
				end
			end
			l_26_2 = l_26_2 + 1
		end
		do
			local l_26_13 = Input:mouse()
			for l_26_17 = 0, l_26_13:num_buttons() - 1 do
				l_26_0._virtual_game_pad:connect(l_26_13, l_26_13:button_name(l_26_17), "mouse " .. tostring(l_26_17))
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end


