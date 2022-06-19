CoreCutsceneActorDatabase = CoreCutsceneActorDatabase or class()
CoreCutsceneActorDatabaseUnitTypeInfo = CoreCutsceneActorDatabaseUnitTypeInfo or class()
function CoreCutsceneActorDatabase.unit_type_info(A0_0, A1_1)
	local L2_2
	L2_2 = A1_1 and A0_0._registered_unit_types
	return L2_2
end
function CoreCutsceneActorDatabase.append_unit_info(A0_3, A1_4)
	A0_3._registered_unit_types = A0_3._registered_unit_types or {}
	A0_3._registered_unit_types[A1_4:name()] = A0_3._registered_unit_types[A1_4:name()] or core_or_local("CutsceneActorDatabaseUnitTypeInfo", A1_4:name())
	A0_3._registered_unit_types[A1_4:name()]:_append_unit_info(A1_4)
end
function CoreCutsceneActorDatabaseUnitTypeInfo.init(A0_5, A1_6)
	A0_5._unit_type = A1_6
end
function CoreCutsceneActorDatabaseUnitTypeInfo.unit_type(A0_7)
	local L1_8
	L1_8 = A0_7._unit_type
	return L1_8
end
function CoreCutsceneActorDatabaseUnitTypeInfo.object_names(A0_9)
	return A0_9._object_names or {}
end
function CoreCutsceneActorDatabaseUnitTypeInfo.initial_object_visibility(A0_10, A1_11)
	local L2_12
	L2_12 = A0_10._object_visibilities
	if L2_12 then
		L2_12 = A0_10._object_visibilities
		L2_12 = L2_12[A1_11]
	else
		L2_12 = L2_12 or false
	end
	return L2_12
end
function CoreCutsceneActorDatabaseUnitTypeInfo.extensions(A0_13)
	return A0_13._extensions or {}
end
function CoreCutsceneActorDatabaseUnitTypeInfo.animation_groups(A0_14)
	return A0_14._animation_groups or {}
end
function CoreCutsceneActorDatabaseUnitTypeInfo._append_unit_info(A0_15, A1_16)
	local L2_17, L3_18, L4_19, L5_20, L6_21, L7_22, L8_23, L9_24, L10_25, L11_26, L12_27, L13_28
	L5_20 = A1_16
	L3_18 = L3_18 == L4_19
	L2_17(L3_18)
	if L2_17 == nil then
		L5_20 = "*"
		A0_15._object_names = L2_17
		L2_17(L3_18, L4_19)
		L2_17(L3_18)
	end
	if L2_17 == nil then
		L5_20 = "*"
		A0_15._object_visibilities = L2_17
	end
	if L2_17 == nil then
		A0_15._extensions = L2_17
		L13_28 = L3_18(L4_19)
		for L5_20, L6_21 in L2_17(L3_18, L4_19, L5_20, L6_21, L7_22, L8_23, L9_24, L10_25, L11_26, L12_27, L13_28, L3_18(L4_19)) do
			L7_22 = A1_16[L6_21]
			if L7_22 then
				L7_22 = A1_16[L6_21]
				L8_23 = A1_16
				L7_22 = L7_22(L8_23)
			end
			if L7_22 then
				L8_23 = {}
				L13_28 = L10_25(L11_26)
				for L12_27, L13_28 in L9_24(L10_25, L11_26, L12_27, L13_28, L10_25(L11_26)) do
					if type(L13_28) == "function" and not string.begins(L12_27, "_") and L12_27 ~= "new" and L12_27 ~= "init" then
						L8_23[L12_27] = A0_15:_argument_names_for_function(L13_28)
					end
				end
				L9_24[L6_21] = L8_23
			end
		end
		L2_17(L3_18)
	end
	if L2_17 == nil then
		A0_15._animation_groups = L2_17
	end
	L2_17(L3_18)
end
function CoreCutsceneActorDatabaseUnitTypeInfo._argument_names_for_function(A0_29, A1_30)
	local L2_31, L3_32, L4_33, L5_34, L6_35
	L2_31 = Application
	L3_32 = L2_31
	L2_31 = L2_31.ews_enabled
	L2_31 = L2_31(L3_32)
	if not L2_31 then
		L2_31 = {}
		return L2_31
	end
	L2_31 = {}
	L3_32 = debug
	L3_32 = L3_32.getinfo
	L4_33 = A1_30
	L3_32 = L3_32(L4_33)
	L4_33 = File
	L5_34 = L4_33
	L4_33 = L4_33.open
	L6_35 = L3_32.source
	L4_33 = L4_33(L5_34, L6_35, "r")
	L6_35 = A0_29
	L5_34 = A0_29._file_line
	L5_34 = L5_34(L6_35, L4_33, L3_32.linedefined)
	L6_35 = File
	L6_35 = L6_35.close
	L6_35(L6_35, L4_33)
	L6_35 = string
	L6_35 = L6_35.match
	L6_35 = L6_35(string.match(L5_34, "%b()") or "", "%((.+)%)")
	return L6_35 and string.split(L6_35, "[,%s]") or {}
end
function CoreCutsceneActorDatabaseUnitTypeInfo._file_line(A0_36, A1_37, A2_38)
	while not A1_37:at_end() do
		A2_38 = A2_38 - 1
		if A2_38 == 0 then
			return (A1_37:gets())
		end
	end
end
