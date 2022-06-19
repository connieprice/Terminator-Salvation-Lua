require("menu/2D/widgets/Menu2DWidgets")
Menu2DChoice = Menu2DChoice or class()
function Menu2DChoice.init(A0_0, A1_1)
	Menu2DChoice._widget_types = {
		volume = Menu2DWidgetVolume,
		checkbutton = Menu2DWidgetCheckButton,
		bitmap = Menu2DWidgetBitmap,
		level = Menu2DWidgetLevel,
		spin = Menu2DWidgetSpinControl
	}
	A0_0._params = {}
	if A1_1 then
		A0_0:parse(A1_1)
	end
end
function Menu2DChoice.post_init(A0_2)
	if A0_2._widget then
		A0_2._widget:post_init()
	end
end
function Menu2DChoice.parse(A0_3, A1_4)
	local L2_5, L3_6, L4_7, L5_8, L6_9, L7_10
	L2_5 = A1_4.parameter_map
	L2_5 = L2_5(L3_6)
	for L6_9, L7_10 in L3_6(L4_7) do
		A0_3:set_param(L6_9, L7_10)
	end
	if L3_6 > 0 then
		if L4_7 then
			L7_10 = A1_4
			L6_9 = A1_4.child
			L6_9 = L6_9(L7_10, 0)
			L7_10 = L6_9
			L6_9 = L6_9.parameter_map
			L7_10 = L6_9(L7_10)
			A0_3._widget = L4_7
		else
			L6_9 = "widget type not defined '"
			L7_10 = tostring
			L7_10 = L7_10(L3_6)
			L6_9 = L6_9 .. L7_10 .. "'"
			L4_7(L5_8, L6_9)
		end
	end
end
function Menu2DChoice.set_active(A0_11, A1_12)
	if A0_11._widget then
		A0_11._widget:set_active(A1_12)
	end
end
function Menu2DChoice.set_inactive(A0_13, A1_14)
	if A0_13._widget then
		A0_13._widget:set_inactive(A1_14)
	end
end
function Menu2DChoice.activate(A0_15)
	A0_15:_activate()
end
function Menu2DChoice._activate(A0_16)
	local L1_17, L2_18, L3_19, L4_20
	L1_17 = A0_16._widget
	if L1_17 then
		L1_17 = A0_16._widget
		L2_18 = L1_17
		L1_17 = L1_17.activate
		L1_17(L2_18)
	end
	L1_17 = false
	L2_18 = A0_16._params
	L2_18 = L2_18.code
	if L2_18 then
		L2_18 = loadstring
		L3_19 = "return "
		L4_20 = A0_16._params
		L4_20 = L4_20.code
		L3_19 = L3_19 .. L4_20
		L3_19 = L2_18(L3_19)
		L4_20 = L2_18
		L4_20 = L4_20()
		if type(L4_20) == "function" then
			L4_20(A0_16._params)
			L1_17 = true
		end
	end
	L2_18 = A0_16._params
	L2_18 = L2_18.event
	if L2_18 then
		L2_18 = managers
		L2_18 = L2_18.menu2d
		L3_19 = L2_18
		L2_18 = L2_18.raise_event
		L4_20 = A0_16._params
		L4_20 = L4_20.event
		L2_18(L3_19, L4_20, A0_16._params)
		L1_17 = true
	end
	L2_18 = A0_16._params
	L2_18 = L2_18.execute_event_on_hold
	if L2_18 then
		L2_18 = managers
		L2_18 = L2_18.menu2d
		L3_19 = L2_18
		L2_18 = L2_18.execute_event_on_hold
		L2_18(L3_19)
		L1_17 = true
	end
	L2_18 = A0_16._params
	L2_18 = L2_18.set_event_on_hold
	if L2_18 then
		L2_18 = managers
		L2_18 = L2_18.menu2d
		L3_19 = L2_18
		L2_18 = L2_18.set_event_on_hold
		L4_20 = A0_16._params
		L4_20 = L4_20.set_event_on_hold
		L2_18(L3_19, L4_20, A0_16._params)
		L1_17 = true
	end
	L3_19 = A0_16
	L2_18 = A0_16.goto
	L2_18 = L2_18(L3_19)
	if L2_18 then
		L2_18 = managers
		L2_18 = L2_18.menu2d
		L3_19 = L2_18
		L2_18 = L2_18.change_page
		L4_20 = A0_16.goto
		L4_20 = L4_20(A0_16)
		L2_18(L3_19, L4_20, A0_16._params.text)
		L1_17 = true
	end
	if L1_17 then
		L2_18 = managers
		L2_18 = L2_18.menu2d
		L3_19 = L2_18
		L2_18 = L2_18.sound
		L2_18 = L2_18(L3_19)
		L3_19 = L2_18
		L2_18 = L2_18.play
		L4_20 = "menu_select"
		L2_18(L3_19, L4_20)
	end
