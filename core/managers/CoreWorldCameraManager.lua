CoreWorldCameraManager = CoreWorldCameraManager or class()
core:require_module("CoreScriptViewport")
function CoreWorldCameraManager.init(A0_0)
	A0_0._camera = World:create_camera()
	A0_0:set_default_fov(75)
	A0_0:set_fov(A0_0._default_fov)
	A0_0:set_default_dof(150, 10000)
	A0_0._current_near_dof = A0_0._default_near_dof
	A0_0._current_far_dof = A0_0._default_far_dof
	A0_0._default_dof_padding = 100
	A0_0._current_dof_padding = A0_0._default_dof_padding
	A0_0._default_dof_clamp = 1
	A0_0._current_dof_clamp = A0_0._default_dof_clamp
	A0_0:set_dof(A0_0._default_near_dof, A0_0._default_far_dof)
	A0_0._camera:set_near_range(7.5)
	A0_0._camera:set_far_range(200000)
	A0_0._viewport = CoreScriptViewport.ScriptViewport:new(0, 0, 1, 1)
	A0_0._director = A0_0._viewport:director()
	A0_0._shaker = A0_0._director:shaker()
	A0_0._camera_controller = A0_0._director:make_camera(A0_0._camera, "world_camera")
	A0_0._viewport:set_camera(A0_0._camera)
	A0_0._director:set_camera(A0_0._camera_controller)
	A0_0._director:position_as(A0_0._camera)
	A0_0:_create_listener()
	A0_0._use_gui = true
	Overlay:newgui():preload("core_world_camera")
	A0_0._workspace = Overlay:newgui():create_screen_workspace(0, 0, 1, 1)
	A0_0._gui = A0_0._workspace:panel():gui("core_world_camera")
	A0_0._gui_visible = nil
	A0_0:_set_gui_visible(false)
	A0_0:_clear_callback_lists()
	A0_0:_set_dof_effect()
	A0_0:clear()
end
function CoreWorldCameraManager.use_gui(A0_1)
	local L1_2
	L1_2 = A0_1._use_gui
	return L1_2
end
function CoreWorldCameraManager._create_listener(A0_3)
	A0_3._listener_id = managers.listener:add_listener("world_camera", A0_3._camera)
	A0_3._listener_activation_id = nil
	managers.listener:add_set("world_camera", {
		"world_camera"
	})
end
function CoreWorldCameraManager.set_default_fov(A0_4, A1_5)
	A0_4._default_fov = A1_5
end
function CoreWorldCameraManager.default_fov(A0_6)
	local L1_7
	L1_7 = A0_6._default_fov
	return L1_7
end
function CoreWorldCameraManager.set_fov(A0_8, A1_9)
	A0_8._camera:set_fov(A1_9)
end
function CoreWorldCameraManager.set_default_dof(A0_10, A1_11, A2_12)
	A0_10._default_near_dof = A1_11
	A0_10._default_far_dof = A2_12
end
function CoreWorldCameraManager.default_near_dof(A0_13)
	local L1_14
	L1_14 = A0_13._default_near_dof
	return L1_14
end
function CoreWorldCameraManager.default_far_dof(A0_15)
	local L1_16
	L1_16 = A0_15._default_far_dof
	return L1_16
end
function CoreWorldCameraManager.set_dof(A0_17, A1_18)
end
function CoreWorldCameraManager.default_dof_padding(A0_19)
	local L1_20
	L1_20 = A0_19._default_dof_padding
	return L1_20
end
function CoreWorldCameraManager.default_dof_clamp(A0_21)
	local L1_22
	L1_22 = A0_21._default_dof_clamp
	return L1_22
end
function CoreWorldCameraManager._set_dof_effect(A0_23)
	local L1_24
	L1_24 = {}
	A0_23._dof = L1_24
	L1_24 = A0_23._dof
	L1_24.update_callback = "update_world_camera"
	L1_24 = A0_23._dof
	L1_24.near_min = A0_23:default_near_dof()
	L1_24 = A0_23._dof
	L1_24.near_max = A0_23:default_near_dof()
	L1_24 = A0_23._dof
	L1_24.far_min = A0_23:default_far_dof()
	L1_24 = A0_23._dof
	L1_24.far_max = A0_23:default_far_dof()
	L1_24 = A0_23._dof
	L1_24.clamp = 1
	L1_24 = A0_23._dof
	L1_24.prio = 1
	L1_24 = A0_23._dof
	L1_24.name = "world_camera"
	L1_24 = A0_23._dof
	L1_24.fade_in = 0.5
	L1_24 = A0_23._dof
	L1_24.fade_out = 0.5
