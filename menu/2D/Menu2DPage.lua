Menu2DPage = Menu2DPage or class()
function Menu2DPage.init(A0_0, A1_1, A2_2)
	A0_0._transition_active = false
	A0_0._root_panel = A2_2
	A0_0:parse(A1_1)
end
function Menu2DPage.post_init(A0_3)
	local L1_4
end
function Menu2DPage.parse(A0_5, A1_6)
	A0_5._no_page_title_gradient = toboolean(A1_6:parameter("no_page_title"))
	A0_5._name = A1_6:parameter("name")
end
function Menu2DPage.can_go_back(A0_7)
	local L1_8
	return L1_8
end
function Menu2DPage.confirm_mode(A0_9)
	local L1_10
	L1_10 = "confirm"
	return L1_10
end
function Menu2DPage.no_page_title_gradient(A0_11)
	local L1_12
	L1_12 = A0_11._no_page_title_gradient
	return L1_12
end
function Menu2DPage.continue_back(A0_13)
	local L1_14
	L1_14 = A0_13._continue_back
	return L1_14
end
function Menu2DPage.update(A0_15, A1_16)
	if A0_15:_transition() then
		A0_15:_transition_end()
	end
end
function Menu2DPage.input(A0_17, A1_18, A2_19)
end
function Menu2DPage.show(A0_20)
	A0_20._root_panel:show()
	A0_20._menu_active = true
end
function Menu2DPage.hide(A0_21)
	A0_21._root_panel:hide()
	A0_21._menu_active = false
end
function Menu2DPage.open(A0_22, A1_23, A2_24, A3_25)
	A0_22._panel = A0_22._root_panel:panel(A1_23)
	A0_22._panel:set_layer(A3_25 or 0)
	A0_22._layer = A3_25
end
function Menu2DPage.set_root_panel(A0_26, A1_27)
	A0_26._root_panel = A1_27
end
function Menu2DPage.reopen(A0_28, A1_29, A2_30)
	A0_28._panel = A1_29:panel({})
	A0_28:open(A2_30, true, A0_28._layer)
end
function Menu2DPage.close(A0_31)
	A0_31:destroy()
end
function Menu2DPage.destroy(A0_32)
	A0_32._root_panel:remove(A0_32._panel)
end
function Menu2DPage.set_transition(A0_33, A1_34)
	A0_33._transition_active = true
	A0_33._frames = 0
	A0_33._transition_forward = A1_34
end
function Menu2DPage._transition(A0_35)
	local L1_36
	L1_36 = A0_35._transition_active
	return L1_36
end
function Menu2DPage._transition_end(A0_37)
	local L1_38
	A0_37._transition_active = false
end
function Menu2DPage.transition_active(A0_39)
	local L1_40
	L1_40 = A0_39._transition_active
	return L1_40
end
function Menu2DPage.advance(A0_41)
	local L1_42
end
function Menu2DPage.set_text(A0_43, A1_44)
	A0_43._text = ""
end
function Menu2DPage.name(A0_45)
	return A0_45._name or ""
end
