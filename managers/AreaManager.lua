if not AreaGroup then
	AreaGroup = class(CoreAreaGroup)
end
AreaGroup.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	CoreAreaGroup.init(l_1_0, l_1_1, l_1_2, l_1_3)
end

AreaGroup.set_properties = function(l_2_0, l_2_1)
	CoreAreaGroup.set_properties(l_2_0, l_2_1)
	l_2_0._unit_infos = l_2_1.unit_infos
	if l_2_1.condition_all then
		l_2_0._condition = TableAlgorithms.count(l_2_0._unit_infos)
	else
		l_2_0._condition = l_2_1.condition_number
	end
end

AreaGroup.activate = function(l_3_0)
	cat_debug("gaspode", "-- AreaGroup:activate - area:", l_3_0._name)
	l_3_0:insert_units_in_unit_vector()
	CoreAreaGroup.activate(l_3_0)
end

AreaGroup.insert_units_in_unit_vector = function(l_4_0)
	local l_4_5, l_4_6, l_4_7, l_4_8, l_4_9, l_4_10 = nil
	local l_4_1 = {}
	for i_0,i_1 in pairs(l_4_0._unit_infos) do
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if (not managers.unit_scripting:unit_exists(i_1.script_name) or alive(nil)) and (not nil:damage_data() or not nil:damage_data():is_fully_damaged()) then
			table.insert(l_4_0._units_vector, nil)
		end
	end
end

AreaGroup.check_area_group = function(l_5_0)
	l_5_0._units_vector = {}
	l_5_0:insert_units_in_unit_vector()
	CoreAreaGroup.check_area_group(l_5_0)
end