end
function CoreWorldCameraManager.destroy(A0_25)
	A0_25:_destroy_listener()
	if A0_25._viewport then
		A0_25._viewport:destroy()
		A0_25._viewport = nil
	end
	if alive(A0_25._camera) then
		World:delete_camera(A0_25._camera)
		A0_25._camera = nil
	end
	if alive(A0_25._workspace) then
		Overlay:newgui():destroy_workspace(A0_25._workspace)
		A0_25._workspace = nil
	end
end
function CoreWorldCameraManager._destroy_listener(A0_26)
	if A0_26._listener_id then
		managers.listener:remove_listener(A0_26._listener_id)
		managers.listener:remove_set("world_camera")
		A0_26._listener_id = nil
	end
end
function CoreWorldCameraManager.stop_simulation(A0_27)
	A0_27:_clear_callback_lists()
end
function CoreWorldCameraManager._clear_callback_lists(A0_28)
	local L1_29
	L1_29 = {}
	A0_28._last_world_camera_done_callback_id = L1_29
	L1_29 = {}
	A0_28._world_camera_done_callback_list = L1_29
	L1_29 = {}
	A0_28._last_sequence_done_callback_id = L1_29
	L1_29 = {}
	A0_28._sequence_done_callback_list = L1_29
	L1_29 = {}
	A0_28._last_sequence_camera_clip_callback_id = L1_29
	L1_29 = {}
	A0_28._sequence_camera_clip_callback_list = L1_29
end
function CoreWorldCameraManager.clear(A0_30)
	local L1_31
	L1_31 = {}
	A0_30._world_cameras = L1_31
	L1_31 = {}
	A0_30._world_camera_sequences = L1_31
	A0_30._current_world_camera = nil
end
function CoreWorldCameraManager.current_world_camera(A0_32)
	local L1_33
	L1_33 = A0_32._current_world_camera
	return L1_33
end
function CoreWorldCameraManager.save(A0_34, A1_35)
	local L2_36, L3_37, L4_38, L5_39, L6_40, L7_41, L8_42
	L2_36 = File
	L2_36 = L2_36.open
	L2_36 = L2_36(L3_37, L4_38, L5_39)
	L3_37(L4_38, L5_39)
	for L6_40, L7_41 in L3_37(L4_38) do
		L8_42 = "\t"
		L2_36:puts(L8_42 .. "<world_camera name=\"" .. L6_40 .. "\" duration=\"" .. L7_41:duration() .. "\" delay=\"" .. L7_41:delay() .. "\" in_acc=\"" .. L7_41:in_acc() .. "\" out_acc=\"" .. L7_41:out_acc() .. "\">")
		L7_41:save(L2_36, L8_42)
		L2_36:puts(L8_42 .. "</world_camera>")
	end
	L6_40 = A0_34
	L7_41 = "_world_camera_sequences"
	L8_42 = "\t"
	L8_42 = L5_39(L6_40, L7_41, L8_42)
	L3_37(L4_38, L5_39, L6_40, L7_41, L8_42, L5_39(L6_40, L7_41, L8_42))
	L3_37(L4_38, L5_39)
	L3_37(L4_38, L5_39)
end
function CoreWorldCameraManager.load(A0_43, A1_44, A2_45)
	local L3_46, L4_47, L5_48, L6_49, L7_50, L8_51
	L3_46 = File
	L3_46 = L3_46.parse_xml
	L3_46 = L3_46(L4_47, L5_48)
	for L7_50 in L4_47(L5_48) do
		L8_51 = L7_50.name
		L8_51 = L8_51(L7_50)
		if L8_51 == "world_camera" then
			L8_51 = L7_50.parameter
			L8_51 = L8_51(L7_50, "name")
			A0_43._world_cameras[L8_51] = (rawget(_G, "WorldCamera") or rawget(_G, "CoreWorldCamera")):new(L8_51)
			A0_43._world_cameras[L8_51]:load(L7_50)
		else
			L8_51 = parse_value_node
			A0_43[L8_51], L8_51 = L7_50, L8_51(L7_50)
		end
	end
