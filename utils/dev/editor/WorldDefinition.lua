require("shared/utils/dev/editor/WorldDefinitionMenuUnit")
if not WorldDefinition then
	WorldDefinition = class(CoreWorldDefinition)
end
WorldDefinition.init = function(l_1_0, ...)
	CoreWorldDefinition.init(l_1_0, ...)
	l_1_0._portal_slot_mask = World:make_slot_mask(1, 11)
end

WorldDefinition.parse_statics = function(l_2_0, l_2_1, l_2_2)
	local l_2_6, l_2_7 = nil
	for i_0 in l_2_1:children() do
		table.insert(l_2_2, StaticUnit:new(i_0))
		managers.worlddefinition:preload_unit(StaticUnit:new(i_0)._unit_name)
	end
end

WorldDefinition.parse_dynamics = function(l_3_0, l_3_1, l_3_2)
	local l_3_6, l_3_7 = nil
	for i_0 in l_3_1:children() do
		table.insert(l_3_2, DynamicUnit:new(i_0))
	end
end

WorldDefinition.parse_cutscenes = function(l_4_0, l_4_1, l_4_2)
	local l_4_6, l_4_7 = nil
	for i_0 in l_4_1:children() do
		table.insert(l_4_2, CutsceneUnit:new(i_0))
	end
end

WorldDefinition.parse_ai = function(l_5_0, l_5_1, l_5_2)
	local l_5_7, l_5_8 = nil
	local l_5_3 = Application:editor()
	if l_5_3 then
		for i_0 in l_5_1:children() do
			table.insert(l_5_2, AiUnit:new(i_0))
		end
	end
end

WorldDefinition.parse_menu = function(l_6_0, l_6_1, l_6_2)
	local l_6_6, l_6_7 = nil
	l_6_0._is_menu_world = l_6_1:parameter("is_menu_world")
	for i_0 in l_6_1:children() do
		table.insert(l_6_2, WorldDefinitionMenuUnit:new(i_0))
		managers.worlddefinition:preload_unit(WorldDefinitionMenuUnit:new(i_0)._unit_name)
	end
end

WorldDefinition.create_units = function(l_7_0, l_7_1, l_7_2)
	local l_7_7, l_7_8, l_7_9, l_7_10, l_7_14, l_7_15, l_7_16, l_7_17, l_7_21, l_7_22, l_7_23, l_7_24, l_7_28, l_7_29, l_7_30, l_7_31, l_7_35, l_7_36, l_7_37, l_7_38 = nil
	if l_7_1 ~= "all" and not l_7_0._definitions[l_7_1] then
		return {}
	end
	local l_7_3 = CoreWorldDefinition.create_units(l_7_0, l_7_1, l_7_2)
	if l_7_1 == "statics" or l_7_1 == "all" then
		for i_0,i_1 in ipairs(l_7_0._definitions.statics) do
			table.insert(l_7_3, i_1:create_unit(l_7_2))
		end
	end
	if l_7_1 == "dynamics" or l_7_1 == "all" then
		for i_0,i_1 in ipairs(l_7_0._definitions.dynamics) do
			table.insert(l_7_3, i_1:create_unit(l_7_2))
		end
	end
	if l_7_1 == "ai" then
		for i_0,i_1 in ipairs(l_7_0._definitions.ai) do
			table.insert(l_7_3, i_1:create_unit(l_7_2))
		end
	end
	if l_7_1 == "cutscenes" or l_7_1 == "all" then
		for i_0,i_1 in ipairs(l_7_0._definitions.cutscenes) do
			table.insert(l_7_3, i_1:create_unit(l_7_2))
		end
	end
	if l_7_1 == "menu" then
		for i_0,i_1 in ipairs(l_7_0._definitions.menu) do
			table.insert(l_7_3, i_1:create_unit(l_7_2))
		end
	end
	return l_7_3
end

WorldDefinition.create_from_level_file = function(l_8_0, l_8_1, l_8_2)
	CoreWorldDefinition.create_from_level_file(l_8_0, l_8_1, l_8_2)
	if l_8_1 == "statics" or l_8_1 == "all" then
		l_8_0:create_level_units("statics", l_8_2)
	end
	if l_8_1 == "dynamics" or l_8_1 == "all" then
		l_8_0:create_level_units("dynamics", l_8_2)
	end
	if l_8_1 == "cutscenes" or l_8_1 == "all" then
		l_8_0:create_level_units("cutscenes", l_8_2)
	end
end

