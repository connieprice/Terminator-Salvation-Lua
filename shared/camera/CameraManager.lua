local L0_0
L0_0 = require
L0_0("shared/camera/CameraSetupNode")
L0_0 = CameraManager
if not L0_0 then
	L0_0 = class
	L0_0 = L0_0()
end
CameraManager = L0_0
L0_0 = "depends_on"
function CameraManager.init(A0_1)
	local L1_2
	L1_2 = {}
	A0_1._camera_setup_nodes = L1_2
	L1_2 = {}
	A0_1._listeners = L1_2
	A0_1._listeners_id = 0
	A0_1._listeners_count = 0
	L1_2 = {}
	A0_1._effects = L1_2
	A0_1._effects_id = 0
	A0_1._effects_count = 0
end
function CameraManager.load_cameras(A0_3, A1_4)
	local L2_5, L3_6, L4_7, L5_8, L6_9, L7_10, L8_11, L9_12, L10_13
	L2_5 = assert
	L3_6 = A1_4 and A1_4 ~= ""
	L2_5(L3_6)
	L2_5 = File
	L3_6 = L2_5
	L2_5 = L2_5.exists
	L4_7 = A1_4
	L2_5 = L2_5(L3_6, L4_7)
	L3_6 = assert
	L4_7 = L2_5
	L5_8 = "No file named: "
	L5_8 = L5_8 .. L6_9
	L3_6(L4_7, L5_8)
	L3_6 = File
	L4_7 = L3_6
	L3_6 = L3_6.new_parse_xml
	L5_8 = A1_4
	L3_6 = L3_6(L4_7, L5_8)
	L4_7 = assert
	L5_8 = L3_6.name
	L5_8 = L5_8(L6_9)
	L5_8 = L5_8 == "camera"
	L10_13 = L6_9(L7_10)
	L4_7(L5_8, L6_9, L7_10, L8_11, L9_12, L10_13, L6_9(L7_10))
	L5_8 = L3_6
	L4_7 = L3_6.parameter
	L4_7 = L4_7(L5_8, L6_9)
	L5_8 = assert
	L6_9 = L4_7 and L4_7 ~= ""
	L5_8(L6_9)
	L5_8 = A0_3._parse_cameras_xml_node
	L5_8 = L5_8(L6_9, L7_10)
	if L6_9 then
		for L9_12, L10_13 in L6_9(L7_10) do
			table.insert(A0_3._camera_setup_nodes[L4_7], L10_13)
		end
	else
		L6_9[L4_7] = L5_8
	end
end
function CameraManager._parse_cameras_xml_node(A0_14, A1_15)
	local L2_16, L3_17, L4_18, L5_19, L6_20, L7_21, L8_22
	L2_16 = {}
	L3_17 = A1_15.children
	L3_17 = L3_17(L4_18)
	for L7_21 in L3_17, nil, nil do
		L8_22 = A0_14._parse_xml_node
		L8_22 = L8_22(A0_14, L7_21)
		if L8_22 then
			table.insert(L2_16, L8_22)
		end
	end
	return L2_16
end
function CameraManager._parse_xml_node(A0_23, A1_24)
	local L2_25, L3_26
	L3_26 = A1_24
	L2_25 = A1_24.name
	L2_25 = L2_25(L3_26)
	L3_26 = _UPVALUE0_
	if L2_25 == L3_26 then
		L3_26 = A1_24.parameter
		L3_26 = L3_26(A1_24, _UPVALUE1_)
		assert(L3_26 and L3_26 ~= "")
		World:preload_unit(L3_26)
	else
		L3_26 = A0_23._create_setup_node
		L3_26 = L3_26(A0_23, A1_24)
		return L3_26
	end
end
function CameraManager._create_setup_node(A0_27, A1_28)
	local L2_29, L3_30, L4_31, L5_32, L6_33, L7_34, L8_35, L9_36, L10_37
	L3_30 = A1_28
	L2_29 = A1_28.name
	L2_29 = L2_29(L3_30)
	L3_30 = assert
	L4_31 = _UPVALUE0_
	L4_31 = L2_29 ~= L4_31
	L3_30(L4_31)
	L3_30 = {}
	L5_32 = A1_28
	L4_31 = A1_28.parameters
	L4_31 = L4_31(L5_32)
	L5_32 = A1_28.children
	L5_32 = L5_32(L6_33)
	for L9_36 in L5_32, nil, nil do
		L10_37 = A0_27._parse_xml_node
		L10_37 = L10_37(A0_27, L9_36)
		if L10_37 then
			table.insert(L3_30, L10_37)
		end
	end
	L8_35 = L6_33 and L6_33 ~= ""
	L7_34(L8_35)
	L9_36 = L7_34
	L8_35(L9_36)
	if L8_35 then
		L9_36 = L8_35
		L10_37 = L4_31
		L9_36(L10_37)
	end
	L9_36 = CameraSetupNode
	L10_37 = L9_36
	L9_36 = L9_36.new
	L9_36 = L9_36(L10_37, L6_33, L4_31, L3_30)
	return L9_36