end
function CoreWorldCameraManager.update(A0_52, A1_53, A2_54)
	if A0_52._current_world_camera then
		A0_52._current_world_camera:update(A1_53, A2_54)
	end
end
function CoreWorldCameraManager._set_gui_visible(A0_55, A1_56)
	if A0_55._gui_visible ~= A1_56 then
		if A1_56 and A0_55._use_gui then
			A0_55._workspace:show()
		else
			A0_55._workspace:hide()
		end
		A0_55._gui_visible = A1_56
	end
end
function CoreWorldCameraManager.add_world_camera_done_callback(A0_57, A1_58, A2_59)
	local L3_60, L4_61
	L3_60 = A0_57._last_world_camera_done_callback_id
	L4_61 = A0_57._last_world_camera_done_callback_id
	L4_61 = L4_61[A1_58]
	L4_61 = L4_61 or 0
	L3_60[A1_58] = L4_61
	L3_60 = A0_57._last_world_camera_done_callback_id
	L4_61 = A0_57._last_world_camera_done_callback_id
	L4_61 = L4_61[A1_58]
	L4_61 = L4_61 + 1
	L3_60[A1_58] = L4_61
	L3_60 = A0_57._world_camera_done_callback_list
	L4_61 = A0_57._world_camera_done_callback_list
	L4_61 = L4_61[A1_58]
	L4_61 = L4_61 or {}
	L3_60[A1_58] = L4_61
	L3_60 = A0_57._world_camera_done_callback_list
	L3_60 = L3_60[A1_58]
	L4_61 = A0_57._last_world_camera_done_callback_id
	L4_61 = L4_61[A1_58]
	L3_60[L4_61] = A2_59
	L3_60 = A0_57._last_world_camera_done_callback_id
	L3_60 = L3_60[A1_58]
	return L3_60
end
function CoreWorldCameraManager.remove_world_camera_done_callback(A0_62, A1_63, A2_64)
	local L3_65
	L3_65 = A0_62._world_camera_done_callback_list
	L3_65 = L3_65[A1_63]
	L3_65[A2_64] = nil
end
function CoreWorldCameraManager.add_sequence_done_callback(A0_66, A1_67, A2_68)
	local L3_69, L4_70
	L3_69 = A0_66._last_sequence_done_callback_id
	L4_70 = A0_66._last_sequence_done_callback_id
	L4_70 = L4_70[A1_67]
	L4_70 = L4_70 or 0
	L3_69[A1_67] = L4_70
	L3_69 = A0_66._last_sequence_done_callback_id
	L4_70 = A0_66._last_sequence_done_callback_id
	L4_70 = L4_70[A1_67]
	L4_70 = L4_70 + 1
	L3_69[A1_67] = L4_70
	L3_69 = A0_66._sequence_done_callback_list
	L4_70 = A0_66._sequence_done_callback_list
	L4_70 = L4_70[A1_67]
	L4_70 = L4_70 or {}
	L3_69[A1_67] = L4_70
	L3_69 = A0_66._sequence_done_callback_list
	L3_69 = L3_69[A1_67]
	L4_70 = A0_66._last_sequence_done_callback_id
	L4_70 = L4_70[A1_67]
	L3_69[L4_70] = A2_68
	L3_69 = A0_66._last_sequence_done_callback_id
	L3_69 = L3_69[A1_67]
	return L3_69
end
function CoreWorldCameraManager.remove_sequence_done_callback(A0_71, A1_72, A2_73)
	local L3_74
	L3_74 = A0_71._sequence_done_callback_list
	L3_74 = L3_74[A1_72]
	L3_74[A2_73] = nil
