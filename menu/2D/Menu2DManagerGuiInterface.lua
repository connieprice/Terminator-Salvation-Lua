Menu2DManagerGuiInterface = Menu2DManagerGuiInterface or class()
function Menu2DManagerGuiInterface.init(A0_0, A1_1)
	A0_0._menu2d_manager = A1_1
end
function Menu2DManagerGuiInterface.set_state(A0_2, ...)
	local L3_4, L4_5
	L3_4 = A0_2._menu2d_manager
	L4_5 = L3_4
	L3_4 = L3_4.set_state
	L3_4(L4_5, ...)
end
function Menu2DManagerGuiInterface.set_dialog(A0_6, ...)
	local L3_8, L4_9
	L3_8 = A0_6._menu2d_manager
	L4_9 = L3_8
	L3_8 = L3_8.set_dialog
	L3_8(L4_9, ...)
end
function Menu2DManagerGuiInterface.remove_dialog(A0_10)
	A0_10._menu2d_manager:remove_dialog()
end
function Menu2DManagerGuiInterface.page_change_completed(A0_11)
	return A0_11._menu2d_manager:page_change_completed()
end
function Menu2DManagerGuiInterface.render(A0_12)
	A0_12._menu2d_manager:render()
end
function Menu2DManagerGuiInterface.sync_started(A0_13, A1_14)
	local L2_15
	L2_15 = A0_13._menu2d_manager
	L2_15 = L2_15._sync_state
	L2_15 = L2_15.sync_started
	return L2_15
end
function Menu2DManagerGuiInterface.sync_done(A0_16, A1_17)
	local L2_18
	L2_18 = A0_16._menu2d_manager
	L2_18 = L2_18._sync_state
	L2_18 = L2_18.sync_done
	return L2_18
end
