core:module("CoreUnit")
core:require_module("CoreCode")
table.get_ray_ignore_args = function(...)
	local l_1_4, l_1_5 = {}, pairs
	l_1_5 = l_1_5({...})
	for i_0,i_1 in l_1_5 do
		if CoreCode.alive(i_1) then
			table.insert(l_1_4, "ignore_unit")
			local l_1_7 = table.insert
			local l_1_8 = l_1_4
			l_1_7(l_1_8, l_1_6)
		end
	end
	return unpack(l_1_4)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

get_distance_to_body = function(l_2_0, l_2_1)
	local l_2_8, l_2_9, l_2_10, l_2_11 = nil
	local l_2_2 = l_2_0:root_object()
	local l_2_3 = l_2_2:distance_to_bounding_volume(l_2_1)
	local l_2_4 = l_2_2:children()
	for i_0,i_1 in ipairs(l_2_4) do
		if i_1:distance_to_bounding_volume(l_2_1) < l_2_3 then
			l_2_3 = i_1:distance_to_bounding_volume(l_2_1)
		end
	end
	return l_2_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

reload_units = function(l_3_0)
	local l_3_7, l_3_8, l_3_9, l_3_10, l_3_11, l_3_12, l_3_13, l_3_14, l_3_15, l_3_16, l_3_17, l_3_18, l_3_19, l_3_20 = nil
	local l_3_1 = World:find_units_quick("all")
	local l_3_2 = 0
	World:reload_unit(l_3_0)
	managers.sequence._unit_elements[l_3_0] = nil
	if l_3_1 then
		local l_3_3 = {}
		for i_0,i_1 in ipairs(l_3_1) do
			if i_1:name() == l_3_0 then
				if not l_3_3[l_3_0] then
					Application:reload_material_config(i_1:material_config())
				end
				l_3_22:set_slot(0)
				World:spawn_unit(l_3_0, i_1:position(), i_1:rotation())
				l_3_3[l_3_0] = true
				l_3_2 = l_3_2 + 1
			end
		end
	end
	return l_3_2
end

set_unit_and_children_visible = function(l_4_0, l_4_1, l_4_2)
	if l_4_2 == nil or l_4_2(l_4_0) then
		l_4_0:set_visible(l_4_1)
	end
	local l_4_6, l_4_7 = ipairs, l_4_0:children()
	l_4_6 = l_4_6(l_4_7)
	for i_0,i_1 in l_4_6 do
		set_unit_and_children_visible(l_4_5, l_4_1, l_4_2)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


