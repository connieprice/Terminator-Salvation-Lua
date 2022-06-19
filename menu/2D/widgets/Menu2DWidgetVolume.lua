require("menu/2D/widgets/Menu2DWidgetBase.lua")
Menu2DWidgetVolume = Menu2DWidgetVolume or class(Menu2DWidgetBase)
Menu2DWidgetVolume._foreground_alpha_active = 1
Menu2DWidgetVolume._foreground_alpha = 0.4
Menu2DWidgetVolume._background_alpha_active = 0.4
Menu2DWidgetVolume._background_alpha = 0.15
function Menu2DWidgetVolume.init(A0_0, A1_1)
	Menu2DWidgetBase.init(A0_0, A1_1)
end
function Menu2DWidgetVolume.post_init(A0_2)
	managers.menu2d:sound():preload_sound(A0_2._sound_up, A0_2._sound_up)
end
function Menu2DWidgetVolume.parse(A0_3, A1_4)
	local L2_5
	L2_5 = A0_3._params
	L2_5.min = A0_3._params.min ~= "" and tonumber(A0_3._params.min) or 0
	L2_5 = A0_3._params
	L2_5.max = A0_3._params.max ~= "" and tonumber(A0_3._params.max) or 1
	L2_5 = A0_3._params
	L2_5 = L2_5.sound
	if L2_5 ~= "" then
		L2_5 = A0_3._params
		L2_5 = L2_5.sound
	else
		L2_5 = L2_5 or "menu_up"
	end
	A0_3._sound_up = L2_5
	L2_5 = A0_3._params
	L2_5 = L2_5.sound
	if L2_5 ~= "" then
		L2_5 = A0_3._params
		L2_5 = L2_5.sound
	else
		L2_5 = L2_5 or "menu_down"
	end
	A0_3._sound_down = L2_5
	A0_3._params = A1_4
end
function Menu2DWidgetVolume.show(A0_6, A1_7, A2_8)
	A0_6._root_panel = A1_7
	Menu2DWidgetBase.show(A0_6, A1_7, A2_8)
