require("core/managers/CoreActionManager")
require("core/managers/CoreAreaManager")
CoreWorldManager = CoreWorldManager or class()
function CoreWorldManager.init(A0_0)
	A0_0._stages = {}
	A0_0._triggers = {}
	A0_0._runned_unit_sequences_callbacks = {}
	A0_0:add_trigger("Enemy", rawget(_G, "EnemyTrigger") or rawget(_G, "CoreEnemyTrigger"))
	A0_0:add_trigger("EnemyProducer", rawget(_G, "EnemyProducerTrigger") or rawget(_G, "CoreEnemyProducerTrigger"))
	A0_0:add_trigger("EnemyGroup", rawget(_G, "EnemyGroupTrigger") or rawget(_G, "CoreEnemyGroupTrigger"))
	A0_0:add_trigger("UnitSequenceTrigger", rawget(_G, "UnitSequenceTrigger") or rawget(_G, "CoreUnitSequenceTrigger"))
	A0_0:add_trigger("WorldCamera", rawget(_G, "WorldCameraDoneTrigger") or rawget(_G, "CoreWorldCameraDoneTrigger"))
	A0_0:add_trigger("WorldCameraTrigger", rawget(_G, "WorldCameraTrigger") or rawget(_G, "CoreWorldCameraTrigger"))
	A0_0:add_trigger("Hub", rawget(_G, "HubTrigger") or rawget(_G, "CoreHubTrigger"))
	A0_0:add_trigger("Cutscene", rawget(_G, "CutsceneTrigger") or rawget(_G, "CoreCutsceneTrigger"))
	managers.area = (rawget(_G, "AreaManager") or rawget(_G, "CoreAreaManager")):new()
	managers.action = (rawget(_G, "ActionManager") or rawget(_G, "CoreActionManager")):new()
end
function CoreWorldManager.add_trigger(A0_1, A1_2, A2_3)
	A0_1._triggers[A1_2] = A2_3
end
function CoreWorldManager.get_trigger(A0_4, A1_5)
	return A0_4._triggers[A1_5]
end
function CoreWorldManager.parse(A0_6, A1_7, A2_8, A3_9)
	local L4_10, L5_11, L6_12, L7_13, L8_14, L9_15
	L4_10 = A3_9 or L4_10(L5_11, L6_12, L7_13)
	A0_6._offset = L4_10
	L4_10 = cat_debug
	L8_14 = A2_8
	L4_10(L5_11, L6_12, L7_13, L8_14)
	L4_10 = managers
	L4_10 = L4_10.worlddefinition
	if L4_10 then
		L4_10 = managers
		L4_10 = L4_10.worlddefinition
		L4_10 = L4_10.check_stage_depended_units
		L4_10(L5_11, L6_12)
	end
	L4_10 = File
	L4_10 = L4_10.config_exists
	L4_10 = L4_10(L5_11, L6_12)
	if L4_10 then
		L4_10 = File
		L4_10 = L4_10.parse_xml
		L4_10 = L4_10(L5_11, L6_12)
		for L8_14 in L5_11(L6_12) do
			L9_15 = L8_14.parameter
			L9_15 = L9_15(L8_14, "name")
			cat_debug("gaspode", L9_15, A2_8)
			if L9_15 == A2_8 then
				cat_debug("gaspode", "insert", L9_15)
				A0_6._current_stage = (rawget(_G, "Stage") or rawget(_G, "CoreStage")):new(L8_14, L9_15)
				A0_6._stages[L9_15] = A0_6._current_stage
				A0_6:activate_current_stage()
			end
		end
	else
		L4_10 = Application
		L4_10 = L4_10.error
		L4_10(L5_11, L6_12, L7_13)
	end
end
function CoreWorldManager.activate_current_stage(A0_16)
	A0_16._current_stage:activate()
end
function CoreWorldManager.update(A0_17, A1_18, A2_19)
	managers.area:update(A1_18, A2_19)
	managers.action:update(A1_18, A2_19)
end
function CoreWorldManager.stop_simulation(A0_20)
	managers.action:clear()
	if A0_20._current_stage then
		A0_20._current_stage:stop_simulation()
	end
end
function CoreWorldManager.offset(A0_21)
	local L1_22
	L1_22 = A0_21._offset
	return L1_22
end
function CoreWorldManager.create_areas(A0_23, A1_24)
	managers.area:set_up(A1_24)
end
function CoreWorldManager.current_stage(A0_25)
	local L1_26
	L1_26 = A0_25._current_stage
	return L1_26
end
function CoreWorldManager.add_runned_unit_sequence_trigger(A0_27, A1_28, A2_29, A3_30)
	if A0_27._runned_unit_sequences_callbacks[A1_28] then
		if A0_27._runned_unit_sequences_callbacks[A1_28][A2_29] then
			table.insert(A0_27._runned_unit_sequences_callbacks[A1_28][A2_29], A3_30)
		else
			A0_27._runned_unit_sequences_callbacks[A1_28][A2_29] = {A3_30}
		end
	else
		({})[A2_29] = {A3_30}
		A0_27._runned_unit_sequences_callbacks[A1_28] = {}
	end
end
function CoreWorldManager.runned_unit_sequence(A0_31, A1_32, A2_33)
	local L3_34, L4_35, L5_36, L6_37, L7_38, L8_39
	L3_34 = alive
	L3_34 = L3_34(L4_35)
	if L3_34 then
		L3_34 = A1_32.unit_data
		L3_34 = L3_34(L4_35)
		if L3_34 then
			L3_34 = A1_32.unit_data
			L3_34 = L3_34(L4_35)
			L3_34 = L3_34.unit_id
			if L4_35 then
				if L4_35 then
					for L7_38, L8_39 in L4_35(L5_36) do
						L8_39()
					end
				end
			end
		end
	end
end
CoreStage = CoreStage or class()
function CoreStage.init(A0_40, A1_41, A2_42)
	local L3_43, L4_44, L5_45, L6_46
	A0_40._name = A2_42
	L6_46 = A0_40._name
	L3_43(L4_44, L5_45, L6_46)
	A0_40._hubs = L3_43
	A0_40._hub_triggers = L3_43
	A0_40._start_hubs = L3_43
	L6_46 = callback
	L6_46 = L6_46(A0_40, A0_40, "parse_hub")
	L3_43(L4_44, L5_45, L6_46, L6_46(A0_40, A0_40, "parse_hub"))
	for L6_46, 