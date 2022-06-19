require("core/managers/CoreActionManager")
require("core/managers/CoreAreaManager")
if not CoreWorldManager then
	CoreWorldManager = class()
end
CoreWorldManager.init = function(l_1_0)
	l_1_0._stages = {}
	l_1_0._triggers = {}
	l_1_0._runned_unit_sequences_callbacks = {}
	if not rawget(_G, "EnemyTrigger") then
		l_1_0:add_trigger("Enemy", rawget(_G, "CoreEnemyTrigger"))
	end
	if not rawget(_G, "EnemyProducerTrigger") then
		l_1_0:add_trigger("EnemyProducer", rawget(_G, "CoreEnemyProducerTrigger"))
	end
	if not rawget(_G, "EnemyGroupTrigger") then
		l_1_0:add_trigger("EnemyGroup", rawget(_G, "CoreEnemyGroupTrigger"))
	end
	if not rawget(_G, "UnitSequenceTrigger") then
		l_1_0:add_trigger("UnitSequenceTrigger", rawget(_G, "CoreUnitSequenceTrigger"))
	end
	if not rawget(_G, "WorldCameraDoneTrigger") then
		l_1_0:add_trigger("WorldCamera", rawget(_G, "CoreWorldCameraDoneTrigger"))
	end
	if not rawget(_G, "WorldCameraTrigger") then
		l_1_0:add_trigger("WorldCameraTrigger", rawget(_G, "CoreWorldCameraTrigger"))
	end
	if not rawget(_G, "HubTrigger") then
		l_1_0:add_trigger("Hub", rawget(_G, "CoreHubTrigger"))
	end
	if not rawget(_G, "CutsceneTrigger") then
		l_1_0:add_trigger("Cutscene", rawget(_G, "CoreCutsceneTrigger"))
	end
	if not rawget(_G, "AreaManager") then
		local l_1_1, l_1_2, l_1_3, l_1_5 = rawget(_G, "CoreAreaManager")
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	managers.area = l_1_1:new()
	if not rawget(_G, "ActionManager") then
		local l_1_4, l_1_6 = , rawget(_G, "CoreActionManager")
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	managers.action = l_1_6:new()
end

CoreWorldManager.add_trigger = function(l_2_0, l_2_1, l_2_2)
	l_2_0._triggers[l_2_1] = l_2_2
end

CoreWorldManager.get_trigger = function(l_3_0, l_3_1)
	return l_3_0._triggers[l_3_1]
end

CoreWorldManager.parse = function(l_4_0, l_4_1, l_4_2, l_4_3)
	if not l_4_3 then
		l_4_0._offset = Vector3(0, 0, 0)
	end
	do
		local l_4_8 = cat_debug
		l_4_8("gaspode", "MISSION", l_4_1, l_4_2)
		l_4_8 = managers
		l_4_8 = l_4_8.worlddefinition
		if l_4_8 then
			l_4_8 = managers
			l_4_8 = l_4_8.worlddefinition
			l_4_8(l_4_8, l_4_2)
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_4_8 then
			for i_0 in l_4_8:children() do
				cat_debug("gaspode", i_0:parameter("name"), l_4_2)
				if i_0:parameter("name") == l_4_2 then
					cat_debug("gaspode", "insert", i_0:parameter("name"))
					if not rawget(_G, "Stage") then
						local l_4_10, l_4_11, l_4_12, l_4_13 = , rawget(_G, "CoreStage")
					end
					 -- DECOMPILER ERROR: Confused about usage of registers!

					 -- DECOMPILER ERROR: Confused about usage of registers!

					l_4_0._current_stage = l_4_11:new(l_4_9, l_4_10)
					 -- DECOMPILER ERROR: Confused about usage of registers!

					l_4_0._stages[l_4_10] = l_4_0._current_stage
					l_4_0:activate_current_stage()
				end
			end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		else
			l_4_8(l_4_8, "Couldn't find", l_4_1)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreWorldManager.activate_current_stage = function(l_5_0)
	l_5_0._current_stage:activate()
end

CoreWorldManager.update = function(l_6_0, l_6_1, l_6_2)
	managers.area:update(l_6_1, l_6_2)
	managers.action:update(l_6_1, l_6_2)
end

CoreWorldManager.stop_simulation = function(l_7_0)
	managers.action:clear()
	if l_7_0._current_stage then
		l_7_0._current_stage:stop_simulation()
	end
end