end
function CoreWorldCameraManager.add_sequence_camera_clip_callback(A0_75, A1_76, A2_77, A3_78)
	local L4_79, L5_80
	L4_79 = A0_75._last_sequence_camera_clip_callback_id
	L5_80 = A0_75._last_sequence_camera_clip_callback_id
	L5_80 = L5_80[A1_76]
	L5_80 = L5_80 or 0
	L4_79[A1_76] = L5_80
	L4_79 = A0_75._last_sequence_camera_clip_callback_id
	L5_80 = A0_75._last_sequence_camera_clip_callback_id
	L5_80 = L5_80[A1_76]
	L5_80 = L5_80 + 1
	L4_79[A1_76] = L5_80
	L4_79 = A0_75._sequence_camera_clip_callback_list
	L5_80 = A0_75._sequence_camera_clip_callback_list
	L5_80 = L5_80[A1_76]
	L5_80 = L5_80 or {}
	L4_79[A1_76] = L5_80
	L4_79 = A0_75._sequence_camera_clip_callback_list
	L4_79 = L4_79[A1_76]
	L5_80 = A0_75._sequence_camera_clip_callback_list
	L5_80 = L5_80[A1_76]
	L5_80 = L5_80[A2_77]
	L5_80 = L5_80 or {}
	L4_79[A2_77] = L5_80
	L4_79 = A0_75._sequence_camera_clip_callback_list
	L4_79 = L4_79[A1_76]
	L4_79 = L4_79[A2_77]
	L5_80 = A0_75._last_sequence_camera_clip_callback_id
	L5_80 = L5_80[A1_76]
	L4_79[L5_80] = A3_78
	L4_79 = A0_75._last_sequence_camera_clip_callback_id
	L4_79 = L4_79[A1_76]
	return L4_79
end
function CoreWorldCameraManager.remove_sequence_camera_clip_callback(A0_81, A1_82, A2_83, A3_84)
	local L4_85
	L4_85 = A0_81._sequence_camera_clip_callback_list
	L4_85 = L4_85[A1_82]
	L4_85 = L4_85[A2_83]
	L4_85[A3_84] = nil
end
function CoreWorldCameraManager.create_world_camera(A0_86, A1_87)
	local L2_88
	L2_88 = A0_86._world_cameras
	L2_88[A1_87] = (rawget(_G, "WorldCamera") or rawget(_G, "CoreWorldCamera")):new(A1_87)
	L2_88 = A0_86._world_cameras
	L2_88 = L2_88[A1_87]
	return L2_88
end
function CoreWorldCameraManager.remove_world_camera(A0_89, A1_90)
	A0_89._world_cameras[A1_90] = nil
end
function CoreWorldCameraManager.all_world_cameras(A0_91)
	local L1_92
	L1_92 = A0_91._world_cameras
	return L1_92
end
function CoreWorldCameraManager.world_camera(A0_93, A1_94)
	return A0_93._world_cameras[A1_94]
end
function CoreWorldCameraManager.play_world_camera(A0_95, A1_96)
	local L2_97
	L2_97 = {
		A0_95:_camera_sequence_table(A1_96)
	}
	A0_95:play_world_camera_sequence(nil, L2_97)
end
function CoreWorldCameraManager.new_play_world_camera(A0_98, A1_99)
	local L2_100, L3_101, L4_102
	L2_100 = A0_98._world_cameras
	L3_101 = A1_99.name
	L2_100 = L2_100[L3_101]
	if L2_100 then
		L3_101 = A0_98._current_world_camera
		if L3_101 then
			L3_101 = A0_98._current_world_camera
			L4_102 = L3_101
			L3_101 = L3_101.stop
			L3_101(L4_102)
		end
		A0_98._current_world_camera = L2_100
		L3_101 = A0_98._current_world_camera
		L4_102 = L3_101
		L3_101 = L3_101.play
		L4_102 = L3_101(L4_102, A1_99)
		if not L3_101 then
			if Application:editor() then
				managers.editor:output_error(L4_102)
			end
			A0_98:stop_world_camera()
			return
		end
	else
		L3_101 = Application
		L4_102 = L3_101
		L3_101 = L3_101.error
		L3_101(L4_102, "WorldCamera named", A1_99.name, "did not exist.")
	end