end
function CameraManager.create_cameras(A0_38, A1_39, A2_40, A3_41)
	local L4_42, L5_43, L6_44
	L4_42 = A0_38._camera_setup_nodes
	L4_42 = L4_42[A1_39]
	L5_43 = assert
	L6_44 = L4_42
	L5_43(L6_44, "No cameras named: " .. A1_39)
	L5_43 = nil
	if A3_41 then
		L6_44 = _UPVALUE0_
		L6_44 = L6_44(L4_42, A3_41)
		assert(L6_44, "No camera named " .. A3_41 .. " in cameras " .. A1_39)
		L5_43 = A0_38:_setup_camera(L6_44, nil, A2_40)
		return L5_43
	else
		L6_44 = SharedCamera
		L6_44 = L6_44.new
		L6_44 = L6_44(L6_44, A2_40)
		L5_43 = L6_44
	end
	L6_44 = A0_38._setup_child_cameras
	L6_44(A0_38, L5_43, L4_42, A2_40)
	return L5_43
end
function CameraManager._create_camera(A0_45, A1_46, A2_47)
	local L3_48, L4_49
	L3_48 = rawget
	L4_49 = _G
	L3_48 = L3_48(L4_49, A1_46)
	if not L3_48 then
		L4_49 = assert
		L4_49(L3_48, "No class named: " .. A1_46)
	end
	L4_49 = assert
	L4_49(L3_48.new, A1_46)
	L4_49 = L3_48.new
	L4_49 = L4_49(L3_48, A2_47)
	assert(L4_49)
	return L4_49
end
function CameraManager._setup_camera(A0_50, A1_51, A2_52, A3_53)
	local L4_54, L5_55, L6_56
	L5_55 = A0_50
	L4_54 = A0_50._create_camera
	L6_56 = A1_51.class_name
	L6_56 = L6_56(A1_51)
	L4_54 = L4_54(L5_55, L6_56, A3_53)
	L6_56 = A1_51
	L5_55 = A1_51.settings
	L5_55 = L5_55(L6_56)
	L6_56 = L4_54.parse_parameters
	L6_56(L4_54, L5_55)
	if A2_52 then
		L6_56 = A2_52.add_child_camera
		L6_56(A2_52, L4_54)
	end
	L6_56 = L4_54
	assert(L6_56)
	A0_50:_setup_child_cameras(L6_56, A1_51:children(), A3_53)
	return L4_54
end
function CameraManager._setup_child_cameras(A0_57, A1_58, A2_59, A3_60)
	local L4_61, L5_62, L6_63, L7_64, L8_65
	L4_61(L5_62)
	for L7_64, L8_65 in L4_61(L5_62) do
		A0_57:_setup_camera(L8_65, A1_58, A3_60)
	end
