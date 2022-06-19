core:module("CoreColorPickerDialog")
core:require_module("CoreClass")
core:require_module("CoreEvent")
core:require_module("CoreEws")
core:require_module("CoreColorPickerPanel")
ColorPickerDialog = ColorPickerDialog or CoreClass.mixin(CoreClass.class(), CoreEvent.BasicEventHandling)
ColorPickerDialog.EDITOR_TITLE = "Color Picker"
function ColorPickerDialog.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	local L5_5, L6_6
	A3_3 = A3_3 or "HORIZONTAL"
	L5_5 = assert
	L6_6 = A3_3 == "HORIZONTAL" or A3_3 == "VERTICAL"
	L5_5(L6_6, "Invalid orientation.")
	if A3_3 == "HORIZONTAL" then
		L5_5 = Vector3
		L6_6 = 366
		L5_5 = L5_5(L6_6, 166)
	elseif not L5_5 then
		L5_5 = Vector3
		L6_6 = 186
		L5_5 = L5_5(L6_6, 300, 0)
	end
	L6_6 = EWS
	L6_6 = L6_6.Frame
	L6_6 = L6_6(L6_6, ColorPickerDialog.EDITOR_TITLE, Vector3(-1, -1, 0), L5_5, "SYSTEM_MENU,CAPTION,CLOSE_BOX,CLIP_CHILDREN", A1_1)
	A0_0._window = L6_6
	L6_6 = EWS
	L6_6 = L6_6.BoxSizer
	L6_6 = L6_6(L6_6, "HORIZONTAL")
	A0_0._window:set_sizer(L6_6)
	A0_0._window:set_icon(CoreEws.image_path("toolbar/color_16x16.png"))
	A0_0._window:connect("", "EVT_CLOSE_WINDOW", CoreEvent.callback(A0_0, A0_0, "_on_close"), "")
	A0_0._picker_panel = CoreColorPickerPanel.ColorPickerPanel:new(A0_0._window, A2_2, A3_3, A4_4)
	A0_0._picker_panel:connect("EVT_COLOR_UPDATED", CoreEvent.callback(A0_0, A0_0, "_on_color_updated"), A0_0._picker_panel)
	A0_0._picker_panel:connect("EVT_COLOR_CHANGED", CoreEvent.callback(A0_0, A0_0, "_on_color_changed"), A0_0._picker_panel)
	L6_6:add(A0_0._picker_panel:panel(), 0, 0, "EXPAND")
	A0_0:set_visible(true)
end
function ColorPickerDialog.update(A0_7, A1_8, A2_9)
	A0_7._picker_panel:update(A1_8, A2_9)
end
function ColorPickerDialog.color(A0_10)
	return A0_10._picker_panel:color()
end
function ColorPickerDialog.set_color(A0_11, A1_12)
	A0_11._picker_panel:set_color(A1_12)
end
function ColorPickerDialog.set_position(A0_13, A1_14)
	A0_13._window:set_position(A1_14)
end
function ColorPickerDialog.set_visible(A0_15, A1_16)
	A0_15._window:set_visible(A1_16)
end
function ColorPickerDialog.center(A0_17, A1_18)
	A0_17._window:set_position(A1_18:get_position() + A1_18:get_size() * 0.5 - A0_17._window:get_size() * 0.5)
end
function ColorPickerDialog.close(A0_19)
	A0_19._window:destroy()
end
function ColorPickerDialog._on_color_updated(A0_20, A1_21, A2_22)
	A0_20:_send_event("EVT_COLOR_UPDATED", A2_22)
end
function ColorPickerDialog._on_color_changed(A0_23, A1_24, A2_25)
	A0_23:_send_event("EVT_COLOR_CHANGED", A2_25)
end
function ColorPickerDialog._on_close(A0_26)
	A0_26._window:set_visible(false)
	A0_26:_send_event("EVT_CLOSE_WINDOW", A0_26._window)
	managers.toolhub:close(ColorPickerDialog.EDITOR_TITLE)
end