CoreWorldManager.offset = function(l_8_0)
	return l_8_0._offset
end

CoreWorldManager.create_areas = function(l_9_0, l_9_1)
	managers.area:set_up(l_9_1)
end

CoreWorldManager.current_stage = function(l_10_0)
	return l_10_0._current_stage
end

CoreWorldManager.add_runned_unit_sequence_trigger = function(l_11_0, l_11_1, l_11_2, l_11_3)
	if l_11_0._runned_unit_sequences_callbacks[l_11_1] then
		if l_11_0._runned_unit_sequences_callbacks[l_11_1][l_11_2] then
			table.insert(l_11_0._runned_unit_sequences_callbacks[l_11_1][l_11_2], l_11_3)
		else
			local l_11_4 = l_11_0._runned_unit_sequences_callbacks[l_11_1]
			local l_11_5 = {}
			 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		end
	else
		local l_11_6 = {}
		local l_11_7 = {}
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	end
	 -- WARNING: undefined locals caused missing assignments!
end

CoreWorldManager.runned_unit_sequence = function(l_12_0, l_12_1, l_12_2)
	local l_12_7, l_12_8, l_12_9, l_12_10 = nil
	if alive(l_12_1) and l_12_1:unit_data() then
		local l_12_3 = l_12_1:unit_data().unit_id
	if l_12_0._runned_unit_sequences_callbacks[l_12_3] then
		end
	if l_12_0._runned_unit_sequences_callbacks[l_12_3][l_12_2] then
		end
		for i_0,i_1 in ipairs(l_12_0._runned_unit_sequences_callbacks[l_12_3][l_12_2]) do
			i_1()
		end
	end
end

if not CoreStage then
	CoreStage = class()
end
CoreStage.init = function(l_13_0, l_13_1, l_13_2)
	l_13_0._name = l_13_2
	cat_debug("gaspode", "Stage:", l_13_0._name)
	l_13_0._hubs = {}
	l_13_0._hub_triggers = {}
	l_13_0._start_hubs = {}
	local l_13_6, l_13_7 = l_13_1:for_each, l_13_1
	l_13_6(l_13_7, "hub", callback(l_13_0, l_13_0, "parse_hub"))
	l_13_6 = pairs
	l_13_7 = l_13_0._hubs
	l_13_6 = l_13_6(l_13_7)
	for i_0,i_1 in l_13_6 do
		do
			if l_13_5:use_as_start() then
				l_13_0._start_hub = l_13_5
		else
			end
		end
		if table.size(l_13_0._start_hubs) > 0 then
			cat_print("gaspode", "START HUB, search default")
			for i_0,i_1 in pairs(l_13_0._start_hubs) do
				if i_1.default then
					cat_print("gaspode", "    START HUB, found default", i_0)
					l_13_0._start_hub = i_1.hub
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreStage.activate = function(l_14_0)
	cat_print("gaspode", "============= NEW ACTIVATE CoreStage:activate() =============")
	if l_14_0._start_hub then
		l_14_0._start_hub:activate()
	end
end

CoreStage.parse_hub = function(l_15_0, l_15_1)
	local l_15_2 = l_15_0._hubs
	do
		local l_15_3 = l_15_1:parameter("name")
		if not rawget(_G, "WMHub") then
			l_15_2[l_15_3] = rawget(_G, "CoreWMHub"):new(l_15_0, l_15_1)
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 15 
end

CoreStage.set_start_actions = function(l_16_0, l_16_1)
	l_16_0._start_actions = l_16_1
end

CoreStage.set_start_activation = function(l_17_0, l_17_1)
	l_17_0._start_hub = l_17_1
end

CoreStage.add_start_hub = function(l_18_0, l_18_1, l_18_2)
	cat_print("gaspode", "add hub has start hub", l_18_1, l_18_2.default)
	l_18_0._start_hubs[l_18_1] = l_18_2
end

CoreStage.add_hub_trigger = function(l_19_0, l_19_1, l_19_2)
	if l_19_0._hub_triggers[l_19_1] then
		table.insert(l_19_0._hub_triggers[l_19_1], l_19_2)
	else
		local l_19_3 = l_19_0._hub_triggers
		local l_19_4 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	end
	 -- WARNING: undefined locals caused missing assignments!
end