end
function CameraManager.update(A0_66, A1_67, A2_68)
	local L3_69, L4_70, L5_71, L6_72, L7_73, L8_74, L9_75, L10_76, L11_77, L12_78, L13_79, L14_80, L15_81, L16_82
	for L6_72, L7_73 in L3_69(L4_70) do
		L8_74 = L7_73.time
		L8_74 = L8_74 + A2_68
		L7_73.time = L8_74
		L8_74 = L7_73.time
		L9_75 = L7_73.life_time
		if L8_74 > L9_75 then
			L8_74 = A0_66._effects_count
			L8_74 = L8_74 - 1
			A0_66._effects_count = L8_74
			L8_74 = A0_66._effects
			L8_74[L6_72] = nil
		else
			L8_74 = L7_73.time
			L9_75 = L7_73.effect
			L9_75 = L9_75.attack
			if L8_74 < L9_75 then
				L8_74 = L7_73.effect
				L8_74 = L8_74.peak
				L9_75 = L7_73.time
				L9_75 = L9_75 / L10_76
				L8_74 = L8_74 * L9_75
				L7_73.amplitude = L8_74
			else
				L8_74 = L7_73.time
				L9_75 = L7_73.effect
				L9_75 = L9_75.attack
				L9_75 = L9_75 + L10_76
				if L8_74 < L9_75 then
					L8_74 = L7_73.effect
					L8_74 = L8_74.peak
					L7_73.amplitude = L8_74
				else
					L8_74 = L7_73.effect
					L8_74 = L8_74.peak
					L9_75 = L7_73.time
					L9_75 = L9_75 / L10_76
					L9_75 = 1 - L9_75
					L8_74 = L8_74 * L9_75
					L7_73.amplitude = L8_74
				end
			end
		end
	end
	for L6_72, L7_73 in L3_69(L4_70) do
		L8_74 = 0
		L9_75 = 0
		for L13_79, L14_80 in L10_76(L11_77) do
			L15_81 = 0
			L16_82 = L7_73.position
			L16_82 = L16_82 - L14_80.position
			L16_82 = L16_82.length
			L16_82 = L16_82(L16_82)
			if L16_82 < L14_80.effect.radius then
				L15_81 = L14_80.amplitude * (1 - L14_80.scale_func(L16_82, L14_80.effect.radius))
			end
			if L8_74 < L15_81 then
				L8_74 = L15_81
			end
			if L9_75 < L14_80.effect.frequency then
				L9_75 = L14_80.effect.frequency
			end
		end
		L7_73.amplitude = L8_74
		L7_73.frequency = L9_75
	end
end
function CameraManager.play_shake_effect(A0_83, A1_84, A2_85)
	local L3_86, L4_87
	L3_86 = TableAlgorithms
	L3_86 = L3_86.recursive_copy
	L4_87 = A1_84
	L3_86 = L3_86(L4_87)
	L4_87 = A0_83._effects_id
	L4_87 = L4_87 + 1
	A0_83._effects_id = L4_87
	L4_87 = nil
	if L3_86.scale == "linear" then
		L4_87 = _UPVALUE0_
	elseif L3_86.scale == "log" then
		L4_87 = _UPVALUE1_
	end
	assert(L4_87)
	A0_83._effects[A0_83._effects_id] = {
		time = 0,
		life_time = L3_86.attack + L3_86.sustain + L3_86.release,
		id = A0_83._effects_id,
		position = A2_85,
		amplitude = 0,
		effect = L3_86,
		scale_func = L4_87
	}
	A0_83._effects_count = A0_83._effects_count + 1
	return A0_83._effects_id
end
function CameraManager.create_listener(A0_88)
	local L1_89, L3_90
	L1_89 = A0_88._effects_id
	L1_89 = L1_89 + 1
	A0_88._effects_id = L1_89
	L1_89 = A0_88._listeners
	L3_90 = A0_88._effects_id
	L1_89[L3_90] = {
		position = Vector3(0, 0, 0),
		rotation = Rotation(),
		amplitude = 0,
		frequency = 1
	}
	L1_89 = A0_88._listeners_count
	L1_89 = L1_89 + 1
	A0_88._listeners_count = L1_89
	L1_89 = A0_88._effects_id
	return L1_89
end
function CameraManager.destroy_listener(A0_91, A1_92)
	assert(A0_91._listeners[A1_92] ~= nil)
	A0_91._listeners[A1_92] = nil
	A0_91._listeners_count = A0_91._listeners_count - 1
end
function CameraManager.set_listener_position(A0_93, A1_94, A2_95)
	local L3_96
	L3_96 = A0_93._listeners
	L3_96 = L3_96[A1_94]
	if L3_96 then
		L3_96.position = A2_95
	end
end
function CameraManager.set_listener_rotation(A0_97, A1_98, A2_99)
	local L3_100
	L3_100 = A0_97._listeners
	L3_100 = L3_100[A1_98]
	if L3_100 then
		L3_100.rotation = A2_99
	end
end
function CameraManager.listener_data(A0_101, A1_102)
	local L2_103, L3_104, L4_105
	L2_103 = A0_101._listeners
	L2_103 = L2_103[A1_102]
	if L2_103 then
		L3_104 = {}
		L4_105 = L2_103.amplitude
		L3_104.amplitude = L4_105
		L4_105 = L2_103.frequency
		L3_104.frequency = L4_105
		return L3_104
	end
end