end
function Menu2DWidgetVolume.create_gui(A0_9)
	local L1_10, L2_11, L3_12, L4_13
	L1_10 = {}
	A0_9._bars = L1_10
	L1_10 = {}
	A0_9._bars_bg = L1_10
	A0_9._text_w = 80
	A0_9._steps = 10
	L1_10 = 32
	L2_11 = A0_9._bars
	L3_12 = A0_9._params
	L3_12 = L3_12.panel
	L4_13 = L3_12
	L3_12 = L3_12.bitmap
	L3_12 = L3_12(L4_13, {
		texture = "gui_menu_volumebar_line",
		w = 1,
		x = 0,
		h = 1,
		layer = tweak_data.menu2d.layer_normal
	})
	L2_11[1] = L3_12
	L2_11 = A0_9._bars
	L2_11 = L2_11[1]
	L3_12 = L2_11
	L2_11 = L2_11.texture_height
	L2_11 = L2_11(L3_12)
	L3_12 = A0_9._params
	L3_12 = L3_12.panel
	L4_13 = L3_12
	L3_12 = L3_12.h
	L3_12 = L3_12(L4_13)
	L2_11 = L2_11 / L3_12
	L3_12 = A0_9._params
	L3_12 = L3_12.panel
	L4_13 = L3_12
	L3_12 = L3_12.w
	L3_12 = L3_12(L4_13)
	L4_13 = A0_9._text_w
	L3_12 = L3_12 - L4_13
	L4_13 = math
	L4_13 = L4_13.floor
	L4_13 = L4_13(L3_12 / A0_9._steps)
	L3_12 = L4_13
	L4_13 = 3
	A0_9._step_value = (A0_9._params.max - A0_9._params.min) / A0_9._steps
	A0_9._bars[1]:set_w(L3_12)
	A0_9._bars[1]:set_h(L1_10)
	A0_9._bars[1]:set_x(L4_13)
	A0_9._bars[1]:set_center_y(A0_9._params.panel:center_y())
	A0_9._bars_bg[1] = A0_9._params.panel:bitmap({
		texture = "gui_menu_volumebar_line",
		w = L3_12,
		x = L4_13,
		h = L1_10,
		blend_mode = "add",
		layer = tweak_data.menu2d.layer_normal
	})
	A0_9._bars_bg[1]:set_center_y(A0_9._params.panel:center_y())
	if 1 > A0_9:initial_value() then
		A0_9._bars[1]:hide()
	end
	for _FORV_11_ = 2, A0_9._steps do
		L4_13 = L4_13 + L3_12
		A0_9._bars[_FORV_11_] = A0_9._params.panel:bitmap({
			texture = "gui_menu_volumebar_line",
			w = L3_12,
			x = L4_13,
			h = L1_10,
			layer = tweak_data.menu2d.layer_normal
		})
		A0_9._bars_bg[_FORV_11_] = A0_9._params.panel:bitmap({
			texture = "gui_menu_volumebar_line",
			w = L3_12,
			x = L4_13,
			h = L1_10,
			blend_mode = "add",
			layer = tweak_data.menu2d.layer_normal
		})
		A0_9._bars[_FORV_11_]:set_center_y(A0_9._params.panel:center_y())
		A0_9._bars_bg[_FORV_11_]:set_center_y(A0_9._params.panel:center_y())
		if A0_9:initial_value() < _FORV_11_ then
			A0_9._bars[_FORV_11_]:hide()
		end
	end
	A0_9._val = A0_9:initial_value()
	A0_9._text = A0_9._params.panel:text({
		color = Color(1, 1, 1, 1),
		font = "faith_font_22",
		w = A0_9._text_w,
		x = A0_9._bars[#A0_9._bars]:right() + 1,
		align = "center",
		vertical = "center",
		text = "",
		layer = tweak_data.menu2d.layer_normal
	})
	A0_9._bar_bg = A0_9._root_panel:bitmap({
		texture = "gui_menu_volumebar_gradient",
		blend_mode = "add",
		h = A0_9._params.panel:h(),
		layer = tweak_data.menu2d.layer_normal
	})
	A0_9._bar_bg:set_h(A0_9._bars[1]:h() * 1.4)
	A0_9._bar_bg:set_world_x(A0_9._params.panel:world_x())
	A0_9._bar_bg:set_world_center_y(A0_9._params.panel:world_center_y())
	A0_9._width = A0_9._text:x()
	A0_9:update()
end
function Menu2DWidgetVolume.destroy(A0_14)
	A0_14._bar_bg:parent():remove(A0_14._bar_bg)
end
function Menu2DWidgetVolume.input(A0_15, A1_16)
	local L2_17
	if A1_16.x > 0 and A0_15._val < A0_15._steps then
		L2_17 = A0_15._val + 1
	elseif A1_16.x < 0 and 0 < A0_15._val then
		L2_17 = A0_15._val - 1
	end
	if L2_17 then
		A0_15:_set_value(L2_17)
	end
end
function Menu2DWidgetVolume._set_value(A0_18, A1_19)
	local L2_20
	L2_20 = A0_18._val
	A0_18._val = A1_19
	if A1_19 > L2_20 then
		managers.menu2d:sound():play(A0_18._sound_up)
	elseif A1_19 < L2_20 then
		managers.menu2d:sound():play(A0_18._sound_down)
	end
	for _FORV_6_ = 1, A0_18._steps do
		if A1_19 < _FORV_6_ then
			A0_18._bars[_FORV_6_]:hide()
		else
			A0_18._bars[_FORV_6_]:show()
		end
	end
	if _FOR_.connection_set then
		managers.menu2d:use_connection(A0_18._params.connection_set, A0_18._step_value * A0_18._val + A0_18._params.min, A0_18._params)
		A0_18:update()
	else
		Application:error("no connection_set in volume widget, correct menu2D.xml, " .. tostring(A0_18._params.connection_set))
	end
end
function Menu2DWidgetVolume.update(A0_21)
	local L1_22
	L1_22 = A0_21._val
	L1_22 = L1_22 / A0_21._steps
	A0_21._bar_bg:set_w(A0_21._width * L1_22)
	A0_21._text:set_text(tostring(math.round(L1_22 * 100)) .. "%")
end
function Menu2DWidgetVolume.text(A0_23)
	return tostring(math.round(A0_23._val / A0_23._steps * 100)) .. "%"
end
function Menu2DWidgetVolume.initial_value(A0_24)
	local L1_25, L2_26, L3_27
	L1_25 = A0_24._params
	L1_25 = L1_25.initial_value
	L2_26 = A0_24._params
	L2_26 = L2_26.connection_get
	if L2_26 then
		L2_26 = A0_24._params
		L2_26 = L2_26.connection_get
		if L2_26 ~= "" then
			L2_26 = managers
			L2_26 = L2_26.menu2d
			L3_27 = L2_26
			L2_26 = L2_26.use_connection
			L2_26 = L2_26(L3_27, A0_24._params.connection_get, A0_24._params)
			L1_25 = L2_26
		end
	else
		L2_26 = A0_24._params
		L2_26 = L2_26.initial_value
		if L2_26 then
			L2_26 = A0_24._params
			L1_25 = L2_26.initial_value
		else
			L2_26 = A0_24._prams
			L1_25 = L2_26.min
		end
	end
	L2_26 = A0_24._params
	L2_26 = L2_26.max
	L3_27 = A0_24._params
	L3_27 = L3_27.min
	L1_25 = math.clamp(L1_25, L2_26 > L3_27 and L3_27 or L2_26, L2_26 > L3_27 and L2_26 or L3_27)
	L1_25 = L1_25 - L3_27
	L1_25 = L1_25 / (L2_26 - L3_27)
	A0_24._val = math.round(A0_24._steps * L1_25)
	return A0_24._val
end
function Menu2DWidgetVolume.set_active(A0_28, A1_29)
	if not A1_29 then
		for _FORV_5_ = 1, 10 do
			A0_28._bars[_FORV_5_]:stop()
			A0_28._bars_bg[_FORV_5_]:stop()
			if _FORV_5_ <= A0_28._val then
				A0_28._bars[_FORV_5_]:animate(Menu2DAnimations.flash, tweak_data.menu2d.animation.choice_text_flash_speed, tweak_data.menu2d.animation.choice_text_flash_times, A0_28._foreground_alpha, A0_28._foreground_alpha_active)
			else
				A0_28._bars[_FORV_5_]:animate(Menu2DAnimations.fade_in, 0, 0.1, A0_28._foreground_alpha_active)
			end
		end
		_FOR_:animate(Menu2DAnimations.flash, tweak_data.menu2d.animation.choice_text_flash_speed, tweak_data.menu2d.animation.choice_text_flash_times, tweak_data.menu2d.animation.choice_text_flash_min_alpha, tweak_data.menu2d.animation.choice_text_flash_max_alpha)
	end
	A0_28._bar_bg:show()
	A0_28:update()
	A0_28._active = true
end
function Menu2DWidgetVolume.set_inactive(A0_30, A1_31)
	A0_30._bar_bg:hide()
	if not A1_31 then
		for 