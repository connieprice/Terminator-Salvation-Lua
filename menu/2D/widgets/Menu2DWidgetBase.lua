if not Menu2DWidgetBase then
	Menu2DWidgetBase = class()
end
Menu2DWidgetBase._tile_size = 64
Menu2DWidgetBase.init = function(l_1_0, l_1_1)
	l_1_0._params = l_1_1
	l_1_0:parse(l_1_1)
end

Menu2DWidgetBase.post_init = function(l_2_0, l_2_1)
end

Menu2DWidgetBase.update = function(l_3_0, l_3_1)
end

Menu2DWidgetBase.parse = function(l_4_0, l_4_1)
end

Menu2DWidgetBase.create_gui = function(l_5_0)
	l_5_0._created_gui = true
end

Menu2DWidgetBase.set_active = function(l_6_0)
end

Menu2DWidgetBase.set_inactive = function(l_7_0)
end

Menu2DWidgetBase.activate = function(l_8_0)
end

Menu2DWidgetBase.show = function(l_9_0, l_9_1, l_9_2)
	l_9_0._root_panel = l_9_1
	l_9_0._params.panel = l_9_2
	l_9_0:create_gui()
end

Menu2DWidgetBase.hide = function(l_10_0)
	l_10_0._params.panel:hide()
end

Menu2DWidgetBase.destroy = function(l_11_0)
end

Menu2DWidgetBase.animate = function(l_12_0, l_12_1, l_12_2)
end

Menu2DWidgetBase.selection_changed = function(l_13_0)
end


