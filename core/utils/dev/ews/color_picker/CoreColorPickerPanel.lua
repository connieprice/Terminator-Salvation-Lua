core:module("CoreColorPickerPanel")
core:require_module("CoreClass")
core:require_module("CoreEvent")
core:require_module("CoreColorPickerDraggables")
core:require_module("CoreColorPickerFields")
if not ColorPickerPanel then
	ColorPickerPanel = CoreClass.mixin(CoreClass.class(), CoreEvent.BasicEventHandling)
end
ColorPickerPanel.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	local l_1_5 = assert
	l_1_5(l_1_3 == "HORIZONTAL" or l_1_3 == "VERTICAL")
	l_1_5(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
end

ColorPickerPanel.panel = function(l_2_0)
	return l_2_0._panel
end

ColorPickerPanel.color = function(l_3_0)
	local l_3_1, l_3_2 = l_3_0._fields:color, l_3_0._fields
	return l_3_1(l_3_2)
end

ColorPickerPanel.set_color = function(l_4_0, l_4_1)
	l_4_0._draggables:set_color(l_4_1)
	l_4_0._fields:set_color(l_4_1)
end

ColorPickerPanel.update = function(l_5_0, l_5_1, l_5_2)
	l_5_0._draggables:update(l_5_1, l_5_2)
	l_5_0._fields:update(l_5_1, l_5_2)
end

ColorPickerPanel._create_panel = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4)
	l_6_0._panel = EWS:Panel(l_6_1)
	local l_6_5 = EWS:BoxSizer(l_6_3)
	l_6_0._panel:set_sizer(l_6_5)
	l_6_0._draggables = CoreColorPickerDraggables.ColorPickerDraggables:new(l_6_0._panel, l_6_2, l_6_4)
	l_6_0._fields = CoreColorPickerFields.ColorPickerFields:new(l_6_0._panel, l_6_2, l_6_4)
	l_6_0._draggables:connect("EVT_COLOR_UPDATED", CoreEvent.callback(l_6_0, l_6_0, "_on_color_updated"), l_6_0._draggables)
	l_6_0._fields:connect("EVT_COLOR_UPDATED", CoreEvent.callback(l_6_0, l_6_0, "_on_color_updated"), l_6_0._fields)
	l_6_0._draggables:connect("EVT_COLOR_CHANGED", CoreEvent.callback(l_6_0, l_6_0, "_on_color_changed"), l_6_0._draggables)
	l_6_0._fields:connect("EVT_COLOR_CHANGED", CoreEvent.callback(l_6_0, l_6_0, "_on_color_changed"), l_6_0._fields)
	l_6_5:add(l_6_0._draggables:panel(), 0, 0, "EXPAND")
	l_6_5:add(l_6_0._fields:panel(), 1, 0, "EXPAND")
end

ColorPickerPanel._on_color_updated = function(l_7_0, l_7_1, l_7_2)
	local l_7_3 = table.exclude
	local l_7_4 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_3(l_7_4, l_7_2)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_3(l_7_4, "EVT_COLOR_UPDATED", l_7_0._fields)
end

ColorPickerPanel._on_color_changed = function(l_8_0, l_8_1, l_8_2)
	l_8_0:_send_event("EVT_COLOR_CHANGED", l_8_2)
end