CoreStage.run_hub_trigger = function(l_20_0, l_20_1)
	local l_20_5, l_20_6, l_20_7, l_20_8 = nil
	if l_20_0._hub_triggers[l_20_1] then
		for i_0,i_1 in ipairs(l_20_0._hub_triggers[l_20_1]) do
			i_1:trigger_hub()
		end
	end
end

CoreStage.activate_hub = function(l_21_0, l_21_1)
	l_21_0._hubs[l_21_1]:activate()
end

CoreStage.get_hub = function(l_22_0, l_22_1)
	return l_22_0._hubs[l_22_1]
end

CoreStage.stop_simulation = function(l_23_0)
	local l_23_4, l_23_5, l_23_6, l_23_7 = nil
	for i_0,i_1 in pairs(l_23_0._hubs) do
		i_1:stop_simulation()
	end
end

if not CoreWMHub then
	CoreWMHub = class()
end
CoreWMHub.init = function(l_24_0, l_24_1, l_24_2)
	l_24_0._owner = l_24_1
	l_24_0._state_vector = {}
	l_24_0._trigger_vector = {}
	l_24_0._values = {}
	l_24_0._values.name = l_24_2:parameter("name")
	l_24_0._done = false
	l_24_0._values.trigger_once = true
	if l_24_2:has_parameter("trigger_once") then
		l_24_0._values.trigger_once = toboolean(l_24_2:parameter("trigger_once"))
	end
	l_24_0._values.trigger_on_inverse = false
	if l_24_2:has_parameter("trigger_on_inverse") then
		l_24_0._values.trigger_on_inverse = toboolean(l_24_2:parameter("trigger_on_inverse"))
	end
	l_24_0._values.never_start = false
	if l_24_2:has_parameter("never_start") then
		l_24_0._values.never_start = toboolean(l_24_2:parameter("never_start"))
	end
	l_24_0._trigger_id = 1
	l_24_0._on_off_state = 0
	l_24_0._trigger_function = callback(l_24_0, l_24_0, "check_trigger_all")
	l_24_2:for_each("trigger", callback(l_24_0, l_24_0, "parse_trigger"))
	l_24_0._actions = managers.action:create_actions(l_24_2)
	l_24_2:for_each("start_hub", callback(l_24_0, l_24_0, "parse_start_hub"))
	if l_24_2:has_parameter("required_triggers") then
		l_24_0._values.required_triggers = "all"
	if l_24_2:parameter("required_triggers") ~= "all" then
		end
		l_24_0._values.required_triggers = tonumber(l_24_2:parameter("required_triggers"))
	end
	l_24_2:for_each("value", callback(l_24_0, l_24_0, "parse_value"))
	if l_24_0._values.required_triggers == "all" then
		l_24_0._values.required_triggers = #l_24_0._trigger_vector
	end
	if #l_24_0._trigger_vector == 0 and not l_24_0._values.never_start then
		cat_debug("gaspode", "Found no triggers for Hub, considering it the start hub")
		l_24_0._owner:set_start_activation(l_24_0)
	end
end

CoreWMHub.use_as_start = function(l_25_0)
	return l_25_0._values.use_as_start
end

CoreWMHub.activate = function(l_26_0)
	local l_26_4, l_26_5 = nil
	if l_26_0._done then
		return 
	end
	if l_26_0._values.trigger_once then
		l_26_0._done = true
	else
		for i_0,i_1 in ipairs(l_26_0._state_vector) do
			l_26_0._state_vector[i_0] = 0
		end
	end
	l_26_0._owner:run_hub_trigger(l_26_0._values.name)
	l_26_0._actions:activate()
end

CoreWMHub.parse_value = function(l_27_0, l_27_1)
	local l_27_2, l_27_3 = parse_value_node(l_27_1)
	l_27_0._values[l_27_2] = l_27_3
end

CoreWMHub.parse_trigger = function(l_28_0, l_28_1)
	local l_28_2 = l_28_0:_trigger_class(l_28_1:parameter("type"))
	if l_28_2 then
		local l_28_3 = l_28_2:new(l_28_0, l_28_1, l_28_0._trigger_id)
		table.insert(l_28_0._trigger_vector, l_28_3)
		table.insert(l_28_0._state_vector, 0)
		l_28_0._trigger_id = l_28_0._trigger_id + 1
	else
		Application:error("No such trigger for type:", l_28_1:parameter("type"))
	end
end

