require("managers/UnitScriptingUnitInfo")
require("shared/TableAlgorithms")
if not UnitScriptingManager then
	UnitScriptingManager = class()
end
UnitScriptingManager.init = function(l_1_0)
	local l_1_4, l_1_5, l_1_6, l_1_7 = nil
	l_1_0._unit_name_to_unit_info = {}
	l_1_0._unit_to_unit_info = {}
	l_1_0._unit_callbacks = {}
	l_1_0._name_aliases = {}
	l_1_0._unit_names_memory = {}
	for i_0,i_1 in pairs(PredefinedUnits.manual_name_ids) do
		l_1_0._unit_names_memory[i_1.script_name] = true
	end
end

UnitScriptingManager.destroy = function(l_2_0)
	l_2_0:clear()
end

UnitScriptingManager.define_unit = function(l_3_0, l_3_1)
	local l_3_2 = l_3_0._unit_name_to_unit_info[l_3_1]
	if l_3_2 then
		return 
	end
	local l_3_3 = UnitScriptingUnitInfo:new(l_3_1)
	l_3_0._unit_name_to_unit_info[l_3_1] = l_3_3
end

UnitScriptingManager.register_new_unit_name = function(l_4_0, l_4_1, l_4_2, l_4_3)
	local l_4_10, l_4_11, l_4_12, l_4_13 = nil
	local l_4_4 = l_4_0._unit_name_to_unit_info[l_4_1]
	local l_4_5 = l_4_0._unit_name_to_unit_info[l_4_2]
	if not l_4_4 then
		l_4_0:register_unit(l_4_2, l_4_3)
		return 
	end
	l_4_4:unregister()
	l_4_5:register_unit(l_4_3)
	l_4_0._unit_to_unit_info[l_4_3] = l_4_5
	l_4_0._unit_name_to_unit_info[l_4_1] = nil
	local l_4_6 = l_4_0._unit_callbacks[l_4_2]
	if l_4_6 then
		for i_0,i_1 in ipairs(l_4_6) do
			i_1(l_4_3)
		end
		l_4_0._unit_callbacks[l_4_2] = nil
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

UnitScriptingManager.register_alias = function(l_5_0, l_5_1, l_5_2)
	l_5_0._name_aliases[l_5_2] = l_5_1
end

UnitScriptingManager.register_unit = function(l_6_0, l_6_1, l_6_2)
	local l_6_8, l_6_9, l_6_10, l_6_11 = nil
	local l_6_3 = l_6_0._unit_name_to_unit_info[l_6_1]
	if not l_6_3 then
		l_6_0:define_unit(l_6_1)
		l_6_3 = l_6_0._unit_name_to_unit_info[l_6_1]
	end
	l_6_3:register_unit(l_6_2)
	l_6_0._unit_to_unit_info[l_6_2] = l_6_3
	local l_6_4 = l_6_0._unit_callbacks[l_6_1]
	if l_6_4 then
		for i_0,i_1 in ipairs(l_6_4) do
			i_1(l_6_2)
		end
		l_6_0._unit_callbacks[l_6_1] = nil
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

UnitScriptingManager.unit_dead = function(l_7_0, l_7_1)
	local l_7_2 = l_7_0._unit_to_unit_info[l_7_1]
	if not l_7_2 then
		return 
	end
	l_7_2:unit_dead()
end

UnitScriptingManager.unit_destroyed = function(l_8_0, l_8_1)
	local l_8_2 = l_8_0._unit_to_unit_info[l_8_1]
	if not l_8_2 then
		return 
	end
	l_8_0._unit_name_to_unit_info[l_8_2:name()] = nil
	l_8_0._unit_names_memory[l_8_2:name()] = true
	if type(l_8_1) ~= "function" then
		l_8_0._unit_to_unit_info[l_8_1] = nil
	end
end

UnitScriptingManager.unit_exists = function(l_9_0, l_9_1)
	if not l_9_0._unit_name_to_unit_info[l_9_1] then
		local l_9_2 = l_9_0._unit_name_to_unit_info[l_9_0._name_aliases[l_9_1]]
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_9_2 then
			return l_9_2:registered()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

UnitScriptingManager.get_unit_by_name = function(l_10_0, l_10_1)
	local l_10_7, l_10_8 = nil
	if not l_10_0._unit_name_to_unit_info[l_10_1] then
		local l_10_2, l_10_3, l_10_4, l_10_9, l_10_10 = l_10_0._unit_name_to_unit_info[l_10_0._name_aliases[l_10_1]]
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_10_2 and l_10_2:registered() then
		local l_10_5, l_10_6 = , l_10_2:unit
		return l_10_6(l_10_2)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_10_5 and l_10_0._unit_names_memory[l_10_1] then
		return nil
	end
	local l_10_11 = nil
	if managers.editor then
		managers.editor:output_warning("Unit " .. l_10_1 .. " does not exist here.")
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	Application:error("Unit " .. l_10_1 .. " does not exist here.")
	return nil
end

UnitScriptingManager.get_unit_by_name_callback = function(l_11_0, l_11_1, l_11_2)
	if not l_11_0._unit_callbacks[l_11_1] then
		l_11_0._unit_callbacks[l_11_1] = {}
	end
	local l_11_3 = nil
	if l_11_0:unit_exists(l_11_1) then
		l_11_3 = l_11_0:get_unit_by_name(l_11_1)
	end
	if alive(l_11_3) then
		l_11_2(l_11_3)
	else
		table.insert(l_11_0._unit_callbacks[l_11_1], l_11_2)
	end
end

UnitScriptingManager.unit_script_name = function(l_12_0, l_12_1)
	local l_12_6, l_12_7, l_12_8, l_12_9, l_12_13, l_12_14 = nil
	local l_12_2 = l_12_0._unit_to_unit_info[l_12_1]
	if not l_12_2 then
		for l_12_12,i_1 in pairs(l_12_0._unit_to_unit_info) do
			if type(l_12_12) == "function" then
				local l_12_15 = l_12_12()
			if l_12_1 == l_12_15 then
				end
				l_12_2 = l_12_16
			end
	else
		end
	end
	if not l_12_2 then
		return nil
	end
	local l_12_10, l_12_11 = l_12_2:name, l_12_2
	return l_12_10(l_12_11)
end

UnitScriptingManager.add_unit_death_callback = function(l_13_0, l_13_1, l_13_2)
	local l_13_3 = l_13_0._unit_name_to_unit_info[l_13_1]
	assert(l_13_3, "No such unit " .. l_13_1 .. " in unit scripting manager!")
	l_13_3:add_death_callback(l_13_2)
end

UnitScriptingManager.update = function(l_14_0, l_14_1, l_14_2)
	local l_14_3 = function(l_15_0)
		if not l_15_0:active() then
			l_15_0:destroy()
			return true
		end
		return false
  end
	TableAlgorithms.remove_if(l_14_0._unit_name_to_unit_info, l_14_3)
	TableAlgorithms.remove_if(l_14_0._unit_to_unit_info, l_14_3)
end


