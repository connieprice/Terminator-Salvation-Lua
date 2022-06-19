require("menu/2D/widgets/Menu2DWidgets")
if not Menu2DChoice then
	Menu2DChoice = class()
end
Menu2DChoice.init = function(l_1_0, l_1_1)
	local l_1_2 = Menu2DChoice
	local l_1_3 = {}
	l_1_3.volume = Menu2DWidgetVolume
	l_1_3.checkbutton = Menu2DWidgetCheckButton
	l_1_3.bitmap = Menu2DWidgetBitmap
	l_1_3.level = Menu2DWidgetLevel
	l_1_3.spin = Menu2DWidgetSpinControl
	l_1_2._widget_types = l_1_3
	l_1_0._params, l_1_2 = l_1_2, {}
	if l_1_1 then
		l_1_2, l_1_3 = l_1_0:parse, l_1_0
		l_1_2(l_1_3, l_1_1)
	end
end

Menu2DChoice.post_init = function(l_2_0)
	if l_2_0._widget then
		l_2_0._widget:post_init()
	end
end

Menu2DChoice.parse = function(l_3_0, l_3_1)
	local l_3_6, l_3_7, l_3_8, l_3_9, l_3_10 = nil
	local l_3_2 = l_3_1:parameter_map()
	for i_0,i_1 in pairs(l_3_2) do
		l_3_0:set_param(i_0, i_1)
	end
	if l_3_1:num_children() > 0 then
		if l_3_0._widget_types[l_3_1:child(0):parameter("type")] then
			l_3_0._widget = l_3_0._widget_types[l_3_1:child(0):parameter("type")]:new(l_3_1:child(0):parameter_map())
		end
	else
		Application:error("widget type not defined '" .. tostring(l_3_1:child(0):parameter("type")) .. "'")
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

Menu2DChoice.set_active = function(l_4_0, l_4_1)
	if l_4_0._widget then
		l_4_0._widget:set_active(l_4_1)
	end
end

Menu2DChoice.set_inactive = function(l_5_0, l_5_1)
	if l_5_0._widget then
		l_5_0._widget:set_inactive(l_5_1)
	end
end

Menu2DChoice.activate = function(l_6_0)
	l_6_0:_activate()
end

Menu2DChoice._activate = function(l_7_0)
	if l_7_0._widget then
		l_7_0._widget:activate()
	end
	local l_7_1 = false
	if l_7_0._params.code then
		local l_7_2, l_7_3 = loadstring("return " .. l_7_0._params.code)
		local l_7_4 = l_7_2()
	if type(l_7_4) == "function" then
		end
		l_7_4(l_7_0._params)
		l_7_1 = true
	end
	if l_7_0._params.event then
		managers.menu2d:raise_event(l_7_0._params.event, l_7_0._params)
		l_7_1 = true
	end
	if l_7_0._params.execute_event_on_hold then
		managers.menu2d:execute_event_on_hold()
		l_7_1 = true
	end
	if l_7_0._params.set_event_on_hold then
		managers.menu2d:set_event_on_hold(l_7_0._params.set_event_on_hold, l_7_0._params)
		l_7_1 = true
	end
	if l_7_0:goto() then
		managers.menu2d:change_page(l_7_0:goto(), l_7_0._params.text)
		l_7_1 = true
	end
	if l_7_1 then
		managers.menu2d:sound():play("menu_select")
	end
end

Menu2DChoice.open_code = function(l_8_0)
	if l_8_0._params.open_code then
		local l_8_1, l_8_2 = loadstring("return " .. l_8_0._open_code)
		local l_8_3 = l_8_1()
	if type(l_8_3) == "function" then
		end
		l_8_3(l_8_0)
	end
end

Menu2DChoice.input = function(l_9_0, ...)
	if l_9_0._widget and l_9_0._widget.input then
		l_9_0._widget:input(...)
	end
end

Menu2DChoice.set_param = function(l_10_0, l_10_1, l_10_2)
	l_10_0._params[l_10_1] = l_10_2
end

Menu2DChoice.set_widget = function(l_11_0, l_11_1)
	if l_11_1.type and l_11_0._widget_types[l_11_1.type] then
		l_11_0._widget = l_11_0._widget_types[l_11_1.type]:new(l_11_1)
	end
end

Menu2DChoice.destroy = function(l_12_0)
end

Menu2DChoice.allowed = function(l_13_0)
	if not not managers.menu2d:state_flag("frontend") or not toboolean(l_13_0._params.not_ingame) then
		local l_13_1 = true
	else
		local l_13_2 = false
	end
	local l_13_3 = nil
	do
		return (l_13_0._params.only_primary_user and managers.menu_input:bound_user() ~= managers.save:primary_user() and not l_13_3) or not l_13_0:conditional() or false
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DChoice.text = function(l_14_0)
	do
		local l_14_1 = l_14_0._params.text
		if not l_14_0._params.ignore_localization then
			local l_14_2, l_14_3 = managers.localization:text, managers.localization
			do
				return l_14_2(l_14_3, l_14_1 or "")
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			return l_14_1
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DChoice.non_localized_text = function(l_15_0)
	return l_15_0._params.text
end

Menu2DChoice.goto = function(l_16_0)
	if l_16_0._params.conditional_goto then
		local l_16_1, l_16_2 = managers.menu2d:check_condition, managers.menu2d
		local l_16_3 = l_16_0._params.conditional_goto
		return l_16_1(l_16_2, l_16_3)
	else
		return l_16_0._params.goto_page
	end
end

Menu2DChoice.platform = function(l_17_0)
	return l_17_0._params.platform
end

Menu2DChoice.name = function(l_18_0)
	return l_18_0._params.name
end

Menu2DChoice.widget = function(l_19_0)
	return l_19_0._widget
end

Menu2DChoice.empty = function(l_20_0)
	local l_20_1 = toboolean
	local l_20_2 = l_20_0._params.empty
	return l_20_1(l_20_2)
end

Menu2DChoice.conditional = function(l_21_0)
	if l_21_0._params.conditional then
		return managers.menu2d:use_connection(l_21_0._params.conditional)
	else
		return true
	end
end


