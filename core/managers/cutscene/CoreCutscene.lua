local L0_0
L0_0 = require
L0_0("core/managers/cutscene/CoreCutsceneKeys")
L0_0 = require
L0_0("core/managers/cutscene/CoreCutsceneKeyCollection")
L0_0 = CoreCutscene
if not L0_0 then
	L0_0 = frozen_class
	L0_0 = L0_0()
end
CoreCutscene = L0_0
L0_0 = mixin
L0_0(CoreCutscene, CoreCutsceneKeyCollection)
L0_0 = 30
function CoreCutscene._all_keys_sorted_by_time(A0_1)
	return A0_1._keys or {}
end
function CoreCutscene.init(A0_2, A1_3, A2_4)
	local L3_5, L4_6, L5_7, L6_8, L7_9, L8_10, L9_11, L10_12, L11_13
	L3_5(L4_6, L5_7)
	L3_5(L4_6, L5_7)
	A0_2._name = L3_5
	A0_2._unit_name = L3_5
	L6_8 = "frames"
	L11_13 = L4_6(L5_7, L6_8)
	A0_2._frame_count = L3_5
	A0_2._keys = L3_5
	A0_2._unit_types = L3_5
	A0_2._unit_animations = L3_5
	A0_2._unit_blend_sets = L3_5
	A0_2._camera_names = L3_5
	A0_2._animation_blobs = L3_5
	for L6_8 in L3_5(L4_6) do
		if L7_9 == "controlled_units" then
			for L10_12 in L7_9(L8_10) do
				L11_13 = L10_12.parameter
				L11_13 = L11_13(L10_12, "name")
				A0_2._unit_types[L11_13] = A2_4:cutscene_actor_unit_type(A0_2:_cutscene_specific_unit_type(L10_12:parameter("type")))
				A0_2._unit_animations[L11_13] = L10_12:parameter("animation")
				A0_2._unit_blend_sets[L11_13] = L10_12:parameter("blend_set")
				if string.begins(L11_13, "camera") then
					table.insert(A0_2._camera_names, L11_13)
				end
			end
		elseif L7_9 == "keys" then
			for L10_12 in L7_9(L8_10) do
				L11_13 = CoreCutsceneKey
				L11_13 = L11_13.create
				L11_13 = L11_13(L11_13, L10_12:name(), A0_2)
				L11_13:load(L10_12)
				table.insert(A0_2._keys, freeze(L11_13))
			end
		end
	end
	L3_5(L4_6)
	L3_5(L4_6, L5_7)
	L6_8 = A0_2._unit_animations
	L3_5(L4_6, L5_7, L6_8, L7_9, L8_10)
end
function CoreCutscene.is_valid(A0_14)
	return table.empty(A0_14._unit_types) or UnitDatabase:get_unit_data(A0_14:unit_name()) ~= nil
end
function CoreCutscene.name(A0_15)
	return A0_15._name or ""
end
function CoreCutscene.unit_name(A0_16)
	return A0_16._unit_name or ""
end
function CoreCutscene.frames_per_second(A0_17)
	local L1_18
	L1_18 = _UPVALUE0_
	return L1_18
end
function CoreCutscene.frame_count(A0_19)
	return A0_19._frame_count or 1
end
function CoreCutscene.duration(A0_20)
	return A0_20:frame_count() / A0_20:frames_per_second()
end
function CoreCutscene.is_optimized(A0_21)
	return table.empty(A0_21._unit_animations)
end
function CoreCutscene.has_cameras(A0_22)
	return not table.empty(A0_22._camera_names)
end
function CoreCutscene.has_unit(A0_23, A1_24, A2_25)
	if A0_23:controlled_unit_types()[A1_24] ~= nil then
		return true
	end
	if A2_25 then
		for 