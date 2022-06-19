core:module("CoreEws")
core:require_module("CoreClass")
function verify_number(A0_0, A1_1)
	local L2_2
	L2_2 = EWS
	L2_2 = L2_2.name_to_key_code
	L2_2 = L2_2(L2_2, "K_BACK")
	if L2_2 ~= A1_1:key_code() then
		L2_2 = EWS
		L2_2 = L2_2.name_to_key_code
		L2_2 = L2_2(L2_2, "K_RIGHT")
		if L2_2 ~= A1_1:key_code() then
			L2_2 = EWS
			L2_2 = L2_2.name_to_key_code
			L2_2 = L2_2(L2_2, "K_LEFT")
			if L2_2 ~= A1_1:key_code() then
				L2_2 = A1_1.key_code
				L2_2 = L2_2(A1_1)
				if L2_2 >= 48 then
					L2_2 = A1_1.key_code
					L2_2 = L2_2(A1_1)
				elseif not (L2_2 <= 57) then
					L2_2 = A1_1.key_code
					L2_2 = L2_2(A1_1)
					if L2_2 ~= 45 then
						L2_2 = A1_1.key_code
						L2_2 = L2_2(A1_1)
						if L2_2 ~= 46 then
							L2_2 = EWS
							L2_2 = L2_2.name_to_key_code
							L2_2 = L2_2(L2_2, "K_RETURN")
							if L2_2 ~= A1_1:key_code() then
								L2_2 = EWS
								L2_2 = L2_2.name_to_key_code
								L2_2 = L2_2(L2_2, "K_TAB")
								if L2_2 ~= A1_1:key_code() then
									L2_2 = EWS
									L2_2 = L2_2.name_to_key_code
									L2_2 = L2_2(L2_2, "K_DELETE")
								end
							end
						end
					end
				end
			end
		end
	elseif L2_2 == A1_1:key_code() then
		L2_2 = A1_1.key_code
		L2_2 = L2_2(A1_1)
		if L2_2 == 46 then
			L2_2 = A0_0.get_value
			L2_2 = L2_2(A0_0)
			L2_2 = L2_2 .. "."
			if not tonumber(L2_2) then
				return
			end
		end
		L2_2 = A1_1.skip
		L2_2(A1_1)
	end
end
function image_path(A0_3)
	local L1_4
	A0_3 = A0_3 or ""
	L1_4 = Application
	L1_4 = L1_4.base_path
	L1_4 = L1_4(L1_4)
	L1_4 = L1_4 .. "data\\lib\\utils\\dev\\ews\\images\\"
	if A0_3 ~= "" and EWS and not EWS:system_file_exists(L1_4 .. A0_3) then
		L1_4 = Application:base_path() .. "core\\lib\\core\\utils\\dev\\ews\\images\\"
	end
	return L1_4 .. A0_3
