core:module("CoreEws")
core:require_module("CoreClass")
verify_number = function(l_1_0, l_1_1)
	if EWS:name_to_key_code("K_BACK") == l_1_1:key_code() or ((l_1_1:key_code() >= 48 and l_1_1:key_code() <= 57) or EWS:name_to_key_code("K_DELETE") == l_1_1:key_code()) then
		if l_1_1:key_code() == 46 then
			local l_1_2 = l_1_0:get_value() .. "."
			if not tonumber(l_1_2) then
				return 
			end
		end
		l_1_1:skip()
	end
end

image_path = function(l_2_0)
	if not l_2_0 then
		l_2_0 = ""
	end
	local l_2_1 = Application:base_path() .. "data\\lib\\utils\\dev\\ews\\images\\"
	if l_2_0 ~= "" and EWS and not EWS:system_file_exists(l_2_1 .. l_2_0) then
		l_2_1 = Application:base_path() .. "core\\lib\\core\\utils\\dev\\ews\\images\\"
	end
	return l_2_1 .. l_2_0
end

if not EWSConfirmDialog then
	EWSConfirmDialog = CoreClass.class()
end
EWSConfirmDialog.init = function(l_3_0, l_3_1, l_3_2)
	l_3_0._yes = false
	l_3_0._no = false
	l_3_0._cancel = false
	l_3_0._dialog = EWS:Dialog(nil, l_3_1, "", Vector3(525, 400, 0), Vector3(250, 110, 0), "DEFAULT_DIALOG_STYLE")
	local l_3_3 = EWS:BoxSizer("HORIZONTAL")
	l_3_0._dialog:set_sizer(l_3_3)
	local l_3_4 = EWS:Panel(l_3_0._dialog, "", "")
	local l_3_5 = EWS:BoxSizer("VERTICAL")
	l_3_4:set_sizer(l_3_5)
	local l_3_6 = EWS:StaticText(l_3_4, l_3_2, "", "ALIGN_CENTRE")
	l_3_5:add(l_3_6, 0, 20, "EXPAND,TOP,BOTTOM")
	local l_3_7 = EWS:BoxSizer("HORIZONTAL")
	local l_3_8 = EWS:Button(l_3_4, "Yes", "", "BU_BOTTOM")
	l_3_7:add(l_3_8, 0, 2, "RIGHT,LEFT")
	l_3_8:connect("EVT_COMMAND_BUTTON_CLICKED", callback(l_3_0, l_3_0, "set_value"), "_yes")
	local l_3_9 = EWS:Button(l_3_4, "No", "", "")
	l_3_7:add(l_3_9, 0, 2, "RIGHT,LEFT")
	l_3_9:connect("EVT_COMMAND_BUTTON_CLICKED", callback(l_3_0, l_3_0, "set_value"), "_no")
	local l_3_10 = EWS:Button(l_3_4, "Cancel", "", "")
	l_3_7:add(l_3_10, 0, 2, "RIGHT,LEFT")
	l_3_10:connect("EVT_COMMAND_BUTTON_CLICKED", callback(l_3_0, l_3_0, "set_value"), "_cancel")
	l_3_5:add(l_3_7, 1, 0, "EXPAND")
	l_3_3:add(l_3_5, 1, 0, "EXPAND")
	l_3_4:fit()
end

EWSConfirmDialog.show_modal = function(l_4_0)
	l_4_0._dialog:show_modal()
	return true
end

EWSConfirmDialog.set_value = function(l_5_0, l_5_1)
	l_5_0[l_5_1] = true
	l_5_0._dialog:end_modal()
end

EWSConfirmDialog.yes = function(l_6_0)
	return l_6_0._yes
end

EWSConfirmDialog.no = function(l_7_0)
	return l_7_0._no
end

EWSConfirmDialog.cancel = function(l_8_0)
	return l_8_0._cancel
end

if not LocalizerTextCtrl then
	LocalizerTextCtrl = CoreClass.class()
end
LocalizerTextCtrl.init = function(l_9_0, l_9_1, l_9_2, l_9_3)
	l_9_0._text_ctrlr = EWS:TextCtrl(l_9_1, Localizer:lookup(l_9_3), "", "TE_CENTRE,TE_READONLY")
	l_9_2:add(l_9_0._text_ctrlr, 1, 0, "EXPAND")
end

LocalizerTextCtrl.get = function(l_10_0)
	return l_10_0._text_ctrlr
end

LocalizerTextCtrl.get_value = function(l_11_0)
	local l_11_1, l_11_2 = l_11_0._text_ctrlr:get_value, l_11_0._text_ctrlr
	return l_11_1(l_11_2)
end