end
function CoreWorldCameraManager.stop_world_camera(A0_103)
	local L1_104, L2_105, L3_106, L4_107, L5_108, L6_109
	L1_104 = A0_103._current_world_camera
	if not L1_104 then
		return
	end
	L1_104 = A0_103._current_world_camera
	L2_105(L3_106)
	if L2_105 then
		if L2_105 then
			if L2_105 then
				for L5_108, L6_109 in L2_105(L3_106) do
					A0_103:remove_sequence_camera_clip_callback(A0_103._current_sequence_name, A0_103._sequence_index, L5_108)
					L6_109(A0_103._current_sequence_name, A0_103._sequence_index, L5_108)
				end
			end
		end
		if L2_105 < L3_106 then
			A0_103._sequence_index = L2_105
			L5_108 = A0_103._sequence_index
			L2_105(L3_106, L4_107)
		else
			A0_103._current_world_camera = nil
			L2_105(L3_106)
		end
	end
	if L2_105 then
		L5_108 = L1_104
		for L5_108, L6_109 in L2_105(L3_106) do
			A0_103:remove_world_camera_done_callback(L1_104:name(), L5_108)
			L6_109(L1_104, L5_108)
		end
	end
end
function CoreWorldCameraManager.create_world_camera_sequence(A0_110, A1_111)
	local L2_112
	L2_112 = A0_110._world_camera_sequences
	L2_112[A1_111] = {}
	L2_112 = A0_110._world_camera_sequences
	L2_112 = L2_112[A1_111]
	return L2_112
end
function CoreWorldCameraManager.remove_world_camera_sequence(A0_113, A1_114)
	A0_113._world_camera_sequences[A1_114] = nil
end
function CoreWorldCameraManager.all_world_camera_sequences(A0_115)
	local L1_116
	L1_116 = A0_115._world_camera_sequences
	return L1_116
end
function CoreWorldCameraManager.world_camera_sequence(A0_117, A1_118)
	return A0_117._world_camera_sequences[A1_118]
end
function CoreWorldCameraManager.add_camera_to_sequence(A0_119, A1_120, A2_121)
	local L3_122
	L3_122 = A0_119._world_camera_sequences
	L3_122 = L3_122[A1_120]
	if not L3_122 then
		Application:error("World camera sequence named", A1_120, "did not exist.")
		return
	end
	table.insert(L3_122, A0_119:_camera_sequence_table(A2_121))
	return #L3_122
end
function CoreWorldCameraManager.insert_camera_to_sequence(A0_123, A1_124, A2_125, A3_126)
	local L4_127
	L4_127 = A0_123._world_camera_sequences
	L4_127 = L4_127[A1_124]
	if not L4_127 then
		Application:error("World camera sequence named", A1_124, "did not exist.")
		return
	end
	table.insert(L4_127, A3_126, A2_125)
	return #L4_127
end
function CoreWorldCameraManager.remove_camera_from_sequence(A0_128, A1_129, A2_130)
	local L3_131, L4_132
	L3_131 = A0_128._world_camera_sequences
	L3_131 = L3_131[A1_129]
	L4_132 = L3_131[A2_130]
	table.remove(L3_131, A2_130)
	return L4_132
end
function CoreWorldCameraManager._camera_sequence_table(A0_133, A1_134)
	local L2_135
	L2_135 = {}
	L2_135.name = A1_134
	L2_135.start = 0
	L2_135.stop = 1
	return L2_135
end
function CoreWorldCameraManager._break_sequence(A0_136)
	if A0_136._current_sequence then
		A0_136:_sequence_done()
	end
