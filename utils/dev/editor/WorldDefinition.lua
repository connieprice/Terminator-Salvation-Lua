require("shared/utils/dev/editor/WorldDefinitionMenuUnit")
WorldDefinition = WorldDefinition or class(CoreWorldDefinition)
function WorldDefinition.init(A0_0, ...)
	CoreWorldDefinition.init(A0_0, ...)
	A0_0._portal_slot_mask = World:make_slot_mask(1, 11)
end
function WorldDefinition.parse_statics(A0_2, A1_3, A2_4)
	local L3_5, L4_6, L5_7, L6_8, L7_9
	for L6_8 in L3_5(L4_6) do
		L7_9 = StaticUnit
		L7_9 = L7_9.new
		L7_9 = L7_9(L7_9, L6_8)
		table.insert(A2_4, L7_9)
		managers.worlddefinition:preload_unit(L7_9._unit_name)
	end
end
function WorldDefinition.parse_dynamics(A0_10, A1_11, A2_12)
	local L3_13, L4_14, L5_15, L6_16
	for L6_16 in L3_13(L4_14) do
		table.insert(A2_12, DynamicUnit:new(L6_16))
	end
end
function WorldDefinition.parse_cutscenes(A0_17, A1_18, A2_19)
	local L3_20, L4_21, L5_22, L6_23
	for L6_23 in L3_20(L4_21) do
		table.insert(A2_19, CutsceneUnit:new(L6_23))
	end
end
function WorldDefinition.parse_ai(A0_24, A1_25, A2_26)
	local L3_27, L4_28, L5_29, L6_30, L7_31
	L3_27 = Application
	L3_27 = L3_27.editor
	L3_27 = L3_27(L4_28)
	if L3_27 then
		for L7_31 in L4_28(L5_29) do
			table.insert(A2_26, AiUnit:new(L7_31))
		end
	end
end
function WorldDefinition.parse_menu(A0_32, A1_33, A2_34)
	local L3_35, L4_36, L5_37, L6_38, L7_39
	A0_32._is_menu_world = L3_35
	for L6_38 in L3_35(L4_36) do
		L7_39 = WorldDefinitionMenuUnit
		L7_39 = L7_39.new
		L7_39 = L7_39(L7_39, L6_38)
		table.insert(A2_34, L7_39)
		managers.worlddefinition:preload_unit(L7_39._unit_name)
	end
end
function WorldDefinition.create_units(A0_40, A1_41, A2_42)
	local L3_43
	if A1_41 ~= "all" then
		L3_43 = A0_40._definitions
		L3_43 = L3_43[A1_41]
		if not L3_43 then
			L3_43 = {}
			return L3_43
		end
	end
	L3_43 = CoreWorldDefinition
	L3_43 = L3_43.create_units
	L3_43 = L3_43(A0_40, A1_41, A2_42)
	if A1_41 == "statics" or A1_41 == "all" then
		for 