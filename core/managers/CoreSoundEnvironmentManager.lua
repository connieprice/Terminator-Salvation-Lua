CoreSoundEnvironmentManager = CoreSoundEnvironmentManager or class()
function CoreSoundEnvironmentManager.init(A0_0)
	local L1_1, L2_2, L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L11_11
	A0_0._areas = L1_1
	A0_0._areas_per_frame = 1
	A0_0._check_objects = L1_1
	A0_0._check_object_id = 0
	A0_0._emitters = L1_1
	A0_0._area_emitters = L1_1
	A0_0._ambience_changed_callback = L1_1
	A0_0._ambience_changed_callbacks = L1_1
	A0_0._environment_changed_callback = L1_1
	A0_0.GAME_DEFAULT_ENVIRONMENT = "padded_cell"
	A0_0._default_environment = L1_1
	A0_0._current_environment = L1_1
	L1_1(L2_2, L3_3)
	A0_0._environments = L1_1
	A0_0._soundbanks = L1_1
	A0_0._emitter_soundbanks = L1_1
	A0_0._emitter_cues = L1_1
	L11_11 = L2_2(L3_3)
	for L4_4, L5_5 in L1_1(L2_2, L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L11_11, L2_2(L3_3)) do
		L6_6 = string
		L6_6 = L6_6.match
		L6_6 = L6_6(L7_7, L8_8)
		if L6_6 then
			L6_6 = table
			L6_6 = L6_6.insert
			L6_6(L7_7, L8_8)
		end
		L6_6 = string
		L6_6 = L6_6.match
		L6_6 = L6_6(L7_7, L8_8)
		if L6_6 then
			L6_6 = table
			L6_6 = L6_6.insert
			L6_6(L7_7, L8_8)
			L6_6 = {}
			L10_10 = L5_5
			L11_11 = L8_8(L9_9, L10_10)
			for L10_10, L11_11 in L7_7(L8_8, L9_9, L10_10, L11_11, L8_8(L9_9, L10_10)) do
				if string.match(L11_11, "emitter") then
					table.insert(L6_6, L11_11)
				end
			end
			L7_7(L8_8)
			L7_7[L5_5] = L6_6
		end
	end
	A0_0.GAME_DEFAULT_EMITTER_SOUNDBANK = L1_1
	A0_0.GAME_DEFAULT_SOUNDBANK = L1_1
	A0_0._default_soundbank = L1_1
	A0_0._ambience_enabled = false
	A0_0.POSITION_OFFSET = 50
	A0_0._active_ambience_soundbanks = L1_1
end
function CoreSoundEnvironmentManager.areas(A0_12)
	local L1_13
	L1_13 = A0_12._areas
	return L1_13
end
function CoreSoundEnvironmentManager.emitters(A0_14)
	local L1_15
	L1_15 = A0_14._emitters
	return L1_15
end
function CoreSoundEnvironmentManager.area_emitters(A0_16)
	local L1_17
	L1_17 = A0_16._area_emitters
	return L1_17
end
function CoreSoundEnvironmentManager._environments(A0_18)
	local L1_19, L2_20, L3_21, L4_22, L5_23
	L1_19 = {}
	for L5_23 = 0, L3_21 - 1 do
		table.insert(L1_19, Sound:environment_name(L5_23))
	end
	L2_20(L3_21)
	return L1_19
end
function CoreSoundEnvironmentManager.environments(A0_24)
	local L1_25
	L1_25 = A0_24._environments
	return L1_25
end
function CoreSoundEnvironmentManager.game_default_environment(A0_26)
	local L1_27
	L1_27 = A0_26.GAME_DEFAULT_ENVIRONMENT
	return L1_27
end
function CoreSoundEnvironmentManager.game_default_soundbank(A0_28)
	local L1_29
	L1_29 = A0_28.GAME_DEFAULT_SOUNDBANK
	return L1_29
end
function CoreSoundEnvironmentManager.game_default_emitter_soundbank(A0_30)
	local L1_31
	L1_31 = A0_30.GAME_DEFAULT_EMITTER_SOUNDBANK
	return L1_31
end
function CoreSoundEnvironmentManager.emitter_cues(A0_32, A1_33)
	return A0_32._emitter_cues[A1_33]
end
function CoreSoundEnvironmentManager.default_environment(A0_34)
	local L1_35
	L1_35 = A0_34._default_environment
	return L1_35
end
function CoreSoundEnvironmentManager.set_default_environment(A0_36, A1_37)
	A0_36._default_environment = A1_37
	A0_36:_set_environment(A0_36._default_environment)
end
function CoreSoundEnvironmentManager._set_environment(A0_38, A1_39)
	local L2_40, L3_41, L4_42, L5_43, L6_44
	for L5_43, L6_44 in L2_40(L3_41) do
		L6_44(A1_39)
	end
	A0_38._current_environment = A1_39
	L5_43 = 1
	L2_40(L3_41, L4_42, L5_43)