WorldDefinition.make_unit = function(l_9_0, l_9_1, l_9_2, l_9_3)
	local l_9_4 = Application:editor()
	local l_9_5 = CoreWorldDefinition.make_unit(l_9_0, l_9_1, l_9_2, l_9_3)
	if not l_9_5 or not l_9_4 then
		return l_9_5
	end
end

StaticUnit = class()
StaticUnit.init = function(l_10_0, l_10_1)
	l_10_0._unit_name = l_10_1:parameter("name")
	l_10_0._generic = Generic:new(l_10_1)
end

StaticUnit.create_unit = function(l_11_0, l_11_1)
	l_11_0._unit = managers.worlddefinition:make_unit(l_11_0._unit_name, l_11_0._generic, l_11_1)
	if not l_11_0._unit or l_11_0._generic._name_id ~= "none" then
		return l_11_0._unit
	end
end

CutsceneUnit = class()
CutsceneUnit.init = function(l_12_0, l_12_1)
	l_12_0._unit_name = l_12_1:parameter("name")
	if l_12_1:parameter("cutscene") then
		l_12_0._cutscene = l_12_1:parameter("cutscene")
	end
	managers.worlddefinition:preload_unit(l_12_0._unit_name)
	l_12_0._generic = Generic:new(l_12_1)
end

CutsceneUnit.create_unit = function(l_13_0, l_13_1)
	l_13_0._unit = managers.worlddefinition:make_unit(l_13_0._unit_name, l_13_0._generic, l_13_1)
	return l_13_0._unit
end

DynamicUnit = class()
DynamicUnit.init = function(l_14_0, l_14_1)
	l_14_0._unit_name = l_14_1:parameter("name")
	managers.worlddefinition:preload_unit(l_14_0._unit_name)
	l_14_0._generic = Generic:new(l_14_1)
end

DynamicUnit.create_unit = function(l_15_0, l_15_1)
	l_15_0._unit = managers.worlddefinition:make_unit(l_15_0._unit_name, l_15_0._generic, l_15_1)
	if not l_15_0._unit or l_15_0._generic._name_id ~= "none" then
		return l_15_0._unit
	end
end

AiUnit = class()
AiUnit.init = function(l_16_0, l_16_1)
	l_16_0._unit_name = l_16_1:parameter("name")
	managers.worlddefinition:preload_unit(l_16_0._unit_name)
	l_16_0._generic = Generic:new(l_16_1)
	l_16_1:for_each("ai_data", callback(l_16_0, l_16_0, "parse_ai_data"))
end

AiUnit.create_unit = function(l_17_0, l_17_1)
	l_17_0._unit = managers.worlddefinition:make_unit(l_17_0._unit_name, l_17_0._generic, l_17_1)
	if l_17_0._radius then
		l_17_0._unit:ai_graph_data().radius = l_17_0._radius
	end
	if l_17_0._height then
		l_17_0._unit:ai_graph_data().height = l_17_0._height
	end
	return l_17_0._unit
end

AiUnit.parse_ai_data = function(l_18_0, l_18_1)
	local l_18_2 = tonumber(l_18_1:parameter("radius"))
	l_18_0._height = tonumber(l_18_1:parameter("height"))
end

if not HubElementUnit then
	HubElementUnit = class(CoreHubElementUnit)
end
HubElementUnit.init = function(l_19_0, l_19_1)
	CoreHubElementUnit.init(l_19_0, l_19_1)
end

HubElementUnit.parse_type = function(l_20_0, l_20_1)
	CoreHubElementUnit.parse_type(l_20_0, l_20_1)
	local l_20_2 = l_20_1:parameter("name")
	if l_20_2 == "enemy" then
		l_20_0._type = WHEnemy:new(l_20_1)
	end
end

if not WHEnemy then
	WHEnemy = class()
end
WHEnemy.init = function(l_21_0, l_21_1)
	local l_21_5, l_21_6 = nil
	l_21_0._enemies = {}
	for i_0 in l_21_1:children() do
		table.insert(l_21_0._enemies, WHEnemyData:new(i_0))
	end
end

WHEnemy.make_unit = function(l_22_0, l_22_1)
	l_22_1:hub_element():load_data(l_22_0)
end

if not WHEnemyData then
	WHEnemyData = class()
end
WHEnemyData.init = function(l_23_0, l_23_1)
	l_23_0._position = math.string_to_vector(l_23_1:parameter("position"))
	l_23_0._rotation = math.string_to_vector(l_23_1:parameter("yaw_pitch_roll"))
	l_23_0._rotation = Rotation(l_23_0._rotation.x, l_23_0._rotation.y, l_23_0._rotation.z)
end