CoreWMHub._trigger_class = function(l_29_0, l_29_1)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	if (managers.world:get_trigger(l_29_1) or rawget(_G, l_29_1 .. "Trigger") or not rawget(_G, "Core" .. l_29_1 .. "Trigger")) and not rawget(_G, l_29_1) then
		return rawget(_G, "Core" .. l_29_1)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreWMHub.parse_start_hub = function(l_30_0, l_30_1)
	if l_30_1:has_parameter("start_from") then
		local l_30_2 = l_30_1:parameter("start_from")
		if l_30_2 ~= "none" then
			local l_30_3 = toboolean(l_30_1:parameter("default"))
			local l_30_4, l_30_5 = l_30_0._owner:add_start_hub, l_30_0._owner
			local l_30_6 = l_30_2
			local l_30_7 = {}
			l_30_7.hub = l_30_0
			l_30_7.default = l_30_3
			l_30_4(l_30_5, l_30_6, l_30_7)
		end
		local l_30_8 = l_30_1:parameter("start_from_relay")
	if l_30_8 ~= "" and l_30_8 ~= "none" then
		end
		cat_print("gaspode", "---- Add start from relay", l_30_8)
		local l_30_9 = toboolean(l_30_1:parameter("default"))
		local l_30_10, l_30_11 = l_30_0._owner:add_start_hub, l_30_0._owner
		local l_30_12 = l_30_8
		local l_30_13 = {}
		l_30_13.hub = l_30_0
		l_30_13.default = l_30_9
		l_30_10(l_30_11, l_30_12, l_30_13)
	end
end

CoreWMHub.add_hub_trigger = function(l_31_0, l_31_1, l_31_2)
	l_31_0._owner:add_hub_trigger(l_31_1, l_31_2)
end

CoreWMHub.trigger_activated = function(l_32_0, l_32_1, l_32_2)
	if l_32_0._done then
		return 
	end
	l_32_0._state_vector[l_32_1] = l_32_2
	if l_32_0._trigger_function(l_32_1, l_32_2) then
		l_32_0:activate()
	end
end

CoreWMHub.trigger_all = function(l_33_0, l_33_1, l_33_2)
	local l_33_6, l_33_7 = nil
	for i_0,i_1 in ipairs(l_33_0._state_vector) do
		if i_1 == 0 then
			return false
		end
	end
	return true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreWMHub.trigger_on_off = function(l_34_0, l_34_1, l_34_2)
	local l_34_6, l_34_7 = nil
	for i_0,i_1 in ipairs(l_34_0._state_vector) do
		if i_1 == l_34_0._on_off_state then
			return false
		end
	end
	l_34_0._on_off_state = l_34_2
	return true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreWMHub.check_trigger_all = function(l_35_0, l_35_1, l_35_2)
	local l_35_7, l_35_8 = nil
	local l_35_3 = 0
	for i_0,i_1 in ipairs(l_35_0._state_vector) do
		l_35_3 = l_35_3 + i_1
	end
	if l_35_3 ~= 0 then
		return not l_35_0._values.trigger_on_inverse
	end
	return l_35_0._values.required_triggers <= l_35_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreWMHub.trigger_entry = function(l_36_0, l_36_1, l_36_2)
	local l_36_6, l_36_7 = nil
	for i_0,i_1 in ipairs(l_36_0._state_vector) do
		if i_1 == 0 then
			return false
		end
	end
	return true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreWMHub.set_done = function(l_37_0, l_37_1)
	l_37_0._done = l_37_1
end

CoreWMHub.stop_simulation = function(l_38_0)
	local l_38_4, l_38_5, l_38_6, l_38_7 = nil
	for i_0,i_1 in ipairs(l_38_0._trigger_vector) do
		i_1:stop_simulation()
	end
end

if not CoreTriggerBase then
	CoreTriggerBase = class()
end
CoreTriggerBase.init = function(l_39_0, l_39_1, l_39_2, l_39_3)
	l_39_0._user = l_39_1
	l_39_0._id = l_39_3
	l_39_0._type = l_39_2:parameter("type")
	l_39_0._name = l_39_2:parameter("name")
	l_39_0._mode = l_39_2:parameter("mode") or ""
	l_39_2:for_each("value", callback(l_39_0, l_39_0, "parse_values"))
end

CoreTriggerBase.parse_values = function(l_40_0, l_40_1)
	local l_40_2 = parse_value_node(l_40_1)
	l_40_0[l_40_2] = l_40_1
end

CoreTriggerBase.activate = function(l_41_0, l_41_1)
end