end
function CoreWorldCameraManager._sequence_done(A0_137)
	local L1_138, L2_139, L3_140, L4_141, L5_142, L6_143, L7_144
	L2_139 = A0_137
	L1_138 = A0_137._set_listener_enabled
	L1_138(L2_139, L3_140)
	L2_139 = A0_137
	L1_138 = A0_137._reset_old_viewports
	L1_138(L2_139)
	L2_139 = A0_137
	L1_138 = A0_137.stop_dof
	L1_138(L2_139)
	L2_139 = A0_137
	L1_138 = A0_137._set_gui_visible
	L1_138(L2_139, L3_140)
	L1_138 = managers
	L1_138 = L1_138.sound_environment
	L2_139 = L1_138
	L1_138 = L1_138.set_check_object_active
	L1_138(L2_139, L3_140, L4_141)
	L1_138 = A0_137._current_sequence
	L2_139 = A0_137._current_sequence_name
	A0_137._current_sequence = nil
	A0_137._current_sequence_name = nil
	if L3_140 then
		for L6_143, L7_144 in L3_140(L4_141) do
			A0_137:remove_sequence_done_callback(L2_139, L6_143)
			L7_144(L1_138, L6_143)
		end
	end
end
function CoreWorldCameraManager.play_world_camera_sequence(A0_145, A1_146, A2_147)
	A0_145:_break_sequence()
	if not (A0_145._world_camera_sequences[A1_146] or A2_147) then
		Application:error("World camaera sequence named", A1_146, "did not exist.")
		return
	end
	if #(A0_145._world_camera_sequences[A1_146] or A2_147) == 0 then
		Application:error("World camaera sequence named", A1_146, "did not have any cameras.")
		return
	end
	A0_145._current_sequence = A0_145._world_camera_sequences[A1_146] or A2_147
	A0_145._current_sequence_name = A1_146
	if not A0_145._sound_environment_check_object then
		A0_145._sound_environment_check_object = managers.sound_environment:add_check_object({
			object = A0_145._camera,
			active = false,
			primary = true
		})
	end
	managers.sound_environment:set_check_object_active(A0_145._sound_environment_check_object, true)
	A0_145:_save_old_viewports()
	A0_145:_use_vp()
	A0_145:_set_gui_visible(true)
	A0_145:_set_listener_enabled(true)
	A0_145:start_dof()
	A0_145._sequence_index = 1
	A0_145:new_play_world_camera(A0_145._current_sequence[A0_145._sequence_index])
end
function CoreWorldCameraManager._save_old_viewports(A0_148)
	managers.viewport:push()
end
function CoreWorldCameraManager._use_vp(A0_149)
	managers.viewport:deactivate_all_viewports()
	A0_149:viewport():set_active(true)
end
function CoreWorldCameraManager._reset_old_viewports(A0_150)
	A0_150:viewport():set_active(false)
	managers.viewport:pop()
end
function CoreWorldCameraManager._set_listener_enabled(A0_151, A1_152)
	if A1_152 then
		if not A0_151._listener_activation_id then
			A0_151._listener_activation_id = managers.listener:activate_set("main", "world_camera")
		end
	elseif A0_151._listener_activation_id then
		managers.listener:deactivate_set(A0_151._listener_activation_id)
		A0_151._listener_activation_id = nil
	end
end
function CoreWorldCameraManager.start_dof(A0_153)
	if not A0_153._using_dof then
		A0_153._using_dof = true
		managers.DOF:play_dof_effect(A0_153._dof)
	end
end
function CoreWorldCameraManager.stop_dof(A0_154)
	managers.DOF:stop_dof_effect("world_camera")
	A0_154._using_dof = false
end
function CoreWorldCameraManager.using_dof(A0_155)
	local L1_156
	L1_156 = A0_155._using_dof
	return L1_156
end
function CoreWorldCameraManager.update_dof_values(A0_157, A1_158, A2_159, A3_160, A4_161)
	A0_157._current_near_dof = A1_158
	A0_157._current_far_dof = A2_159
	A0_157._current_dof_padding = A3_160
	A0_157._current_dof_clamp = A4_161
end
function CoreWorldCameraManager.update_dof(A0_162, A1_163, A2_164, A3_165)
	local L4_166, L5_167, L6_168
	L4_166 = A3_165.data
	L5_167 = A0_162._current_near_dof
	L4_166.near_min = L5_167
	L5_167 = A0_162._current_near_dof
	L6_168 = A0_162._current_dof_padding
	L5_167 = L5_167 - L6_168
	L4_166.near_max = L5_167
	L5_167 = A0_162._current_far_dof
	L4_166.far_min = L5_167
	L5_167 = A0_162._current_far_dof
	L6_168 = A0_162._current_dof_padding
	L5_167 = L5_167 + L6_168
	L4_166.far_max = L5_167
	L5_167 = A0_162._current_dof_clamp
	L4_166.clamp = L5_167
