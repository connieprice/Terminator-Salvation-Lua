local L0_0, L1_1
L0_0 = Menu2DPageControllerUtil
L0_0 = L0_0 or {}
Menu2DPageControllerUtil = L0_0
L0_0 = Menu2DPageControllerUtil
L1_1 = {
	"num abnt c1",
	"num abnt c2",
	"@",
	"ax",
	"convert",
	"kana",
	"kanji",
	"no convert",
	"oem 102",
	"stop",
	"unlabeled",
	"yen",
	"esc",
	"sys rq",
	"scroll lock",
	"pause",
	"left windows",
	"right windows",
	"",
	"left alt"
}
L0_0.forbidden_buttons = L1_1
L0_0 = Menu2DPageControllerUtil
function L1_1(A0_2, A1_3)
	local L2_4, L3_5, L4_6, L5_7, L6_8, L7_9, L8_10, L9_11, L10_12, L11_13, L12_14, L13_15, L14_16, L15_17, L16_18, L17_19
	L2_4 = {}
	L3_5 = {}
	L4_6 = nil
	if A0_2 == "pc" then
		L4_6 = "data/lib/menu/2D/pages/pc_controller_setup.xml"
	elseif A0_2 == "gamepad" or A0_2 == "xbox360" then
		L4_6 = "data/lib/menu/2D/pages/gamepad_controller_setup.xml"
	end
	if L4_6 then
		L5_7 = File
		L5_7 = L5_7.exists
		L5_7 = L5_7(L6_8, L7_9)
		if L5_7 then
			L5_7 = File
			L5_7 = L5_7.parse_xml
			L5_7 = L5_7(L6_8, L7_9)
			for L9_11 in L6_8(L7_9) do
				L10_12 = {}
				L12_14 = L9_11
				L11_13 = L9_11.parameter
				L11_13 = L11_13(L12_14, L13_15)
				L10_12.name = L11_13
				L12_14 = L9_11
				L11_13 = L9_11.parameter
				L11_13 = L11_13(L12_14, L13_15)
				L10_12.text_id = L11_13
				L12_14 = A1_3
				L11_13 = A1_3.get_connection_settings
				L11_13 = L11_13(L12_14, L13_15)
				L12_14 = L11_13._input_name_list
				L10_12.current_input = L13_15
				L13_15(L14_16, L15_17)
				for L16_18 in L13_15(L14_16) do
					L17_19 = {}
					L17_19.connected_to = L10_12.name
					L17_19.name = L16_18:parameter("connection_name")
					L17_19.text_id = L16_18:parameter("text_id")
					table.insert(L3_5, L17_19)
				end
			end
		end
	end
	L5_7 = L2_4
	return L5_7, L6_8
end
L0_0.parse_xml = L1_1
L0_0 = Menu2DPageControllerUtil
function L1_1(A0_20)
	local L1_21, L2_22, L3_23, L4_24
	L1_21 = {}
	L2_22 = nil
	L3_23 = "input"
	L4_24 = 1
	repeat
		if A0_20:has_parameter(L3_23) then
			L2_22 = A0_20:parameter(L3_23)
		else
			L2_22 = nil
		end
		if L2_22 then
			table.insert(L1_21, L2_22)
			L4_24 = L4_24 + 1
			L3_23 = "input" .. L4_24
		end
	until not L2_22
	return L1_21
end
L0_0._get_input_name_list = L1_1
L0_0 = Menu2DPageControllerUtil
function L1_1(A0_25, A1_26)
	local L2_27, L3_28, L4_29, L5_30, L6_31, L7_32, L8_33, L9_34, L10_35, L11_36, L12_37, L13_38, L14_39, L15_40, L16_41, L17_42, L18_43, L19_44, L20_45, L21_46, L22_47
	L2_27 = {}
	for L6_31 in L3_28(L4_29) do
		L7_32 = L6_31.name
		L7_32 = L7_32(L8_33)
		if A1_26 == "xbox360" and L7_32 == "xbox360" or A1_26 == "pc" and L7_32 == "pc" or A1_26 == "gamepad" and L7_32 == "gamepad" then
			for L11_36 in L8_33(L9_34) do
				if L12_37 == "connections" then
					for L15_40 in L12_37(L13_38) do
						L17_42 = L15_40
						L16_41 = L15_40.name
						L16_41 = L16_41(L17_42)
						L17_42 = L15_40.parameter
						L17_42 = L17_42(L18_43, L19_44)
						if L17_42 ~= true then
							if L16_41 == "button" then
								L17_42 = nil
								L18_43.connection_type = "button"
								L21_46 = "name"
								L18_43.name = L19_44
								L18_43.buttons = L19_44
								L21_46 = "controller"
								L18_43.controller = L19_44
								L17_42 = L18_43
								L18_43(L19_44, L20_45)
							elseif L16_41 == "axis" then
								L17_42 = {}
								L17_42.connection_type = "axis"
								L17_42.name = L18_43
								L17_42.input = L18_43
								L17_42.controller = L18_43
								L17_42.lerp = L18_43
								L17_42.multiplier = L18_43
								L17_42.no_limit = L18_43
								L17_42.inversion = L18_43
								L17_42.debug = L18_43
								L17_42.pad_bottom = L18_43
								L17_42.pad_top = L18_43
								L17_42.soft_top = L18_43
								if L18_43 == "buttons" then
									for L21_46 in L18_43(L19_44) do
										L22_47 = {}
										L22_47.connection_type = "button"
										L22_47.name = L21_46:parameter("name")
										L22_47.buttons = Menu2DPageControllerUtil._get_input_name_list(L21_46)
										L22_47.controller = L21_46:parameter("controller")
										table.insert(L2_27, L22_47)
									end
								end
								L18_43(L19_44, L20_45)
							end
						end
					end
				end
			end
		end
	end
	return L2_27
end
L0_0.parse_controllers_xml = L1_1
L0_0 = Menu2DPageControllerUtil
function L1_1(A0_48, A1_49, A2_50, A3_51)
	local L4_52, L5_53, L6_54, L7_55, L8_56, L9_57, L10_58, L11_59, L12_60, L13_61, L14_62, L15_63
	L4_52 = A2_50.pressed_inputs
	L4_52 = L4_52(L5_53)
	for L8_56, L9_57 in L5_53(L6_54) do
		L10_58 = L9_57.is_button
		if L10_58 then
			L10_58 = L9_57.input_name
			L11_59 = true
			for L15_63, 