end
EWSConfirmDialog = EWSConfirmDialog or CoreClass.class()
function EWSConfirmDialog.init(A0_5, A1_6, A2_7)
	local L3_8, L4_9, L5_10, L6_11, L7_12, L8_13, L9_14, L10_15
	A0_5._yes = false
	A0_5._no = false
	A0_5._cancel = false
	L3_8 = EWS
	L4_9 = L3_8
	L3_8 = L3_8.Dialog
	L5_10 = nil
	L6_11 = A1_6
	L7_12 = ""
	L8_13 = Vector3
	L9_14 = 525
	L10_15 = 400
	L8_13 = L8_13(L9_14, L10_15, 0)
	L9_14 = Vector3
	L10_15 = 250
	L9_14 = L9_14(L10_15, 110, 0)
	L10_15 = "DEFAULT_DIALOG_STYLE"
	L3_8 = L3_8(L4_9, L5_10, L6_11, L7_12, L8_13, L9_14, L10_15)
	A0_5._dialog = L3_8
	L3_8 = EWS
	L4_9 = L3_8
	L3_8 = L3_8.BoxSizer
	L5_10 = "HORIZONTAL"
	L3_8 = L3_8(L4_9, L5_10)
	L4_9 = A0_5._dialog
	L5_10 = L4_9
	L4_9 = L4_9.set_sizer
	L6_11 = L3_8
	L4_9(L5_10, L6_11)
	L4_9 = EWS
	L5_10 = L4_9
	L4_9 = L4_9.Panel
	L6_11 = A0_5._dialog
	L7_12 = ""
	L8_13 = ""
	L4_9 = L4_9(L5_10, L6_11, L7_12, L8_13)
	L5_10 = EWS
	L6_11 = L5_10
	L5_10 = L5_10.BoxSizer
	L7_12 = "VERTICAL"
	L5_10 = L5_10(L6_11, L7_12)
	L7_12 = L4_9
	L6_11 = L4_9.set_sizer
	L8_13 = L5_10
	L6_11(L7_12, L8_13)
	L6_11 = EWS
	L7_12 = L6_11
	L6_11 = L6_11.StaticText
	L8_13 = L4_9
	L9_14 = A2_7
	L10_15 = ""
	L6_11 = L6_11(L7_12, L8_13, L9_14, L10_15, "ALIGN_CENTRE")
	L8_13 = L5_10
	L7_12 = L5_10.add
	L9_14 = L6_11
	L10_15 = 0
	L7_12(L8_13, L9_14, L10_15, 20, "EXPAND,TOP,BOTTOM")
	L7_12 = EWS
	L8_13 = L7_12
	L7_12 = L7_12.BoxSizer
	L9_14 = "HORIZONTAL"
	L7_12 = L7_12(L8_13, L9_14)
	L8_13 = EWS
	L9_14 = L8_13
	L8_13 = L8_13.Button
	L10_15 = L4_9
	L8_13 = L8_13(L9_14, L10_15, "Yes", "", "BU_BOTTOM")
	L10_15 = L7_12
	L9_14 = L7_12.add
	L9_14(L10_15, L8_13, 0, 2, "RIGHT,LEFT")
	L10_15 = L8_13
	L9_14 = L8_13.connect
	L9_14(L10_15, "EVT_COMMAND_BUTTON_CLICKED", callback(A0_5, A0_5, "set_value"), "_yes")
	L9_14 = EWS
	L10_15 = L9_14
	L9_14 = L9_14.Button
	L9_14 = L9_14(L10_15, L4_9, "No", "", "")
	L10_15 = L7_12.add
	L10_15(L7_12, L9_14, 0, 2, "RIGHT,LEFT")
	L10_15 = L9_14.connect
	L10_15(L9_14, "EVT_COMMAND_BUTTON_CLICKED", callback(A0_5, A0_5, "set_value"), "_no")
	L10_15 = EWS
	L10_15 = L10_15.Button
	L10_15 = L10_15(L10_15, L4_9, "Cancel", "", "")
	L7_12:add(L10_15, 0, 2, "RIGHT,LEFT")
	L10_15:connect("EVT_COMMAND_BUTTON_CLICKED", callback(A0_5, A0_5, "set_value"), "_cancel")
	L5_10:add(L7_12, 1, 0, "EXPAND")
	L3_8:add(L5_10, 1, 0, "EXPAND")
	L4_9:fit()
end
function EWSConfirmDialog.show_modal(A0_16)
	A0_16._dialog:show_modal()
	return true
end
function EWSConfirmDialog.set_value(A0_17, A1_18)
	A0_17[A1_18] = true
	A0_17._dialog:end_modal()
end
function EWSConfirmDialog.yes(A0_19)
	local L1_20
	L1_20 = A0_19._yes
	return L1_20
end
function EWSConfirmDialog.no(A0_21)
	local L1_22
	L1_22 = A0_21._no
	return L1_22
end
function EWSConfirmDialog.cancel(A0_23)
	local L1_24
	L1_24 = A0_23._cancel
	return L1_24
end
LocalizerTextCtrl = LocalizerTextCtrl or CoreClass.class()
function LocalizerTextCtrl.init(A0_25, A1_26, A2_27, A3_28)
	A0_25._text_ctrlr = EWS:TextCtrl(A1_26, Localizer:lookup(A3_28), "", "TE_CENTRE,TE_READONLY")
	A2_27:add(A0_25._text_ctrlr, 1, 0, "EXPAND")
end
function LocalizerTextCtrl.get(A0_29)
	local L1_30
	L1_30 = A0_29._text_ctrlr
	return L1_30
end
function LocalizerTextCtrl.get_value(A0_31)
	return A0_31._text_ctrlr:get_value()
end
function LocalizerTextCtrl.set_value(A0_32, A1_33)
	local L3_34
	L3_34 = A0_32._text_ctrlr
	L3_34 = L3_34.set_value
	return L3_34(L3_34, Localizer:lookup(A1_33))
end
EWSRadioBitmapButton = EWSRadioBitmapButton or CoreClass.class()
function EWSRadioBitmapButton.init(A0_35, A1_36, A2_37, A3_38, A4_39)
	A0_35._on_bmp = A2_37
	A0_35._off_bmp = A2_37
	A0_35._button = EWS:BitmapButton(A1_36, A2_37, "", "")
	A0_35._value = true
