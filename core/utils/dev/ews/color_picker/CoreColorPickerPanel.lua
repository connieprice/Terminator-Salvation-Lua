core:module("CoreColorPickerPanel")
core:require_module("CoreClass")
core:require_module("CoreEvent")
core:require_module("CoreColorPickerDraggables")
core:require_module("CoreColorPickerFields")
ColorPickerPanel = ColorPickerPanel or CoreClass.mixin(CoreClass.class(), CoreEvent.BasicEventHandling)
function ColorPickerPanel.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	assert(A3_3 == "HORIZONTAL" or A3_3 == "VERTICAL")
	A0_0:_create_panel(A1_1, A2_2, A3_3, A4_4)
end
function ColorPickerPanel.panel(A0_5)
	local L1_6
	L1_6 = A0_5._panel
	return L1_6
end
function ColorPickerPanel.color(A0_7)
	return A0_7._fields:color()
end
function ColorPickerPanel.set_color(A0_8, A1_9)
	A0_8._draggables:set_color(A1_9)
	A0_8._fields:set_color(A1_9)
end
function ColorPickerPanel.update(A0_10, A1_11, A2_12)
	A0_10._draggables:update(A1_11, A2_12)
	A0_10._fields:update(A1_11, A2_12)
end
function ColorPickerPanel._create_panel(A0_13, A1_14, A2_15, A3_16, A4_17)
	local L5_18
	L5_18 = EWS
	L5_18 = L5_18.Panel
	L5_18 = L5_18(L5_18, A1_14)
	A0_13._panel = L5_18
	L5_18 = EWS
	L5_18 = L5_18.BoxSizer
	L5_18 = L5_18(L5_18, A3_16)
	A0_13._panel:set_sizer(L5_18)
	A0_13._draggables = CoreColorPickerDraggables.ColorPickerDraggables:new(A0_13._panel, A2_15, A4_17)
	A0_13._fields = CoreColorPickerFields.ColorPickerFields:new(A0_13._panel, A2_15, A4_17)
	A0_13._draggables:connect("EVT_COLOR_UPDATED", CoreEvent.callback(A0_13, A0_13, "_on_color_updated"), A0_13._draggables)
	A0_13._fields:connect("EVT_COLOR_UPDATED", CoreEvent.callback(A0_13, A0_13, "_on_color_updated"), A0_13._fields)
	A0_13._draggables:connect("EVT_COLOR_CHANGED", CoreEvent.callback(A0_13, A0_13, "_on_color_changed"), A0_13._draggables)
	A0_13._fields:connect("EVT_COLOR_CHANGED", CoreEvent.callback(A0_13, A0_13, "_on_color_changed"), A0_13._fields)
	L5_18:add(A0_13._draggables:panel(), 0, 0, "EXPAND")
	L5_18:add(A0_13._fields:panel(), 1, 0, "EXPAND")
end
function ColorPickerPanel._on_color_updated(A0_19, A1_20, A2_21)
	table.exclude({
		A0_19._draggables,
		A0_19._fields
	}, A1_20)[1]:set_color(A2_21)
	A0_19:_send_event("EVT_COLOR_UPDATED", A2_21)
end
function ColorPickerPanel._on_color_changed(A0_22, A1_23, A2_24)
	A0_22:_send_event("EVT_COLOR_CHANGED", A2_24)
end