LocalizerTextCtrl.set_value = function(l_12_0, l_12_1)
	local l_12_2, l_12_3 = l_12_0._text_ctrlr:set_value, l_12_0._text_ctrlr
	local l_12_4, l_12_5, l_12_6 = Localizer:lookup(l_12_1), .end
	return l_12_2(l_12_3, l_12_4, l_12_5, l_12_6)
end

if not EWSRadioBitmapButton then
	EWSRadioBitmapButton = CoreClass.class()
end
EWSRadioBitmapButton.init = function(l_13_0, l_13_1, l_13_2, l_13_3, l_13_4)
	l_13_0._on_bmp = l_13_2
	l_13_0._off_bmp = l_13_2
	l_13_0._button = EWS:BitmapButton(l_13_1, l_13_2, "", "")
	l_13_0._value = true
end

EWSRadioBitmapButton.button = function(l_14_0)
	return l_14_0._button
end

EWSRadioBitmapButton.set_on_bmp = function(l_15_0, l_15_1)
	l_15_0._on_bmp = l_15_1
end

EWSRadioBitmapButton.set_off_bmp = function(l_16_0, l_16_1)
	l_16_0._off_bmp = l_16_1
end

EWSRadioBitmapButton.set_value = function(l_17_0, l_17_1)
	l_17_0._value = l_17_1
	if l_17_1 then
		l_17_0._button:set_label_bitmap(l_17_0._on_bmp)
	else
		l_17_0._button:set_label_bitmap(l_17_0._off_bmp)
	end
end

EWSRadioBitmapButton.value = function(l_18_0)
	return l_18_0._value
end

if not EwsTextDialog then
	EwsTextDialog = CoreClass.class()
end
EwsTextDialog.init = function(l_19_0, l_19_1, l_19_2)
	if not l_19_2 then
		l_19_2 = "new"
	end
	l_19_0._dialog = EWS:Dialog(nil, l_19_1, "", Vector3(525, 400, 0), Vector3(230, 150, 0), "CAPTION,CLOSE_BOX")
	l_19_0._dialog:set_background_colour("LIGHT GREY")
	local l_19_3 = EWS:StaticBoxSizer(l_19_0._dialog, "VERTICAL")
	l_19_0._dialog:set_sizer(l_19_3)
	l_19_0._text = EWS:TextCtrl(l_19_0._dialog, l_19_2, "", "TE_CENTRE")
	l_19_3:add(l_19_0._text, 0, 0, "EXPAND")
	local l_19_4 = EWS:BoxSizer("HORIZONTAL")
	local l_19_5 = EWS:Button(l_19_0._dialog, "Ok", "", "BU_EXACTFIT,NO_BORDER")
	l_19_4:add(l_19_5, 0, 0, "EXPAND")
	local l_19_6, l_19_7 = l_19_5:connect, l_19_5
	local l_19_8 = "EVT_COMMAND_BUTTON_CLICKED"
	local l_19_9 = callback(l_19_0, l_19_0, "close")
	local l_19_10 = {}
	l_19_10.dialog = l_19_0._dialog
	l_19_10.cancel = false
	l_19_6(l_19_7, l_19_8, l_19_9, l_19_10)
	l_19_6 = EWS
	l_19_6, l_19_7 = l_19_6:Button, l_19_6
	l_19_8 = l_19_0._dialog
	l_19_9 = "Cancel"
	l_19_10 = ""
	l_19_6 = l_19_6(l_19_7, l_19_8, l_19_9, l_19_10, "BU_EXACTFIT,NO_BORDER")
	l_19_7, l_19_8 = l_19_4:add, l_19_4
	l_19_9 = l_19_6
	l_19_10 = 0
	l_19_7(l_19_8, l_19_9, l_19_10, 0, "EXPAND")
	l_19_7, l_19_8 = l_19_6:connect, l_19_6
	l_19_9 = "EVT_COMMAND_BUTTON_CLICKED"
	l_19_10 = callback
	l_19_10 = l_19_10(l_19_0, l_19_0, "close")
	local l_19_11 = {}
	l_19_11.dialog = l_19_0._dialog
	l_19_11.cancel = true
	l_19_7(l_19_8, l_19_9, l_19_10, l_19_11)
	l_19_7, l_19_8 = l_19_3:add, l_19_3
	l_19_9 = l_19_4
	l_19_10 = 0
	l_19_11 = 0
	l_19_7(l_19_8, l_19_9, l_19_10, l_19_11, "ALIGN_RIGHT")
end

EwsTextDialog.close = function(l_20_0, l_20_1)
	l_20_1.dialog:end_modal()
	l_20_0._cancel_dialog = l_20_1.cancel
end

EwsTextDialog.cancel_dialog = function(l_21_0)
	return l_21_0._cancel_dialog
end

EwsTextDialog.dialog = function(l_22_0)
	return l_22_0._dialog
end

EwsTextDialog.text = function(l_23_0)
	return l_23_0._text
end