CoreTriggerBase.on = function(l_42_0)
end

CoreTriggerBase.off = function(l_43_0)
end

CoreTriggerBase.stop_simulation = function(l_44_0)
end

CoreTriggerBase.destroy = function(l_45_0)
end

if not CoreEnemyGroupTrigger then
	CoreEnemyGroupTrigger = class(CoreTriggerBase)
end
CoreEnemyGroupTrigger.init = function(l_46_0, l_46_1, l_46_2, l_46_3)
	CoreTriggerBase.init(l_46_0, l_46_1, l_46_2, l_46_3)
	l_46_0._killed_count = 0
	l_46_2:for_each("enemy", callback(l_46_0, l_46_0, "parse_enemy"))
end

CoreEnemyGroupTrigger.parse_enemy = function(l_47_0, l_47_1)
	l_47_0._group_id = l_47_1:parameter("group_id")
	l_47_0._condition = l_47_1:parameter("condition")
	if l_47_0._condition ~= "all" then
		l_47_0._condition = tonumber(l_47_0._condition)
	end
end

CoreEnemyGroupTrigger.set_amount = function(l_48_0, l_48_1)
	l_48_0._condition = l_48_1
end

CoreEnemyGroupTrigger.enemy_killed = function(l_49_0, l_49_1)
	l_49_0._killed_count = l_49_0._killed_count + 1
	cat_debug("gaspode", "EnemyGroupTrigger", l_49_0._condition, l_49_0._killed_count)
	if l_49_0._condition == l_49_0._killed_count then
		cat_debug("gaspode", "TRIGGER TRIGGER")
		l_49_0._user:trigger_activated(l_49_0._id, 1)
	end
end

if not CoreUnitInAreaTrigger then
	CoreUnitInAreaTrigger = class(CoreTriggerBase)
end
CoreUnitInAreaTrigger.init = function(l_50_0, l_50_1, l_50_2, l_50_3)
	CoreTriggerBase.init(l_50_0, l_50_1, l_50_2, l_50_3)
	l_50_0._area = managers.area:create_area(l_50_2)
	l_50_0._area:add_trigger(l_50_0)
end

CoreUnitInAreaTrigger.set_state = function(l_51_0, l_51_1)
	l_51_0._user:trigger_activated(l_51_0._id, l_51_1)
end

if not CoreEnemyTrigger then
	CoreEnemyTrigger = class(CoreTriggerBase)
end
CoreEnemyTrigger.init = function(l_52_0, l_52_1, l_52_2, l_52_3)
	CoreTriggerBase.init(l_52_0, l_52_1, l_52_2, l_52_3)
	l_52_0._name = l_52_2:parameter("name")
	l_52_0._enemy_group = managers.enemy:get_enemy_group(l_52_0._name)
	l_52_0._enemy_group:add_trigger(callback(l_52_0, l_52_0, "enemies_killed"))
end

CoreEnemyTrigger.enemies_killed = function(l_53_0)
	l_53_0._user:trigger_activated(l_53_0._id, 1)
end

if not CoreEnemyProducerTrigger then
	CoreEnemyProducerTrigger = class(CoreTriggerBase)
end
CoreEnemyProducerTrigger.init = function(l_54_0, l_54_1, l_54_2, l_54_3)
	CoreTriggerBase.init(l_54_0, l_54_1, l_54_2, l_54_3)
	l_54_0._name = l_54_2:parameter("name")
	l_54_0._enemy_group = managers.enemy:get_enemy_producer(l_54_0._name)
	l_54_0._enemy_group:add_trigger(callback(l_54_0, l_54_0, "enemies_killed"))
end

CoreEnemyProducerTrigger.enemies_killed = function(l_55_0)
	l_55_0._user:trigger_activated(l_55_0._id, 1)
end

if not CoreHubTrigger then
	CoreHubTrigger = class(CoreTriggerBase)
end
CoreHubTrigger.init = function(l_56_0, l_56_1, l_56_2, l_56_3)
	CoreTriggerBase.init(l_56_0, l_56_1, l_56_2, l_56_3)
	l_56_0._name = l_56_2:parameter("name")
	l_56_0._user:add_hub_trigger(l_56_0._name, l_56_0)
end

CoreHubTrigger.trigger_hub = function(l_57_0)
	l_57_0._user:trigger_activated(l_57_0._id, 1)
end

if not CoreUnitSequenceTrigger then
	CoreUnitSequenceTrigger = class(CoreTriggerBase)
