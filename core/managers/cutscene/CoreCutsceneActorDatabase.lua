if not CoreCutsceneActorDatabase then
	CoreCutsceneActorDatabase = class()
end
if not CoreCutsceneActorDatabaseUnitTypeInfo then
	CoreCutsceneActorDatabaseUnitTypeInfo = class()
end
CoreCutsceneActorDatabase.unit_type_info = function(l_1_0, l_1_1)
	do
		if l_1_1 and l_1_0._registered_unit_types then
			return l_1_0._registered_unit_types[l_1_1]
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreCutsceneActorDatabase.append_unit_info = function(l_2_0, l_2_1)
	if not l_2_0._registered_unit_types then
		l_2_0._registered_unit_types = {}
	end
	local l_2_2 = l_2_0._registered_unit_types
	local l_2_3 = l_2_1:name()
	if not l_2_0._registered_unit_types[l_2_1:name()] then
		l_2_2[l_2_3] = core_or_local("CutsceneActorDatabaseUnitTypeInfo", l_2_1:name())
	end
	l_2_2 = l_2_0._registered_unit_types
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_2 = l_2_2[l_2_3]
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_2 = l_2_2:_append_unit_info
	l_2_2(l_2_3, l_2_1)
end

CoreCutsceneActorDatabaseUnitTypeInfo.init = function(l_3_0, l_3_1)
	l_3_0._unit_type = l_3_1
end

CoreCutsceneActorDatabaseUnitTypeInfo.unit_type = function(l_4_0)
	return l_4_0._unit_type
end

CoreCutsceneActorDatabaseUnitTypeInfo.object_names = function(l_5_0)
	if not l_5_0._object_names then
		return {}
	end
end

CoreCutsceneActorDatabaseUnitTypeInfo.initial_object_visibility = function(l_6_0, l_6_1)
	return l_6_0._object_visibilities and l_6_0._object_visibilities[l_6_1] or false
end

CoreCutsceneActorDatabaseUnitTypeInfo.extensions = function(l_7_0)
	if not l_7_0._extensions then
		return {}
	end
end

CoreCutsceneActorDatabaseUnitTypeInfo.animation_groups = function(l_8_0)
	if not l_8_0._animation_groups then
		return {}
	end
end

CoreCutsceneActorDatabaseUnitTypeInfo._append_unit_info = function(l_9_0, l_9_1)
	local l_9_2 = assert
	l_9_2(l_9_0:unit_type() == l_9_1:name())
	l_9_2 = l_9_0._object_names
	if l_9_2 == nil then
		l_9_2 = table
		l_9_2 = l_9_2.collect
		l_9_2 = l_9_2(l_9_1:get_objects("*"), function(l_10_0)
			local l_10_1, l_10_2 = l_10_0:name, l_10_0
			return l_10_1(l_10_2)
    end)
		l_9_0._object_names = l_9_2
		l_9_2 = table
		l_9_2 = l_9_2.sort
		l_9_2(l_9_0._object_names, string.case_insensitive_compare)
		l_9_2 = freeze
		l_9_2(l_9_0._object_names)
	end
	l_9_2 = l_9_0._object_visibilities
	if l_9_2 == nil then
		l_9_2 = table
		l_9_2 = l_9_2.remap
		l_9_2 = l_9_2(l_9_1:get_objects("*"), function(l_11_0, l_11_1)
			return l_11_1:name(), l_11_1.visibility and l_11_1:visibility() or nil
    end)
		l_9_0._object_visibilities = l_9_2
	end
	l_9_2 = l_9_0._extensions
	if l_9_2 == nil then
		l_9_0._extensions, l_9_2 = l_9_2, {}
		l_9_2 = ipairs
		local l_9_7, l_9_8 = l_9_1:extensions(), .end
		l_9_2 = l_9_2(l_9_7, l_9_8)
		for i_0,i_1 in l_9_2 do
			if l_9_1[l_9_6] then
				local l_9_9, l_9_10 = l_9_1[l_9_6](l_9_1)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_9_9 then
				local l_9_11 = nil
				local l_9_15, l_9_16 = {}, pairs
				l_9_16 = l_9_16(getmetatable(l_9_11))
				for i_0,i_1 in l_9_16 do
					if type(i_1) == "function" and not string.begins(l_9_14, "_") and l_9_14 ~= "new" and l_9_14 ~= "init" then
						l_9_15[l_9_14] = l_9_0:_argument_names_for_function(i_1)
					end
				end
				l_9_0._extensions[l_9_6] = l_9_15
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
		freeze(l_9_0._extensions)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	if l_9_0._animation_groups == nil then
		l_9_0._animation_groups = l_9_1:anim_groups()
	end
	freeze(l_9_0)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutsceneActorDatabaseUnitTypeInfo._argument_names_for_function = function(l_10_0, l_10_1)
	if not Application:ews_enabled() then
		return {}
	end
	local l_10_2 = {}
	local l_10_3 = debug.getinfo(l_10_1)
	local l_10_4 = File:open(l_10_3.source, "r")
	local l_10_5 = l_10_0:_file_line(l_10_4, l_10_3.linedefined)
	File:close(l_10_4)
	local l_10_6 = string.match(string.match(l_10_5, "%b()") or "", "%((.+)%)")
	if not l_10_6 or not string.split(l_10_6, "[,%s]") then
		return {}
	end
end

CoreCutsceneActorDatabaseUnitTypeInfo._file_line = function(l_11_0, l_11_1, l_11_2)
	while 1 do
		if not l_11_1:at_end() and l_11_2 == 0 then
			return l_11_1:gets()
		end
	end
end


