if not UnitMaterials then
	UnitMaterials = class()
end
UnitMaterials.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._unit:set_extension_update_enabled("unit_materials", false)
end

UnitMaterials.update = function(l_2_0)
	local l_2_1, l_2_4, l_2_5, l_2_6, l_2_7, l_2_9, l_2_10, l_2_11, l_2_12 = nil
	for i_0,i_1 in pairs(l_2_0._update_map) do
		if i_1() then
			if not l_2_1 then
				l_2_1 = {}
			end
			table.insert(l_2_1, i_1())
		end
	end
	if l_2_1 then
		for i_0,i_1 in ipairs(l_2_1) do
			i_1()
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

UnitMaterials.set_material_variable = function(l_3_0, l_3_1, l_3_2, l_3_3)
	local l_3_8, l_3_9 = assert, l_3_0._unit:has_material_assigned(l_3_1)
	l_3_8(l_3_9)
	l_3_8 = l_3_0._unit
	l_3_8, l_3_9 = l_3_8:get_objects_by_type, l_3_8
	l_3_8 = l_3_8(l_3_9, "material")
	local l_3_4 = nil
	l_3_9 = ipairs
	l_3_4 = l_3_8
	l_3_9 = l_3_9(l_3_4)
	for i_0,i_1 in l_3_9 do
		if l_3_7:name() == l_3_1 then
			l_3_7:set_variable(l_3_2, l_3_3)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

UnitMaterials.play_material_opacity_by_anim_light = function(l_4_0, l_4_1, l_4_2, l_4_3)
	local l_4_4 = l_4_0._unit:get_object(l_4_1)
	local l_4_5 = (l_4_0._unit:material(l_4_2))
	local l_4_6 = nil
	if l_4_3 then
		l_4_6 = TimerManager:game_animation():time() + l_4_3
	end
	do
		if not l_4_0._update_map then
			l_4_0._unit:set_extension_update_enabled("unit_materials", true)
		end
		l_4_0._update_map[l_4_5:key()] = function()
		-- upvalues: l_4_4 , l_4_5 , l_4_6 , l_4_0 , l_4_2
		local l_5_0 = l_4_4:color().x
		l_4_5:set_variable("opacity", l_5_0)
		if l_4_6 and l_4_6 <= TimerManager:game_animation():time() then
			return function()
			-- upvalues: l_4_0 , l_4_2
			l_4_0:stop_material_opacity_by_anim_light(l_4_2)
    end
		end
  end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

UnitMaterials.stop_material_opacity_by_anim_light = function(l_5_0, l_5_1)
	if l_5_0._update_map then
		local l_5_2 = l_5_0._unit:material(l_5_1)
		l_5_0._update_map[l_5_2:key()] = nil
	if next(l_5_0._update_map) == nil then
		end
		l_5_0._unit:set_extension_update_enabled("unit_materials", false)
		l_5_0._update_map = nil
	end
end

UnitMaterials.change_material = function(l_6_0, l_6_1, l_6_2)
	local l_6_8, l_6_9, l_6_10, l_6_11 = nil
	local l_6_3 = l_6_0._unit:get_objects_by_type("model")
	local l_6_4 = l_6_0._unit:material(l_6_2)
	for i_0,i_1 in ipairs(l_6_3) do
		i_1:set_material(l_6_1, l_6_4)
	end
end

UnitMaterials.set_all_materials = function(l_7_0, l_7_1)
	local l_7_9, l_7_10, l_7_11, l_7_12, l_7_13, l_7_14, l_7_15, l_7_16 = nil
	local l_7_2 = l_7_0._unit:get_objects_by_type("model")
	local l_7_3 = l_7_0._unit:material(l_7_1)
	local l_7_4 = l_7_3:render_template()
	local l_7_5 = false
	if l_7_4:find("SKINNED_") then
		l_7_5 = true
	end
	for i_0,i_1 in ipairs(l_7_2) do
		if not l_7_5 or l_7_5 and i_1:has_bones() then
			for i_0,i_1 in ipairs(i_1:materials()) do
				l_7_21:set_material(i_1:name(), l_7_3)
			end
		end
	end
end