end
function EWSRadioBitmapButton.button(A0_40)
	local L1_41
	L1_41 = A0_40._button
	return L1_41
end
function EWSRadioBitmapButton.set_on_bmp(A0_42, A1_43)
	A0_42._on_bmp = A1_43
end
function EWSRadioBitmapButton.set_off_bmp(A0_44, A1_45)
	A0_44._off_bmp = A1_45
end
function EWSRadioBitmapButton.set_value(A0_46, A1_47)
	A0_46._value = A1_47
	if A1_47 then
		A0_46._button:set_label_bitmap(A0_46._on_bmp)
	else
		A0_46._button:set_label_bitmap(A0_46._off_bmp)
	end
end
function EWSRadioBitmapButton.value(A0_48)
	local L1_49
	L1_49 = A0_48._value
	return L1_49
end
EwsTextDialog = EwsTextDialog or CoreClass.class()
function EwsTextDialog.init(A0_50, A1_51, A2_52)
	local L3_53, L4_54, L5_55, L6_56
	A2_52 = A2_52 or "new"
	L3_53 = EWS
	L4_54 = L3_53
	L3_53 = L3_53.Dialog
	L5_55 = nil
	L6_56 = A1_51
	L3_53 = L3_53(L4_54, L5_55, L6_56, "", Vector3(525, 400, 0), Vector3(230, 150, 0), "CAPTION,CLOSE_BOX")
	A0_50._dialog = L3_53
	L3_53 = A0_50._dialog
	L4_54 = L3_53
	L3_53 = L3_53.set_background_colour
	L5_55 = "LIGHT GREY"
	L3_53(L4_54, L5_55)
	L3_53 = EWS
	L4_54 = L3_53
	L3_53 = L3_53.StaticBoxSizer
	L5_55 = A0_50._dialog
	L6_56 = "VERTICAL"
	L3_53 = L3_53(L4_54, L5_55, L6_56)
	L4_54 = A0_50._dialog
	L5_55 = L4_54
	L4_54 = L4_54.set_sizer
	L6_56 = L3_53
	L4_54(L5_55, L6_56)
	L4_54 = EWS
	L5_55 = L4_54
	L4_54 = L4_54.TextCtrl
	L6_56 = A0_50._dialog
	L4_54 = L4_54(L5_55, L6_56, A2_52, "", "TE_CENTRE")
	A0_50._text = L4_54
	L5_55 = L3_53
	L4_54 = L3_53.add
	L6_56 = A0_50._text
	L4_54(L5_55, L6_56, 0, 0, "EXPAND")
	L4_54 = EWS
	L5_55 = L4_54
	L4_54 = L4_54.BoxSizer
	L6_56 = "HORIZONTAL"
	L4_54 = L4_54(L5_55, L6_56)
	L5_55 = EWS
	L6_56 = L5_55
	L5_55 = L5_55.Button
	L5_55 = L5_55(L6_56, A0_50._dialog, "Ok", "", "BU_EXACTFIT,NO_BORDER")
	L6_56 = L4_54.add
	L6_56(L4_54, L5_55, 0, 0, "EXPAND")
	L6_56 = L5_55.connect
	L6_56(L5_55, "EVT_COMMAND_BUTTON_CLICKED", callback(A0_50, A0_50, "close"), {
		dialog = A0_50._dialog,
		cancel = false
	})
	L6_56 = EWS
	L6_56 = L6_56.Button
	L6_56 = L6_56(L6_56, A0_50._dialog, "Cancel", "", "BU_EXACTFIT,NO_BORDER")
	L4_54:add(L6_56, 0, 0, "EXPAND")
	L6_56:connect("EVT_COMMAND_BUTTON_CLICKED", callback(A0_50, A0_50, "close"), {
		dialog = A0_50._dialog,
		cancel = true
	})
	L3_53:add(L4_54, 0, 0, "ALIGN_RIGHT")
end
function EwsTextDialog.close(A0_57, A1_58)
	A1_58.dialog:end_modal()
	A0_57._cancel_dialog = A1_58.cancel
end
function EwsTextDialog.cancel_dialog(A0_59)
	local L1_60
	L1_60 = A0_59._cancel_dialog
	return L1_60
end
function EwsTextDialog.dialog(A0_61)
	local L1_62
	L1_62 = A0_61._dialog
	return L1_62
end
function EwsTextDialog.text(A0_63)
	local L1_64
	L1_64 = A0_63._text
	return L1_64
end