end
function CoreWorldCameraManager.viewport(A0_169)
	local L1_170
	L1_170 = A0_169._viewport
	return L1_170
end
function CoreWorldCameraManager.director(A0_171)
	local L1_172
	L1_172 = A0_171._director
	return L1_172
end
function CoreWorldCameraManager.workspace(A0_173)
	local L1_174
	L1_174 = A0_173._workspace
	return L1_174
end
function CoreWorldCameraManager.camera(A0_175)
	local L1_176
	L1_176 = A0_175._camera
	return L1_176
end
function CoreWorldCameraManager.camera_controller(A0_177)
	local L1_178
	L1_178 = A0_177._camera_controller
	return L1_178
end
CoreWorldCamera = CoreWorldCamera or class()
function CoreWorldCamera.init(A0_179, A1_180)
	local L2_181
	A0_179._world_camera_name = A1_180
	L2_181 = {}
	A0_179._points = L2_181
	L2_181 = {}
	A0_179._positions = L2_181
	L2_181 = {}
	A0_179._target_positions = L2_181
	A0_179._duration = 2.5
	A0_179._delay = 0
	A0_179._playing = false
	A0_179._target_offest = 1000
	L2_181 = {}
	A0_179._in_accelerations = L2_181
	L2_181 = {}
	A0_179._out_accelerations = L2_181
	L2_181 = A0_179._in_accelerations
	L2_181.linear = 0.33
	L2_181 = A0_179._out_accelerations
	L2_181.linear = 0.66
	L2_181 = A0_179._in_accelerations
	L2_181.ease = 0
	L2_181 = A0_179._out_accelerations
	L2_181.ease = 1
	L2_181 = A0_179._in_accelerations
	L2_181.fast = 0.5
	L2_181 = A0_179._out_accelerations
	L2_181.fast = 0.5
	L2_181 = A0_179._in_accelerations
	L2_181 = L2_181.linear
	A0_179._in_acc = L2_181
	L2_181 = A0_179._out_accelerations
	L2_181 = L2_181.linear
	A0_179._out_acc = L2_181
	A0_179._old_viewport = nil
	L2_181 = {}
	A0_179._keys = L2_181
	L2_181 = 0
	table.insert(A0_179._keys, {
		time = L2_181,
		fov = managers.worldcamera:default_fov(),
		near_dof = managers.worldcamera:default_near_dof(),
		far_dof = managers.worldcamera:default_far_dof()
	})
	A0_179._dof_padding = managers.worldcamera:default_dof_padding()
	A0_179._dof_clamp = managers.worldcamera:default_dof_clamp()
end
function CoreWorldCamera.save(A0_182, A1_183, A2_184)
	A2_184 = A2_184 .. "\t"
	A1_183:puts(save_value_string(A0_182, "_positions", A2_184))
	A1_183:puts(save_value_string(A0_182, "_target_positions", A2_184))
	A1_183:puts(save_value_string(A0_182, "_keys", A2_184))
	A1_183:puts(save_value_string(A0_182, "_dof_padding", A2_184))
	A1_183:puts(save_value_string(A0_182, "_dof_clamp", A2_184))
end
function CoreWorldCamera.load(A0_185, A1_186)
	local L2_187, L3_188, L4_189, L5_190
	L5_190 = "duration"
	L5_190 = L3_188(L4_189, L5_190)
	A0_185._duration = L2_187
	L5_190 = "delay"
	L5_190 = L3_188(L4_189, L5_190)
	A0_185._delay = L2_187
	if L2_187 then
		L5_190 = "in_acc"
		L5_190 = L3_188(L4_189, L5_190)
		A0_185._in_acc = L2_187
	end
	if L2_187 then
		L5_190 = "out_acc"
		L5_190 = L3_188(L4_189, L5_190)
		A0_185._out_acc = L2_187
	end
	for L5_190 in L2_187(L3_188) do
		if L5_190:name() == "point" then
			for 