end
CoreUnitSequenceTrigger.init = function(l_58_0, l_58_1, l_58_2, l_58_3)
	CoreTriggerBase.init(l_58_0, l_58_1, l_58_2, l_58_3)
	l_58_0._name = l_58_2:parameter("name")
	l_58_0._unit_id = tonumber(l_58_2:parameter("unit_id"))
	l_58_0._sequence = l_58_2:parameter("sequence")
	managers.world:add_runned_unit_sequence_trigger(l_58_0._unit_id, l_58_0._sequence, callback(l_58_0, l_58_0, "sequence_runned"))
end

CoreUnitSequenceTrigger.sequence_runned = function(l_59_0)
	l_59_0._user:trigger_activated(l_59_0._id, 1)
end

if not CoreWorldCameraTrigger then
	CoreWorldCameraTrigger = class(CoreTriggerBase)
end
CoreWorldCameraTrigger.init = function(l_60_0, l_60_1, l_60_2, l_60_3)
	CoreTriggerBase.init(l_60_0, l_60_1, l_60_2, l_60_3)
	if l_60_0.worldcamera_trigger_sequence ~= "none" then
		if l_60_0.worldcamera_trigger_after_clip == "done" then
			l_60_0._sequence = managers.worldcamera:add_sequence_done_callback(l_60_0.worldcamera_trigger_sequence, callback(l_60_0, l_60_0, "set_state"))
		end
	else
		l_60_0._sequence = managers.worldcamera:add_sequence_camera_clip_callback(l_60_0.worldcamera_trigger_sequence, l_60_0.worldcamera_trigger_after_clip, callback(l_60_0, l_60_0, "set_state"))
	end
end

CoreWorldCameraTrigger.set_state = function(l_61_0, l_61_1, l_61_2)
	cat_print("gaspode", "CoreWorldCameraTrigger:set_state", l_61_0._sequence, l_61_2)
	l_61_0._user:trigger_activated(l_61_0._id, 1)
end

if not CoreWorldCameraDoneTrigger then
	CoreWorldCameraDoneTrigger = class(CoreTriggerBase)
end
CoreWorldCameraDoneTrigger.init = function(l_62_0, l_62_1, l_62_2, l_62_3)
	CoreTriggerBase.init(l_62_0, l_62_1, l_62_2, l_62_3)
	cat_print("gaspode", "CoreWorldCameraDoneTrigger:init")
	if l_62_2:has_parameter("sequence") and l_62_2:parameter("sequence") ~= "none" then
		l_62_0._worldcamera = managers.worldcamera:add_sequence_done_callback(l_62_2:parameter("sequence"), callback(l_62_0, l_62_0, "set_state"))
	else
		local l_62_4 = l_62_2:parameter("worldcamera")
		l_62_0._worldcamera = managers.worldcamera:add_world_camera_done_callback(l_62_4, callback(l_62_0, l_62_0, "set_state"))
	end
end

CoreWorldCameraDoneTrigger.set_state = function(l_63_0, l_63_1, l_63_2)
	cat_print("gaspode", "CoreWorldCameraDoneTrigger:set_state", l_63_0._worldcamera, l_63_2)
	l_63_0._user:trigger_activated(l_63_0._id, 1)
end

if not CoreCutsceneTrigger then
	CoreCutsceneTrigger = class(CoreTriggerBase)
end
CoreCutsceneTrigger.init = function(l_64_0, l_64_1, l_64_2, l_64_3)
	CoreTriggerBase.init(l_64_0, l_64_1, l_64_2, l_64_3)
	local l_64_4 = l_64_2:parameter("cutscene")
	l_64_0._cutscene_done_callback = managers.cutscene:connect("EVT_PLAYBACK_FINISHED", callback(l_64_0, l_64_0, "set_state"), l_64_4)
end

CoreCutsceneTrigger.set_state = function(l_65_0, l_65_1, l_65_2)
	if l_65_2 == l_65_1 then
		cat_print("gaspode", "CoreCutsceneTrigger:set_state", l_65_1)
		l_65_0._user:trigger_activated(l_65_0._id, 1)
	end
end

CoreCutsceneTrigger.stop_simulation = function(l_66_0)
	if l_66_0._cutscene_done_callback then
		managers.cutscene:disconnect("EVT_PLAYBACK_FINISHED", l_66_0._cutscene_done_callback)
	end
end