end
function Menu2DChoice.open_code(A0_21)
	local L1_22, L2_23, L3_24
	L1_22 = A0_21._params
	L1_22 = L1_22.open_code
	if L1_22 then
		L1_22 = loadstring
		L2_23 = "return "
		L3_24 = A0_21._open_code
		L2_23 = L2_23 .. L3_24
		L2_23 = L1_22(L2_23)
		L3_24 = L1_22
		L3_24 = L3_24()
		if type(L3_24) == "function" then
			L3_24(A0_21)
		end
	end
end
function Menu2DChoice.input(A0_25, ...)
	local L2_27, L3_28, L4_29
	L2_27 = A0_25._widget
	if L2_27 then
		L2_27 = A0_25._widget
		L2_27 = L2_27.input
		if L2_27 then
			L2_27 = A0_25._widget
			L3_28 = L2_27
			L2_27 = L2_27.input
			L4_29 = ...
			L2_27(L3_28, L4_29)
		end
	end
end
function Menu2DChoice.set_param(A0_30, A1_31, A2_32)
	A0_30._params[A1_31] = A2_32
end
function Menu2DChoice.set_widget(A0_33, A1_34)
	if A1_34.type and A0_33._widget_types[A1_34.type] then
		A0_33._widget = A0_33._widget_types[A1_34.type]:new(A1_34)
	end
end
function Menu2DChoice.destroy(A0_35)
	local L1_36
end
function Menu2DChoice.allowed(A0_37)
	local L1_38, L2_39
	L1_38 = managers
	L1_38 = L1_38.menu2d
	L2_39 = L1_38
	L1_38 = L1_38.state_flag
	L1_38 = L1_38(L2_39, "frontend")
	L1_38 = not L1_38
	if L1_38 then
		L2_39 = toboolean
		L2_39 = L2_39(A0_37._params.not_ingame)
	L1_38 = not L2_39 and true
	L2_39 = true
	if A0_37._params.only_primary_user and managers.menu_input:bound_user() ~= managers.save:primary_user() then
		L2_39 = false
	end
	return L1_38 and A0_37:conditional() and L2_39
end
function Menu2DChoice.text(A0_40)
	local L1_41
	L1_41 = A0_40._params
	L1_41 = L1_41.text
	if not A0_40._params.ignore_localization then
		return managers.localization:text(L1_41 or "")
	else
		return L1_41
	end
end
function Menu2DChoice.non_localized_text(A0_42)
	return A0_42._params.text
end
function Menu2DChoice.goto(A0_43)
	if A0_43._params.conditional_goto then
		return managers.menu2d:check_condition(A0_43._params.conditional_goto)
	else
		return A0_43._params.goto_page
	end
end
function Menu2DChoice.platform(A0_44)
	return A0_44._params.platform
end
function Menu2DChoice.name(A0_45)
	return A0_45._params.name
end
function Menu2DChoice.widget(A0_46)
	local L1_47
	L1_47 = A0_46._widget
	return L1_47
end
function Menu2DChoice.empty(A0_48)
	return toboolean(A0_48._params.empty)
end
function Menu2DChoice.conditional(A0_49)
	if A0_49._params.conditional then
		return (managers.menu2d:use_connection(A0_49._params.conditional))
	else
		return true
	end
end