end
function CoreSoundEnvironmentManager.current_environment(A0_45)
	local L1_46
	L1_46 = A0_45._current_environment
	return L1_46
end
function CoreSoundEnvironmentManager.default_soundbank(A0_47)
	local L1_48
	L1_48 = A0_47._default_soundbank
	return L1_48
end
function CoreSoundEnvironmentManager.set_default_soundbank(A0_49, A1_50)
	local L2_51, L3_52, L4_53, L5_54, L6_55
	if not A1_50 then
		return
	end
	if not L2_51 then
		L5_54 = A1_50
		L6_55 = " doesn't exist."
		L2_51(L3_52, L4_53)
		return
	end
	A0_49._default_soundbank = A1_50
	L2_51(L3_52, L4_53)
	for L5_54, L6_55 in L2_51(L3_52) do
		A0_49:_change_ambiences(L6_55)
	end
end
function CoreSoundEnvironmentManager._add_soundbank(A0_56, A1_57)
	Sound:add_soundbank(A1_57)
end
function CoreSoundEnvironmentManager.soundbanks(A0_58)
	local L1_59
	L1_59 = A0_58._soundbanks
	return L1_59
end
function CoreSoundEnvironmentManager.emitter_soundbanks(A0_60)
	local L1_61
	L1_61 = A0_60._emitter_soundbanks
	return L1_61
end
function CoreSoundEnvironmentManager.set_to_default(A0_62)
	A0_62:set_default_environment(A0_62.GAME_DEFAULT_ENVIRONMENT)
	A0_62:set_default_soundbank(A0_62.GAME_DEFAULT_SOUNDBANK)
	A0_62:set_ambience_enabled(false)
end
function CoreSoundEnvironmentManager.add_area(A0_63, A1_64)
	local L2_65
	L2_65 = SoundEnvironmentArea
	L2_65 = L2_65.new
	L2_65 = L2_65(L2_65, A1_64)
	table.insert(A0_63._areas, L2_65)
	return L2_65
end
function CoreSoundEnvironmentManager.remove_area(A0_66, A1_67)
	local L2_68, L3_69, L4_70, L5_71, L6_72
	L2_68(L3_69)
	for L5_71, L6_72 in L2_68(L3_69) do
		if A1_67 == L6_72.area then
			L6_72.area = nil
			L6_72.sound_area_counter = 1
			A0_66:_change_ambiences(L6_72)
		end
	end
	L2_68(L3_69, L4_70)
end
function CoreSoundEnvironmentManager.add_emitter(A0_73, A1_74)
	local L2_75
	L2_75 = SoundEnvironmentEmitter
	L2_75 = L2_75.new
	L2_75 = L2_75(L2_75, A1_74)
	table.insert(A0_73._emitters, L2_75)
	return L2_75
end
function CoreSoundEnvironmentManager.remove_emitter(A0_76, A1_77)
	A1_77:destroy()
	table.delete(A0_76._emitters, A1_77)
end
function CoreSoundEnvironmentManager.add_area_emitter(A0_78, A1_79)
	local L2_80
	L2_80 = SoundEnvironmentAreaEmitter
	L2_80 = L2_80.new
	L2_80 = L2_80(L2_80, A1_79)
	table.insert(A0_78._area_emitters, L2_80)
	return L2_80
end
function CoreSoundEnvironmentManager.remove_area_emitter(A0_81, A1_82)
	A1_82:destroy()
	table.delete(A0_81._area_emitters, A1_82)
end
function CoreSoundEnvironmentManager.add_listener(A0_83, A1_84)
	A1_84.object = Sound:listener(A1_84.listener)
	return A0_83:add_check_object(A1_84)
end
function CoreSoundEnvironmentManager.add_check_object(A0_85, A1_86)
	local L2_87
	L2_87 = A1_86.object
	if not L2_87 then
		L2_87 = Application
		L2_87 = L2_87.error
		L2_87(L2_87, "Must use an Object3D when adding check objects to sound environment manager.")
		L2_87 = nil
		return L2_87
	end
	L2_87 = A0_85._disable_fallback
	L2_87(A0_85)
	L2_87 = A0_85._check_object_id
	L2_87 = L2_87 + 1
	A0_85._check_object_id = L2_87
	L2_87 = {}
	L2_87.object = A1_86.object
	L2_87.area = nil
	L2_87.ambiences = A0_85:_ambiences()
	L2_87.active = A1_86.active
	L2_87.listener = A1_86.listener
	L2_87.primary = A1_86.primary
	L2_87.id = A0_85._check_object_id
	L2_87.sound_area_counter = 1
	A0_85:_change_ambiences(L2_87)
	A0_85._check_objects[A0_85._check_object_id] = L2_87
	return A0_85._check_object_id
end
function CoreSoundEnvironmentManager.remove_check_object(A0_88, A1_89)
	local L2_90
	L2_90 = A0_88._check_objects
	L2_90 = L2_90[A1_89]
	for 