Menu2DWidgetBase = Menu2DWidgetBase or class()
Menu2DWidgetBase._tile_size = 64
function Menu2DWidgetBase.init(A0_0, A1_1)
	A0_0._params = A1_1
	A0_0:parse(A1_1)
end
function Menu2DWidgetBase.post_init(A0_2, A1_3)
end
function Menu2DWidgetBase.update(A0_4, A1_5)
end
function Menu2DWidgetBase.parse(A0_6, A1_7)
end
function Menu2DWidgetBase.create_gui(A0_8)
	local L1_9
	A0_8._created_gui = true
end
function Menu2DWidgetBase.set_active(A0_10)
	local L1_11
end
function Menu2DWidgetBase.set_inactive(A0_12)
	local L1_13
end
function Menu2DWidgetBase.activate(A0_14)
	local L1_15
end
function Menu2DWidgetBase.show(A0_16, A1_17, A2_18)
	A0_16._root_panel = A1_17
	A0_16._params.panel = A2_18
	A0_16:create_gui()
end
function Menu2DWidgetBase.hide(A0_19)
	A0_19._params.panel:hide()
end
function Menu2DWidgetBase.destroy(A0_20)
	local L1_21
end
function Menu2DWidgetBase.animate(A0_22, A1_23, A2_24)
end
function Menu2DWidgetBase.selection_changed(A0_25)
	local L1_26
end
